#include "../app/sim.hpp"
#include "llvm/ExecutionEngine/ExecutionEngine.h"
#include "llvm/ExecutionEngine/GenericValue.h"
#include "llvm/IR/IRBuilder.h"
#include "llvm/IR/LLVMContext.h"
#include "llvm/IR/Module.h"
#include "llvm/Support/TargetSelect.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Verifier.h"

using namespace llvm;

int main() {
  LLVMContext context;
  // ; ModuleID = 'app.c'
  // source_filename = "app.c"
  Module *module = new Module("app.c", context);
  IRBuilder<> builder(context);

  // declare void @paint_pixel(i32, i32, i32)
  Type* voidType = Type::getVoidTy(context);
  ArrayRef<Type*> PaintPixelArgsType = {Type::getInt32Ty(context),
                                        Type::getInt32Ty(context),
                                        Type::getInt32Ty(context)};
  FunctionType*  PaintPixelFunctionType = FunctionType::get(voidType, PaintPixelArgsType, false);
  FunctionCallee PaintPixel = module->getOrInsertFunction("paint_pixel", PaintPixelFunctionType);

  // declare void @flush_window()
  FunctionType* FlushWindowFunctionType  = FunctionType::get(voidType, false);
  FunctionCallee FlushWindow = module->getOrInsertFunction("flush_window", FlushWindowFunctionType);

  // declare i32 @llvm.abs.i32(i32, i1 immarg) #1
  ArrayRef<Type*> AbsArgsType = {Type::getInt32Ty(context),
                                 Type::getInt1Ty(context)};
  FunctionType* AbsFunctionType = FunctionType::get(builder.getInt32Ty(), AbsArgsType, false);
  Function* AbsFunc = Function::Create(AbsFunctionType, Function::ExternalLinkage, "llvm.abs.i32", module);

  // define void @app() {
  FunctionType* AppFuncType = FunctionType::get(voidType, false);
  Function* AppFunc = Function::Create(AppFuncType, Function::ExternalLinkage, "app", module);

  // BasicBlocks:
  BasicBlock* BB0  = BasicBlock::Create(context, "", AppFunc);
  BasicBlock* BB1  = BasicBlock::Create(context, "", AppFunc);
  BasicBlock* BB3  = BasicBlock::Create(context, "", AppFunc);
  BasicBlock* BB6  = BasicBlock::Create(context, "", AppFunc);
  BasicBlock* BB10 = BasicBlock::Create(context, "", AppFunc);
  BasicBlock* BB13 = BasicBlock::Create(context, "", AppFunc);

  //0:
  builder.SetInsertPoint(BB0);
  // br label %1
  builder.CreateBr(BB1);

  //1:                                                ; preds = %6, %0
  builder.SetInsertPoint(BB1);
  // %2 = phi i32 [ 125, %0 ], [ %9, %6 ]
  PHINode* val2 = builder.CreatePHI(builder.getInt32Ty(), 2);
  // br label %3
  builder.CreateBr(BB3);

  //3:                                                ; preds = %1, %10
  builder.SetInsertPoint(BB3);
  // %4 = phi i32 [ 0, %1 ], [ %11, %10 ]
  PHINode* val4 = builder.CreatePHI(builder.getInt32Ty(), 2);
  // %5 = sub nsw i32 %4, %2
  Value* val5 = builder.CreateNSWSub(val4, val2);
  // br label %13
  builder.CreateBr(BB13);
  
  // 6:                                                ; preds = %10
  builder.SetInsertPoint(BB6);
  //tail call void @flush_window() #4
  builder.CreateCall(FlushWindow);
  // %7 = icmp sgt i32 %2, 274
  Value* val7 = builder.CreateICmpSGT(val2, builder.getInt32(274));
  // %8 = add nsw i32 %2, 1
  Value* val8 = builder.CreateNSWAdd(val2, builder.getInt32(1));
  // %9 = select i1 %7, i32 -49, i32 %8
  Value* val9 = builder.CreateSelect(val7, builder.getInt32(-49), val8);
  // br label %1
  builder.CreateBr(BB1);

  // 10:                                               ; preds = %13
  builder.SetInsertPoint(BB10);
  // %11 = add nuw nsw i32 %4, 1
  Value* val11 = builder.CreateAdd(val4, builder.getInt32(1), "", true, true);
  //%12 = icmp eq i32 %11, 250
  Value* val12 = builder.CreateICmpEQ(val11, builder.getInt32(250));
  //br i1 %12, label %6, label %3, !llvm.loop !6
  builder.CreateCondBr(val12, BB6, BB3);

  //13:                                               ; preds = %3, %13
  builder.SetInsertPoint(BB13);
  // %14 = phi i32 [ 0, %3 ], [ %23, %13 ]
  PHINode* val14 = builder.CreatePHI(builder.getInt32Ty(), 2);
  // %15 = add nsw i32 %14, -250
  Value* val15 = builder.CreateNSWAdd(val14, builder.getInt32(-250));
  // %16 = add nsw i32 %15, %5
  Value* val16 = builder.CreateNSWAdd(val15, val5);
  // %17 = tail call i32 @llvm.abs.i32(i32 %16, i1 true)
  Value* args_abs[] = {val16, builder.getInt1(true)};
  Value* val17 = builder.CreateCall(AbsFunc, args_abs);
  // %18 = sub nsw i32 %15, %5
  Value* val18 = builder.CreateNSWSub(val15, val5);
  // %19 = tail call i32 @llvm.abs.i32(i32 %18, i1 true)
  args_abs[0] = val18;
  Value* val19 =  builder.CreateCall(AbsFunc, args_abs);
  // %20 = add nuw nsw i32 %17, %19
  Value* val20 = builder.CreateAdd(val17, val19, "", true, true);
  // %21 = icmp ugt i32 %20, 50
  Value* val21 = builder.CreateICmpUGT(val20, builder.getInt32(50));
  // %22 = select i1 %21, i32 -741092353, i32 -16777216
  Value* val22 = builder.CreateSelect(val21, builder.getInt32(-741092353), builder.getInt32(-16777216));
  // tail call void @paint_pixel(i32 noundef %14, i32 noundef %4, i32 noundef %22) #4
  Value* args[] = {val14, val4, val22};
  builder.CreateCall(PaintPixel, args);
  // %23 = add nuw nsw i32 %14, 1
  Value* val23 = builder.CreateAdd(val14, builder.getInt32(1), "", true, true);
  // %24 = icmp eq i32 %23, 500
  Value* val24 = builder.CreateICmpEQ(val23, builder.getInt32(500));
  // br i1 %24, label %10, label %13, !llvm.loop !8
  builder.CreateCondBr(val24, BB10, BB13);
  // }

  // Link PHI nodes
  // %2 = phi i32 [ 125, %0 ], [ %9, %6 ]
  val2->addIncoming(builder.getInt32(125), BB0);
  val2->addIncoming(val9, BB6);

  // %4 = phi i32 [ 0, %1 ], [ %11, %10 ]
  val4->addIncoming(builder.getInt32(0), BB1);
  val4->addIncoming(val11, BB10);

  // %14 = phi i32 [ 0, %3 ], [ %23, %13 ]
  val14->addIncoming(builder.getInt32(0), BB3);
  val14->addIncoming(val23, BB13);

  // Dump LLVM IR
  module->print(outs(), nullptr);
  outs() << "\n";
  bool verif = verifyFunction(*AppFunc, &outs());
  outs() << "[VERIFICATION] " << (!verif ? "OK\n\n" : "FAIL\n\n");

  // LLVM IR Interpreter
  outs() << "Run\n";
  InitializeNativeTarget();
  InitializeNativeTargetAsmPrinter();

  ExecutionEngine *ee = EngineBuilder(std::unique_ptr<Module>(module)).create();
  ee->InstallLazyFunctionCreator([&](const std::string &fnName) -> void * {
    if (fnName == "paint_pixel") {
      return reinterpret_cast<void *>(paint_pixel);
    }
    if (fnName == "flush_window") {
      return reinterpret_cast<void *>(flush_window);
    }
    return nullptr;
  });
  ee->finalizeObject();

  create_window();

  ArrayRef<GenericValue> noargs;
  GenericValue v = ee->runFunction(AppFunc, noargs);
  outs() << "Result: App finilized\n";

  quit_window();
 
  return 0;
}
