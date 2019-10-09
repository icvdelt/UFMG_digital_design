library IEEE;
use IEEE.NUMERIC_STD.all;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.VLC_PHY_TYPES.PhyType;
use work.VLC_PHY_TYPES.MCSId;
use work.VLC_PHY_TYPES.RSMode;
use work.VLC_PHY_TYPES.rs_n_parameter;

package VLC_PHY_FUNCTIONS is
    function get_frame_size_length(phy_type: PhyType) return integer;
    function get_num_of_rs_codecs(phy_type: PhyType) return integer;
    function get_rs_gf_length(phy_type: PhyType) return integer;

    --bellow requires review
    function select_rll_input_from_mcs_id(input_buffer, rs_encoder, convolutional_encoder: std_logic_vector(4 downto 0); mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector;
    function get_max_rs_galois_field(I_FRAME_SIZE_LENGTH: natural) return natural;
    function select_input_buffer_consumer(rs_set_in_ready, rll_consumer: std_logic; mcs_id: std_logic_vector(5 downto 0)) return std_logic;

    function get_type_mcs_id(mcs_bit_vector: std_logic_vector(5 downto 0)) return MCSId;
    function get_rs_mode_id_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return integer;
    function get_rs_n_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector;
    function get_rs_k_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector;
    function is_manchester_rll(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic;
    function select_mod_mode_from_mcs_id(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic;
end package VLC_PHY_FUNCTIONS;

package body VLC_PHY_FUNCTIONS is
    function get_frame_size_length(phy_type: PhyType) return integer is
    begin
        if (phy_type = PHY_I) then
            return 10;
        else
            return 16;
        end if;
    end function;

    function get_num_of_rs_codecs(phy_type: PhyType) return integer is
    begin
        if (phy_type = PHY_I) then
            return 4;
        else
            return 6;
        end if; 
    end function;

    function get_rs_gf_length(phy_type: PhyType) return integer is
    begin
        if (phy_type = PHY_I) then
            return 4;
        else
            return 8;
        end if; 
    end function;

    function select_rll_input_from_mcs_id(input_buffer, rs_encoder, convolutional_encoder: std_logic_vector(4 downto 0); mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector is
    begin
        return "00000";
    end function;

    function get_max_rs_galois_field(I_FRAME_SIZE_LENGTH: natural) return natural is
    begin
        return 4;
    end function;
    
    function select_input_buffer_consumer(rs_set_in_ready, rll_consumer: std_logic; mcs_id: std_logic_vector(5 downto 0)) return std_logic is
    begin
        return '1';
    end function;

    function get_type_mcs_id(mcs_bit_vector: std_logic_vector(5 downto 0)) return MCSId is
        variable mcs_id_int : integer range 0 to 31;
    begin
        case mcs_id_int is
            when MCSId'pos(PHY_I_11_67_KBS) =>
                return PHY_I_11_67_KBS;
            when MCSId'pos(PHY_I_24_44_KBS) =>
                return PHY_I_24_44_KBS;
            when MCSId'pos(PHY_I_48_89_KBS) =>
                return PHY_I_48_89_KBS;
            when MCSId'pos(PHY_I_73_3_KBS) =>
                return PHY_I_73_3_KBS;
            when MCSId'pos(PHY_I_100_KBS) =>
                return PHY_I_100_KBS;
            when MCSId'pos(PHY_I_35_56_KBS) =>
                return PHY_I_35_56_KBS;
            when MCSId'pos(PHY_I_71_11_KBS) =>
                return PHY_I_71_11_KBS;
            when MCSId'pos(PHY_I_124_4_KBS) =>
                return PHY_I_124_4_KBS;
            when MCSId'pos(PHY_I_266_6_KBS) =>
                return PHY_I_266_6_KBS;
            when MCSId'pos(PHY_II_1_25_MBS) =>
                return PHY_II_1_25_MBS;
            when MCSId'pos(PHY_II_2_MBS) =>
                return PHY_II_2_MBS;
            when MCSId'pos(PHY_II_2_5_MBS) =>
                return PHY_II_2_5_MBS;
            when MCSId'pos(PHY_II_4_MBS) =>
                return PHY_II_4_MBS;
            when MCSId'pos(PHY_II_5_MBS) =>
                return PHY_II_5_MBS;
            when MCSId'pos(PHY_II_6_MBS) =>
                return PHY_II_6_MBS;
            when MCSId'pos(PHY_II_9_6_MBS) =>
                return PHY_II_9_6_MBS;
            when MCSId'pos(PHY_II_12_MBS) =>
                return PHY_II_12_MBS;
            when MCSId'pos(PHY_II_19_2_MBS) =>
                return PHY_II_19_2_MBS;
            when MCSId'pos(PHY_II_24_MBS) =>
                return PHY_II_24_MBS;
            when MCSId'pos(PHY_II_38_4_MBS) =>
                return PHY_II_38_4_MBS;
            when MCSId'pos(PHY_II_48_MBS) =>
                return PHY_II_48_MBS;
            when MCSId'pos(PHY_II_76_8_MBS) =>
                return PHY_II_76_8_MBS;
            when MCSId'pos(PHY_II_96_MBS) =>
                return PHY_II_96_MBS;
            when MCSId'pos(PHY_III_12_MBS) =>
                return PHY_III_12_MBS;
            when MCSId'pos(PHY_III_18_MBS) =>
                return PHY_III_18_MBS;
            when MCSId'pos(PHY_III_24_MBS) =>
                return PHY_III_24_MBS;
            when MCSId'pos(PHY_III_36_MBS) =>
                return PHY_III_36_MBS;
            when MCSId'pos(PHY_III_48_MBS) =>
                return PHY_III_48_MBS;
            when MCSId'pos(PHY_III_72_MBS) =>
                return PHY_III_72_MBS;
            when MCSId'pos(PHY_III_96_MBS) =>
                return PHY_III_96_MBS;
            when MCSId'pos(MCS_ID_ERROR) =>
                return MCS_ID_ERROR;
            when others =>
                return MCS_ID_ERROR;
        end case;
    end function;

    function get_rs_mode_id_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return integer is
        variable mcs_id : MCSId := get_type_mcs_id(mcs_bit_vector);
    begin
        case mcs_id is
            when  PHY_I_11_67_KBS | PHY_I_124_4_KBS =>
                return RSMode'pos(RS_15_7);
            when  PHY_I_24_44_KBS | PHY_I_73_3_KBS =>
                return RSMode'pos(RS_15_11);
            when  PHY_I_35_56_KBS =>
                return RSMode'pos(RS_15_2);
            when  PHY_I_71_11_KBS =>
                return RSMode'pos(RS_15_4);
            when  PHY_II_1_25_MBS |
                  PHY_II_2_5_MBS | 
                  PHY_II_6_MBS | 
                  PHY_II_12_MBS | 
                  PHY_II_24_MBS | 
                  PHY_II_48_MBS | 
                  PHY_III_12_MBS | 
                  PHY_III_18_MBS | 
                  PHY_III_24_MBS |
                  PHY_III_36_MBS | 
                  PHY_III_48_MBS =>
                return RSMode'pos(RS_64_32);
            when PHY_II_2_MBS | 
                 PHY_II_4_MBS | 
                 PHY_II_9_6_MBS | 
                 PHY_II_19_2_MBS | 
                 PHY_II_38_4_MBS | 
                 PHY_II_76_8_MBS =>
                return RSMode'pos(RS_160_128);
            when PHY_I_100_KBS | 
                 PHY_I_266_6_KBS | 
                 PHY_II_5_MBS | 
                 PHY_II_96_MBS | 
                 PHY_III_72_MBS | 
                 PHY_III_96_MBS =>
                --RS_NONE
                return 0;
            when others =>
                --RS_NONE
                return 0;
        end case;
    end function;

    function get_rs_n_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector is
        variable rs_mode_id : integer := get_rs_mode_id_from_mcs_vector(mcs_bit_vector);
    begin
        return "0000";
    end function;

    function get_rs_k_from_mcs_vector(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic_vector is
        variable rs_mode_id : integer := get_rs_mode_id_from_mcs_vector(mcs_bit_vector);
    begin
        return "0000";
    end function;
    
    function is_manchester_rll(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic is
    begin
        return '1';
    end function;

    function select_mod_mode_from_mcs_id(mcs_bit_vector: std_logic_vector(5 downto 0)) return std_logic is
    begin
        return '1';
    end function;
end package body VLC_PHY_FUNCTIONS;