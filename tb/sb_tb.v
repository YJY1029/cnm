`include "../rtl/core/defines.v"

module sb_tb(); 
	
	//Clock signal
	localparam clk_period = 10; 
	reg clk; 
	initial clk = 1'b0; 
	always #(clk_period/2) clk = ~clk; 
	
	reg rst; 
	reg m0_un_sign; 
	reg [`BYTE_SEL] m0_byte_mask; 
	reg m0_re; 
	reg m0_we; 
	reg [`MEM_ADDR_WIDTH] m0_addr; 
	reg [`DATA_WIDTH] m0_wdata; 
	wire [`DATA_WIDTH] m0_rdata_o; 
	
	reg rst; 
	reg m1_un_sign; 
	reg [`BYTE_SEL] m1_byte_mask; 
	reg m1_re; 
	reg m1_we; 
	reg [`MEM_ADDR_WIDTH] m1_addr; 
	reg [`DATA_WIDTH] m1_wdata; 
	wire [`DATA_WIDTH] m1_rdata_o; 
	
	reg [`DATA_WIDTH] s_rdata; 
	wire s_rw_o; 
	wire [`MEM_ADDR_WIDTH] s_addr_o; 
	wire [`DATA_WIDTH] s_wdata_o; 

sb u_sb(
	.clk(clk), 
	.rst(rst), 
	.m0_un_sign(m0_un_sign), 
	.m0_byte_mask(m0_byte_mask), 
	.m0_re(m0_re), 
	.m0_we(m0_we), 
	.m0_addr(m0_addr), 
	.m0_wdata(m0_wdata), 
	.m0_rdata(m0_rdata_o), 
	
	.m1_un_sign(m1_un_sign), 
	.m1_byte_mask(m1_byte_mask), 
	.m1_re(m1_re), 
	.m1_we(m1_we), 
	.m1_addr(m1_addr), 
	.m1_wdata(m1_wdata), 
	.m1_rdata(m1_rdata_o), 
	
	.s_rdata(s_rdata), 
	.s_rw_o(s_rw_o), 
	.s_addr_o(s_addr_o), 
	.s_wdata_o(s_wdata_o)
	);
	
	initial begin
		rst = `RST; 
		#10; 
		rst = `UNRST; 
		
		//