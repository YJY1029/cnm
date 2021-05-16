`include "defines.v"

module csregfile(
	input wire clk, 
	input wire rst, 
	
	//csr from executrol
	input wire [`CSR_ADDR_WIDTH] csr_waddr, 
	input wire [`DATA_WIDTH] csr_wdata, 
	
	//csr from id
	input wire [`CSR_ADDR_WIDTH] csr_raddr, 
	
	//regfile from executrol
	input wire [`REG_ADDR_WIDTH] rd_waddr, 
	input wire [`DATA_WIDTH] extl_rd_wdata, 
	
	//regfile from sb
	input wire [`DATA_WIDTH] sb_rd_wdata, 
	
	//regfile from id
	input wire [`REG_ADDR_WIDTH] rs1_raddr, 
	input wire [`REG_ADDR_WIDTH] rs2_raddr, 
	
	//csr to executrol
	output reg [`DATA_WIDTH] csr_rdata_o, 
	
	//regfile to executrol
	output reg [`DATA_WIDTH] rs1_rdata_o, 
	output reg [`DATA_WIDTH] rs2_rdata_o, 
	
	output wire stop, 
	output wire succ 
);
	
	reg [`DATA_WIDTH] regs[0:`REG_NUM-1]; 
	
	reg [1+2*`DATA_WIDTH] cycle; 
	
	//some might be useless while others might be needed
	reg [`DATA_WIDTH] mstatus;   //*very complex
	reg [`DATA_WIDTH] misa;      //ISA indicator
	reg [`DATA_WIDTH] mtvec;     //trap address
	reg [`DATA_WIDTH] mscratch;  //temporary register data saving before exception
	reg [`DATA_WIDTH] mepc;      //the pc address before exception
	//reg [`DATA_WIDTH] mcause;  //exception cause indicator
	//reg [`DATA_WIDTH] mtval;   //opcode or memory address before exception
	//reg [`DATA_WIDTH] mip;     //pending related?
	reg [`DATA_WIDTH] mcycle;    //counting cycle times, lower 32 bits
	reg [`DATA_WIDTH] mcycleh;   //counting cycle times, higher 32 bits
	reg [`DATA_WIDTH] mvendorid; //vendor id indicator
	
	//read
	always @ (*) begin 
		//reading rs1
		if (rs1_raddr == `ZERO_REG) begin 
			rs1_rdata_o = `ZERO32; 
		end else if (rs1_raddr == rd_waddr) begin 
			rs1_rdata_o = (extl_rd_wdata|sb_rd_wdata); 
		end else begin 
			rs1_rdata_o = regs[rs1_raddr]; 
		end
		
		//reading rs2
		if (rs2_raddr == `ZERO_REG) begin 
			rs2_rdata_o = `ZERO32; 
		end else if (rs2_raddr == rd_waddr) begin 
			rs2_rdata_o = (extl_rd_wdata|sb_rd_wdata); 
		end else begin 
			rs2_rdata_o = regs[rs2_raddr]; 
		end 
		
		//reading csr
		if ((csr_waddr == csr_raddr) && (csr_raddr != `mdisable)) begin
			csr_rdata_o = csr_wdata; 
		end else begin 
			case (csr_raddr) 
				`mstatus: begin 
					csr_rdata_o = mstatus; 
				end 
				`misa: begin 
					csr_rdata_o = misa; 
				end 
				`mtvec: begin 
					csr_rdata_o = mtvec; 
				end 
				`mscratch: begin 
					csr_rdata_o = mscratch; 
				end 
				`mepc: begin 
					csr_rdata_o = mepc; 
				end 
				/*
				`mcause: begin 
					csr_rdata_o = mcause; 
				end 
				`mtval: begin 
					csr_rdata_o = mtval; 
				end 
				`mip: begin 
					csr_rdata_o = mip; 
				end 
				*/
				`mcycle: begin 
					csr_rdata_o = cycle[31:0]; 
				end 
				`mcycleh: begin 
					csr_rdata_o = cycle[63:32]; 
				end 
				`mvendorid: begin 
					csr_rdata_o = mvendorid; 
				end 
				default: begin 
				  csr_rdata_o = `ZERO32; 
				end 
			endcase 
		end	
		
	end 
	
	//write, on clk posedge
	always @ (posedge clk) begin 
		if (rst == `RST) begin //initialization
			cycle <= {`ZERO32, `ZERO32}; 
			mstatus <= `ZERO32; 
			misa <= 32'h40020000; //Meaning RV32I
			mtvec <= `ZERO32; 
			mscratch <= `ZERO32; 
			mepc <= `ZERO32; 
			//mcause <= `ZERO32; 
			//mtval <= `ZERO32; 
			//mip <= `ZERO32; 
			mcycle <= `ZERO32; 
			mcycleh <= `ZERO32; 
			mvendorid <= 32'h13109f5; //Awesome you found an easter egg! In decimal form it's my birthday :-)
		end else begin 
			cycle <= cycle+1'b1; 
			
			//writing rd
			if (rd_waddr != `ZERO_REG) begin 
				regs[rd_waddr] <= (extl_rd_wdata|sb_rd_wdata); 
				
			end else if (csr_waddr != `mdisable) begin
				case (csr_waddr) 
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
					default: begin 
						
					end 
				endcase 
			end 
			
		end 
	
	end 

	assign stop = 
		(rst == `RST) ? 1'b1 : 
		~regs[26]; 
	assign succ = 
		(rst == `RST) ? 1'b1 : 
		~regs[27]; 
	
endmodule