`include "defines.v"

module sb(
	input wire clk, 
	input wire rst, 
	//master0 interface, executrol exclusive
	input wire m0_un_sign, 
	input wire [`BYTE_SEL] m0_byte_mask, 
	input wire m0_re, 
	input wire m0_we, 
	input wire [`MEM_ADDR_WIDTH] m0_addr, 
	input wire [`DATA_WIDTH] m0_wdata, 
	
	output reg [`DATA_WIDTH] m0_rdata_o, 
	
	//master1 interface, pc exclusive
	input wire m1_un_sign, 
	input wire [`BYTE_SEL] m1_byte_mask, 
	input wire m1_re, 
	input wire m1_we, 
	input wire [`MEM_ADDR_WIDTH] m1_addr, 
	input wire [`MEM_ADDR_WIDTH] m1_wdata, 
	
	output reg [`DATA_WIDTH] m1_rdata_o, 
	
	//slave interface, mem exclusive
	input wire [`DATA_WIDTH] s_rdata, 
	
	output reg s_rw_o, 
	output reg [`MEM_ADDR_WIDTH] s_addr_o, 
	output reg [`DATA_WIDTH] s_wdata_o 
	); 
	//input
	always @ (*) begin
		m0_rdata_o = `ZERO32; 
		m1_rdata_o = `ZERO32; 
		s_wdata_o = `ZERO32; 
		
		if (m0_re) begin
			s_rw_o = 1'b0; 
			s_addr_o = m0_addr; 
			m0_rdata_o = 
				m0_byte_mask[3] ? s_rdata : 
				m0_byte_mask[1] ? {{16{m0_un_sign&s_rdata[15]}}, {16{1'b1}}} & s_rdata : 
				m0_byte_mask[0] ? {{24{m0_un_sign&s_rdata[15]}}, {8{1'b1}}} & s_rdata : 
				`ZERO32; 
		end else if (m0_we) begin 
			s_rw_o = `WRITE_ENABLE; 
			s_addr_o = m0_addr; 
			s_wdata_o = m0_wdata; 
			
		end else if (m1_re) begin 
			s_rw_o = 1'b0; 
			s_addr_o = m1_addr; 
			m1_rdata_o = 
				m1_byte_mask[3] ? s_rdata : 
				m1_byte_mask[1] ? {{16{m1_un_sign&s_rdata[15]}}, {16{1'b1}}} & s_rdata : 
				m1_byte_mask[0] ? {{24{m1_un_sign&s_rdata[15]}}, {8{1'b1}}} & s_rdata : 
				`ZERO32; 
		end else if (m0_we) begin
			s_rw_o = `WRITE_ENABLE; 
			s_addr_o = m0_addr; 
			s_wdata_o = m0_wdata; 
		end else begin
			
		end
	end
endmodule