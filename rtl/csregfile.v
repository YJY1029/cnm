`include "defines.v"
/*
It's really hard to express registers in fully combinational logical circuits. 
Once again, some registers might be useless while others might be needed. 
Not sure if csr_addr should be 32-bit long. 
How on earth should I express a hard-wired x0???
*/

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
	
	//reading, as soon as we signals arrive
	always @ (*) begin
		//reading rs1
		if (rs1_raddr == `ZERO_REG) begin
			rs1_rdata = 32'h0; 
		end else if (rs1_raddr == waddr && rd_we == `WRITE_ENABLE) begin
			rs1_rdata = wdata; 
		end else begin//do we need a read signal? or just leave it to ZERO_REG?
			rs1_rdata = regs[rs1_raddr];
		end
		
		//reading rs2
		if (rs2_raddr == `ZERO_REG) begin
			rs2_rdata = 32'h0; 
		end else if (rs2_raddr == waddr && rd_we == `WRITE_ENABLE) begin
			rs2_rdata = wdata; 
		end else begin
			rs2_rdata = regs[rs2_raddr];
		end
		
		//reading csr
		if ((csr_waddr[11:0] == csr_raddr[11:0]) && (csr_we == `WRITE_ENABLE)) begin
			csr_rdata = csr_wdata; 
		end else begin
			case (csr_raddr[11:0]) 
				`mstatus: begin
					csr_rdata = mstatus; 
				end
				`misa: begin
					csr_rdata = misa; 
				end
				`mtvec: begin
					csr_rdata = mtvec; 
				end
				`mscratch: begin
					csr_rdata = mscratch; 
				end
				`mepc: begin
					csr_rdata = mepc; 
				end
				/*
				`mcause: begin
					csr_rdata = mcause; 
				end
				`mtval: begin
					csr_rdata = mtval; 
				end
				`mip: begin
					csr_rdata = mip; 
				end
				*/
				`mcycle: begin
					csr_rdata = cycle[31:0]; 
				end
				`mcycleh: begin
					csr_rdata = cycle[63:32]; 
				end
				`mvendorid: begin
					csr_rdata = mvendorid; 
				end
			endcase
		end	
		
	end
	
	//write, on positive edges of clk
	always @ (posedge clk) begin
		if (rst == `RST) begin //initialization
			cycle <= {32'h0, 32'h0}; 
			mstatus <= 32'h0; 
			misa <= 32'h40020000; //Meaning RV32I
			mtvec <= 32'h0; //trap address, revision needed
			mscratch <= 32'h0; //exception related
			mepc <= 32'h0; //ditto
			//mcause <= 32'h0; //ditto
			//mtval <= 32'h0; //ditto
			//mip <= 32'h0; //pending related
			mcycle <= 32'h0; 
			mcycleh <= 32'h0; 
			mvendorid <= 32h'13109f5; //Awesome you found an easter egg! In decimal form it's my birthday :-)
		end else begin
			cycle <= cycle+1b'1; 
			
			//writing rd
			if (rd_we == `WRITE_ENABLE) && (waddr != `ZERO_REG) begin 
				regs[waddr_i] <= wdata; 
				
			end else if (csr_we == `WRITE_ENABLE) begin
				case (csr_waddr[11:0])
					`mstatus: begin
						mstatus <= csr_wdata; 
					end
					`misa: begin
						misa <= csr_wdata; 
					end
					`mtvec: begin
						mtvec <= csr_wdata; 
					end
					`mscratch: begin
						mscratch <= csr_wdata; 
					end
					`mepc: begin
						mepc <= csr_wdata; 
					end
					/*
					`mcause: begin
						mcause <= csr_wdata; 
					end
					`mtval: begin
						mtval <= csr_wdata; 
					end
					`mip: begin
						mip <= csr_wdata; 
					end
					*/
					`mcycle: begin
						cycle[31:0] <= csr_wdata; 
					end
					`mcycleh: begin
						cycle[63:32] <= csr_wdata; 
					end
					//mvendorid is readonly
				endcase
			end
		end
	end