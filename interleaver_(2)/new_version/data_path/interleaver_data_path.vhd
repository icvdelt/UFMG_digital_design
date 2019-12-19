library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity interleaver_data_path is
	generic (
		NUMBER_OF_ELEMENTS : natural := 20;
   	NUMBER_OF_LINES : natural range 1 to 16 := 4;
		WORD_LENGTH : natural := 4;
		LINE_ADDR_LENGTH : natural := integer(ceil(log2(real(4))));
		COLUMN_ADDR_LENGTH : natural := integer(ceil(log2(real(20/4)))));
		
	port (
		clk : in std_logic;								--Clock signal.
		wr_rd_status : in std_logic;					--Status of the memory according dsd to the state of the FSM.
		rst_last_input : in std_logic;				--Resets the last line and last column registers.
		en_last_input : in std_logic;					--Enables the last line and last column register.
		en_ram_input : in std_logic;					--Enables the input register.
		rst_indexer : in std_logic;					--Resets the line counter and column counter registers.
		en_indexer : in std_logic;						--Enables the load of the line counter and column counter registers.
		ram_wr_en : in std_logic;						--Enables the ram.
		
		i_data : in std_logic_vector ((WORD_LENGTH - 1) downto 0); --Data input.
		
		full_ram_first_out : out std_logic;			--Represents that the ram is full or that the first output has been sent depending on the selection of the target.
		last_out : out std_logic;						--Represents that the last output has been sent.
		
		lin_count : out std_logic_vector ((LINE_ADDR_LENGTH - 1) downto 0);
		col_count : out std_logic_vector	((COLUMN_ADDR_LENGTH - 1) downto 0);
		
		o_data : out std_logic_vector ((WORD_LENGTH -1 ) downto 0));	--Data output.	
end interleaver_data_path;

