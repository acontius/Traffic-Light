library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_counter is
    Port ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           count  : out STD_LOGIC_VECTOR (7 downto 0));
end bcd_counter;

architecture Behavioral of bcd_counter is
    signal ones_count  : STD_LOGIC_VECTOR (3 downto 0);
    signal tens_count  : STD_LOGIC_VECTOR (3 downto 0);
    signal carry_ones  : STD_LOGIC;
    signal carry_tens  : STD_LOGIC;
begin -- 0000 ro 1010
    ones_digit: entity work.bcd_digit 
        port map (
            clk    => clk,
            reset  => reset,
            enable => '1',
            count  => ones_count,
            carry  => carry_ones
        );
    --0000 to 0110
    tens_digit: entity work.bcd_digit
        port map (
            clk    => clk,
            reset  => reset,
            enable => carry_ones,
            count  => tens_count,
            carry  => carry_tens
        );

    count <= tens_count & ones_count;
end Behavioral;
