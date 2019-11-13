library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity single_port_ram is
    generic (
        NUMBER_OF_ELEMENTS : natural := 15;
--      NUMBER_OF_LINES : natural range 1 to NUMBER_OF_ELEMENTS;
        WORD_LENGTH : natural := 4;
        RAM_ADDR_LENGTH : natural := integer(ceil(log2(real(15))))
    );
    port (
	 
		  o_memory : out std_logic_vector ((WORD_LENGTH * NUMBER_OF_ELEMENTS - 1) downto 0);
	 
        clk : in std_logic;
--		  rst : in std_logic;
        i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
		  i_ram_wr_en : in std_logic;
--      i_ram_rd_en : in std_logic;
        i_ram_addr : in std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
        o_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
--		  o_error : out std_logic
    );
end single_port_ram;

architecture behavioral of single_port_ram is
	signal memory : std_logic_vector ((WORD_LENGTH * NUMBER_OF_ELEMENTS - 1) downto 0) := (others => '0');
	
	begin
		write_data : process (clk, i_ram_data, i_ram_wr_en, i_ram_addr)
			begin
				if (rising_edge (clk)) then
					if (i_ram_wr_en = '1') then
						for it0 in 0 to (WORD_LENGTH - 1) loop
							memory (it0 + WORD_LENGTH * to_integer(unsigned (i_ram_addr))) <= i_ram_data (it0);
						end loop;
					end if;
				end if;		
		end process;
		
		read_data : process (clk, i_ram_addr)
			begin
				if (rising_edge (clk)) then
					for it0 in 0 to (WORD_LENGTH - 1) loop
						o_ram_data (it0) <= memory (it0 + WORD_LENGTH * to_integer(unsigned (i_ram_addr)));
					end loop;
				end if;
		end process;

		o_memory <= memory;
		
end behavioral;