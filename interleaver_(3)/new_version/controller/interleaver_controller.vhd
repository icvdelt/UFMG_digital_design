library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity interleaver_controller is
	generic (
		NUMBER_OF_STATES : natural := 9);
	
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
	
--		rst_ram_input : out std_logic;			--Resets the input register.
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
	

end interleaver_controller;

architecture behaviour_ict of interleaver_controller is

	type state_type is (START, RECEIVE, STALL, ERROR, LAST_INPUT, WAIT_CONSUME, FIRST_OUTPUT, CONSUMING, LAST_OUTPUT);
	signal current_state, next_state : state_type;

	begin
		
		sequential_process : process (clk, rst, next_state)
			begin
				if (rising_edge(CLK)) then	--Synchronous process;
					if (rst = '1') then	--When rsest is on, the next state must be START. That includes the start off.
						current_state <= START;
					elsif (rst = '0') then
						current_state <= next_state;	--Chnages to the next satate.
					end if;
				end if;
		end process;
		
		conbinational_process : process (current_state, i_start_interleaver, i_valid, i_end_interleaver, i_consume, full_ram, first_out, last_out)
			begin
				case current_state is
					when START =>	--Starting condition. Ready to receive data.
--						rst_ram_input <= '0';
						en_ram_input <= '1';
						rst_indexer <= '1';
						wr_rd_status <= '0';
						en_indexer <= '0';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '1';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						if (i_consume = '1' OR i_end_interleaver = '1') then
							next_state <= ERROR;
						elsif (i_end_interleaver = '0' AND i_consume = '0' AND i_valid = '1' AND i_start_interleaver = '1') then
							next_state <= RECEIVE;
						else
							next_state <= START;
						end if;
						
					when RECEIVE =>	--Receiving data.
--						rst_ram_input <= '0';
						en_ram_input <= '1';
						rst_indexer <= '0';
						wr_rd_status <= '0';
						en_indexer <= '1';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '1';
						o_ram_wr_en <= '1';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						if (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '0') then
							next_state <= STALL;
						elsif (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '1' AND i_end_interleaver = '1') then
							next_state <= LAST_INPUT;
						elsif (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '1' AND i_end_interleaver = '0' AND full_ram = '0') then
							next_state <= RECEIVE;
						else
							next_state <= ERROR;
						end if;
						
					when STALL =>	--Waiting for valid data.
--						rst_ram_input <= '0';
						en_ram_input <= '1';
						rst_indexer <= '0';
						wr_rd_status <= '0';
						en_indexer <= '0';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '1';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						if (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '0') then
							next_state <= STALL;
						elsif (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '1' AND i_end_interleaver = '1') then
							next_state <= LAST_INPUT;
						elsif (i_start_interleaver = '0' AND i_consume = '0' AND i_valid = '1' AND i_end_interleaver = '0' AND full_ram = '0') then
							next_state <= RECEIVE;
						else
							next_state <= ERROR;
						end if;
						
					when ERROR =>	--Indictes something wrong has happened.
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '1';
						wr_rd_status <= '0';
						en_indexer <= '0';
						rst_last_input <= '1';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '1';
						o_in_ready <= '0';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						next_state <= ERROR;
						
					when LAST_INPUT =>	--Happens when the i_end_interleaver is received.
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '1';
						wr_rd_status <= '1';
						en_indexer <= '0';
						rst_last_input <= '0';
						en_last_input <= '1';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '0';
						o_ram_wr_en <= '1';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						if (i_start_interleaver = '1' OR i_end_interleaver = '1' OR i_valid = '1') then
							next_state <= ERROR;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '0') then
							next_state <= WAIT_CONSUME;
						else
							next_state <= FIRST_OUTPUT;
						end if;
						
					when WAIT_CONSUME =>	--Waits until an output is required.
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '0';
						wr_rd_status <= '1';
						en_indexer <= '0';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '0';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						if (i_start_interleaver = '1' OR i_end_interleaver = '1' OR i_valid = '1') then
							next_state <= ERROR;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '0') then
							next_state <= WAIT_CONSUME;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '1' AND last_out = '1') then
							next_state <= LAST_OUTPUT;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '1' AND last_out = '0' AND first_out = '1') then
							next_state <= FIRST_OUTPUT;
						else
							next_state <= CONSUMING;
						end if;
						
					when FIRST_OUTPUT =>	--Sends the first output and all control signals associated with it.
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '0';
						wr_rd_status <= '1';
						en_indexer <= '1';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '0';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '1';
						o_valid <= '1';
						
						if (i_start_interleaver = '1' OR i_end_interleaver = '1' OR i_valid = '1') then
							next_state <= ERROR;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '0') then
							next_state <= WAIT_CONSUME;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '1' AND last_out = '1') then
							next_state <= LAST_OUTPUT;
						else
							next_state <= CONSUMING;
						end if;
						
					when CONSUMING =>	--Keeps sending outputs while i_consume is on.
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '0';
						wr_rd_status <= '1';
						en_indexer <= '1';
						rst_last_input <= '0';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '0';
						o_in_ready <= '0';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '1';
						
						if (i_start_interleaver = '1' OR i_end_interleaver = '1' OR i_valid = '1') then
							next_state <= ERROR;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '0') then
							next_state <= WAIT_CONSUME;
						elsif (i_start_interleaver = '0' AND i_end_interleaver = '0' AND i_valid = '0' AND i_consume = '1' AND last_out = '1') then
							next_state <= LAST_OUTPUT;
						else
							next_state <= CONSUMING;
						end if;
						
					when LAST_OUTPUT =>	--Sends the last output and all control signals associated with it.
--						rst_ram_input <= '0';
						en_ram_input <= '1';
						rst_indexer <= '1';
						wr_rd_status <= '0';
						en_indexer <= '0';
						rst_last_input <= '1';
						en_last_input <= '0';
						o_end_interleaver <= '1';
						o_error <= '0';
						o_in_ready <= '1';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '1';
						
						if (i_consume = '1' OR i_end_interleaver = '1') then
							next_state <= ERROR;
						elsif (i_consume = '0' AND i_end_interleaver = '0' AND i_start_interleaver = '1' AND i_valid = '1') then
							next_state <= RECEIVE;
						else
							next_state <= START;
						end if;
						
					when others =>
--						rst_ram_input <= '0';
						en_ram_input <= '0';
						rst_indexer <= '1';
						wr_rd_status <= '0';
						en_indexer <= '0';
						rst_last_input <= '1';
						en_last_input <= '0';
						o_end_interleaver <= '0';
						o_error <= '1';
						o_in_ready <= '0';
						o_ram_wr_en <= '0';
						o_start_interleaver <= '0';
						o_valid <= '0';
						
						next_state <= ERROR;
				
				end case;							
		end process;
		
		with current_state select output <=
			"0000" when START,
			"0001" when RECEIVE,
			"0010" when STALL,
			"0011" when ERROR,
			"0100" when LAST_INPUT,
			"0101" when WAIT_CONSUME,
			"0110" when FIRST_OUTPUT,
			"0111" when CONSUMING,
			"1000" when LAST_OUTPUT,
			"1111" when others;
		
end behaviour_ict;