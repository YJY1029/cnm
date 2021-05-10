`include "../rtl/core/defines.v"
`define REGS soc.u_CoNM.u_csregfile.regs

module tb(); 
	
	//Clock signal
	localparam clk_period = 10; 
	reg clk; 
	initial clk = 1'b0; 
	always #(clk_period/2) clk = ~clk; 
	
	reg rst; 
	
	reg [`INST_WIDTH] inst; 
	wire [`INST_ADDR_WIDTH] inst_addr_o; 
	
	integer r; 
	
soc_top soc(
	.clk(clk), 
	.rst(rst), 
	.inst(inst), 
	.inst_addr_o(inst_addr_o)
	);
	
	//general test benchmark
	initial begin
		rst = `RST; 
		#10; 
		$display("Here comes the test!");
		rst = `UNRST; 
		inst <= `NOP; //nop
		#15; 
		inst <= 32'h00000d13; //li x26, 0
		#10; 
		inst <= 32'h00000d93; //li x27, 0
		#10; 
		inst <= 32'b00000000000111010000111110010011; //addi x31, x26, 32'b1
		#10; 
		inst <= 32'b00000001101111010011111100110011; //sltu x30, x26, x27
		#10; 
		inst <= 32'b00000001111111011000000010100011; //sb x31, 32'b1(x27)
		#10;
		inst <= 32'b00000000000111011001111010000011; //lh x29, 32'b1(x27)
		#10; 
		inst <= 32'b00010000000000000000111111101111; //jal x31, 32'h100
		//          funct7/ rs2/ rs1/f3/  rd/opcode/
		#10; 
		inst <= 32'b00000000000111110000111100010011; //addi x30, x30, 32'b1
		#10; 
		inst <= 32'b00000000000111110000111100010011; //addi x30, x30, 32'b1
		#10; 
		inst <= 32'b00000000000111110000111100010011; //addi x30, x30, 32'b1
		#10; 
		inst <= 32'b00000000000111110000111100010011; //addi x30, x30, 32'b1
		#10; 
		inst <= 32'b00000000000111110000111100010011; //addi x30, x30, 32'b1
		#30; 
			for (r = 0; r < 32; r = r + 1) 
				$display("x%2d = 0x%x", r, `REGS[r]); 
			$finish; 
	end
	
endmodule