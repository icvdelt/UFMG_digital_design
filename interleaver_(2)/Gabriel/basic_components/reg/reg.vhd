library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.all;

entity reg is
	generic (
		NUMBER_OF_BITS : natural := 4);
	port (
		rst : in std_logic;
		clk : in std_logic;
		ld : in std_logic;
		i_data : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
		o_data : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0));
end reg;

architecture bh_reg of reg is
	begin
		store : process (rst, clk, ld, i_data)
			begin
				if (rst = '1') then --Clears the register asynchronously.
					o_data <= (others => '0');
				else
					if (rising_edge (clk)) then	--Synchronous behaviour.
						if (ld = '1') then
							o_data <= i_data;
						end if;
					end if;
				end if;
		end process;
end bh_reg;