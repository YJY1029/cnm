`inlcude "defines.v"

module sb(
	input wire clk, 
	input wire rst, 
	
	//from executrol
	input wire [`BYTE_SEL] byte_sel, 
	input wire mem_re, 
	input wire [`MEM_ADDR_WIDTH] mem_raddr, 
	input wire mem_we, 
	input wire [`MEM_ADDR_WIDTH] mem_waddr, 
	input wire [`DATA_WIDTH] mem_wdata, 
	
	//to csregfile
	output ? [`MEM_ADDR_WIDTH] mem_rdata_o
	
	//to mem
	output reg mem_re_o, 
	output reg mem_we_o, 
	output reg [`MEM_ADDR_WIDTH] mem_addr_o, 
	output reg [`DATA_WIDTH] mem_wdata_o, 
	); 
	
	always @ (posedge clk) begin
		