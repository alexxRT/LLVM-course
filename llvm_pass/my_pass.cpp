#include "llvm/IR/PassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"
#include "llvm/IR/Module.h"

using namespace llvm;

//pass itself
struct MyPass : public PassInfoMixin<MyPass> {
    // here bla bla my pass
    PreservedAnalyses run(Module &M, ModuleAnalysisManager &AM) {
        outs() << "Dumping statistic for module " << M.getName() << "\n";
        for (auto &F : M) {
            for (auto &B : F) {
                for (auto &I : B) {
                    // Dump Instructions with users
                    for (auto &U : I.uses()) {
                        Instruction *user_instr = dyn_cast<Instruction>(U.getUser());
                        outs() << user_instr->getOpcodeName() << "<-" << I.getOpcodeName() << "\n";
                    }
                }
            }
        }
        outs() << "\n";
        return PreservedAnalyses::all();
    }
};

// applying pass
PassPluginLibraryInfo getPassPluginInfo() {
  const auto callback = [](PassBuilder &PB) {
    PB.registerPipelineStartEPCallback([&](ModulePassManager &MPM, auto) {
      MPM.addPass(MyPass{});
      return true;
    });
  };

  return {LLVM_PLUGIN_API_VERSION, "MyPlugin", "0.0.1", callback};
};

// entry point for compiler when applying my pass
extern "C" LLVM_ATTRIBUTE_WEAK PassPluginLibraryInfo llvmGetPassPluginInfo() {
  return getPassPluginInfo();
}
