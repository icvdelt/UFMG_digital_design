clear -all
set_elaborate_single_run_mode off
proc run_analyze {} {
    analyze -vhdl08 -L GENERIC_TYPES ../../generic_components/generic_types.vhd
    analyze -vhdl08 -L GENERIC_COMPONENTS ../../generic_components/generic_components.vhd
    analyze -vhdl08 -L GENERIC_FUNCTIONS ../../generic_components/generic_functions.vhd
    analyze -vhdl08 -L RS_TYPES ../../rs_common/rs_types.vhd
    analyze -vhdl08 -L RS_CONSTANTS ../../rs_common/rs_constants.vhd
    analyze -vhdl08 -L RS_FUNCTIONS ../../rs_common/rs_functions.vhd
    analyze -vhdl08 -L RS_COMPONENTS ../../rs_common/rs_components.vhd
    analyze -vhdl08 -L RS_CONSTANTS ../../rs_common/rs_constants.vhd
    analyze -vhdl08 ../../rs_encoder/rtl/rs_encoder.vhd\
                    ../../generic_components/async_dff/async_dff.vhd\
                    ../../rs_common/rs_adder/rs_adder.vhd\
                    ../../rs_common/rs_multiplier_lut/rs_multiplier_lut.vhd\
                    ../../rs_common/rs_multiplier/rs_multiplier.vhd\
                    ../../rs_encoder/rtl/rs_remainder_unit/rs_remainder_unit.vhd\
		    ../../rs_decoder/rtl/rs_syndrome/rs_syndrome.vhd\
		    ../../rs_decoder/rtl/rs_syndrome/rs_syndrome_subunit/rs_syndrome_subunit.vhd\
		    ../../rs_encoder/rtl/rs_encoder_wrapper.vhd

    analyze -sv09	fv_encoder.sv
}


proc run_design_compilation {N K} {
    clear -all
    run_analyze
    elaborate -vhdl -top rs_encoder_wrapper -parameter N $N -parameter K $K
    connect -bind -auto fv_encod mod2 -auto -elaborate 
   
}

set WAIT_SYMBOL 0
set START_CODEWORD 1
set PROCESS_SYMBOLS 2
set GENERATE_PARITY 3
set END_CODEWORD 4
set STALL 5
set ERROR 6


run_analyze
run_design_compilation 15 11

clock clk
reset rst

assert -disable <constraints>::DUT.rs_CONTROL._type_constraint_r_counter
assert -disable <constraints>::DUT.rs_CONTROL._type_constraint_r_state

assert  {DUT.RS_CONTROL.r_state=GENERATE_PARITY |-> $past(not(o_in_ready))} -name REQ_RS_ENC_013.CHECK.01
cover   {DUT.RS_CONTROL.r_state=GENERATE_PARITY |-> $past(not(o_in_ready))} -name REQ_RS_ENC_013.COVER.01
prove -all
