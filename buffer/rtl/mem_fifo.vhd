library ieee;
use ieee.std_logic_1164.all;

entity mem_fifo is
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
    o_empty_buffer : out std_logic := '1';
    o_full_buffer : out std_logic := '0' 
  );
end mem_fifo;  

architecture behavioral of mem_fifo is
signal mem: std_logic_vector(MEM_SIZE-1 downto 0) := (others => '0');
subtype index_type is integer range 0 to MEM_SIZE-1;
signal head : index_type := 0;
signal tail : index_type := 0;
signal r_index_count : integer range 0 to MEM_SIZE := 0;
signal r_full_buffer: std_logic := '0';
signal r_empty_buffer: std_logic := '1';

begin

	r_empty_buffer <= '1' when (r_index_count < O_SIZE) else '0';
	r_full_buffer <= '1' when (r_index_count = MEM_SIZE) else '0';

	o_empty_buffer <= r_empty_buffer;
	o_full_buffer <= r_full_buffer;

	mem_process : process(clk, rst)
	variable v_head : index_type;
	variable v_tail : index_type;
    variable v_index_count : integer range 0 to MEM_SIZE;
    variable v_data: std_logic_vector(O_SIZE - 1 downto 0);
    variable v_mem: std_logic_vector(MEM_SIZE-1 downto 0);
	begin
 		if(rst = '1') then
    		v_head := 0;
        	v_tail := 0;
        	v_data := (others => '0');
        	v_mem := (others => '0');
        	v_index_count := 0;
  		else 
        	if (rising_edge(clk)) then
    			v_index_count := r_index_count;
        		v_head := head;
        		v_tail := tail;
        		v_mem := mem;
        		v_data := o_data;
        		if(i_wr_en = '1' and r_full_buffer = '0') then
            		for I in 0 to I_SIZE-1 loop
                		v_mem(v_head) := i_data(I);
                		if v_head = MEM_SIZE-1 then
      						v_head := 0;
    					else
      						v_head := v_head + 1;
    					end if;
           	 		end loop;
             		v_index_count := v_index_count + I_SIZE;
         		end if;
         		if(i_rd_en = '1' and r_empty_buffer = '0') then
            		for I in 0 to O_SIZE-1 loop
                		v_data(I) := v_mem(v_tail);
                		if v_tail = MEM_SIZE-1 then
      						v_tail := 0;
    					else
      						v_tail := v_tail + 1;
    					end if;
            		end loop;
            		v_index_count := v_index_count - O_SIZE;
          		end if;
      		end if;
    	end if;
    	head <= v_head;
    	tail <= v_tail;
    	mem <= v_mem;
    	r_index_count <= v_index_count;
    	o_data <= v_data;
	end process;
end behavioral;