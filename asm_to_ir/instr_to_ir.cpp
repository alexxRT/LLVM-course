#include "../app/sim.hpp"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Verifier.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include <fstream>
#include <iostream>
#include <string>
#include <unordered_map>
#include <regex> 
using namespace llvm;

// register files
const int REGISTERS_NUM = 8;
int REG[REGISTERS_NUM];

const int CENTER_X = WIN_WIDTH / 2;
const int SPEED    = 5;

const int COLORS_NUM = 2;
int COLORS[] = {static_cast<int>(0x00FF0000), static_cast<int>(0xD3D3D3FF)};

void MOVE(int y_center) {
    REG[y_center] += SPEED;
    return;
}

void SET_COLOR(int arg, int color_code) {
    REG[arg] = COLORS[color_code];
    return;
}

void ADD(int arg1, int imm, int res) {
    REG[res] = REG[arg1] + imm;
    return;
}

void DIV(int arg1, int imm, int res) {
    REG[res] = REG[arg1] / imm;
    return;
}

void BLE(int arg1, int arg2, int arg3) {
    REG[arg3] = (REG[arg1] <= REG[arg2]);
    return;
}

void MOV(int arg, int imm) {
    REG[arg] = imm;
    return;
}

void INC_LT(int arg1, int arg2, int arg3) {
  REG[arg1]++;
  REG[arg3] = REG[arg1] < arg2;
}

void SQUARE_ABS(int x, int y, int y_center, int res) {
    REG[res] = abs((REG[x] - CENTER_X) + (REG[y] - REG[y_center])) + abs((REG[x] - CENTER_X) - (REG[y] - REG[y_center]));
    return;
}

void FLUSH_WIN() {
    flush_window();
    return;
}

void PAINT_PIXEL(int arg1, int arg2, int arg3) {
    paint_pixel(REG[arg1], REG[arg2], REG[arg3]);
    return;
}

