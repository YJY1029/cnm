`include "../core/defines.v"

//All testbenches are based on addi x31, x1, 12'b101010101010
module pc_tb(); 

	//Clock signal
	localparam clk_period = 10; 
	reg clk; 
	initial clk = 1'b0; 
	always #(clk_period/2) clk = ~clk; 
	
	reg rst; 
	
	reg [`INST_WIDTH] inst; 
	reg jump; 
	reg [`INST_ADDR_WIDTH] jump_addr; 
	reg hold; 
	
	wire [`INST_ADDR_WIDTH] pc_o; 
	wire [`INST_WIDTH] inst_o; 
	
	pc u_pc(
		.clk(clk), 
		.rst(rst), 
		.inst(inst), 
		.jump(jump), 
		.jump_addr(jump_addr), 
		.hold(hold), 
		.pc_o(pc_o), 
		.inst_o(inst_o)
		);
		
	initial begin
		rst = `RST; 
		inst = 32'b1010101010100000100011110010011; //addi x31, x1, 101010101010
		jump = 1'b0; 
		jump_addr = `INI_INST_ADDR; 
		hold = 1'b0; 
		#10; //Reset
		
		rst = 1'b1; 
		#10; //Nothing happens, pc+=4
		
		hold = `HOLD; 
		#10; //Holds, pc=pc
		
		jump = `JUMP; 
		#10; //Jump back to initial address
		
		jump_addr = 32'b10100001010010100; 
		#10; //Jump to some random address
		
		rst = `RST; 
		#10; //Reset
	end
	
endmodule