architecture structure_idp of interleaver_data_path is
	
	component comparator is
		generic (
			NUMBER_OF_BITS_PER_INPUT : natural);
		port (
			i_ref : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			i_data : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			lt : out std_logic;
			eq : out std_logic);
	end component;
	
	component decrementer is
		generic (
			NUMBER_OF_BITS : natural);
	
		port (
			input : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			output : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			carry_out : out std_logic);
	end component;
	
	component matrix_indexer_incrementer is
		generic(
			NUMBER_OF_BITS : natural);
		port (
			clk : in std_logic;													-- clock do sistema
			rst : in std_logic; 												-- reset do sistema
			clear_line : in std_logic;											-- zera a linha quando acionado
			clear_column : in std_logic; 										-- zera a coluna quando acionado
			inc : in std_logic; 												-- incrementa quando acionado
			axis : in std_logic; 												-- seleciona o eixo que será incrementado: '0' para linja, '1' para coluna
			lin_counter : out std_logic_vector(NUMBER_OF_BITS - 1 downto 0);	-- contagem das linhas
			column_counter: out std_logic_vector(NUMBER_OF_BITS - 1 downto 0)); -- contagem das colunas
	end component;
		
	component mux_2x1 is
		generic (
			NUMBER_OF_BITS_PER_INPUT : natural);
		port (
			i_index : in std_logic;
			i_data_0 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			i_data_1 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			o_data : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0));
	end component;
	
	component reg is
		generic (
			NUMBER_OF_BITS : natural := 4);
		port (
			rst : in std_logic;
			clk : in std_logic;
			ld : in std_logic;
			i_data : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			o_data : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0));
	end component;
	
	component single_port_ram is
		generic (
			NUMBER_OF_ELEMENTS : natural;
			NUMBER_OF_LINES : natural;
			WORD_LENGTH : natural;
			LINE_ADDR_LENGTH : natural;
			COLUMN_ADDR_LENGTH : natural);
			
		port (
			clk : in std_logic;
			i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
			i_ram_wr_en : in std_logic;
			i_lin_addr : in std_logic_vector(LINE_ADDR_LENGTH-1 downto 0);
			i_col_addr : in std_logic_vector(COLUMN_ADDR_LENGTH-1 downto 0);
			o_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0));
	end component;
	
	signal wire0 : std_logic_vector (5 downto 0);
	signal wire1 : std_logic_vector (5 downto 0);
	signal last_col, col_cnt, w_mux3, w_mux7, last_col_1 : std_logic_vector ((COLUMN_ADDR_LENGTH - 1) downto 0);
	signal last_lin, lin_cnt, w_mux6 : std_logic_vector ((LINE_ADDR_LENGTH - 1) downto 0);
	signal i_ram_data : std_logic_vector ((WOrD_LENGTH - 1) downto 0);
	
	function MAX(A, B: INTEGER) return INTEGER is
		begin
			if (A > B) then return A;
			else return B;
			end if;
	end function;
	
	signal aux0, aux1 : std_logic_vector ((MAX (LINE_ADDR_LENGTH, COLUMN_ADDR_LENGTH) - 1) downto 0);
	
	signal aux2, aux3, aux4, aux5 : std_logic_vector (0 downto 0);
	
	begin
	
		COMP0 : comparator  --Compares whether the target has been reached by the current line.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => LINE_ADDR_LENGTH)
			port map (
				i_ref => w_mux6,
				i_data => lin_cnt,
				eq => wire0 (0));
		
		COMP1 : comparator  --Compares whether the last line has been reached.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => LINE_ADDR_LENGTH)
			port map (
				i_ref => std_logic_vector (to_unsigned ((NUMBER_OF_LINES - 1), LINE_ADDR_LENGTH)),
				i_data => lin_cnt,
				eq => wire0 (1));
				
		wire0 (5) <= NOT (wire0 (1));
		
		COMP2 : comparator  --Compares whether the last line written is littler than the current line.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => LINE_ADDR_LENGTH)
			port map (
				i_ref => lin_cnt,
				i_data => last_lin,
				lt => wire0 (2));
	
		COMP3 : comparator --Compares whether the last column has been reached.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => COLUMN_ADDR_LENGTH)
			port map (
				i_ref => w_mux3,
				i_data => col_cnt,
				eq => wire0 (3));
				
		last_out <= wire0 (1) AND wire0 (3);
				
		COMP4 : comparator  --Compares whether the target has been reached by the current line.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => COLUMN_ADDR_LENGTH)
			port map (
				i_ref => w_mux7,
				i_data => col_cnt,
				eq => wire0 (4));
				
		full_ram_first_out <= wire0 (0) AND wire0 (4);
		
		aux2 <= "" & wire0 (5);
		aux3 <= "" & wire0 (3);
				
		MUX1 : mux_2x1	--Selects the reference for selecting the axis.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => 1)
			port map (
				i_index => wr_rd_status,
				i_data_0 => aux2,
				i_data_1 => aux3,
				o_data (0) => wire1 (0));
		
		wire1 (5) <= NOT (wire1 (0));
		
		MUX3 : mux_2x1	--Selects the reference for the last column.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => COLUMN_ADDR_LENGTH)
			port map (
				i_index => wire0 (2),
				i_data_0 => last_col,
				i_data_1 => last_col_1,
				o_data => w_mux3);
				
		aux4 <= "" & wire0 (1);
				
		MUX4 : mux_2x1	--Selects the reset option for the line counter.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => 1)
			port map (
				i_index => wr_rd_status,
				i_data_0 => aux4,
				i_data_1 => "0",
				o_data (0) => wire1 (1));
				
		wire1 (3) <= wire1 (1) AND en_indexer;
				
		aux5 <= "" & wire0 (3);
			
		MUX5 : mux_2x1	--Selects the reset option for the column counter.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => 1)
			port map (
				i_index => wr_rd_status,
				i_data_0 => "0",
				i_data_1 => aux5,
				o_data (0) => wire1 (2));
		
		wire1 (4) <= wire1 (2) AND en_indexer;
				
		MUX6 : mux_2x1	--Selects the reference for the target of the lines.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => LINE_ADDR_LENGTH)
			port map (
				i_index => wr_rd_status,
				i_data_0 => std_logic_vector (to_unsigned ((NUMBER_OF_LINES - 1), LINE_ADDR_LENGTH)),
				i_data_1 => std_logic_vector (to_unsigned (0, LINE_ADDR_LENGTH)),
				o_data => w_mux6);
		
		MUX7 : mux_2x1	--Selects the reference for the target of the columns.
			generic map (
				NUMBER_OF_BITS_PER_INPUT => COLUMN_ADDR_LENGTH)
			port map (
				i_index => wr_rd_status,
				i_data_0 => std_logic_vector (to_unsigned (((NUMBER_OF_ELEMENTS/NUMBER_OF_LINES) - 1), COLUMN_ADDR_LENGTH)),
				i_data_1 => std_logic_vector (to_unsigned (0, COLUMN_ADDR_LENGTH)),
				o_data => w_mux7);
				
		DEC0 : decrementer -- Calculates the last column minus 1.
			generic map (
				NUMBER_OF_BITS => COLUMN_ADDR_LENGTH)
	
			port map (
				input => last_col,
				output => last_col_1);
				
		REG3 : reg	--Holds the last line written.
			generic map (
				NUMBER_OF_BITS => LINE_ADDR_LENGTH)
			port map (
				rst => rst_last_input,
				clk => clk,
				ld => en_last_input,
				i_data => lin_cnt,
				o_data => last_lin);
				
		REG4 : reg	--Holds the last column written.
			generic map (
				NUMBER_OF_BITS => COLUMN_ADDR_LENGTH)
			port map (
				rst => rst_last_input,
				clk => clk,
				ld => en_last_input,
				i_data => col_cnt,
				o_data => last_col);
				
		REG5 : reg	--Holds the input.
			generic map (
				NUMBER_OF_BITS => WORD_LENGTH)
			port map (
				rst => '0',
				clk => clk,
				ld => en_ram_input,
				i_data => i_data,
				o_data => i_ram_data);
				
		MII0 : matrix_indexer_incrementer	--Includes the counters that indicate the current line and the current column.
			generic map (
				NUMBER_OF_BITS => MAX (LINE_ADDR_LENGTH, COLUMN_ADDR_LENGTH))
			port map (
				clk => clk,
				rst => rst_indexer,
				clear_line => wire1 (3),
				clear_column => wire1 (4),
				inc => en_indexer,
				axis => wire1 (5),
				lin_counter => aux0,
				column_counter => aux1);
				
				lin_cnt <= aux0 ((LINE_ADDR_LENGTH - 1) downto 0);
				col_cnt <= aux1 ((COLUMN_ADDR_LENGTH - 1) downto 0);
		
		SPR0 : single_port_ram	--Holds the data that would be shuffled.
			generic map (
				NUMBER_OF_ELEMENTS => NUMBER_OF_ELEMENTS,
				NUMBER_OF_LINES => NUMBER_OF_LINES,
				WORD_LENGTH => WORD_LENGTH,
				LINE_ADDR_LENGTH => LINE_ADDR_LENGTH,
				COLUMN_ADDR_LENGTH => COLUMN_ADDR_LENGTH)
			
			port map (
				clk => clk,
				i_ram_data => i_ram_data,
				i_ram_wr_en => ram_wr_en,
				i_lin_addr => lin_cnt,
				i_col_addr => col_cnt,
				o_ram_data => o_data);
				
			lin_count <= lin_cnt;
			col_count <= col_cnt;
		
end structure_idp;