# Core of Normal Microarchitecture
This project is an RV32I core of normal, simple and classical microarchitecture. 
This first version of design is very simple, focusing on simplicity and readability rather than performance, as it only has a three-stage pipeline, which is divided into instruction fetch, instruction decoding and execution. 

## Principles

When implementing this design, three main principles are held: 

 1. *Classical*. A three-stage classical pipeline is implemented and no abundant optimization has been done. For any branch instruction, the pipeline simply holds. 
 2. *Simple*. Similar modules are integrated, which unifies their functions and minimizes the number of interfaces. 
 3. *Extendable*. Enough space for classical optimization modules, e.g. static branch predictor, should be kept, and the datapath should not be rigid; also, the pipeline design should be easy to be modified to two-stage or five-stage pipeline. 

## Modules

Basically our core contains: 
1. **pc** : Programme counter. It's used to indicate the address of current instruction. Global clk signal and rst signal (both are connected to almost every module), along with hold signal and jump signal are connected to our pc module. If none of these signals request pc to change its address, then after each tick it points to the next instruction address, which is exactly one word, or 4 bytes after current address. Most importantly, after deciding the address we are about to use, pc fetches the instruction from *sb* and passes it into *id*. 

2. ***id***: Instruction decoder. It's used to decode instructions from previous instruction fetch stage, using a completely logical circuit. After this it passes relevant information to *excutrol*.  
3. ***csregfile***: Control and status registers and regfile. 
4. ***executrol***: Execution and control. 
5. ***Two fliops***: Flip-flops between each pipeline stage. 
6. ***sb***: A simple bus. 
7. ***CoNM***: Top module. 

## Coding Style

*To be continued*