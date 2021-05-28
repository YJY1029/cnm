`include "../core/defines.v"

module dmem(
	input wire clk, 
	input wire rst, 
	input wire rw, 
	input wire [`MEM_ADDR_WIDTH] addr, 
	input wire [`DATA_WIDTH] wdata, 
	
	output reg [`DATA_WIDTH] rdata_o 
	); 
	
	reg [`DATA_WIDTH] mem_unit[0:2*`MEM_NUM-1]; 
	
	always @ (posedge clk) begin 
		if (rw == `WRITE_ENABLE) begin 
			mem_unit[addr] <= wdata; 
		end 
	end 
	
	always @ (*) begin 
		if (rst == `RST) begin 
			rdata_o = `ZERO32; 
		end else if (rw == `READ_ENABLE) begin 
			rdata_o = mem_unit[addr]; 
		end else begin
			
		end
	end 
	
endmodule 