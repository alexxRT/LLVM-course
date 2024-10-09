#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"
#include "llvm/IR/Function.h"

using namespace llvm;

//pass itself
class InstructionsInfoPass : public PassInfoMixin<InstructionsInfoPass> {
    public:
        bool isDumpFunction (StringRef func_name) {
              return func_name == "DumpTrace";
        }

        bool isPhiInstr (StringRef instr_name) {
            return instr_name == "phi";
        }

        PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
            //Prepare builder to modify IR
            LLVMContext &Ctx = M.getContext();
            IRBuilder<> builder(Ctx);
            Type *retType = Type::getVoidTy(Ctx);

            // Prepare DumpTrace function
            ArrayRef<Type *> funcStartParamTypes = {
            builder.getInt8Ty()}; // char*
            FunctionType *DumpTraceFuncType =
            FunctionType::get(retType, funcStartParamTypes, false);

            FunctionCallee DumpTraceFunc = M.getOrInsertFunction("DumpTrace", DumpTraceFuncType);
            for (auto &F : M) {
                if (isDumpFunction(F.getName()))
                    continue;
                for (auto &B : F) {
                    for (auto &I : B) {
                        // skipping loger function and phi 
                        if (!isPhiInstr(I.getOpcodeName())) {
                            builder.SetInsertPoint(&I);
                            Value *instr_name = builder.CreateGlobalStringPtr(I.getOpcodeName());
                            builder.CreateCall(DumpTraceFunc, {instr_name});
                        }
                    }
                }
            }
            return PreservedAnalyses::none();
        }
        static bool isRequired() { return true; }
};

PassPluginLibraryInfo getPassPluginInfo() {
    const auto callback = [](PassBuilder &PB) {
        PB.registerOptimizerLastEPCallback([&](ModulePassManager &MPM, auto) {
            MPM.addPass(InstructionsInfoPass{});
            return true;
        });
    };

    return {LLVM_PLUGIN_API_VERSION, "InstructionsInfoPlugin", "0.0.1", callback};
}

extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
    return getPassPluginInfo();
}
