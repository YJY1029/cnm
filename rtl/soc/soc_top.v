`include "../core/defines.v"

module soc_top(
	input wire sys_clk, 
	input wire rst, 
	
	output reg stop, 
	output reg bug, 
	output reg rst_o 
	);
	
	wire clk; 
	
	//imem and pc
	wire [`MEM_ADDR_WIDTH] pc_imem_inst_addr; 
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
	
clk_wiz clk_wiz(
  // Clock out ports
  .clk_50(clk),     // output clk_25
  // Clock in ports
  .clk_in1(sys_clk) // input clk_in1
);
	
imem_gen imem(
  .clka(sys_clk), // input clka
  .addra(pc_imem_inst_addr), // input [31 : 0] addra
  .douta(imem_pc_inst) // output [31 : 0] douta
);
	
CoNM u_CoNM(
	.clk(clk), 
	.rst(rst), 
	
	.imem_pc_inst(imem_pc_inst), 
	.sb_csrgf_rdata(sb_csrgf_rdata), 
	
	.pc_imem_inst_addr(pc_imem_inst_addr), 
	
	.extl_sb_un_sign_o(extl_sb_un_sign), 
	.extl_sb_byte_mask_o(extl_sb_byte_mask), 
	.extl_sb_mem_re_o(extl_sb_mem_re), 
	.extl_sb_mem_we_o(extl_sb_mem_we), 
	.extl_sb_addr_o(extl_sb_addr), 
	.extl_sb_mem_wdata_o(extl_sb_mem_wdata)
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
	
dmem_gen dmem (
  .clka(sys_clk),    // input wire clka
  
  .wea(sb_dmem_rw),      // input wire [3 : 0] wea
  .addra(sb_dmem_addr),  // input wire [31 : 0] addra
  .dina(sb_dmem_wdata),    // input wire [31 : 0] dina
  .douta(dmem_sb_rdata)  // output wire [31 : 0] douta
);

    always @ (posedge clk) begin
        if (rst == `RST) begin
            rst_o <= 1'b0; 
            stop <= 1'b1;
            bug <= 1'b1;
        end else begin
            rst_o <= 1'b1; 
            stop <= u_CoNM.u_csregfile.regs[26][0];  // programme finished
            bug <= ~u_CoNM.u_csregfile.regs[27][0];  // "damn it!"
        end
    end
	
endmodule