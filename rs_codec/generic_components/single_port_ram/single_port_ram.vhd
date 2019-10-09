library IEEE;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.STD_LOGIC_1164.all;

entity single_port_ram is
    generic (
        NUMBER_OF_ELEMENTS : natural;
        WORD_LENGTH : natural;
        RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
    );
    port (
        clk : in std_logic;
        i_ram_wr_en : in std_logic;
        i_ram_addr : in std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
        i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0)  
    );
end single_port_ram;

architecture behavioral of single_port_ram is
begin

end behavioral;