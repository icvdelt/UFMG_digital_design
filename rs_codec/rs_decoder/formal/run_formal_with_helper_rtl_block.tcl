clear -all
source procs.itcl
run_design_compilation 15 2 RS_GF_16
clock clk
reset rst
task -create formal -set
assert {o_valid and o_error_counter = 2 |->  not o_fifo_xor_decoder_symbol}
assert -set_target_bound 60 {*} -regexp
#cover {o_valid and o_error_counter <= 2 |->  not o_fifo_xor_decoder_symbol}
create_single_codeword_transmission 1
prove -task formal
