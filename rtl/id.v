`include "defines.v"

module id(
	//global
	input wire rst,
	 
	//from fliop1
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	
	//to csregfile
	output wire [`REG_ADDR_WIDTH] rs1_addr_o, 
	output wire [`REG_ADDR_WIDTH] rs2_addr_o, 
	output wire [`CSR_ADDR_WIDTH] csr_addr_o,
	
	//to executrol
	output wire inst_addr_o, 
	output wire rd_we_o, 
	output wire [`REG_ADDR_WIDTH] rd_addr_o, 
	output wire csr_we_o, 
	output wire [`REG_ADDR_WIDTH] csr_o, 
	output wire imm_en_o, 
	output wire [`REG_WIDTH] imm_o, 
	output wire un_signed_o 
	);
	
	wire [6:0] opcode = inst[6:0]; 
	wire [`REG_ADDR_WIDTH] rd = inst[11:7];
	wire [2:0] funct3 = inst[14:12];
	wire [`REG_ADDR_WIDTH] rs1 = inst[19:15];
	wire [`REG_ADDR_WIDTH] rs2 = inst[24:20]; 
	wire [6:0] funct7 = inst[31:25]; 
	
	assign inst_addr_o = inst_addr; 
endmodule