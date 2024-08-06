library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter_60sec is
    Port ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           count  : out STD_LOGIC_VECTOR (7 downto 0));
end counter_60sec;

architecture Behavioral of counter_60sec is
    signal bcd_count : STD_LOGIC_VECTOR (7 downto 0);
    signal sec_reset : STD_LOGIC;
begin
    bcd_counter_inst: entity work.bcd_counter
        port map (
            clk    => clk,
            reset  => sec_reset,
            count  => bcd_count
        );
    --0110 0000
    process (bcd_count)
    begin
       sec_reset <= (not bcd_count(7)) and ( bcd_count(6)) and ( bcd_count(5)) and (not bcd_count(4)) and (not bcd_count(3)) and 
       (not bcd_count(2)) and (not bcd_count(1)) and (not bcd_count(0)) ;
    end process;

    count <= bcd_count;
end Behavioral;

