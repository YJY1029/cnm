
# Core of Normal Microarchitecture
## Memo - 4/16
imm本身传进executrol内当做一个输入，alu只是用来对op1和op2做操作的器件
跳转地址如果不是alu的结果，就自己算自己的，自己带一个小型alu

如何load？如何save？
从mem_rw可以知道是load，此时根据byte_sel向总线发出信号，又根据alu_rslt得到地址，总线从mem取出数据，从总线取出数据
（数据和请求的时序问题怎么解决？加延时？），然后按其他类型一般向rd写入
从mem_rw可以知道是save，此时根据byte_sel取出寄存器中特定数据，alu_rslt是写入的地址，将数据与地址放入总线中即可，似乎不存在时序问题

imm有较大问题，暂定所有有符号、无符号的问题全部交由id解决，故id中的imm_o需要大加修改

R类型，基本没有问题，alu正常计算即可，需要解决shamt的问题（实际上仍是上述imm_o问题）
I类型，同上，只是将rs2中数据换成了imm罢了
S类型见上
B类型，op1与op2的比较由alu完成，完成后放入jump_o，跳转地址由executrol另外一个部分进行计算（可能存在时序问题）
U类型，auipc按照I类型的方法解决了，lui“可能”判定不到写回的数据，检查datapath，看看wb_sel有没有包括这一种情况
J类型，名字有误，wb_sel里面好像把它叫成了u_type

总之，思考认为imm_o，B类型（涉及jump_o与jump_addr）、L类型（涉及总线信号与以及内存）可能还有其他类型的时序，J类型的名字这三个方面很有可能存在问题
现在似乎把wb_sel信号弄得太重要了，明天需要仔细思考wb_sel的意义

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

3. ***id***: Instruction decoder. It's used to decode instructions from previous instruction fetch stage, using a completely combinational logical circuit. After this, while it passes register addresses to *csregfile*, informing it to output data to *executrol*, it also passes relevant information to *executrol*.  
4. ***csregfile***: Control and status registers and regfile. CSRs (control and status registers) and register file are integrated in this design, due to the obvious similarity between them, and they are in charge of reading and writing of these registers. From *id* it receives addresses of registers that are to be read by *executrol*, and outputs data in rs1 and/or rs2 or specific CSR; From *executrol* it receives we (write enable) signal, write address and write data of specific rd or CSR, and puts the data into where it belong. 
5. ***executrol***: Execution and control. Given that execution results are tightly coherent to control function, in this design we also integrated execution and control modules into *executrol*. This module performs all calculations, including add, sub, shift, etc., and all control-related operations, including jump, branch, hold, etc. In all, it performs functions referring to the information inputted from *id*, and control-related part processes its results. Finally, *executrol* outputs relevant signals along with operation results. 
6. ***Two fliops***: D flip-flops between each pipeline stage. They are both very simple D flip-flops: all data and signals inputted from previous stage are kept here for one tick and then sent to the next stage. Note that when hold signal is set, these two flip-flops will continuously perform NOP instructions until hold flag is off. 
7. ***sb***: A simple bus. Its details are to be determined, but in all it's a very simple bus connected to *pc*, *executrol* and the most significant peripheral *RAM*, transmitting instruction and data. 
8. ***CoNM***: Top module. All submodules are instantiated here, with several peripherals and global signals connected to it.

## Coding Style
To enhance readability and coding convenience, several coding principles should be clarified: 
 - Clean and simple macro definitions and variable naming,  e.g. non-suffix input variables and instruction names, -r-suffixed register variables and -o-suffixed output variables. 
 - Using *assign* statements as conditionals, as to avoid uncertain states and priority selection circuits under some circumstances. 
 - Initiating standard D flip-flop modules implemented elsewhere, which will greatly benefit the implementation process as well. 
 - Omitting every possible read or write enable signal, replacing them with specific hard-wired address, following the rule of RISC. 