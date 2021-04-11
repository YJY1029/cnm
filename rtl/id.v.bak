`include "defines.v"

module id(
	//global
	input wire rst,
	 
	//from fliop1
	input wire [`INST_WIDTH] inst, 
	input wire [`INST_ADDR_WIDTH] inst_addr, 
	
	//to csregfile
	output wire [`REG_ADDR_WIDTH] rs1_addr_o, 
	output wire [`REG_ADDR_WIDTH] rs2_addr_o, 
	output wire [`CSR_ADDR_WIDTH] csr_addr_o,
	
	//to executrol
	output wire inst_addr_o, 
	output wire rd_we_o, 
	output wire [`REG_ADDR_WIDTH] rd_addr_o, 
	output wire csr_we_o, 
	output wire [`REG_ADDR_WIDTH] csr_o, 
	output wire imm_en_o, 
	output wire [`REG_WIDTH] imm_o, 
	output wire un_signed_o 
	);
	
	//Instruction breakup
	wire [6:0] opcode = inst[6:0]; 
	wire [`REG_ADDR_WIDTH] rd = inst[11:7];
	wire [2:0] funct3 = inst[14:12];
	wire [`REG_ADDR_WIDTH] rs1 = inst[19:15];
	wire [`REG_ADDR_WIDTH] rs2 = inst[24:20]; 
	wire [6:0] funct7 = inst[31:25]; 
	
	assign inst_addr_o = inst_addr; 
	
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
	wire envir_csr = (opcode == `ENVIR_CSR); 
	
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
	
	assign rd_addr_o = 
		(lui | auipc | jal | jalr | il_format | i_format | r_format | csr) ? rd : 
		`ZERO_REG; 
	assign rs1_addr_o = 
		(jalr | b_format | il_format | s_format | i_format | r_format | csrrw | csrrs | csrrc) ? rs1 : 
		`ZERO_REG; 
	assign rs2_addr_o = 
		(b_format | s_format | r_format) ? rs2 : 
		`ZERO_REG; 
	assign imm_o = 
		(i_format | il_format) ? {{20{inst[31]}}, inst[31:20]} : 
		(s_format) ? {{20{inst[31]}}, inst[31:25], inst[11:7]} : 
		(b_format) ? {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1b'0} :
		jal ? {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0} : 
		jalr ? {{20{inst[31]}}, inst[31:20]} : 
		(lui | auipc) ? {inst[31:12], 12b'0} : 
		32h'0; 
	
	
		
endmodule