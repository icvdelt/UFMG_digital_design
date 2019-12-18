-- matrix_indexer_incrementer
-- componente que incrementa os contadores de linha e coluna

library IEEE;
use IEEE.STD_LOGIC_1164.all;

entity matrix_indexer_incrementer is
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
end matrix_indexer_incrementer;

architecture dataflow of matrix_indexer_incrementer is

	-- sinais internos:
    
    -- sinais de load dos registradores de linha e coluna:
	signal ld_reg_lin : std_logic;
    signal ld_reg_column : std_logic;
    
    -- sinais de rst dos registradores de linha e coluna:
    signal rst_reg_lin : std_logic;
    signal rst_reg_column : std_logic;
    
    -- sinais de entrada e saída do incrementador:
    signal i_incrementer : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
    signal o_incrementer : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
    
    -- sinais das contagens de linha e coluna (saídas dos registradores de linha e coluna):
    signal r_lin_counter : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
    signal r_column_counter : std_logic_vector(NUMBER_OF_BITS - 1 downto 0);
	
    -- componentes utilizados:
    
    --incrementador
	component incrementer is
    	generic (
			NUMBER_OF_BITS : natural);
		port (
			input : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			output : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			carry_out : out std_logic);
	end component;
    
    -- multiplexador 2 pra 1
    component mux_2x1 is
		generic (
			NUMBER_OF_BITS_PER_INPUT : natural);
		port (
			-- en : in std_logic;
			i_index : in std_logic;
			i_data_0 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			i_data_1 : in std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0);
			o_data : out std_logic_vector ((NUMBER_OF_BITS_PER_INPUT - 1) downto 0));
	end component;
    
    -- registrador
    component reg is
		generic (
			NUMBER_OF_BITS : natural);
		port (
			rst : in std_logic;
			clk : in std_logic;
			ld : in std_logic;
			i_data : in std_logic_vector ((NUMBER_OF_BITS - 1) downto 0);
			o_data : out std_logic_vector ((NUMBER_OF_BITS - 1) downto 0));
	end component;

	begin

	  -- registrador que guarda a contagem de linhas
      reg_lin : reg 
          generic map (NUMBER_OF_BITS => NUMBER_OF_BITS)
          port map   (rst => rst_reg_lin,
                      clk => clk,
                      ld => ld_reg_lin,
                      i_data => o_incrementer,
                      o_data => r_lin_counter);
                      
      -- registrador que guarda a contagem de colunas                
      reg_column : reg
          generic map (NUMBER_OF_BITS => NUMBER_OF_BITS)
          port map   (rst => rst_reg_column,
                      clk => clk,
                      ld => ld_reg_column,
                      i_data => o_incrementer,
                      o_data => r_column_counter);
                      
      -- multiplexador que seleciona a entrada do incrementador                
      mux : mux_2x1
          generic map ( NUMBER_OF_BITS_PER_INPUT => NUMBER_OF_BITS)
          port map   (i_index => axis,
                      i_data_0 => r_lin_counter,
                      i_data_1 => r_column_counter,
                      o_data => i_incrementer);
                      
                      
      -- incrementador
      incrementer1 : incrementer
          generic map (NUMBER_OF_BITS => NUMBER_OF_BITS)
          port map   (input => i_incrementer,
                      output => o_incrementer);                   
	
	  -- lógica para o acionamento dos sinais de load dos registradores de linha e coluna:    
      ld_reg_lin <= inc and (not axis);
      ld_reg_column <= inc and axis;
      
      -- lógica para acionamento dos sinais de reset dos registradores de linha e coluna
      rst_reg_lin <= rst or clear_line;
      rst_reg_column <= rst or clear_column;
      
      -- definição dos sinais de saída do componente
      lin_counter <= r_lin_counter;
      column_counter <= r_column_counter;

end dataflow;
     