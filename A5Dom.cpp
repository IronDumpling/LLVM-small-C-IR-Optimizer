//
//  A5Dom.cpp
//  ECE467 Lab 5
//
//  Created by Tarek Abdelrahman on 2023-11-18.
//  Copyright © 2023 Tarek Abdelrahman. All rights reserved.
//
//  Permission is hereby granted to use this code in ECE467 at
//  the University of Toronto. It is prohibited to distribute
//  this code, either publicly or to third parties.
//

#include "llvm/IR/LegacyPassManager.h"
#include "llvm/Passes/PassBuilder.h"
#include "llvm/Passes/PassPlugin.h"
#include "llvm/Support/raw_ostream.h"

#include <string>
#include <map>
#include <set>
#include <vector>
#include <iostream>

using namespace llvm;
using namespace std;

#define StrVec std::vector<llvm::StringRef>
#define DOMs std::array<StrVec, 4>
#define BB llvm::StringRef, DOMs
#define BBMap std::map<BB>

#define DOMINATOR 0
#define DIRECTDOM 1
#define POSTDOMIN 2
#define DIRECPOSD 3

namespace {

class BBDB{
  public:
    BBMap bbMap;
                
    void addBB(llvm::BasicBlock * bb, Function & F){
      llvm::StringRef bbName = bb->getName(); 
      if(bbMap.find(bbName) != bbMap.end()) return;
      
      DOMs doms;
      bbMap[bbName] = doms; 
      // Dominator
      if(bbName == "entry"){
        addDOM(bb, bb, DOMINATOR);
      }else{
        for(auto & curr : F){
          addDOM(bb, &curr, DOMINATOR);
        }
      }
      // POSTDOMIN
      llvm::Instruction * lastInst = bb->getTerminator();
      if(llvm::isa<llvm::ReturnInst>(lastInst)){
          addDOM(bb, bb, DOMINATOR);
      }else{
        for(auto & curr : F){
          addDOM(bb, &curr, POSTDOMIN);
        }
      }
    }

    StrVec & getDOM(const llvm::BasicBlock * bb, int idx){
      llvm::StringRef bbName = bb->getName();
      if(bbMap.find(bbName) == bbMap.end()) assert(false);
      return bbMap[bbName][idx];
    }

    StrVec & getDOM(const llvm::StringRef bbName, int idx){
      if(bbMap.find(bbName) == bbMap.end()) assert(false);
      return bbMap[bbName][idx];
    }

    void addDOM(const llvm::BasicBlock * bb, const llvm::BasicBlock * dom, int idx){
      llvm::StringRef bbName = bb->getName();
      llvm::StringRef domName = dom->getName();
      StrVec * domin = &bbMap[bbName][idx];
      if(std::find(domin->begin(), domin->end(), domName) == domin->end()){
        domin->push_back(domName);
      }
    }

    bool equalDOM(const StrVec& lhs, const StrVec& rhs){
      if (lhs.size() != rhs.size()) return false;
      for (size_t i = 0; i < lhs.size(); ++i) {
        if (lhs[i] != rhs[i]) {
            return false;
        }
      }
      return true;
    }

    StrVec intersectDOM(StrVec lhs, StrVec rhs){
      StrVec result;
      std::sort(lhs.begin(), lhs.end());
      std::sort(rhs.begin(), rhs.end());
      std::set_intersection(lhs.begin(), lhs.end(), rhs.begin(), rhs.end(), std::back_inserter(result));
      return result;
    }

    void printBB(){
      std::vector<std::pair<BB>> sortedBB(bbMap.begin(), bbMap.end());

      std::sort(sortedBB.begin(), sortedBB.end(), [](const auto& a, const auto& b) {
        return a.first < b.first;
      });

      for (auto& ent : sortedBB) {
        llvm::outs() << ent.first << ": \n";
        this->printDOMS(ent.first, sortedBB);
      }
    }

