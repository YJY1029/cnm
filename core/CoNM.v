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
		.hold(extl_hold), 
		
		.pc_o(pc_prp_f1_pc_o), //is junction available? 
		.inst_o(pc_f1_o)//this might not be right, considering using fliop1 as ir
	);
	
	fliop1 u_fliop1(
		.clk(clk), 
		.rst(rst), 
		.hold(extl_hold), 
		.inst(pc_f1_inst), 
		.inst_addr(pc_f1_inst_addr), 
		
		.inst_o(f1_id_inst), 
		.inst_addr_o(f1_id_inst_addr)
	);
	
	id u_id(
		.rst(rst), 
		.inst(f1_id_inst), 
		.inst_addr(f1_id_inst_addr), 
		
		.rs1_raddr_o(id_csrgf_rs1_raddr), 
		.rs2_raddr_o(id_csrgf_rs2_raddr), 
		.csr_raddr_o(id_csrgf_csr_raddr), 
		.inst_o(id_extl_inst), 
		.inst_addr_o(id_f2_inst_addr), 
		.rd_waddr_o(id_f2_rd_waddr), 
		.csr_waddr_o(id_f2_csr_waddr), 
		.imm_o(id_f2_imm), 
		.alu_sel_o(id_f2_alu_sel), 
		.op1_sel_o(id_f2_op1_sel), 
		.op2_sel_o(id_f2_op2_sel), 
		.mem_rw_o(id_f2_mem_rw), 
		.br_sel_o(id_f2_br_sel), 
		.wb_sel_o(id_f2_wb_sel), 
		.byte_sel_o(id_f2_byte_sel)
	); 
	
	csregfile u_csregfile(
		.clk(clk), 
		.rst(rst), 
		.csr_waddr(extl_csrgf_csr_waddr), 
		.csr_wdata(extl_csrgf_csr_wdata), 
		.csr_raddr(id_csrgf_csr_raddr), 
		.rd_waddr(extl_csrgf_rd_waddr), 
		.rd_wdata(extl_csrgf_rd_wdata), 
		.rs1_data(id_csrgf_rs1_raddr), 
		.rs2_data(id_csrgf_rs2_raddr), 
		
		.csr_rdata(csrgf_f2_csr_rdata), 
		.rs1_rdata(csrgf_f2_rs1_rdata), 
		.rs1_rdata(csrgf_f2_rs2_rdata)
	);
	
	fliop2 u_fliop2(
		.clk(clk), 
		.rst(rst), 
		.hold(extl_hold), 
		.inst(id_f2_inst), 
		.inst_addr(id_f2_inst), 
		.rd_waddr(id_f2_rd_waddr), 
		.csr_waddr(id_f2_csr_waddr), 
		.imm(id_f2_imm), 
		.alu_sel(id_f2_alu_sel), 
		.op1_sel(id_f2_op1_sel), 
		.op2_sel(id_f2_op2_sel), 
		.mem_rw(id_f2_mem_rw), 
		.br_sel(id_f2_br_sel), 
		.wb_sel(id_f2_wb_sel), 
		.byte_sel(id_f2_byte_sel), 
		.rs1_rdata(csrgf_f2_rs1_rdata), 
		.rs2_rdata(csrgf_f2_rs2_rdata), 
		.csr_rdata(csrgf_f2_csr_rdata), 
		
		.inst_o(f2_extl_inst), 
		.inst_addr_o(f2_extl_inst), 
		.rd_waddr_o(f2_extl_rd_waddr), 
		.csr_waddr_o(f2_extl_csr_waddr), 
		.imm_o(f2_extl_imm), 
		.alu_sel_o(f2_extl_alu_sel), 
		.op1_sel_o(f2_extl_op1_sel), 
		.op2_sel_o(f2_extl_op2_sel), 
		.mem_rw_o(f2_extl_mem_rw), 
		.br_sel_o(f2_extl_br_sel), 
		.wb_sel_o(f2_extl_wb_sel), 
		.byte_sel_o(f2_extl_byte_sel), 
		.rs1_rdata_o(f2_extl_rs1_rdata), 
		.rs2_rdata_o(f2_extl_rs2_rdata), 
		.csr_rdata_o(f2_extl_csr_rdata)
	);
	
	executrol u_executrol( 
		.rst(rst), 
		.inst(id_extl_inst), 
		.inst_addr(id_extl_inst_addr), 
		.rd_waddr(id_extl_rd_waddr), 
		.csr_waddr(id_extl_csr_waddr), 
		.imm(id_extl_imm), 
		.alu_sel(id_extl_alu_sel), 
		.op1_sel(id_extl_op1_sel), 
		.op2_sel(id_extl_op2_sel), 
		.mem_rw(id_extl_mem_rw), 
		.br_sel(id_extl_br_sel), 
		.wb_sel(id_extl_wb_sel), 
		.byte_sel(id_extl_byte_sel),
		.rs1_rdata(csrgf_extl_rs1_rdata), 
		.rs2_rdata(csrgf_extl_rs2_rdata), 
		.csr_rdata(csrgf_extl_csr_rdata), 
		//.mem_rdata(sb_extl_mem_rdata), 
		
		.rd_waddr_o(extl_csrgf_rd_waddr), 
		.rd_wdata_o(extl_csrgf_rd_wdata), 
		.csr_waddr_o(extl_csrgf_csr_waddr), 
		.csr_wdata_o(extl_csrgf_csr_wdata), 
		.byte_sel_o(extl_sb_byte_sel), 
		.mem_re_o(extl_sb_mem_re), 
		.mem_raddr_o(extl_sb_mem_raddr), 
		.mem_we_o(extl_sb_mem_we), 
		.mem_waddr_o(extl_sb_mem_waddr), 
		.mem_wdata_o(extl_sb_mem_wdata), 
		.hold_o(extl_hold), 
		.jump_o(extl_pc_jump), 
		.jump_addr_o(extl_pc_jump_addr)
	);