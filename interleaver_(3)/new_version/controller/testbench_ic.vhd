library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity testbench_ic is
	generic (
		NUMBER_OF_STATES : natural := 9);
end testbench_ic;

architecture dataflow_tbic of testbench_ic is
	
	component interleaver_controller is
		generic (
			NUMBER_OF_STATES : natural);
	
		port (
			clk : in std_logic;
			rst : in std_logic;
	
			i_start_interleaver : in std_logic;		--Indicates that the first input has been sent.	
			i_valid : in std_logic;						--Validates the incoming data.
			i_end_interleaver : in std_logic;		--Indicates that the last input has been sent.
			i_consume : in std_logic;					--Requires an output from the interleaver.
			full_ram : in std_logic;					--Indicates that the ram has reached its capacity.
			first_out : in std_logic;					--Indicates that the first output is to be sent.
			last_out : in std_logic;					--Indicates that the last output is to be sent.
	
--			rst_ram_input : out std_logic;			--Resets the input register.
			en_ram_input : out std_logic;				--Enables the input register.
			rst_indexer : out std_logic;				--Resets the registers of the counter.
			wr_rd_status : out std_logic;				--Selects the status of process (read/write).
			en_indexer : out std_logic;				--Enables the registers of the counters.
			rst_last_input : out std_logic;			--Resets the registers of the last line/column.
			en_last_input : out std_logic;			--Enables the registers of the last line/column.
			o_end_interleaver : out std_logic;		--Sets if the last output is sent. 
			o_error : out std_logic;					--Sets in case of an error.
			o_ram_wr_en : out std_logic;				--Sets when the interleaver is ready to recieve data.
			o_in_ready : out std_logic;				--Enables the ram to store data.
			o_start_interleaver : out std_logic;	--Sets if the first output is sent.
			o_valid : out std_logic;					--Sets if the output sent is valid.
	
			output : out std_logic_vector ((integer(ceil(log2(real(NUMBER_OF_STATES)))) - 1) downto 0));
	

	end component;
	
	signal clk, rst, i_start_interleaver, i_valid, i_end_interleaver, i_consume : std_logic;
	signal full_ram, first_out, last_out, en_ram_input, rst_indexer, wr_rd_status : std_logic;
	signal en_indexer, rst_last_input, en_last_input, o_end_interleaver, o_error : std_logic;
	signal o_ram_wr_en, o_in_ready, o_start_interleaver, o_valid : std_logic;
	signal output : std_logic_vector ((integer(ceil(log2(real(NUMBER_OF_STATES)))) - 1) downto 0);
	
	begin
	
		IC0 : interleaver_controller
			generic map (
				NUMBER_OF_STATES => NUMBER_OF_STATES)
	
			port map (
				clk => clk,
				rst => rst,
				
				i_start_interleaver => i_start_interleaver,	
				i_valid => i_valid,
				i_end_interleaver => i_end_interleaver,
				i_consume => i_consume,
				full_ram => full_ram,
				first_out => first_out,
				last_out => last_out,
	
				en_ram_input => en_ram_input,
				rst_indexer => rst_indexer,
				wr_rd_status => wr_rd_status,
				en_indexer => en_indexer,
				rst_last_input => rst_last_input,
				en_last_input => en_last_input,
				o_end_interleaver => o_end_interleaver,
				o_error => o_error,
				o_ram_wr_en => o_ram_wr_en,
				o_in_ready => o_in_ready,
				o_start_interleaver => o_start_interleaver,
				o_valid => o_valid,
	
				output => output);
				
		pulse : process
			begin
				clk <= '0';
				wait for 5 ns;
				clk <= '1';
				wait for 10 ns;
				clk <= '0';
				wait for 5 ns;
		end process;
		
		rst <= '1', '0' after 5001 ps, '1' after 365001 ps, '0' after 385001 ps;
		
		i_start_interleaver <= '0', '1' after 5001 ps, '0' after 25001 ps, '1' after 385001 ps, '0' after 405001 ps;	
		i_valid <= '0', '1' after 5001 ps, '0' after 465001 ps, '1' after 485001 ps, '0' after 545001 ps;
		i_end_interleaver <= '0', '1' after 525001 ps, '0' after 545001 ps;
		i_consume <= '0', '1' after 645001 ps, '0' after 685001 ps, '1' after 725001 ps, '0' after 825001 ps;
		full_ram <= '0', '1' after 345001 ps, '0' after 385001 ps;
		first_out <= '0', '1' after 645001 ps, '0' after 665001 ps;
		last_out <= '0', '1' after 805001 ps, '0' after 825001 ps;
	
end dataflow_tbic;