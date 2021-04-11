//Flags
`define RST              1'b0
`define JUMP             1'b1
`define HOLD             1'b1
`define WRITE_ENABLE	   1'b1
                             
//Instruction parameters                
`define INST_WIDTH		   31:0
`define INST_ADDR_WIDTH  31:0
`define INI_INST_ADDR    32'h0
                             
//General integer register       
`define REG_NUM					 32    
`define DATA_WIDTH			   31:0
`define REG_ADDR_WIDTH   4:0
`define ZERO_REG 			   5'h0

//RAM 
`define RAM_ADDR_WIDTH   31:0 //?

//CSRs
//others might be needed while some below might be useless
`define CSR_ADDR_WIDTH 11:0

`define mstatus    12'h300	//*very complex                                       
`define misa       12'h301	//32'h40020000                                        
`define mie 	     12'h304	//mstatus and mask related?                           
`define mtvec      12'h305	//trap address                                        
`define mscratch   12'h340	//temporary register data saving before exception     
`define mepc			 12'h341	//the pc address before exception                     
`define mcause 		 12'h342	//exception cause indicator                           
`define mtval 		 12'h343	//opcode or memory address before exception           
`define mip 			 12'h344	//pending related?                                    
`define mcycle 		 12'hb00	//counting cycle times                                
`define mcycleh 	 12'hb80                                                        
`define mvendorid  12'hf11 	//32'h13109f5                                         
/*These might be totally useless
`define minstret 
`define minstreth 
`define msip 
*/

//NOP
`define NOP 			32h'1b

//LUI
`define LUI				7'b0110111

//AUIPC
`define AUIPC 		7'b0010111

//JAL and JALR
`define JAL 			7'b1101111
`define JALR 			7'b1100111

//B format *6
`define B_FORMAT	7'b1100011            
`define BEQ 			3'b000                
`define BNE 			3'b001                
`define BLT 			3'b100                
`define BGE 			3'b101                
`define BLTU 			3'b110                
`define BGEU 			3'b111                
                                        
//I format, loads *5                    
`define IL_FORMAT 7'b0000011            
`define LB 				3'b000                
`define LH 				3'b001                
`define LW 				3'b010                
`define LBU 			3'b100                
`define LHU 			3'b101                
                                        
//S format *3                           
`define S_FORMAT 	7'b0100011            
`define SB 				3'b000                
`define SH 				3'b001                
`define SW 				3'b010                
                                        
//I format *9                           
`define I_FORMAT 	7'b0010011            
`define ADDI 			3'b000                
`define SLTI 			3'b010                
`define SLTIU 		3'b011                
`define XORI 			3'b100                
`define ORI 			3'b110                
`define ANDI			3'b111                
`define SLLI 			3'b001                
`define SRLI_SRAI 3'b101                
	`define SRLI 		7'b0000000            
	`define SRAI 		7'b0100000            
                                        
//R format *10                          
`define R_FORMAT 	7'b0110011            
`define ADD_SUB 	3'b000                
	`define ADD 		7'b0000000            
	`define SUB			7'b0100000            
`define SLL 			3'b001                
`define SLT 			3'b010                
`define SLTU 			3'b011                
`define XOR 			3'b101                
`define SRL_SRA 	3'b101                
	`define SRL 		7'b0000000            
	`define SRA 		7'b0100000            
`define OR 				3'b110                
`define AND 			3'b111                

//FENCE and FENCE.I
`define FENCE_FENCEI	7'b0001111
`define FENCE 		3'b000        
`define FENCEI 		3'b001        
                                
//CSRs *8                       
`define CSR 			7'b1110011    
`define CSRRW 		3'b001        
`define CSRRS			3'b010        
`define CSRRC 		3'b011        
`define CSRRWI 		3'b101        
`define CSRRSI 		3'b110        
`define CSRRCI		3'b111        
                                
//Environment *2                
`define ECALL 		32'h73        
`define EBREAK 		32'h100073    