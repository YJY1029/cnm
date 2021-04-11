
# Core of Normal Microarchitecture
This project is an RV32I core of normal, simple and classical microarchitecture. 
This first version of design is very simple, focusing on simplicity and readability rather than performance, as it only has a three-stage pipeline, which is divided into instruction fetch, instruction decoding and execution. 

## Design Ideas

When implementing this design, there are three main design ideas: 

 1. *Classical*. A three-stage classical pipeline is implemented and no abundant optimization has been done. For any branch instruction, the pipeline simply holds. 
 2. *Simple*. Similar modules are integrated, which unifies their functions and minimizes the number of interfaces. 
 3. *Extendable*. Enough space for classical optimization modules, e.g. static branch predictor, should be kept, and the datapath should not be rigid; also, the pipeline design should be easy to be modified to two-stage or five-stage pipeline. 

## Modules

Basically our core contains: 
1. ***defines***: Relevant parameters, configure, and necessary information of decoding. 
2. ***pc*** : Programme counter. It's used to indicate the address of current instruction. Global rst signal (connected to almost every module), along with hold signal and jump signal are connected to our *pc* module. If none of these signals request *pc* to change its address, then it points to the next instruction address, which is exactly one word, or four bytes after current address. Most importantly, after deciding the address we are about to use, *pc* fetches the instruction from *sb* and passes it into *id*. 

3. ***id***: Instruction decoder. It's used to decode instructions from previous instruction fetch stage, using a completely combinational logical circuit. After this, while it passes register addresses to *csregfile*, informing it to output data to *executrol*, it also passes relevant information to *excutrol*.  
4. ***csregfile***: Control and status registers and regfile. CSRs (control and status registers) and register file are integrated in this design, due to the obvious similarity between them, and they are in charge of reading and writing of these registers. From *id* it receives addresses of registers that are to be read by *executrol*, and outputs data in rs1 and/or rs2 or specific CSR; From *executrol* it receives we (write enable) signal, write address and write data of specific rd or CSR, and puts the data into where it belong. 
5. ***executrol***: Execution and control. Given that execution results are tightly coherent to control function, in this design we also integrated execution and control modules into *executrol*. This module performs all calculations, including add, sub, shift, etc., and all control-related operations, including jump, branch, hold, etc. In all, it performs functions referring to the information inputted from *id*, and control-related part processes its results. Finally, *executrol* outputs relevant signals along with operation results. 
6. ***Two fliops***: D flip-flops between each pipeline stage. They are both very simple D flip-flops: all data and signals inputted from previous stage are kept here for one tick and then sent to the next stage. Note that when hold signal is set, these two flip-flops will continuously perform NOP instruction until hold flag is off. 
7. ***sb***: A simple bus. Its details are to be determined, but in all it's a very simple bus connected to *pc*, *executrol* and the most significant peripheral *RAM*, transmitting instruction and data. 
8. ***CoNM***: Top module. All submodules are instantiated here, with several peripherals and global signals connected to it.

## Coding Style
To enhance readability and coding convenience, several coding principles should be clarified: 
 - Clean and simple macro definitions and variable naming,  e.g. non-suffix input variables and instruction names, -r-suffixed register variables and -o-suffixed output variables, enhancing readability and coding convenience. 
 - Using *assign* statements as conditionals, as to avoid uncertain states and priority selection circuits under some circumstances. 
 - Initiating standard D flip-flop modules implemented elsewhere, which will greatly benefit implementation process as well. 