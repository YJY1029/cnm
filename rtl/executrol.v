`include "defines.v"

module executrol(
	
	input wire rst, 
	
	//from id
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	input wire [`REG_ADDR_WIDTH] rd_waddr, 
	input wire [`CSR_ADDR_WIDTH] csr_waddr, 
	input wire [`DATA_WIDTH] imm, 
	input wire [`ALU_SEL] alu_sel, 
	input wire [`OP1_SEL] op1_sel, 
	input wire [`OP2_SEL] op2_sel, 
	input wire [`MEM_RW] mem_rw, 
	input wire [`BR_SEL] br_sel, 
	input wire [`WB_SEL] wb_sel, 
	input wire [`BYTE_SEL] byte_sel, 
	
	//from csregfile
	input wire [`DATA_WIDTH] rs1_rdata, 
	input wire [`DATA_WIDTH] rs2_rdata, 
	input wire [`DATA_WIDTH] csr_rdata, 
	
	//from sb
	input wire [`DATA_WIDTH] mem_rdata, 
	
	//to csregfile 
	output wire rd_we_o, 
	output wire [`REG_ADDR_WIDTH] rd_waddr_o, 
	output wire [`DATA_WIDTH] rd_wdata_o, 
	output wire [`CSR_ADDR_WIDTH] csr_waddr_o, 
	output wire [`DATA_WIDTH] csr_wdata_o, 
	
	//to sb
	output wire mem_req_o, 
	output ? [`MEM_ADDR_WIDTH] mem_raddr_o, 
	output wire mem_we_o, 
	output ? [`MEM_ADDR_WIDTH] mem_waddr_o, 
	output ? [`DATA_WIDTH] mem_wdata_o, 
	
	//to pc
	output ? hold_o, 
	output ? jump_o, 
	output wire [`INST_ADDR_WIDTH] jump_addr_o
	); 
	
	