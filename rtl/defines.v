//Flags
`define RST 1b'0
`define JUMP 1b'1
`define HOLD 1b'1

//Instruction parameters
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

//LUI
`define LUI		7b'0110111

//AUIPC
`define AUIPC 7b'0010111

//JAL and JALR
`define JAL 		7b'1101111
`define JALR 	7b'1100111

//B format *6
`define B_FORMAT	7b'1100011
`define BEQ 3b'000
`define BNE 3b'001
`define BLT 3b'100
`define BGE 3b'101
`define BLTU 3b'110
`define BGEU 3b'111

//I format, loads *5
`define IL_FORMAT 7b'0000011
`define LB 3b'000
`define LH 3b'001
`define LW 3b'010
`define LBU 3b'100
`define LHU 3b'101

//S format *3
`define S_FORMAT 7b'0100011
`define SB 3b'000
`define SH 3b'001
`define SW 3b'010

//I format *9
`define I_FORMAT 7b'0010011
`define ADDI 3b'000
`define SLTI 3b'010
`define SLTIU 3b'011
`define XORI 3b'100
`define ORI 3b'110
`define ANDI 3b'111
`define SLLI 3b'001
`define SRLI_SRAI 3b'101
	`define SRLI 7b'0000000
	`define SRAI 7b'0100000

//R format *10
`define R_FORMAT 7b'0110011
`define ADD_SUB 3b'000
	`define ADD 7b'0000000
	`define SUB 7b'0100000
`define SLL 3b'001
`define SLT 3b'010
`define SLTU 3b'011
`define XOR 3b'101
`define SRL_SRA 3b'101
	`define SRL 7b'0000000
	`define SRA 7b'0100000
`define OR 3b'110
`define AND 3b'111

//FENCE and FENCE.I
`define FENCE_FENCEI 7b'0001111
`define FENCE 3b'000
`define FENCEI 3b'001

//Environment and CSRs *8
`define ENVIR_CSR 7b'1110011
`define ENVIR 3b'000
	`define ECALL 12b'0
	`define EBREAK 12b'1
`define CSRRW 3b'001
`define CSRRS	3b'010
`define CSRRC 3b'011
`define CSRRWI 3b'101
`define CSRRSI 3b'110
`define CSRRCI 3b'111