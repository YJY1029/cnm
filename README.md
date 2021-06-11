

# Core of Normal Microarchitecture
## Update Log - 5/16
Paperwork and picturework. A so-called manual added. 

This project is an RV32I core of normal, simple and classical microarchitecture. 
This first version of design is very simple, focusing on simplicity and readability rather than performance, as it only has a four-stage pipeline, which is divided into instruction fetch, instruction decoding, execution and write-back. 
## Design Ideas

When implementing this design, there are three main design ideas: 

 1. *Classical*. A classical four-stage pipeline as well as a static branch prediction mechanism is implemented and no abundant optimization has been done. . 
 2. *Simple*. Similar modules are integrated, which unifies their functions and minimises the number of interfaces. 
 3. *Extendable*. Enough space for classical optimization modules , e.g. dynamic branch predictor, and future extension is kept. 

## Modules
![Datapath](https://github.com/YJY1029/conm/blob/main/datapath.png?raw=true)

Basically our core contains: 
1. ***defines***: Relevant parameters, configure, and necessary information of decoding. 
2. ***pc*** : Programme counter. It's used to indicate the address of current instruction. Global rst signal (connected to almost every module), hold signal and jump signal are connected to our *pc* module. If none of these signals request *pc* to change its address, then it points to the next instruction address, which is exactly one word, or four bytes away from current address. Most importantly, after deciding the address we are about to use, *pc* fetches the instruction from *sb* and passes it into *id*. 
3. ***id***: Instruction decoder. It's used to decode instructions fetched from the previous stage, using a completely combinational logical circuit. After this, while it passes register addresses to *csregfile*, informing it to output data to *executrol*, it also passes relevant information to *executrol*.  
4. ***csregfile***: Control and status registers and register file. CSRs (control and status registers) and register file are integrated in this design, due to the obvious similarity between them, and they are in charge of reading and writing of these registers. From *id* it receives addresses of registers that are to be read by *executrol*, and outputs data in rs1 and/or rs2 or specific CSR; From *executrol* it receives we (write enable) signal, write address and write data of specific rd or CSR, and puts the data into where it belong. 
5. ***executrol***: Execution and control. Given that execution results are tightly coherent to control function, in this design we also integrated execution and control modules into *executrol*. This module performs all calculations, including add, sub, shift, etc., and all control-related operations, including jump, branch, flush, etc. In all, it performs functions referring to the information inputted from *id*, and control-related part processes its results. Finally, *executrol* outputs relevant signals along with operation results. 
6. ***Two fliops***: D flip-flops between each pipeline stage. They are both very simple D flip-flops: all data and signals inputted from previous stage are kept here for one tick and then sent to the next stage. Note that when flush signal is set, these two flip-flops will continuously perform NOP instructions until flush flag is off. 
7. ***sb***: A simple bus. It's a rather simple bus connected to *executrol* and the most significant peripheral, data memory, transmitting instruction and data. 
8. ***CoNM***: Top module. All submodules are instantiated here, with several peripherals and global signals connected to it.

## Coding Style
To enhance readability and coding convenience, several coding principles should be clarified: 
 - Clean and simple macro definitions and variable naming,  e.g. non-suffixed input variables and instruction names, -r-suffixed register variables and -o-suffixed output variables. 
 - Using *assign* statements as conditionals, as to avoid uncertain states transfer problem and priority selection circuits under some circumstances. 
 - Initiating standard D flip-flop modules implemented elsewhere, which will greatly benefit the implementation process as well. 
 - Omitting read or write enable signal as many as possible, replacing them with specific hard-wired address, following the rule of RISC. 