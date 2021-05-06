`include "../core/defines.v"

module mem(
	input wire clk, 
	input wire rst, 
	input wire rw, 
	input wire [`MEM_ADDR_WIDTH] addr, 
	input wire [`DATA_WIDTH] wdata, 
	
	output reg [`DATA_WIDTH] rdata_o
	); 
	
	reg [`DATA_WIDTH] mem_unit[0:`MEM_NUM-1]; 
	
	always @ (posedge clk) begin
		if (rw == `WRITE_ENABLE) begin
			mem_unit[addr[31:2]] <= wdata; 
		end
	end
	
	always @ (*) begin
		if (rst == `RST) begin
			rdata_o = 32'h0; 
		end else begin
			rdata_o = mem_unit[addr[31:2]]; 
		end
	end
	
endmodule