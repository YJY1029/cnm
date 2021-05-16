`include "../core/defines.v"

module soc_top(
	input wire clk, 
	input wire rst, 
	
	output wire stop, 
	output wire succ 
	);
	
	//imem and pc
	wire [`INST_ADDR_WIDTH] pc_imem_inst_addr_r; 
	wire [`MEM_ADDR_WIDTH] pc_imem_inst_addr = {2'b0, pc_imem_inst_addr_r[31:2]}; 
	wire [`INST_WIDTH] imem_pc_inst; 
	
	//extl and sb
	wire extl_sb_un_sign; 
	wire [`BYTE_SEL] extl_sb_byte_mask; 
	wire extl_sb_mem_re; 
	wire extl_sb_mem_we; 
	wire [`MEM_ADDR_WIDTH] extl_sb_addr; 
	wire [`DATA_WIDTH] extl_sb_mem_wdata; 
	//sb and csrgf
	wire [`DATA_WIDTH] sb_csrgf_rdata; 
	
	/*suspended
	wire m1_un_sign = `UNSIGNED; 
	wire [`BYTE_SEL] m1_byte_mask = `SL_NONE; 
	wire m1_re = `READ_DISABLE; 
	wire m1_we = `WRITE_DISABLE; 
	wire [`MEM_ADDR_WIDTH] m1_addr = `ZERO32; 
	wire [`DATA_WIDTH] m1_wdata = `ZERO32; 
	reg [`DATA_WIDTH] m1_rdata; 
	*/
	
	//dmem and sb
	wire [`DATA_WIDTH] dmem_sb_rdata; 
	wire [3:0] sb_dmem_rw; 
	wire [`MEM_ADDR_WIDTH] sb_dmem_addr; 
	wire [`DATA_WIDTH] sb_dmem_wdata; 
	
imem imem(
  .clka(clk), // input clka
  .addra(pc_imem_inst_addr), // input [31 : 0] addra
  .douta(imem_pc_inst) // output [31 : 0] douta
);
	
CoNM u_CoNM(
	.clk(clk), 
	.rst(rst), 
	
	.imem_pc_inst(imem_pc_inst), 
	.sb_csrgf_rdata(sb_csrgf_rdata), 
	
	.pc_imem_inst_addr(pc_imem_inst_addr_r), 
	
	.extl_sb_un_sign_o(extl_sb_un_sign), 
	.extl_sb_byte_mask_o(extl_sb_byte_mask), 
	.extl_sb_mem_re_o(extl_sb_mem_re), 
	.extl_sb_mem_we_o(extl_sb_mem_we), 
	.extl_sb_addr_o(extl_sb_addr), 
	.extl_sb_mem_wdata_o(extl_sb_mem_wdata), 
	.stop(stop), 
	.succ(succ)
	);
	
sb u_sb(
	.clk(clk), 
	.rst(rst), 
	
	.m0_un_sign(extl_sb_un_sign), 
	.m0_byte_mask(extl_sb_byte_mask), 
	.m0_re(extl_sb_mem_re), 
	.m0_we(extl_sb_mem_we), 
	.m0_addr(extl_sb_addr), 
	.m0_wdata(extl_sb_mem_wdata), 
	.m0_rdata_o(sb_csrgf_rdata), 
	
	.m1_un_sign(), 
	.m1_byte_mask(), 
	.m1_re(), 
	.m1_we(), 
	.m1_addr(), 
	.m1_wdata(), 
	.m1_rdata_o(), 
	
	.s_rdata(dmem_sb_rdata), 
	.s_rw_o(sb_dmem_rw), 
	.s_addr_o(sb_dmem_addr), 
	.s_wdata_o(sb_dmem_wdata)
	); 
	
dmem dmem (
  .clka(clk),    // input wire clka
  
  .wea(sb_dmem_rw),      // input wire [3 : 0] wea
  .addra(sb_dmem_addr),  // input wire [31 : 0] addra
  .dina(sb_dmem_wdata),    // input wire [31 : 0] dina
  .douta(dmem_sb_rdata)  // output wire [31 : 0] douta
);
	
endmodule