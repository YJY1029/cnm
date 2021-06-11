`timescale 1ns/1ps
`include "../rtl/core/defines.v"
`define REGS u_soc_top.u_CoNM.u_csregfile.regs

module vvd_tb(); 

	//Clock signal
	localparam clk_period = 8; 
	reg sys_clk; 
	initial sys_clk = 1'b0; 
	always #(clk_period/2) sys_clk = ~sys_clk; 
	
	reg rst; 
	
	wire [`DATA_WIDTH] x1 = `REGS[1]; 
	wire [`DATA_WIDTH] x3 = `REGS[3]; 
	wire [`DATA_WIDTH] x4 = `REGS[4]; 
	wire [`DATA_WIDTH] x5 = `REGS[5]; 
	wire [`DATA_WIDTH] x6 = `REGS[6]; 
	wire [`DATA_WIDTH] x26 = `REGS[26]; 
	wire [`DATA_WIDTH] x27 = `REGS[27]; 
	wire [`DATA_WIDTH] x29 = `REGS[29]; 
	wire [`DATA_WIDTH] x30 = `REGS[30]; 
	wire clk = u_soc_top.clk; 
	wire [`INST_ADDR_WIDTH] inst_addr = u_soc_top.pc_imem_inst_addr; 
	wire [`INST_WIDTH] inst = u_soc_top.imem_pc_inst;
	wire [`INST_ADDR_WIDTH] inst_addr_1 = u_soc_top.u_CoNM.f1_id_inst_addr; 
	wire [`INST_WIDTH] inst_1 = u_soc_top.u_CoNM.f1_id_inst; 
	wire [`INST_ADDR_WIDTH] inst_addr_2 = u_soc_top.u_CoNM.f2_extl_inst_addr;
	wire [`INST_WIDTH] inst_2 = u_soc_top.u_CoNM.f2_extl_inst;  
	wire [`DATA_WIDTH] imm = u_soc_top.u_CoNM.f2_extl_imm; 
	wire jump_o = u_soc_top.u_CoNM.extl_jump; 
	wire [`INST_ADDR_WIDTH] jump_addr_o = u_soc_top.u_CoNM.extl_pc_jump_addr; 
	
	initial begin
		rst = `RST; 
		#40; 
		rst = `UNRST; 
	end
	
soc_top u_soc_top(
	.sys_clk(sys_clk), 
	.rst(rst), 
	.stop(stop), 
	.bug(bug)
	); 
	
endmodule