    void printDOMS(llvm::StringRef bbName, std::vector<std::pair<BB>> bbVec){
      printDOMed(bbName, bbVec, DOMINATOR);
      printDOMtor(bbName, DIRECTDOM);
      printDOMed(bbName, bbVec, POSTDOMIN);
      printDOMtor(bbName, DIRECPOSD);
    }
  public:
    void printDOMed(llvm::StringRef bbName, std::vector<std::pair<BB>> bbVec, int index) const{
      StrVec domed;
      for (const auto& ent : bbVec) {
        StrVec dom = ent.second[index];
        if(std::find(dom.begin(), dom.end(), bbName) != dom.end()){
          domed.push_back(ent.first);
        }
      }
      printDOM(domed);
    }

    void printDOMtor(llvm::StringRef bbName, int index){
      StrVec domtor = bbMap[bbName][index];
      std::sort(domtor.begin(), domtor.end());
      printDOM(domtor);
    }

    void printDOM(const StrVec & dom) const{
      llvm::outs() << "    ";
        if(dom.size() == 0){
          llvm::outs() << "X";
        }else{
          for (const auto& el : dom) {
            llvm::outs() << el << " ";
          }
        }
        llvm::outs() << "\n";
    }
};

class Analyizer{
public:
  BBDB bbdb;
  Function * F;
  llvm::BasicBlock * entry;
  llvm::BasicBlock * exit;

  void analyze(Function * F){
    this->F = F;
    entry = &(this->F->getEntryBlock());
    dominatorAnalysis();
    directDomAnalysis();
    postDomAnalysis();
    dirPostDomAnalysis();
    bbdb.printBB();
  }

private:
  void dominatorAnalysis(){
    std::set<llvm::BasicBlock*> bbSet;
    bbSet.insert(entry);

    for(auto & curr : *F){
      bbdb.addBB(&curr, *F);
    }

    while(!bbSet.empty()){
      llvm::BasicBlock * curr = *(bbSet.rbegin());
      llvm::Instruction * lastInst = curr->getTerminator();
      if(llvm::isa<llvm::ReturnInst>(lastInst)) exit = curr;

      StrVec oldDOM = bbdb.getDOM(curr, DOMINATOR);
      llvm::pred_iterator pIter = llvm::pred_begin(curr), pEnd = llvm::pred_end(curr);
      if(pIter != pEnd){
        bbdb.getDOM(curr, DOMINATOR) = bbdb.getDOM(*pIter, DOMINATOR);
        for(; pIter != pEnd; ++pIter){
          bbdb.getDOM(curr, DOMINATOR) = bbdb.intersectDOM(bbdb.getDOM(curr, DOMINATOR), 
                                                          bbdb.getDOM(*pIter, DOMINATOR));
        }
      }
      bbdb.addDOM(curr, curr, DOMINATOR);
      
      if(bbdb.equalDOM(oldDOM, bbdb.getDOM(curr, DOMINATOR)) && curr->getName() != "entry"){
        bbSet.erase(*(bbSet.rbegin()));
        continue;
      } 

      llvm::succ_iterator sIter = llvm::succ_begin(curr), sEnd = llvm::succ_end(curr);
      bbSet.erase(*(bbSet.rbegin()));
      for(; sIter != sEnd; ++sIter){
        llvm::BasicBlock * succ = *sIter;
        bbSet.insert(succ);
      }
    }
  }
  
  void directDomAnalysis(){
    for(auto & curr : *F){
      StrVec & currVec = bbdb.getDOM(&curr, DIRECTDOM);
      currVec = bbdb.getDOM(&curr, DOMINATOR);
      currVec.erase(std::remove(currVec.begin(), currVec.end(), curr.getName()), 
                    currVec.end());
    }

    for(auto & curr : *F){
      StrVec & dirDomVec = bbdb.getDOM(&curr, DIRECTDOM);
      StrVec dirDomCP = dirDomVec;
      for(llvm::StringRef domS : dirDomCP){
        StrVec domSVec = bbdb.getDOM(domS, DIRECTDOM);
        for(llvm::StringRef domT : dirDomCP){
          if(domT == domS) continue;
          if(std::find(domSVec.begin(), domSVec.end(), domT) != domSVec.end()){
            dirDomVec.erase(std::remove(dirDomVec.begin(), dirDomVec.end(), domT), dirDomVec.end());
          }
        }
      }
    }
  }
  
