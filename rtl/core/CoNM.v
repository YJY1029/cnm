`include "defines.v"

module CoNM(
	input wire clk, 
	input wire rst, 
	//sb to pc
	input wire [`INST_WIDTH] imem_pc_inst, 
	//sb to csregfile
	input wire [`DATA_WIDTH] sb_csrgf_rdata, 
	//pc to sb
	output wire [`INST_ADDR_WIDTH] pc_imem_inst_addr, 
	//extl to sb
	output wire extl_sb_un_sign_o, 
	output wire [`BYTE_SEL] extl_sb_byte_mask_o, 
	output wire extl_sb_mem_re_o, 
	output wire extl_sb_mem_we_o, 
	output wire [`MEM_ADDR_WIDTH] extl_sb_addr_o, 
	output wire [`DATA_WIDTH] extl_sb_mem_wdata_o
	); 
	
	//these are executrol outputs
	wire [`REG_ADDR_WIDTH] extl_csrgf_rd_waddr; 
	wire [`DATA_WIDTH] extl_csrgf_rd_wdata; 
	wire [`CSR_ADDR_WIDTH] extl_csrgf_csr_waddr; 
	wire [`DATA_WIDTH] extl_csrgf_csr_wdata; 
	wire extl_jump; 
	wire [`INST_ADDR_WIDTH] extl_pc_jump_addr; 
	
	//in pipeline stage order
	wire [`INST_ADDR_WIDTH] pc_f1_inst_addr; 
	wire [`INST_WIDTH] pc_f1_inst; 
	assign pc_imem_inst_addr = pc_f1_inst_addr; 
	pc u_pc(
		.clk(clk), 
		.rst(rst), 
		
		.inst(imem_pc_inst), 
		.jump(extl_jump), 
		.jump_addr(extl_pc_jump_addr), 
		
		.pc_o(pc_f1_inst_addr), 
		.inst_o(pc_f1_inst)
	);
	
	wire [`INST_WIDTH] f1_id_inst; 
	wire [`INST_ADDR_WIDTH] f1_id_inst_addr; 
	fliop1 u_fliop1(
		.clk(clk), 
		.rst(rst), 
		
		.flush(extl_jump), 
		.inst(pc_f1_inst), 
		.inst_addr(pc_f1_inst_addr), 
		
		.inst_o(f1_id_inst), 
		.inst_addr_o(f1_id_inst_addr)
	);
	
	wire [`REG_ADDR_WIDTH] id_csrgf_rs1_raddr; 
	wire [`REG_ADDR_WIDTH] id_csrgf_rs2_raddr; 
	wire [`CSR_ADDR_WIDTH] id_csrgf_csr_raddr; 
	wire [`INST_WIDTH] id_f2_inst; 
	wire [`INST_ADDR_WIDTH] id_f2_inst_addr; 
	wire [`REG_ADDR_WIDTH] id_f2_rd_waddr; 
	wire [`CSR_ADDR_WIDTH] id_f2_csr_waddr; 
	wire [`DATA_WIDTH] id_f2_imm; 
	wire [`OP1_SEL] id_f2_op1_sel; 
	wire [`OP2_SEL] id_f2_op2_sel; 
	wire [`ALU_SEL] id_f2_alu_sel; 
	wire [`BR_SEL] id_f2_br_sel; 
	wire [`WB_SEL] id_f2_wb_sel; 
	wire [`MEM_RW] id_f2_mem_rw; 
	wire [`BYTE_SEL] id_f2_byte_sel; 
	wire id_f2_un_sign; 
	id u_id(
		.rst(rst), 
		.inst(f1_id_inst), 
		
		.inst_addr(f1_id_inst_addr), 
		
		.rs1_raddr_o(id_csrgf_rs1_raddr), 
		.rs2_raddr_o(id_csrgf_rs2_raddr), 
		.csr_raddr_o(id_csrgf_csr_raddr), 
		.inst_o(id_f2_inst), 
		.inst_addr_o(id_f2_inst_addr), 
		.rd_waddr_o(id_f2_rd_waddr), 
		.csr_waddr_o(id_f2_csr_waddr), 
		.imm_o(id_f2_imm), 
		.op1_sel_o(id_f2_op1_sel), 
		.op2_sel_o(id_f2_op2_sel), 
		.alu_sel_o(id_f2_alu_sel), 
		.br_sel_o(id_f2_br_sel), 
		.wb_sel_o(id_f2_wb_sel), 
		.mem_rw_o(id_f2_mem_rw), 
		.byte_sel_o(id_f2_byte_sel), 
		.un_sign_o(id_f2_un_sign)
	); 
	
	wire [`DATA_WIDTH] csrgf_f2_csr_rdata; 
	wire [`DATA_WIDTH] csrgf_f2_rs1_rdata; 
	wire [`DATA_WIDTH] csrgf_f2_rs2_rdata; 
	csregfile u_csregfile(
		.clk(clk), 
		.rst(rst), 
		
		.csr_waddr(extl_csrgf_csr_waddr), 
		.csr_wdata(extl_csrgf_csr_wdata), 
		.csr_raddr(id_csrgf_csr_raddr), 
		.rd_waddr(extl_csrgf_rd_waddr), 
		.extl_rd_wdata(extl_csrgf_rd_wdata), 
		.sb_rd_wdata(sb_csrgf_rdata), 
		.rs1_raddr(id_csrgf_rs1_raddr), 
		.rs2_raddr(id_csrgf_rs2_raddr), 
		
		.csr_rdata_o(csrgf_f2_csr_rdata), 
		.rs1_rdata_o(csrgf_f2_rs1_rdata), 
		.rs2_rdata_o(csrgf_f2_rs2_rdata)
	);
	
	wire [`INST_WIDTH] f2_extl_inst; 
	wire [`INST_ADDR_WIDTH] f2_extl_inst_addr; 
	wire [`REG_ADDR_WIDTH] f2_extl_rd_waddr; 
	wire [`CSR_ADDR_WIDTH] f2_extl_csr_waddr; 
	wire [`DATA_WIDTH] f2_extl_imm; 
	wire [`OP1_SEL] f2_extl_op1_sel; 
	wire [`OP2_SEL] f2_extl_op2_sel; 
	wire [`ALU_SEL] f2_extl_alu_sel; 
	wire [`BR_SEL] f2_extl_br_sel; 
	wire [`WB_SEL] f2_extl_wb_sel; 
	wire [`MEM_RW] f2_extl_mem_rw; 
	wire [`BYTE_SEL] f2_extl_byte_sel; 
	wire f2_extl_un_sign; 
	wire [`DATA_WIDTH] f2_extl_rs1_rdata; 
	wire [`DATA_WIDTH] f2_extl_rs2_rdata; 
	wire [`DATA_WIDTH] f2_extl_csr_rdata; 
	fliop2 u_fliop2(
		.clk(clk), 
		.rst(rst), 
		
		.flush(extl_jump), 
		.inst(id_f2_inst), 
		.inst_addr(id_f2_inst_addr), 
		.rd_waddr(id_f2_rd_waddr), 
		.csr_waddr(id_f2_csr_waddr), 
		.imm(id_f2_imm), 
		.op1_sel(id_f2_op1_sel), 
		.op2_sel(id_f2_op2_sel), 
		.alu_sel(id_f2_alu_sel), 
		.br_sel(id_f2_br_sel), 
		.wb_sel(id_f2_wb_sel), 
		.mem_rw(id_f2_mem_rw), 
		.byte_sel(id_f2_byte_sel), 
		.un_sign(id_f2_un_sign), 
		.rs1_rdata(csrgf_f2_rs1_rdata), 
		.rs2_rdata(csrgf_f2_rs2_rdata), 
		.csr_rdata(csrgf_f2_csr_rdata), 
		
		.inst_o(f2_extl_inst), 
		.inst_addr_o(f2_extl_inst_addr), 
		.rd_waddr_o(f2_extl_rd_waddr), 
		.csr_waddr_o(f2_extl_csr_waddr), 
		.imm_o(f2_extl_imm), 
		.op1_sel_o(f2_extl_op1_sel), 
		.op2_sel_o(f2_extl_op2_sel), 
		.alu_sel_o(f2_extl_alu_sel), 
		.br_sel_o(f2_extl_br_sel), 
		.wb_sel_o(f2_extl_wb_sel), 
		.mem_rw_o(f2_extl_mem_rw), 
		.byte_sel_o(f2_extl_byte_sel), 
		.un_sign_o(f2_extl_un_sign),
		.rs1_rdata_o(f2_extl_rs1_rdata), 
		.rs2_rdata_o(f2_extl_rs2_rdata), 
		.csr_rdata_o(f2_extl_csr_rdata)
	);
	
	wire [`MEM_ADDR_WIDTH] extl_sb_mem_raddr; 
	wire [`MEM_ADDR_WIDTH] extl_sb_mem_waddr; 
	assign extl_sb_addr_o = 
		extl_sb_mem_re_o ? extl_sb_mem_raddr : 
		extl_sb_mem_we_o ? extl_sb_mem_waddr : 
		`ZERO32; 
	executrol u_executrol( 
		.rst(rst), 
		
		.inst(f2_extl_inst), 
		.inst_addr(f2_extl_inst_addr), 
		.rd_waddr(f2_extl_rd_waddr), 
		.csr_waddr(f2_extl_csr_waddr), 
		.imm(f2_extl_imm), 
		.op1_sel(f2_extl_op1_sel), 
		.op2_sel(f2_extl_op2_sel), 
		.alu_sel(f2_extl_alu_sel), 
		.br_sel(f2_extl_br_sel), 
		.wb_sel(f2_extl_wb_sel), 
		.mem_rw(f2_extl_mem_rw), 
		.byte_sel(f2_extl_byte_sel), 
		.un_sign(f2_extl_un_sign), 
		.rs1_rdata(f2_extl_rs1_rdata), 
		.rs2_rdata(f2_extl_rs2_rdata), 
		.csr_rdata(f2_extl_csr_rdata), 
		
		.rd_waddr_o(extl_csrgf_rd_waddr), 
		.rd_wdata_o(extl_csrgf_rd_wdata), 
		.csr_waddr_o(extl_csrgf_csr_waddr), 
		.csr_wdata_o(extl_csrgf_csr_wdata),
		.un_sign_o(extl_sb_un_sign_o), 
		.byte_sel_o(extl_sb_byte_mask_o), 
		.mem_re_o(extl_sb_mem_re_o), 
		.mem_raddr_o(extl_sb_mem_raddr), 
		.mem_we_o(extl_sb_mem_we_o), 
		.mem_waddr_o(extl_sb_mem_waddr), 
		.mem_wdata_o(extl_sb_mem_wdata_o), 
		.jump_o(extl_jump), 
		.jump_addr_o(extl_pc_jump_addr)
	);
	
endmodule