vopt +acc CoNM_soc_tb -o CoNM_soc_tb_opt
vsim CoNM_soc_tb_opt
onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /CoNM_soc_tb/soc/clk
add wave -noupdate /CoNM_soc_tb/soc/rst
add wave -noupdate /CoNM_soc_tb/soc/pc_imem_inst_addr
add wave -noupdate /CoNM_soc_tb/soc/imem_pc_inst
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_un_sign
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_byte_mask
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_mem_re
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_mem_we
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_addr
add wave -noupdate /CoNM_soc_tb/soc/extl_sb_mem_wdata
add wave -noupdate /CoNM_soc_tb/soc/sb_csrgf_rdata
add wave -noupdate /CoNM_soc_tb/soc/dmem_sb_rdata
add wave -noupdate /CoNM_soc_tb/soc/sb_dmem_rw
add wave -noupdate /CoNM_soc_tb/soc/sb_dmem_addr
add wave -noupdate /CoNM_soc_tb/soc/sb_dmem_wdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/clk
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/rst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/imem_pc_inst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/sb_csrgf_rdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/pc_imem_inst_addr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f1_id_inst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f1_id_inst_addr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_csrgf_rs1_raddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_csrgf_rs2_raddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_f2_inst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_f2_inst_addr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_f2_rd_waddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/id_f2_imm
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/csrgf_f2_rs1_rdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/csrgf_f2_rs2_rdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_inst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_inst_addr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_rd_waddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_imm
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_op1_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_op2_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_alu_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_br_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_wb_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_mem_rw
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_byte_sel
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_un_sign
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_rs1_rdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/f2_extl_rs2_rdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_un_sign_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_byte_mask_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_mem_re_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_mem_we_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_addr_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_mem_wdata_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_csrgf_rd_waddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_csrgf_rd_wdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_jump
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_pc_jump_addr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_mem_raddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/extl_sb_mem_waddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/clk
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rst
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rd_waddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/extl_rd_wdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/sb_rd_wdata
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rs1_raddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rs2_raddr
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rs1_rdata_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/rs2_rdata_o
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/cycle
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_csregfile/regs
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_executrol/op1
add wave -noupdate /CoNM_soc_tb/soc/u_CoNM/u_executrol/op2
add wave -position insertpoint sim:/CoNM_soc_tb/soc/dmem/*
add wave -position insertpoint  \
{sim:/CoNM_soc_tb/soc/dmem/mem_unit[1000]}
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {126 ns} 0}
quietly wave cursor active 1
configure wave -namecolwidth 313
configure wave -valuecolwidth 98
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ns
update
WaveRestoreZoom {6952 ns} {8614 ns}
bookmark add wave bookmark0 {{0 ns} {717 ns}} 52
run -all