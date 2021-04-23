`include "defines.v"

/*In this testbench we test instructions as follows: 
I format: addi x32, x1, 12'b1 
B format: bge x1, x2, 12'b10
IL format: lh x32, 12'b11
S format: sb x2, 12'b100(x1)
U format: lui x32, 12'b101; auipc x32, 12'b110
J format: jal x32, 12'b111
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
	wire load_sign_o; 
	
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
		.load_sign_o(load_sign_o)
		);
	
	initial begin
		