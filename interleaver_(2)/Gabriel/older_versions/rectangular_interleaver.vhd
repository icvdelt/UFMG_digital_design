library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.MATH_REAL.ceil;
use IEEE.MATH_REAL.log2;
use IEEE.NUMERIC_STD.all;

entity rectangular_interleaver is
    generic (
        NUMBER_OF_ELEMENTS : natural := 15;
        NUMBER_OF_LINES : natural range 1 to 15 := 4;
        WORD_LENGTH : natural := 4;
        RAM_ADDR_LENGTH : 	natural := integer(ceil(log2(real(15))))
    );
    port (
	 
--		  o_filled : out std_logic;
--		  o_memory : out std_logic_vector ((WORD_LENGTH * NUMBER_OF_ELEMENTS - 1) downto 0);
	 
        clk : in std_logic;
        rst : in std_logic;
        i_consume : in std_logic;
        i_end_interleaver : in std_logic;
        i_start_interleaver : in std_logic;
        i_valid : in std_logic;
        i_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
        o_end_interleaver : out std_logic;
        o_error : out std_logic;
        o_in_ready : out std_logic;
        o_start_interleaver : out std_logic;
        o_valid : out std_logic;
        o_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
    );
end rectangular_interleaver;

architecture behavioral of rectangular_interleaver is
	
	component inner_rectangular_interleaver is
		generic (
			NUMBER_OF_ELEMENTS_INRI : natural := NUMBER_OF_ELEMENTS;
			NUMBER_OF_LINES_INRI : natural range 1 to 15 := NUMBER_OF_LINES;
			WORD_LENGTH_INRI : natural := WORD_LENGTH;
			RAM_ADDR_LENGTH_INRI : 	natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
		);
		port (
	 
--		  o_filled : out std_logic;
	 
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
	end component;
	
	component single_port_ram is
		generic (
			NUMBER_OF_ELEMENTS_SPR : natural := NUMBER_OF_ELEMENTS;
--     	NUMBER_OF_LINES_SPR : natural range 1 to NUMBER_OF_ELEMENTS;
			WORD_LENGTH_SPR : natural := WORD_LENGTH;
			RAM_ADDR_LENGTH_SPR : natural := integer(ceil(log2(real(NUMBER_OF_ELEMENTS))))
		);
		port (
		
--			o_memory : out std_logic_vector ((WORD_LENGTH_SPR * NUMBER_OF_ELEMENTS_SPR - 1) downto 0);
		
			clk : in std_logic;
--			rst : in std_logic;
			i_ram_data : in std_logic_vector(WORD_LENGTH-1 downto 0);
			i_ram_wr_en : in std_logic;
--     	i_ram_rd_en : in std_logic;
			i_ram_addr : in std_logic_vector(RAM_ADDR_LENGTH-1 downto 0);
			o_ram_data : out std_logic_vector(WORD_LENGTH-1 downto 0)
--		 	o_error : out std_logic
		);
	end component;
	
	signal w : std_logic_vector ((2*WORD_LENGTH + RAM_ADDR_LENGTH) downto 0);
	
	begin
		INRI0 : inner_rectangular_interleaver port map (
			
--				o_filled => filled,
			
				clk => clk,
				rst => rst,
				i_consume => i_consume,
				i_end_interleaver => i_end_interleaver,
				i_start_interleaver => i_start_interleaver,
				i_valid => i_valid,
				i_data => i_data,
				i_ram_data => w (WORD_LENGTH downto 1),
				o_end_interleaver => o_end_interleaver,
				o_error => o_error,
				o_in_ready => o_in_ready,
				o_ram_wr_en => w (0),
				o_start_interleaver => o_start_interleaver,
				o_valid => o_valid,
				o_i_ram_addr => w ((RAM_ADDR_LENGTH + WORD_LENGTH) downto (WORD_LENGTH + 1)),
				o_i_ram_data => w ((2*WORD_LENGTH + RAM_ADDR_LENGTH) downto (RAM_ADDR_LENGTH + WORD_LENGTH + 1)),
				o_data => o_data);
				
		SPR0 : single_port_ram port map (
		
--			o_memory => o_memory,
	
			clk => clk,
--		  	rst,
			i_ram_data => w ((2*WORD_LENGTH + RAM_ADDR_LENGTH) downto (RAM_ADDR_LENGTH + WORD_LENGTH + 1)),
			i_ram_wr_en => w (0),
--      	i_ram_rd_en,
			i_ram_addr => w ((RAM_ADDR_LENGTH + WORD_LENGTH) downto (WORD_LENGTH + 1)),
			o_ram_data => w (WORD_LENGTH downto 1)
--		  	o_error
			);

end behavioral;