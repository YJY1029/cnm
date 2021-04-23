`include "defines.v"

module fliop2( 
	input clk, 
	input rst, 
	input hold, 
	
	//from id
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	input wire [`REG_ADDR_WIDTH] rd_waddr, 
	input wire [`CSR_ADDR_WIDTH] csr_waddr, 
	input wire [`DATA_WIDTH] imm, 
	input wire [`ALU_SEL] alu_sel, 
	input wire [`OP1_SEL] op1_sel, 
	input wire [`OP2_SEL] op2_sel, 
	input wire [`BR_SEL] br_sel, 
	input wire [`MEM_RW] mem_rw,
	input wire [`WB_SEL] wb_sel, 
	input wire [`BYTE_SEL] byte_sel, 
	input wire un_sign, 
	
	//from csregfile
	input wire [`DATA_WIDTH] rs1_rdata, 
	input wire [`DATA_WIDTH] rs2_rdata,
	input wire [`DATA_WIDTH] csr_rdata, 
	
	//to executrol
	output wire [`INST_WIDTH] inst_o, 
	output wire [`INST_ADDR_WIDTH] inst_addr_o, 
	output wire [`REG_ADDR_WIDTH] rd_waddr_o, 
	output wire [`CSR_ADDR_WIDTH] csr_waddr_o, 
	output wire [`DATA_WIDTH] imm_o, 
	output wire [`ALU_SEL] alu_sel_o, 
	output wire [`OP1_SEL] op1_sel_o, 
	output wire [`OP2_SEL] op2_sel_o, 
	output wire [`MEM_RW] mem_rw_o, 
	output wire [`BR_SEL] br_sel_o, 
	output wire [`WB_SEL] wb_sel_o, 
	output wire [`BYTE_SEL] byte_sel_o, 
	output wire un_sign_o, 
	output wire [`DATA_WIDTH] rs1_rdata_o, 
	output wire [`DATA_WIDTH] rs2_rdata_o,
	output wire [`DATA_WIDTH] csr_rdata_o
	); 
	
	wire [`INST_WIDTH] inst_r; 
	gnrl_dff #(32) inst_dff(clk, rst, hold, `NOP, inst, inst_r); 
	assign inst_o = inst_r; 
	
	wire [`INST_ADDR_WIDTH] inst_addr_r; 
	gnrl_dff #(32) inst_addr_dff(clk, rst, hold, `INI_INST_ADDR, inst_addr, inst_addr_r); 
	assign inst_addr_o = inst_addr_r; 
	
	wire [`REG_ADDR_WIDTH] rd_waddr_r; 
	gnrl_dff #(5) rd_waddr_dff(clk, rst, hold, `ZERO_REG, rd_waddr, rd_waddr_r); 
	assign rd_waddr_o = rd_waddr_r; 
	
	wire [`CSR_ADDR_WIDTH] csr_waddr_r; 
	gnrl_dff #(12) csr_waddr_dff(clk, rst, hold, `mdisable, csr_waddr, csr_waddr_r); 
	assign csr_waddr_o = csr_waddr_r; 
	
	wire [`DATA_WIDTH] imm_r; 
	gnrl_dff #(32) imm_dff(clk, rst, hold, 32'h0, imm, imm_r); 
	assign imm_o = imm_r; 
	
	wire [`ALU_SEL] alu_sel_r; 
	gnrl_dff #(4) alu_sel_dff(clk, rst, hold, `ALU_ADD, alu_sel, alu_sel_r); 
	assign alu_sel_o = alu_sel_r; 
	
	wire [`OP1_SEL] op1_sel_r; 
	gnrl_dff #(2) op1_sel_dff(clk, rst, hold, `ZERO_REG, op1_sel, op1_sel_r); 
	assign op1_sel_o = op1_sel_r; 
	
	wire [`OP2_SEL] op2_sel_r; 
	gnrl_dff #(2) op2_sel_dff(clk, rst, hold, `ZERO_REG, op2_sel, op2_sel_r); 
	assign op2_sel_o = op2_sel_r; 
	
	wire [`BR_SEL] br_sel_r; 
	gnrl_dff #(3) br_sel_dff(clk, rst, hold, `BR_DISABLE, br_sel, br_sel_r); 
	assign br_sel_o = br_sel_r; 
	
	wire mem_rw_r; 
	gnrl_dff #(2) mem_rw_dff(clk, rst, hold, `MEM_DISABLE, mem_rw, mem_rw_r); 
	assign mem_rw_o = mem_rw_r; 
	
	wire [`WB_SEL] wb_sel_r; 
	gnrl_dff #(3) wb_sel_dff(clk, rst, hold, `WB_NONE, wb_sel, wb_sel_r); 
	assign wb_sel_o = wb_sel_r; 
	
	wire [`BYTE_SEL] byte_sel_r; 
	gnrl_dff #(2) byte_sel_dff(clk, rst, hold, `SL_NONE, byte_sel, byte_sel_r); 
	assign byte_sel_o = byte_sel_r; 
	
	wire un_sign_r; 
	gnrl_dff #(1) un_sign_dff(clk, rst, hold, `UNSIGNED, un_sign, un_sign_r); 
	assign un_sign_o = un_sign_r; 
	
	wire [`DATA_WIDTH] rs1_rdata_r; 
	gnrl_dff #(32) rs1_rdata_dff(clk, rst, hold, 32'h0, rs1_rdata, rs1_rdata_r); 
	assign rs1_rdata_o = rs1_rdata_r; 
	
	wire [`DATA_WIDTH] rs2_rdata_r; 
	gnrl_dff #(32) rs2_rdata_dff(clk, rst, hold, 32'h0, rs2_rdata, rs2_rdata_r); 
	assign rs2_rdata_o = rs2_rdata_r; 
	
	wire [`DATA_WIDTH] csr_rdata_r; 
	gnrl_dff #(32) csr_rdata_dff(clk, rst, hold, 32'h0, csr_rdata, csr_rdata_r); 
	assign csr_rdata_o = csr_rdata_r; 
	
endmodule