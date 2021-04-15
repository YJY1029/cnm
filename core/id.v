`include "defines.v"

module id(
	//global
	input wire rst,
	 
	//from fliop1
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	
	//to csregfile
	output wire [`REG_ADDR_WIDTH] rs1_raddr_o, 
	output wire [`REG_ADDR_WIDTH] rs2_raddr_o, 
	output wire [`CSR_ADDR_WIDTH] csr_raddr_o, 
	
	//to executrol
	output wire inst_o, 
	output wire inst_addr_o, 
	output wire [`REG_ADDR_WIDTH] rd_waddr_o, 
	output wire [`CSR_ADDR_WIDTH] csr_waddr_o, 
	output wire [`DATA_WIDTH] imm_o, 
	output wire [`ALU_SEL] alu_sel_o, 
	output wire [`OP1_SEL] op1_sel_o, 
	output wire [`OP2_SEL] op2_sel_o, 
	output wire [`MEM_RW] mem_rw_o, 
	output wire [`BR_SEL] br_sel_o, 
	output wire [`WB_SEL] wb_sel_o, 
	output wire [`BYTE_SEL] byte_sel_o
	);
	/*
	rd_we 2: enable, disable 
	mem_rw 3: write, read, disable
	wb_sel 3: reg, mem, pc, csr, ?
	op1sel 2: rs1, inst_addr, imm, none
	op2sel 3: rs2, 32h'4, imm, none
	imm_en: none//should sign extension be left to executrol module? 
	rsdata_signed 2: data signed, data unsigned 
	alusel 9: add, sub, and, or, xor, logical shift left, logical shift right, arithmetic shift left, arithmetic shift right
	branch_type ?: unconditional, equal, less than, signed?, none
	*/
	//Instruction breakup
	wire [6:0] opcode = inst[6:0]; 
	wire [`REG_ADDR_WIDTH] rd = inst[11:7];
	wire [2:0] funct3 = inst[14:12];
	wire [`REG_ADDR_WIDTH] rs1 = inst[19:15];
	wire [`REG_ADDR_WIDTH] rs2 = inst[24:20]; 
	wire [6:0] funct7 = inst[31:25]; 
	/*
	//opcode
	wire lui = (opcode == `LUI); 
	wire auipc = (opcode == `AUIPC); 
	wire jal = (opcode == `JAL); 
	wire jalr = (opcode == `JALR); 
	wire b_format = (opcode == `B_FORMAT); 
	wire il_format = (opcode == `IL_FORMAT); 
	wire s_format = (opcode == `S_FORMAT); 
	wire i_format = (opcode == `I_FORMAT); 
	wire r_format = (opcode == `R_FORMAT); 
	wire fence_fencei = (opcode == `FENCE_FENCEI); 
	wire csr = (opcode == `CSR); 
	
	//B format
	wire beq = b_format & (funct3 == `BEQ); 
	wire bne = b_format & (funct3 == `BNE); 
	wire blt = b_format & (funct3 == `BLT); 
	wire bge = b_format & (funct3 == `BGE); 
	wire bltu = b_format & (funct3 == `BLTU); 
	wire bgeu = b_format & (funct3 == `BGEU); 
	
	//I format loads
	wire lb = il_format & (funct3 == `LB); 
	wire lh = il_format & (funct3 == `LH); 
	wire lw = il_format & (funct3 == `LW); 
	wire lbu = il_format & (funct3 == `LBU); 
	wire lhu = il_format & (funct3 == `LHU); 
	
	//S format
	wire sb = s_format & (funct3 == `SB); 
	wire sh = s_format & (funct3 == `SH); 
	wire sw = s_format & (funct3 == `SW); 
	
	//I format 
	wire addi = i_format & (funct3 == `ADDI); 
	wire slti = i_format & (funct3 == `SLTI); 
	wire sltiu = i_format & (funct3 == `SLTIU); 
	wire xori = i_format & (funct3 == `XORI); 
	wire ori = i_format & (funct3 == `ORI); 
	wire andi = i_format & (funct3 == `ANDI); 
	wire slli = i_format & (funct3 == `SLLI); 
	wire srli_srai = i_format & (funct3 == `SRLI_SRAI); 
		wire srli = srli_srai & (funct7 == `SRLI); 
		wire srai = srli_srai & (funct7 == `SRAI); 
	
	//R format 
	wire add_sub = r_format & (funct3 == `ADD_SUB); 
		wire add = add_sub & (funct7 == `ADD); 
		wire sub = add_sub & (funct7 == `SUB); 
	wire sll = r_format & (funct3 == `SLL); 
	wire slt = r_format & (funct3 == `SLT); 
	wire sltu = r_format & (funct3 == `SLTU); 
	wire xorr = r_format & (funct3 == `XOR); //avoiding keyword xor
	wire srl_sra = r_format & (funct3 == `SRL_SRA); 
		wire srl = srl_sra & (funct7 == `SRL); 
		wire sra = srl_sra & (funct7 == `SRA); 
	wire orr = r_format & (funct3 == `OR); //avoiding keyword or
	wire andd = r_format & (funct3 == `AND); //avoiding keyword and
	
	//FENCE and FENCE.I
	wire fence = fence_fencei & (funct3 == `FENCE); 
	wire fencei = fence_fencei & (funct3 == `FENCEI); 
	
	//CSR
	wire csrrw = envir_csr & (funct3 == `CSRRW);
	wire csrrs = envir_csr & (funct3 == `CSRRS);
	wire csrrc = envir_csr & (funct3 == `CSRRC);
	wire csrrwi = envir_csr & (funct3 == `CSRRWI);
	wire csrrsi = envir_csr & (funct3 == `CSRRSI);
	wire csrrci = envir_csr & (funct3 == `CSRRCI); 
	
	//Environment
	wire ecall = (inst == `ECALL); 
	wire ebreak = (inst == `EBREAK); 
	*/
	//to csregfile
	assign rs1_raddr_o = 
		(jalr | b_format | il_format | s_format | i_format | r_format | csrrw | csrrs | csrrc) ? rs1 : 
		`ZERO_REG; 
		
	assign rs2_raddr_o = 
		(b_format | s_format | r_format) ? rs2 : 
		`ZERO_REG; 
		
	assign csr_raddr_o = inst[31:20]; 
		
	//to executrol
	assign inst_o = inst; 
	
	assign inst_addr_o = inst_addr; 
	
	assign rd_we_o = 
		(lui | auipc | jal | jalr | il_format | i_format | r_format | csr) ? `WRITE_ENABLE : 
		1'b0; 
	
	assign rd_waddr_o = 
		(lui | auipc | jal | jalr | il_format | i_format | r_format | csr) ? rd : 
		`ZERO_REG; 
		
	assign csr_waddr_o = 
		csr ? inst[31:20] : 
		`mdisable; 
				
	assign imm_o = 
		(i_format | il_format) ? {{20{inst[31]}}, inst[31:20]} : 
		(s_format) ? {{20{inst[31]}}, inst[31:25], inst[11:7]} : 
		(b_format) ? {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1b'0} :
		jal ? {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} : 
		jalr ? {{20{inst[31]}}, inst[31:20]} : 
		(lui | auipc) ? {inst[31:12], 12b'0} : 
		32h'0; 
		/*
	assign alu_sel_o = 
		(({4{auipc}} | {4{jal}} | {4{jalr}} | {4{il_format}} | {4{s_format}} | {4{addi}} | {4{add}}) & `ALU_ADD) | 
		(({4{b_format}} | {4{slti}} | {4{sltiu}} | {4{slt}} | {4{sltu}} | {4{sub}}) & `ALU_SUB) | 
		not finished*/
		
	assign alu_sel_o = 
		(auipc | jal | jalr | il_format | s_format | addi | add) ? `ALU_ADD : 
		(b_format | slti | sltiu | slt | sltu | sub) ? `ALU_SUB : 
		(xori | xorr) ? `ALU_XOR : 
		(ori | orr) ? `ALU_OR : 
		(andi | andd) ? `ALU_AND : 
		(slli | sll) ? `ALU_SLL : 
		(srli | srl) ? `ALU_SRL : 
		(srai | sra) ? `ALU_SRA : 
		`ALU_NOP; 
		
	assign op1_sel_o = 
		(jalr | b_format | il_format | s_format | i_format | r_format | fence_fencei | csrrw | csrrs | csrrc) ? `OP1_RS1 : 
		(lui | auipc | jal | csrrwi | csrrsi | csrrci) ? `OP1_IMM : 
		`OP1_NONE; 
	
	assign op2_sel_o = 
		(b_format | r_format) ? `OP2_RS2 : 
		(auipc | jal | jalr) ? `OP2_INST_ADDR : 
		(il_format | s_format | i_format) ? `OP2_IMM : 
		`OP2_NONE; 
	
	assign mem_rw_o = 
		il_format ? `MEM_READ : 
		s_format ? `MEM_WRITE : 
		`MEM_DISABLE; 
	
	assign br_sel_o = 
		(jal | jalr) ? `BR_UNCON : 
		beq ? `BR_EQ : 
		bne ? `BR_NE : 
		blt ? `BR_LT : 
		bge ? `BR_GE : 
		bltu ? `BR_LTU : 
		bgeu ? `BR_GEU : 
		`BR_DISABLE; 
	
	assign wb_sel_o = 
		(lui | auipc | il_format | i_format | r_format | fence_fencei) ? `WB_RD : 
		(jal | jalr) ? `WB_U_TYPE : 
		s_format ? `WB_MEM : 
		csr ? `WB_CSR : 
		`WB_NONE; 
		
endmodule