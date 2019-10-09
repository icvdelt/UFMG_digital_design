library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
library work;
use work.GENERIC_COMPONENTS.single_port_ram;
use work.INTERLEAVER_COMPONENTS.rectangular_interleaver;

entity vlc_phy_rectangular_interleaver is
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
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end vlc_phy_rectangular_interleaver;
 
architecture behavioral of vlc_phy_rectangular_interleaver is
    signal w_i_ram_wr_en : std_logic;
    signal w_i_ram_addr : std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
    signal w_i_ram_data : std_logic_vector(WORD_LENGTH-1 downto 0);
    signal w_o_ram_data : std_logic_vector(WORD_LENGTH-1 downto 0);
begin
    --Interface reference: https://www.xilinx.com/support/documentation/ip_documentation/sid/v8_0/pg049-sid.pdf
    RECTANGULAR_INTERLEAVER_INST : rectangular_interleaver
                                   generic map (NUMBER_OF_ELEMENTS => NUMBER_OF_ELEMENTS,
                                                NUMBER_OF_LINES => NUMBER_OF_LINES,
                                                WORD_LENGTH => WORD_LENGTH)
                                   port map(clk => clk,
                                            rst => rst,
                                            i_consume => i_consume,
                                            i_end_interleaver => i_end_interleaver,
                                            i_start_interleaver => i_start_interleaver,
                                            i_valid => i_valid,
                                            i_ram_data => w_o_ram_data, 
                                            i_data => i_data,
                                            o_end_interleaver => o_end_interleaver,
                                            o_error => o_error,
                                            o_in_ready => open,
                                            o_ram_wr_en => w_i_ram_wr_en,
                                            o_start_interleaver => o_start_interleaver,
                                            o_valid => o_valid,
                                            o_i_ram_addr => w_i_ram_addr,
                                            o_i_ram_data => w_i_ram_data,
                                            o_data => o_data); 
     SINGLE_PORT_RAM_INST : single_port_ram
                            generic map (NUMBER_OF_ELEMENTS => NUMBER_OF_ELEMENTS,
                                         WORD_LENGTH => WORD_LENGTH)
                            port map (clk => clk,
                                      i_ram_wr_en => w_i_ram_wr_en,
                                      i_ram_addr => w_i_ram_addr,
                                      i_ram_data => w_i_ram_data,
                                      o_ram_data => w_o_ram_data);
end behavioral;
