library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.GENERIC_TYPES.array_of_integers;

package VLC_PHY_TYPES is
    type B2BType is (B2B_4b6b);

    type PhyType is (PHY_I, 
                     PHY_II,
                     PHY_III);

    type MCSId is (PHY_I_11_67_KBS,
                   PHY_I_24_44_KBS,
                   PHY_I_48_89_KBS,
                   PHY_I_73_3_KBS,
                   PHY_I_100_KBS,
                   PHY_I_35_56_KBS,
                   PHY_I_71_11_KBS,
                   PHY_I_124_4_KBS,
                   PHY_I_266_6_KBS,
                   PHY_II_1_25_MBS,
                   PHY_II_2_MBS,
                   PHY_II_2_5_MBS,
                   PHY_II_4_MBS,
                   PHY_II_5_MBS,
                   PHY_II_6_MBS,
                   PHY_II_9_6_MBS,
                   PHY_II_12_MBS,
                   PHY_II_19_2_MBS,
                   PHY_II_24_MBS,
                   PHY_II_38_4_MBS,
                   PHY_II_48_MBS,
                   PHY_II_76_8_MBS,
                   PHY_II_96_MBS,
                   PHY_III_12_MBS,
                   PHY_III_18_MBS,
                   PHY_III_24_MBS,
                   PHY_III_36_MBS,
                   PHY_III_48_MBS,
                   PHY_III_72_MBS,
                   PHY_III_96_MBS,
                   MCS_ID_ERROR);

    type RSMode is (RS_15_7,
                    RS_15_11,
                    RS_15_2,
                    RS_15_4,
                    RS_64_32,
                    RS_160_128,
                    RS_NONE);
    
	constant rs_n_parameter: array_of_integers(0 to 5) := (15, 15, 15, 15, 64, 160);
	constant rs_k_parameter: array_of_integers(0 to 5) := (7, 11, 2, 4, 32, 128);
end package VLC_PHY_TYPES;
