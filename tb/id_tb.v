`include "defines.v"

/*In this testbench we test instructions as follows: 
I format: addi x32, x1, 32'b1
B format: bge x1, x2, 32'b{19{1}1011111100000
IL format: lh x32, 32'b11(x1)
S format: sb x2, 32'b{20{1}}100000000100(x1)
U format: lui x32, 32'b101
U format: auipc x32, 32'b110
J format: jalr x32, 32'b{20{1}}100000000111(x1)
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
	reg [`INST_ADDR_WIDTh] inst_addr; 
	
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
		
		rst = 1'b1; 
		
		//I format: addi x32, x1, 32'b1
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		//B format: bge x1, x2, 32'b{19{1}1011111100000
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		//IL format: lh x32, 32'b11(x1)
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		
		//S format: sb x2, 32'b{20{1}}100000000100(x1)
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		//U format: lui x32, 32'b101
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		//U format: auipc x32, 32'b110
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
		
		//J format: jalr x32, 32'b{20{1}}100000000111(x1)
		inst = 32'b
		//32'b
		inst_addr = 32'b
		/*
		rs1_raddr_o = 5'b
		rs2_raddr_o = 5'b
		csr_raddr_o = 12'b
		inst_o = 32'b
		inst_addr_o = 32'b
		rd_waddr_o = 5'b
		csr_waddr_o = 12'b
		imm_o = 32'b
		op1_sel_o = 2'b
		op2_sel_o = 2'b
		alu_sel_o = 4'b
		br_sel_o = 3'b
		wb_sel_o = 3'b
		mem_rw_o = 2'b
		byte_sel_o = 4'b
		un_sign_o = 
		*/
		#10; 
	end
	
endmodule