int get_label_number(std::string& label) {
    std::regex label_number_regx(".*_([0-9]+)");
    return std::atoi(std::regex_replace(label.c_str(), label_number_regx, std::string("$1")).c_str());
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        outs() << "[ERROR] Need 1 argument: file with assembler code\n";
        return 1;
    }
    std::ifstream input;
    input.open(argv[1]);
    if (!input.is_open()) {
        outs() << "[ERROR] Can't open " << argv[1] << "\n";
        return 1;
    }

    LLVMContext context;
    // ; ModuleID = 'top'
    // source_filename = "top"
    Module *module = new Module("top", context);
    IRBuilder<> builder(context);
    Type* voidType  = Type::getVoidTy(context);
    Type* int32Type = Type::getInt32Ty(context); 

    //global variables declairation
    ArrayType* RegFileType = ArrayType::get(int32Type, REGISTERS_NUM);
    module->getOrInsertGlobal("REG", RegFileType);
    GlobalVariable* regs = module->getNamedGlobal("REG");

    ArrayType* ColorsSetType = ArrayType::get(int32Type, COLORS_NUM);
    module->getOrInsertGlobal("COLORS", ColorsSetType);
    GlobalVariable* colors = module->getNamedGlobal("COLORS");

    module->getOrInsertGlobal("SPEED", int32Type);
    GlobalVariable* speed = module->getNamedGlobal("SPEED");

    module->getOrInsertGlobal("CENTER_X", int32Type);
    GlobalVariable* center_x = module->getNamedGlobal("CENTER_X");

    // declare void @main()
    FunctionType *funcType = FunctionType::get(voidType, false);
    Function *mainFunc = Function::Create(funcType, Function::ExternalLinkage, "main", module);

    std::string name;
    std::string arg;
    std::unordered_map<int32_t, BasicBlock *> BBMap;
    while (input >> name) {
        if (!name.compare("ADD") || !name.compare("DIV") || !name.compare("BLE") ||
            !name.compare("PAINT_PIXEL") || !name.compare("INC_LT")) {
        input >> arg >> arg >> arg;
        continue;
        }
        if (!name.compare("SQUARE_ABS")) {
        input >> arg >> arg >> arg >> arg;
        continue;
        }
        if (!name.compare("MOV") || !name.compare("SET_COLOR") || !name.compare("JUMP_COND")) {
        input >> arg >> arg;
        continue;
        }
        if (!name.compare("MOVE")){
        input >> arg;
        continue;
        }

        if (!name.compare("HLT") || !name.compare("FLUSH_WIN")) {
        continue;
        }
        int label_num = get_label_number(name);
        BBMap[label_num] = BasicBlock::Create(context, std::to_string(label_num).c_str(), mainFunc);
    }
    input.close();
    input.open(argv[1]);

    ArrayRef<Type*> int32x4Types = {int32Type,
                                    int32Type,
                                    int32Type,
                                    int32Type};
    FunctionType* int32x4FuncType = FunctionType::get(voidType, int32x4Types, false);

    ArrayRef<Type*> int32x3Types = {int32Type,
                                    int32Type,
                                    int32Type};
    FunctionType* int32x3FuncType = FunctionType::get(voidType, int32x3Types, false);

    ArrayRef<Type*> int32x2Types = {int32Type,
                                    int32Type};
    FunctionType* int32x2FuncType = FunctionType::get(voidType, int32x2Types, false);

    FunctionType* int32FuncType = FunctionType::get(voidType, int32Type, false);

    FunctionType* voidFuncType = FunctionType::get(voidType, false);

    // Functions
    FunctionCallee SQUARE_ABSFunc = module->getOrInsertFunction("SQUARE_ABS", int32x4FuncType);

    FunctionCallee ADDFunc = module->getOrInsertFunction("ADD", int32x3FuncType);

    FunctionCallee DIVFunc = module->getOrInsertFunction("DIV", int32x3FuncType);

    FunctionCallee BLEFunc = module->getOrInsertFunction("BLE", int32x3FuncType);

    FunctionCallee PAINT_PIXELFunc = module->getOrInsertFunction("PAINT_PIXEL", int32x3FuncType);

    FunctionCallee INC_LTFunc = module->getOrInsertFunction("INC_LT", int32x3FuncType);

    FunctionCallee MOVFunc = module->getOrInsertFunction("MOV", int32x2FuncType);

    FunctionCallee SET_COLORFunc = module->getOrInsertFunction("SET_COLOR", int32x2FuncType);

    FunctionCallee MOVEFunc = module->getOrInsertFunction("MOVE", int32FuncType);

    FunctionCallee FLUSHFunc = module->getOrInsertFunction("FLUSH", voidFuncType);

    while (input >> name) {
        if (!name.compare("HLT")) {
        builder.CreateRetVoid();
        if (input >> name) {
            builder.SetInsertPoint(BBMap[get_label_number(name)]);
        }
        continue;
        }
        if (!name.compare("SQUARE_ABS")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg4 = builder.getInt32(std::stoi(arg.substr(1)));
        
        Value *args[] = {arg1, arg2, arg3, arg4};
        builder.CreateCall(SQUARE_ABSFunc, args);
        continue;
        }

        if (!name.compare("PAINT_PIXEL")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        Value *args[] = {arg1, arg2, arg3};
        builder.CreateCall(PAINT_PIXELFunc, args);
        continue;
        }
        if (!name.compare("FLUSH_WIN")) {
        outs() << "\tFLUSH\n";
        builder.CreateCall(FLUSHFunc);
        continue;
        }
        if (!name.compare("ADD")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        Value *args[] = {arg1, arg2, arg3};
        builder.CreateCall(ADDFunc, args);
        continue;
        }
        if (!name.compare("BLE")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        Value *args[] = {arg1, arg2, arg3};
        builder.CreateCall(BLEFunc, args);
        continue;
        }
        if (!name.compare("DIV")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        Value *args[] = {arg1, arg2, arg3};
        builder.CreateCall(DIVFunc, args);
        continue;
        }

        if (!name.compare("INC_LT")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg));

        input >> arg;
        Value *arg3 = builder.getInt32(std::stoi(arg.substr(1)));

        Value *args[] = {arg1, arg2, arg3};
        builder.CreateCall(INC_LTFunc, args);
        continue;
        }

        if (!name.compare("SET_COLOR")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg));

        Value *args[] = {arg1, arg2};
        builder.CreateCall(SET_COLORFunc, args);
        continue;
        }

        if (!name.compare("MOV")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));

        input >> arg;
        Value *arg2 = builder.getInt32(std::stoi(arg));

        Value *args[] = {arg1, arg2};
        builder.CreateCall(MOVFunc, args);
        continue;
        }

        if (!name.compare("JUMP_COND")) {
        input >> arg;  
        Value *reg_p = builder.CreateConstGEP2_32(RegFileType, regs, 0, std::stoi(arg.substr(1)));
        Value *reg_i1 = builder.CreateTrunc(builder.CreateLoad(int32Type, reg_p), builder.getInt1Ty());

        input >> arg;
        input >> name;
        builder.CreateCondBr(reg_i1, BBMap[get_label_number(arg)], BBMap[get_label_number(name)]);
        builder.SetInsertPoint(BBMap[get_label_number(name)]);
        continue;
        }

        if (!name.compare("MOVE")) {
        input >> arg;
        Value *arg1 = builder.getInt32(std::stoi(arg.substr(1)));
        
        builder.CreateCall(MOVEFunc, arg1);
        continue;
        }

        if (builder.GetInsertBlock()) {
        builder.CreateBr(BBMap[get_label_number(name)]);
        }

        outs() << "BB " << name << "\n";
        builder.SetInsertPoint(BBMap[get_label_number(name)]);
    }

    outs() << "\n#[LLVM IR]:\n";
    module->print(outs(), nullptr);
    outs() << "\n";
    bool verif = verifyFunction(*mainFunc, &outs());
    outs() << "[VERIFICATION] " << (!verif ? "OK\n\n" : "FAIL\n\n");

    outs() << "\n#[Running code]\n";
    InitializeNativeTarget();
    InitializeNativeTargetAsmPrinter();

    ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
    ee->InstallLazyFunctionCreator([=](const std::string &fnName) -> void * {
        outs() << "String function: " << fnName << "\n";
        if (fnName == "_MOVE") {
        return reinterpret_cast<void *>(MOVE);
        }
        if (fnName == "_ADD") {
        return reinterpret_cast<void *>(ADD);
        }
        if (fnName == "_DIV") {
        return reinterpret_cast<void *>(DIV);
        }
        if (fnName == "_PAINT_PIXEL") {
        return reinterpret_cast<void *>(PAINT_PIXEL);
        }
        if (fnName == "_INC_LT") {
        return reinterpret_cast<void *>(INC_LT);
        }
        if (fnName == "_FLUSH") {
        return reinterpret_cast<void *>(FLUSH_WIN);
        }
        if (fnName == "_MOV") {
        return reinterpret_cast<void *>(MOV);
        }
        if (fnName == "_SQUARE_ABS") {
        return reinterpret_cast<void *>(SQUARE_ABS);
        }
        if (fnName == "_SET_COLOR") {
        return reinterpret_cast<void *>(SET_COLOR);
        }
        if (fnName == "_BLE") {
        return reinterpret_cast<void *>(BLE);
        }
        return nullptr;
    });

    ee->addGlobalMapping(regs,     (void *)REG);
    ee->addGlobalMapping(colors,   (void *)COLORS);
    ee->addGlobalMapping(speed,    (void *)&SPEED);
    ee->addGlobalMapping(center_x, (void *)&CENTER_X);
    ee->finalizeObject();

    create_window();

    ArrayRef<GenericValue> noargs;
    ee->runFunction(mainFunc, noargs);
    outs() << "#[Code was run]\n";

    quit_window();

    return EXIT_SUCCESS;
}