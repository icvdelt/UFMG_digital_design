library IEEE;
use IEEE.STD_LOGIC_1164.all;
library work;
use work.VLC_PHY_TYPES.B2BType;

entity b_to_b_rll_code is
    generic (
        B2B_TYPE : B2BType
    );
    port (
        i_data : in std_logic_vector(3 downto 0);
        o_data : out std_logic_vector(5 downto 0)
    );
end b_to_b_rll_code;

architecture behavioral of b_to_b_rll_code is
begin

end behavioral;