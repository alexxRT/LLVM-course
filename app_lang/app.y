%{
#include <iostream>
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/Verifier.h"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/Support/TargetSelect.h"
using namespace llvm;

#define YYSTYPE Value*
extern "C" {
    int yyparse();
    int yylex();
    void yyerror(char *s) {
        std::cerr << s << "\n";
    }
    int yywrap(void){return 1;}
}

#include "./app/sim.hpp"

LLVMContext context;
IRBuilder<>* builder;
Module* module;
Function *curFunc;
FunctionCallee Flush;
FunctionCallee PaintPixel;
FunctionCallee absFunc;
Value* absArg = nullptr;

typedef struct {
    GlobalVariable* irVal;
    int realVal;
} value_t;
std::map<std::string, value_t> ValueMap;

std::map<BasicBlock *, BasicBlock *> JumpMap;

std::map<std::string, BasicBlock *> BBMap;

int main(int argc, char **argv)
{
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    // ; ModuleID = 'top'
    // source_filename = "top"
    module  = new Module("top", context);
    builder = new IRBuilder<> (context);

    Type *voidType = Type::getVoidTy(context);
    Type *intType  = Type::getInt32Ty(context);


    absArg = new GlobalVariable(
        *module,
        Type::getInt32Ty(context),
        false,
        GlobalValue::ExternalLinkage,
        ConstantInt::get(context, APInt(32, 0)),
        "absArg"
    );

    ArrayRef<Type *> PaintPixelParamTypes = {Type::getInt32Ty(context),
                                             Type::getInt32Ty(context),
                                             Type::getInt32Ty(context)};

    FunctionType *PaintPixelType = FunctionType::get(voidType, PaintPixelParamTypes, false);
    PaintPixel = module->getOrInsertFunction("PaintPixel", PaintPixelType);

    FunctionType *FlushType = FunctionType::get(voidType, false);
    Flush = module->getOrInsertFunction("Flush", FlushType);

    FunctionType *absType = FunctionType::get(intType, intType, false);
    absFunc = module->getOrInsertFunction("abs", absType);

    yyparse();

    outs() << "[LLVM IR]:\n";
    module->print(outs(), nullptr);
    outs() << "\n";
    bool verif = verifyModule(*module, &outs());
    outs() << "[VERIFICATION] " << (!verif ? "OK\n\n" : "FAIL\n\n");

    // Interpreter of LLVM IR
    outs() << "[EE] Run\n";
	ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
    outs() << ee << "\n";

    // function creator
    ee->InstallLazyFunctionCreator([=](const std::string &fnName) -> void * {
        if (fnName == "_Flush") {
            std::cout << "Returning Flush" << std::endl;
            return reinterpret_cast<void *>(flush_window);
        }
        if (fnName == "_PaintPixel") {
            std::cout << "Returning paint pixel" << std::endl;
            return reinterpret_cast<void *>(paint_pixel);
        }
        std::cout << fnName << std::endl;
        return nullptr;
    });


    for (auto& value : ValueMap) {
        ee->addGlobalMapping(value.second.irVal, &value.second.realVal);
    }

    // falls here
    ee->finalizeObject();

    create_window();

	std::vector<GenericValue> noargs;
    Function *mainFunc = module->getFunction("main");
    if (mainFunc == nullptr) {
	    outs() << "Can't find main\n";
        return -1;
    }
    // start interpretering main app
	ee->runFunction(mainFunc, noargs);
    outs() << "[EE] Done\n";

    for (auto& value : ValueMap) {
        outs() << value.first << " = " <<  value.second.realVal << "\n";
    }

    quit_window();
    return 0;
}
%}

%token IntLiteral
%token FunctionBegin
%token FunctionEnd
%token CallFunction
%token NameToken
%token IfToken
%token ForToken
%token GotoToken
%token PutToken
%token FlushToken
%token AbsToken

%%

Parse: Program {YYACCEPT;}

Program: RoutineDeclaration {}
         | VariableDeclaration {}
         | Program VariableDeclaration {}
         | Program RoutineDeclaration {}

VariableDeclaration : NameToken '=' IntLiteral ';' {
                            printf("NameToken '=' IntLiteral ';'\n");
                            module->getOrInsertGlobal((char*)$1, builder->getInt32Ty());
                            value_t val;
                            val.irVal = module->getNamedGlobal((char*)$1);
                            val.realVal = atoi((char*)$3);
                            ValueMap.insert({(char*)$1, val});
                        }

RoutineDeclaration : FunctionBegin NameToken   {
                            printf("FunctionBegin NameToken ...\n");
                            // declare void @NameToken()
                            Function *func = module->getFunction((char*)$2);
                            if (func == nullptr) {
                                FunctionType *funcType =
                                                        FunctionType::get(builder->getVoidTy(), false);
                                func = Function::Create(funcType, Function::ExternalLinkage, (char*)$2, module);
                            }
                            curFunc = func;
                            // entry:
                            BasicBlock *entryBB = BasicBlock::Create(context, "entry", curFunc);
                            builder->SetInsertPoint(entryBB);
                        } Statements FunctionEnd {
                            printf("... Statements FunctionEnd\n");
                            builder->CreateRetVoid();
                        }

Statements: Assignment {printf("Assignment\n");}
            | Statements Assignment {printf("Statements Assignment\n");}
            | Statements RoutineCall {printf("Statements RoutineCall\n");}
            | Statements IfStatement {printf("Statements IfStatement\n");}
            | Statements ForStatement {printf("Statements ForStatement\n");}
            | Statements Label {printf("Statements Label\n");}
            | Statements GoTo {printf("Statements GoTo\n");}
            | Statements Put {printf("Statements Put\n");}
            | Statements Flush {printf("Statements Flush\n");}

