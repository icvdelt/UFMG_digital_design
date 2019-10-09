---------------------------------------------------------------------------
-- Universidade Federal de Minas Gerais (UFMG)
---------------------------------------------------------------------------
-- Project: Generic Components
-- Design: sync_dff_gen_rst
---------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity async_dff_gen_rst is 
    generic (
        WORD_LENGTH : natural range 1 to 10;
        RESET_VALUE : std_logic_vector(WORD_LENGTH-1  downto 0)
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
    	d : in std_logic_vector(WORD_LENGTH-1 downto 0);
        q : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end async_dff_gen_rst;

architecture behavioral of async_dff_gen_rst is
begin 
    process (clk,rst) 
    begin 
        if (rst = '1') then 
            q <= RESET_VALUE;
        elsif (rising_edge(clk)) then
            q <= d; 
        end if; 
    end process; 
end behavioral;
