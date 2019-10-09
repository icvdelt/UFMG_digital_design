clear -all
analyze -vhdl08 -L GENERIC_TYPES ../generic_components/generic_types.vhd
analyze -vhdl08 -L GENERIC_COMPONENTS ../generic_components/generic_components.vhd
analyze -vhdl08 -L GENERIC_FUNCTIONS ../generic_components/generic_functions.vhd
analyze -vhdl08 -L RS_TYPES ../rs_common/rs_types.vhd
analyze -vhdl08 -L RS_CONSTANTS ../rs_common/rs_constants.vhd
analyze -vhdl08 -L RS_FUNCTIONS ../rs_common/rs_functions.vhd
analyze -vhdl08 -L RS_COMPONENTS ../rs_common/rs_components.vhd
analyze -vhdl08 rs_decoder.vhd\
                ../generic_components/d_flop/d_flop.vhd\
                ../generic_components/fifo_array/reg_fifo_array.vhd\
                ../generic_components/fifo/reg_fifo.vhd\
                ../generic_components/d_sync_flop_gen_rst/d_sync_flop_gen_rst.vhd\
                ../generic_components/d_flop_no_rst/d_flop_no_rst.vhd\
                ../rs_common/rs_adder/rs_adder.vhd\
                ../rs_common/rs_multiplier_lut/rs_multiplier_lut.vhd\
                ../rs_common/rs_multiplier/rs_multiplier.vhd\
                ../rs_common/rs_full_multiplier/rs_full_multiplier.vhd\
                ../rs_common/rs_inverse/rs_inverse.vhd\
                rs_syndrome/rs_syndrome.vhd\
                rs_syndrome/rs_syndrome_subunit/rs_syndrome_subunit.vhd\
                rs_euclidean/rs_euclidean.vhd\
                rs_euclidean/rs_euclidean_acc_unit/rs_euclidean_acc_unit.vhd\
                rs_euclidean/rs_euclidean_division_unit/rs_euclidean_division_unit.vhd\
                rs_euclidean/rs_shifter_acc/rs_shifter_acc.vhd\
                rs_euclidean/rs_shitfer_zero_significant_positions/rs_shitfer_zero_significant_positions.vhd\
                rs_chien_forney/rs_chien_forney.vhd\
                rs_chien_forney/rs_chien/rs_chien.vhd\
                rs_chien_forney/rs_forney/rs_forney.vhd
#it does not work
elaborate -vhdl -top rs_decoder -parameter N 255 -parameter K 239
#elaborate -vhdl -top rs_decoder -parameter N 15 -parameter K 11
get_design_info
