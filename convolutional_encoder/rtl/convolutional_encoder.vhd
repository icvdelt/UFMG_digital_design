library IEEE;
use IEEE.std_logic_1164.all;
library work;
use work.GENERIC_TYPES.array_of_integers;

entity convolutional_encoder is
    generic (
        CASCADE_LENGTH : natural;
        RATE : integer;
        GENERATOR_POLY: array_of_integers(RATE-1 downto 0)
    );
    port (
        clk : in std_logic;
        rst : in std_logic;
        i_data : in std_logic;
        i_valid : in std_logic;
        o_valid : out std_logic;
        o_data : out std_logic_vector(RATE-1 downto 0)
    );
end convolutional_encoder;

architecture behavioral of convolutional_encoder is
begin

end behavioral;
