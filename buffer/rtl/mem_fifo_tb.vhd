library IEEE;
use IEEE.std_logic_1164.all;

entity mem_fifo_tb is 
generic(
    O_SIZE : integer := 6;
    I_SIZE : integer := 4;
    MEM_SIZE: integer := 12);
end mem_fifo_tb;

architecture test of mem_fifo_tb is

component mem_fifo is
generic (
    O_SIZE : integer;
    I_SIZE : integer;
    MEM_SIZE: integer 
  );
port (
    clk : in std_logic;
    rst : in std_logic;
    i_wr_en : in std_logic;
    i_data : in std_logic_vector(I_SIZE - 1 downto 0);
    i_rd_en : in std_logic;
    o_data : out std_logic_vector(O_SIZE - 1 downto 0);
    o_empty_buffer : out std_logic;
    o_full_buffer : out std_logic 
  );
end component;

signal rst: std_logic;
signal clk: std_logic := '0';
signal i_data: std_logic_vector(I_SIZE-1 downto 0);
constant c_period : time := 10 ns;
signal i_wr_en: std_logic;
signal i_rd_en: std_logic;

begin

process_clock: process
begin
    clock_loop : loop
      clk <= '0';
      wait for (c_period*0.5);
      clk <= '1';
      wait for (c_period*0.5);
    end loop clock_loop;
end process process_clock;

memory: mem_fifo
	generic map(O_SIZE, I_SIZE, MEM_SIZE)
    port map(clk, rst, i_wr_en, i_data, i_rd_en);

rst <= '1', '0' after 10 ns;
i_data <= "1001", "1101" after 10 ns, "1011" after 20 ns, "1111" after 30 ns, "1001" after 40 ns, "1000" after 50 ns, "1010" after 60 ns, "1111" after 70 ns, "1001" after 80 ns;
i_wr_en <= '1';
i_rd_en <= '0', '1' after 40 ns;

end test;