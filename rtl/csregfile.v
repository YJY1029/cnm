`include "defines.v"

module csregfile(
	input wire clk, 
	input wire rst, 
	
	//csr from executrol
	input wire csr_we, 
	input wire [`RAM_ADDR_WIDTH] csr_waddr, 
	input wire [`DATA_WIDTH] csr_wdata, 
	
	//csr from id
	input wire [`RAM_ADDR_WIDTH] csr_raddr, 
	
	//csr to executrol
	output reg [`DATA_WIDTH] csr_rdata, 
	
	//regfile from executrol
	input wire rd_we, 
	input wire [`REG_ADDR_WIDTH] waddr, 
	input wire [`DATA_WIDTH] wdata, 
	
	//regfile from id
	input wire [`REG_ADDR_WIDTH] rs1_raddr, 
	input wire [`REG_ADDR_WIDTH] rs2_raddr, 
	
	//regfile to executrol
	output reg [`DATA_WIDTH] rs1_rdata, 
	output reg [`DATA_WIDTH] rs2_rdata
);
	
	reg [`DATA_WIDTH] regs[0:`REG_NUM-1];
	
	reg [`DATA_WIDTH*2] cycle; 
	
	//some might be useless while others might be needed
	reg [`DATA_WIDTH] mstatus; 
	reg [`DATA_WIDTH] misa; 
	reg [`DATA_WIDTH] mtvec; 
	reg [`DATA_WIDTH] mscratch; 
	reg [`DATA_WIDTH] mepc; 
	//reg [`DATA_WIDTH] mcause; 
	//reg [`DATA_WIDTH] mtval; 
	//reg [`DATA_WIDTH] mip; 
	reg [`DATA_WIDTH] mcycle; 
	reg [`DATA_WIDTH] mcycleh; 
	reg [`DATA_WIDTH] mvendorid; 
	
	//regfile rs1
	always @ (*) begin
		if (rs1_raddr == `ZERO_REG) begin
			rs1_rdata = `DATA_WIDTH'b0; 
		end else if (rs1_raddr == waddr && rd_we == `WRITE_ENABLE) begin
			rs1_rdata = wdata; 
		end else begin
			rs1_rdata = regs[rs1_raddr];
		end
	end
	
	//regfile rs2
	always @ (*) begin
		if (rs2_raddr == `ZERO_REG) begin
			rs2_rdata = `DATA_WIDTH'b0; 
		end else if (rs2_raddr == waddr && rd_we == `WRITE_ENABLE) begin
			rs2_rdata = wdata; 
		end else begin
			rs2_rdata = regs[rs2_raddr];
		end
	end
	
	//csr read
	always @ (*) begin
		if ((csr_waddr[11:0] == csr_raddr[11:0]) && (csr_we == `WRITE_ENABLE)) begin
			csr_rdata = csr_wdata; 
		end else begin
			case (csr_raddr[11:0] 
	
	//regfile rd
	always @ (posedge clk) begin 
		if ((rst != `RST) && (rd_we == `WRITE_ENABLE) && (waddr != `ZERO_REG) begin 
			regs[waddr_i] <= wdata; 
		end
	end
	
	//csr write
	