Put : PutToken '('Expression','Expression','Expression')' ';' {
                            Value *args[] = {$3, $5, $7};
                            builder->CreateCall(PaintPixel, args);
                        }

Flush : FlushToken '(' ')' ';' { builder->CreateCall(Flush); }

Assignment: Value '=' Expression ';' { builder->CreateStore($3, $1); }
          | Value '=' Abs {
                            Value* loaded_value = builder->CreateLoad(Type::getInt32Ty(context), absArg, "LoadAbsArg");
                            builder->CreateStore(builder->CreateCall(absFunc, loaded_value), $1);
                      }

Abs : AbsToken '('Expression')' ';' {
    builder->CreateStore($3, absArg);
}

RoutineCall: CallFunction NameToken ';' {
                            Function *func = module->getFunction((char*)$2);
                            if (func == nullptr) {
                                FunctionType *funcType = FunctionType::get(builder->getVoidTy(), false);
                                func = Function::Create(funcType, Function::ExternalLinkage, (char*)$2, module);
                            }
                            builder->CreateCall(func);
                        }

ForStatement: ForToken Expression '|' NameToken '|' NameToken ';' {
                            // add names to basic block
                            if (BBMap.find((char*)$4) == BBMap.end()) {
                                BBMap.insert({(char*)$4, BasicBlock::Create(context, (char*)$4, curFunc)});
                            }
                            if (BBMap.find((char*)$6) == BBMap.end()) {
                                BBMap.insert({(char*)$6, BasicBlock::Create(context, (char*)$6, curFunc)});
                            }
                            Value *cond = builder->CreateICmpNE($2, builder->getInt32(0));
                            builder->CreateCondBr(cond, BBMap[(char*)$4], BBMap[(char*)$6]);
                        }

IfStatement: IfToken Expression '|' NameToken '|' NameToken '|' NameToken ';' {
                            BasicBlock* block_true;
                            BasicBlock* block_false;

                            if (BBMap.find((char*)$4) == BBMap.end()) {
                                block_true = BasicBlock::Create(context, (char*)$4, curFunc);
                                BBMap.insert({(char*)$4, block_true});
                            }
                            block_true = BBMap.at((char*)$4);
                            if (BBMap.find((char*)$6) == BBMap.end()) {
                                block_false = BasicBlock::Create(context, (char*)$6, curFunc);
                                BBMap.insert({(char*)$6, block_false});
                            }
                            block_false = BBMap.at((char*)$6);

                            if (BBMap.find((char*)$8) == BBMap.end()) {
                                BasicBlock* block_term  = BasicBlock::Create(context, (char*)$8, curFunc);
                                BBMap.insert({(char*)$8, block_term});

                                if (JumpMap.find(block_true) == JumpMap.end()) {
                                    JumpMap.insert({block_true, block_term});
                                }
                                if (JumpMap.find(block_false) == JumpMap.end()) {
                                    JumpMap.insert({block_false, block_term});
                                }
                            }

                            Value *cond = builder->CreateICmpNE($2, builder->getInt32(0));
                            builder->CreateCondBr(cond, BBMap[(char*)$4], BBMap[(char*)$6]);
                        }

Label: NameToken ':'   {
                            if (BBMap.find((char*)$1) == BBMap.end()) {
                                BBMap.insert({(char*)$1, BasicBlock::Create(context, (char*)$1, curFunc)});
                            }

                            BasicBlock* currentB = builder->GetInsertBlock();
                            if (JumpMap.find(currentB) != JumpMap.end()) {
                                builder->CreateBr(JumpMap.at(currentB));
                            }

                            BasicBlock *BB = BBMap[(char*)$1];
                            builder->SetInsertPoint(BB);
                        }

GoTo:  GotoToken NameToken ';' {
                            if (BBMap.find((char*)$2) == BBMap.end()) {
                                BBMap.insert({(char*)$2, BasicBlock::Create(context, (char*)$2, curFunc)});
                            }
                            BasicBlock *BB = BBMap[(char*)$2];
                            builder->CreateBr(BB);
                        }

Expression: Simple
            | Expression '!''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpNE($1, $4), builder->getInt32Ty()); }
            | Expression '=''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpEQ($1, $4), builder->getInt32Ty()); }
            | Expression '<'    Simple { $$ = builder->CreateZExt(builder->CreateICmpSLT($1, $3), builder->getInt32Ty()); }
            | Expression '<''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpSLE($1, $4), builder->getInt32Ty()); }
            | Expression '>'    Simple { $$ = builder->CreateZExt(builder->CreateICmpSGT($1, $3), builder->getInt32Ty()); }
            | Expression '>''=' Simple { $$ = builder->CreateZExt(builder->CreateICmpSGE($1, $4), builder->getInt32Ty()); }
;
Simple:     Summand
            | Simple '+' Summand { $$ = builder->CreateAdd($1, $3); }
            | Simple '-' Summand { $$ = builder->CreateSub($1, $3); }

Summand:    Factor
            | Summand '*' Factor  { $$ = builder->CreateMul($1, $3); }
            | Summand '/' Factor  { $$ = builder->CreateSDiv($1, $3); }
            | Summand '%' Factor  { $$ = builder->CreateSRem($1, $3); }
;

Factor:     Primary { $$ = $1; }
            | '-' Primary { $$ = builder->CreateNeg($2); }
            | '(' Expression ')' { $$ =$2; }
;

Primary:    IntLiteral { $$ = builder->getInt32(atoi((char*)$1)); }
            | Value { $$ = builder->CreateLoad(builder->getInt32Ty(), $1); }
;

Value:      NameToken  { $$ = builder->CreateConstGEP1_32(builder->getInt32Ty(), ValueMap[(char*)$1].irVal, 0); }

%%