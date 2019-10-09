library IEEE;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.STD_LOGIC_1164.all;

entity rectangular_interleaver is
    generic (
        NUMBER_OF_ELEMENTS : natural;
        NUMBER_OF_LINES : natural range 1 to NUMBER_OF_ELEMENTS;
        WORD_LENGTH : natural;
        RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_consume : in std_logic;
        i_end_interleaver : in std_logic;
        i_start_interleaver : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_in_ready : out std_logic;
        o_ram_wr_en : out std_logic;
        o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_i_ram_addr : out std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
        o_i_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0);
        o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end rectangular_interleaver;

architecture behavioral of rectangular_interleaver is
begin

end behavioral;