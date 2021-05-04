`include "../rtl/core/defines.v"

/*In this testbench we test instructions as follows: 
I format: addi x31, x1, 32'b1
B format: bge x1, x2, 32'b{19{1}1011111100000
IL format: lh x31, 32'b11(x1)
S format: sb x2, 32'b{20{1}}100000000100(x1)
U format: lui x31, 32'b101
U format: auipc x31, 32'b110
J format: jalr x31, 32'b{20{1}}100000000111(x1)
*/
module id_tb(); 

	/*Clock signal
	localparam clk_period = 10; 
	reg clk; 
	initial clk = 1'b0; 
	always #(clk_period/2) clk = ~clk; 
	*/
	reg rst; 
	
	reg [`INST_WIDTH] inst; 
	reg [`INST_ADDR_WIDTH] inst_addr; 
	
	wire [`REG_ADDR_WIDTH] rs1_raddr_o; 
	wire [`REG_ADDR_WIDTH] rs2_raddr_o; 
	wire [`CSR_ADDR_WIDTH] csr_raddr_o; 
	wire [`INST_WIDTH] inst_o; 
	wire [`INST_ADDR_WIDTH] inst_addr_o; 
	wire [`REG_ADDR_WIDTH] rd_waddr_o; 
	wire [`CSR_ADDR_WIDTH] csr_waddr_o; 
	wire [`DATA_WIDTH] imm_o; 
	wire [`OP1_SEL] op1_sel_o; 
	wire [`OP2_SEL] op2_sel_o; 
	wire [`ALU_SEL] alu_sel_o; 
	wire [`BR_SEL] br_sel_o; 
	wire [`WB_SEL] wb_sel_o; 
	wire [`MEM_RW] mem_rw_o; 
	wire [`BYTE_SEL] byte_sel_o; 
	wire un_sign_o; 
	
	id u_id( 
		.rst(rst), 
		.inst(inst), 
		.inst_addr(inst_addr), 
		.rs1_raddr_o(rs1_raddr_o), 
		.rs2_raddr_o(rs2_raddr_o), 
		.csr_raddr_o(csr_raddr_o), 
		.inst_o(inst_o), 
		.inst_addr_o(inst_addr_o), 
		.rd_waddr_o(rd_waddr_o), 
		.csr_waddr_o(csr_waddr_o), 
		.imm_o(imm_o), 
		.op1_sel_o(op1_sel_o), 
		.op2_sel_o(op2_sel_o), 
		.alu_sel_o(alu_sel_o), 
		.br_sel_o(br_sel_o), 
		.wb_sel_o(wb_sel_o), 
		.mem_rw_o(mem_rw_o), 
		.byte_sel_o(byte_sel_o), 
		.un_sign_o(un_sign_o)
		);
	
	initial begin
		rst = `RST; 
		#10; 
		
		rst = `UNRST; 
		
		//10ns, I format: addi x31, x1, 32'b1
		inst = 32'b00000000000100001000111110010011; 
		//32'b000000000001/**/00001/**/000/**/11111/**/0010011
		inst_addr = `INI_INST_ADDR; 
		/*
		rs1_raddr_o = 5'b1
		rs2_raddr_o = 5'b1
		csr_raddr_o = 12'b1
		rd_waddr_o = 5'b11111
		imm_o = 32'b1
		op1_sel_o = 2'b1
		op2_sel_o = 2'b11
		alu_sel_o = 4'b1
		br_sel_o = 3'b0
		wb_sel_o = 3'b1
		mem_rw_o = 2'b0
		byte_sel_o = 4'b0
		un_sign_o = 1
		*/
		#10; 
		
		//20ns, B format: bge x1, x2, 32'b{19{1}1011111100000
		inst = 32'b11111110001000001101000001100011; 
		//32'b1/**/111111/**/00010/**/00001/**/101/**/0000/**/0/**/1100011
		inst_addr = 32'b100; 
		/*
		rs1_raddr_o = 5'b1
		rs2_raddr_o = 5'b10
		csr_raddr_o = 12'b111111100010
		rd_waddr_o = 5'b0
		imm_o = 32'b{19{1}1011111100000
		op1_sel_o = 2'b1
		op2_sel_o = 2'b1
		alu_sel_o = 4'b10
		br_sel_o = 3'b101
		wb_sel_o = 3'b0
		mem_rw_o = 2'b0
		byte_sel_o = 4'b0
		un_sign_o = 1
		*/
		#10; 
		
		//30ns, IL format: lh x31, 32'b11(x1)
		inst = 32'b00000000001100001001111110000011; 
		//32'b00000000011/**/00001/**/001/**/11111/**/0000011
		inst_addr = 32'b1000; 
		/*
		rs1_raddr_o = 5'b1
		rs2_raddr_o = 5'b11
		csr_raddr_o = 12'b11
		rd_waddr_o = 5'b11111
		imm_o = 32'b11
		op1_sel_o = 2'b1
		op2_sel_o = 2'b11
		alu_sel_o = 4'b1
		br_sel_o = 3'b0
		wb_sel_o = 3'b11
		mem_rw_o = 2'b1
		byte_sel_o = 4'b11
		un_sign_o = 1
		*/
		#10; 
		
		
		//40ns, S format: sb x2, 32'b{20{1}}100000000100(x1)
		inst = 32'b10000000001000001000001000100011; 
		//32'b1000000/**/00010/**/00001/**/000/**/00100/**/0100011
		inst_addr = 32'b1100; 
		/*
		rs1_raddr_o = 5'b1
		rs2_raddr_o = 5'b10
		csr_raddr_o = 12'b100000000010
		rd_waddr_o = 5'b00100		?0
		imm_o = 32'b{20{1}}100000000100
		op1_sel_o = 2'b1
		op2_sel_o = 2'b11
		alu_sel_o = 4'b1
		br_sel_o = 3'b0
		wb_sel_o = 3'b100
		mem_rw_o = 2'b10
		byte_sel_o = 4'b1
		un_sign_o = 1
		*/
		#10; 
		
		//50ns, U format: lui x31, 32'b101{12{0}}
		inst = 32'b00000000000000000101111110110111; 
		//32'b00000000000000000101/**/11111/**/0110111
		inst_addr = 32'b10000; 
		/*
		rs1_raddr_o = 5'b0
		rs2_raddr_o = 5'b0
		csr_raddr_o = 12'b0
		rd_waddr_o = 5'b11111
		imm_o = 32'b101{12{0}}
		op1_sel_o = 2'b10
		op2_sel_o = 2'b0
		alu_sel_o = 4'b1
		br_sel_o = 3'b0
		wb_sel_o = 3'b1
		mem_rw_o = 2'b0
		byte_sel_o = 4'b0
		un_sign_o = 1
		*/
		#10; 
		
		//60ns, U format: auipc x31, 32'b110{12{0}}
		inst = 32'b00000000000000000110111110010111; 
		//32'b00000000000000000110/**/11111/**/0010111
		inst_addr = 32'b10100; 
		/*
		rs1_raddr_o = 5'b0
		rs2_raddr_o = 5'b0
		csr_raddr_o = 12'b0
		rd_waddr_o = 5'b11111
		imm_o = 32'b110{12{0}}
		op1_sel_o = 2'b10
		op2_sel_o = 2'b10
		alu_sel_o = 4'b1
		br_sel_o = 3'b0
		wb_sel_o = 3'b1
		mem_rw_o = 2'b0
		byte_sel_o = 4'b0
		un_sign_o = 1
		*/
		#10; 
		
		//70ns, J format: jalr x31, 32'b{20{1}}100000000111(x1)
		inst = 32'b10000000011100001010111111100111; 
		//32'b100000000111/**/00001/**/010/**/11111/**/1100111; 
		inst_addr = 32'b11000; 
		/*
		rs1_raddr_o = 5'b1
		rs2_raddr_o = 5'b00111
		csr_raddr_o = 12'b100000000111
		rd_waddr_o = 5'b11111
		imm_o = 32'b{20{1}}100000000111
		op1_sel_o = 2'b1
		op2_sel_o = 2'b10
		alu_sel_o = 4'b1
		br_sel_o = 3'b1
		wb_sel_o = 3'b10
		mem_rw_o = 2'b0
		byte_sel_o = 4'b0
		un_sign_o = 1
		*/
		#10; 
	end
	
endmodule