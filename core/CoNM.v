`include "defines.v"

module CoNM(
	input wire clk, 
	input wire rst, 
	
	input ? [`INST_WIDTH] prp_inst,
	
	input ? [`DATA_WIDTH] prp_rdata, 
	
	output ? [`INST_ADDR_WIDTH] prp_inst_addr, 
	
	output ? prp_re_o, 
	output ? prp_we_o, 
	output ? [`MEM_ADDR_WIDTH] prp_addr, 
	output ? [`DATA_WIDTH] prp_wdata 
	); 
	
	//in pipeline stage order
	pc u_pc(
		.rst(rst), 
		.inst(prp_inst), 
		.jump(extl_pc_jump), 
		.jump_addr(extl_pc_jump_addr), 
		.hold(extl_pc_hold), 
		.pc_o(pc_prp_f1_pc_o), //is junction available? 
		.inst_o(pc_f1_o)//this might not be right, considering using fliop1 as ir
	);
	
	