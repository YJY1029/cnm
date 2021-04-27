`include "../core/defines.v"

module fliop2_tb(); 

	//Clock signal
	localparam clk_period = 10; 
	reg clk; 
	initial clk = 1'b0; 
	always #(clk_period/2) clk = ~clk; 
	
	reg rst; 
	reg hold; 
	
	reg [`INST_WIDTH] inst; 
	reg [`INST_ADDR_WIDTH] inst_addr; 
	reg [`REG_ADDR_WIDTH] rd_waddr; 
	reg [`CSR_ADDR_WIDTH] csr_waddr; 
	reg [`DATA_WIDTH] imm; 
	reg [`OP1_SEL] op1_sel; 
	reg [`OP2_SEL] op2_sel; 
	reg [`ALU_SEL] alu_sel; 
	reg [`BR_SEL] br_sel; 
	reg [`WB_SEL] wb_sel; 
	reg [`MEM_RW] mem_rw; 
	reg [`BYTE_SEL] byte_sel; 
	reg un_sign; 
	reg [`DATA_WIDTH] rs1_rdata; 
	reg [`DATA_WIDTH] rs2_rdata;
	reg [`DATA_WIDTH] csr_rdata; 
	
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
	wire [`DATA_WIDTH] rs1_rdata_o; 
	wire [`DATA_WIDTH] rs2_rdata_o;
	wire [`DATA_WIDTH] csr_rdata_o; 
	
fliop2 u_fliop2(
	.clk(clk), 
	.rst(rst), 
	.hold(hold), 
	.inst(inst), 
	.inst_addr(inst_addr), 
	.rd_waddr(rd_waddr), 
	.csr_waddr(csr_waddr), 
	.imm(imm), 
	.op1_sel(op1_sel), 
	.op2_sel(op2_sel), 
	.alu_sel(alu_sel), 
	.br_sel(br_sel), 
	.wb_sel(wb_sel), 
	.mem_rw(mem_rw), 
	.byte_sel(byte_sel), 
	.un_sign(un_sign), 
	.rs1_rdata(rs1_rdata), 
	.rs2_rdata(rs2_rdata), 
	.csr_rdata(csr_rdata), 
	
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
	.un_sign_o(un_sign_o),
	.rs1_rdata_o(rs1_rdata_o), 
	.rs2_rdata_o(rs2_rdata_o), 
	.csr_rdata_o(csr_rdata_o)
	); 
	
	initial begin
		rst = `RST; 
		#10; 
		rst = 1'b1; 
		
		//addi x32, x1, 32'b1
		inst = 32'b00000000000100001000111110010011; 
		inst_addr = `INI_INST_ADDR; 
		rd_waddr = 5'b11111; 
		csr_waddr = 12'b1; 
		imm = 32'b1; 
		op1_sel = 2'b1; 
		op2_sel = 2'b11; 
		alu_sel = 4'b1; 
		br_sel = 3'b0; 
		wb_sel = 3'b1; 
		mem_rw = 2'b0; 
		byte_sel = 4'b0; 
		un_sign = 1'b1; 
		rs1_rdata = 32'b10; 
		rs2_rdata = 32'b11; 
		csr_rdata = 32'b100; 
		#10; 
		
		//hold
		hold = `HOLD; 
		#10; 
		
		//bge x1, x2, 32'b{19{1}}1011111100000
		inst = 32'b11111110001000001101000001100011; 
		inst_addr = 32'b100; 
		rd_waddr = 5'b0; 
		csr_waddr = 12'b111111100010; 
		imm = {{19{1'b1}}, 12'b101111110000, {1'b0}}; 
		op1_sel = 2'b1; 
		op2_sel = 2'b1; 
		alu_sel = 4'b10; 
		br_sel = 3'b101; 
		wb_sel = 3'b0; 
		mem_rw = 2'b0; 
		byte_sel = 4'b0; 
		un_sign = 1'b1; 
		rs1_rdata = 32'b11; 
		rs2_rdata = 32'b10; 
		csr_rdata = 32'b1; 
		#20; 
		
		hold = 1'b0; 
		
		//addi x32, x1, 32'b1
		inst = 32'b00000000000100001000111110010011; 
		inst_addr = `INI_INST_ADDR; 
		rd_waddr = 5'b11111; 
		csr_waddr = 12'b1; 
		imm = 32'b1; 
		op1_sel = 2'b1; 
		op2_sel = 2'b11; 
		alu_sel = 4'b1; 
		br_sel = 3'b0; 
		wb_sel = 3'b1; 
		mem_rw = 2'b0; 
		byte_sel = 4'b0; 
		un_sign = 1'b1; 
		rs1_rdata = 32'b10; 
		rs2_rdata = 32'b11; 
		csr_rdata = 32'b100; 
		#10; 
		
		//bge x1, x2, 32'b{19{1}}1011111100000
		inst = 32'b11111110001000001101000001100011; 
		inst_addr = 32'b100; 
		rd_waddr = 5'b0; 
		csr_waddr = 12'b111111100010; 
		imm = {{19{1'b1}}, 12'b101111110000, {1'b0}}; 
		op1_sel = 2'b1; 
		op2_sel = 2'b1; 
		alu_sel = 4'b10; 
		br_sel = 3'b101; 
		wb_sel = 3'b0; 
		mem_rw = 2'b0; 
		byte_sel = 4'b0; 
		un_sign = 1'b1; 
		rs1_rdata = 32'b11; 
		rs2_rdata = 32'b10; 
		csr_rdata = 32'b1; 
		#10; 
	end
	
endmodule