  void postDomAnalysis(){
    std::set<llvm::BasicBlock*> bbSet;
    bbSet.insert(exit);
    
    while(!bbSet.empty()){
      llvm::BasicBlock * curr = *(bbSet.rbegin());
      
      StrVec oldDOM = bbdb.getDOM(curr, POSTDOMIN);
      llvm::succ_iterator sIter = llvm::succ_begin(curr), sEnd = llvm::succ_end(curr);
      if(sIter != sEnd){
        bbdb.getDOM(curr, POSTDOMIN) = bbdb.getDOM(*sIter, POSTDOMIN);
        for(; sIter != sEnd; ++sIter){
          bbdb.getDOM(curr, POSTDOMIN) = bbdb.intersectDOM(bbdb.getDOM(curr, POSTDOMIN), 
                                                          bbdb.getDOM(*sIter, POSTDOMIN));
        }
      }
      bbdb.addDOM(curr, curr, POSTDOMIN);

      if(bbdb.equalDOM(oldDOM, bbdb.getDOM(curr, POSTDOMIN)) && curr->getName() != "exit"){
        bbSet.erase(*(bbSet.rbegin()));
        continue;
      } 

      llvm::pred_iterator pIter = llvm::pred_begin(curr), pEnd = llvm::pred_end(curr);
      bbSet.erase(*(bbSet.rbegin()));
      for(; pIter != pEnd; ++pIter){
        llvm::BasicBlock * pred = *pIter;
        bbSet.insert(pred);
      }      
    }
  }

  void dirPostDomAnalysis(){
    for(auto & curr : *F){
      StrVec & currVec = bbdb.getDOM(&curr, DIRECPOSD);
      currVec = bbdb.getDOM(&curr, POSTDOMIN);
      currVec.erase(std::remove(currVec.begin(), currVec.end(), curr.getName()), currVec.end());
    }

    for(auto & curr : *F){
      StrVec & dirDomVec = bbdb.getDOM(&curr, DIRECPOSD);
      StrVec dirDomCP = dirDomVec;
      for(llvm::StringRef domS : dirDomCP){
        StrVec domSVec = bbdb.getDOM(domS, DIRECPOSD);
        for(llvm::StringRef domT : dirDomCP){
          if(domT == domS) continue;
          if(std::find(domSVec.begin(), domSVec.end(), domT) != domSVec.end()){
            dirDomVec.erase(std::remove(dirDomVec.begin(), dirDomVec.end(), domT), dirDomVec.end());
          }
        }
      }
    }
  }
};

// This method implements what the pass does
void processFunction(Function &F) {
  Analyizer ana;
  ana.analyze(&F);
}

struct A5Dom : PassInfoMixin<A5Dom> {
  // This is the main entry point for processing the IR of a function
  // It simply calls the function that has your code
  PreservedAnalyses run(Function &F, FunctionAnalysisManager &) {
    processFunction(F);
    return PreservedAnalyses::all();
  }

  // This makes sure that the pass is executed, even when functions are
  // decorated with the optnone attribute; this is the case when using
  // clang without -O flags
  static bool isRequired() { return true; }
};
} // namespace

// Register the pass with the pass manager as a function pass
llvm::PassPluginLibraryInfo getA5DomPluginInfo() { 
  return {LLVM_PLUGIN_API_VERSION, "A5Dom", LLVM_VERSION_STRING,
          [](PassBuilder &PB) {
            PB.registerPipelineParsingCallback(
                [](StringRef Name, FunctionPassManager &FPM,
                  ArrayRef<PassBuilder::PipelineElement>) {
                  if (Name == "A5Dom") {
                    FPM.addPass(A5Dom());
                    return true;
                  }
                  return false;
                });
          }
  };
}

// This ensures that opt recognizes A5Dom when specified on the
// command line by -passes="A5Dom"
extern "C" LLVM_ATTRIBUTE_WEAK ::llvm::PassPluginLibraryInfo
llvmGetPassPluginInfo() {
  return getA5DomPluginInfo();
}
