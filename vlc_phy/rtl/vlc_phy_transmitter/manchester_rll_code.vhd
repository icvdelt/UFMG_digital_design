library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity manchester_rll_code is
    generic (
        NUM_OF_UNITS : natural range 1 to 10
    );
    port (
        i_data : in std_logic_vector(NUM_OF_UNITS-1 downto 0);
        o_data : out std_logic_vector(2*NUM_OF_UNITS-1 downto 0)
    );
end manchester_rll_code;

architecture behavioral of manchester_rll_code is
begin

end behavioral;