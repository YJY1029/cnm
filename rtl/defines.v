//Flags
`define RST 1b'0
`define JUMP 1b'1
`define HOLD 1b'1

//Instruction
`define INST_WIDTH 31:0
`define INST_ADDR_WIDTH 31:0
`define INI_INST_ADDR 32h'0

//General integer register
`define REG_WIDTH 31:0
`define REG_ADDR_WIDTH 4:0

//CSR
//others might be needed while some below might be useless
`define CSR_ADDR_WIDTH 11:0

`define mstatus 12h'300 //*very complex
`define misa 12h'301 //32h'40020000
`define mie 12h'304//mstatus and mask related?
`define mtvec 12h'305//trap address
`define mscratch 12h'340//temporary register data saving before exception
`define mepc 12h'341//the pc address before exception
`define mcause 12h'342//exception cause indicator
`define mtval 12h'343//opcode or memory address before exception
`define mip 12h'344//pending related?
`define mcycle 12h'b00//counting cycle times
`define mcycleh 12h'b80
`define mvendorid 12h'f11 //32h'13109f5
/*
`define minstret //this one might be totally useless
`define minstreth 
`define msip 
*/