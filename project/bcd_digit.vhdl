library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

use ieee.numeric_std.all;

entity bcd_digit is
    Port ( clk    : in  STD_LOGIC;
           reset  : in  STD_LOGIC;
           enable : in  STD_LOGIC;
           count  : out STD_LOGIC_VECTOR (3 downto 0);
           carry  : out STD_LOGIC);
end bcd_digit;

architecture Behavioral of bcd_digit is
    signal cnt : integer:= 0;
begin
    process (clk, reset)
    begin
        if reset = '1' then
            cnt <= 0;
        elsif rising_edge(clk) then
            if enable = '1' then
                if cnt = 9 then
                    cnt <= 0;
                else
                    cnt <= cnt + 1;
                end if;
            end if;
        end if;
    end process;

    count <= std_logic_vector(to_unsigned(cnt, count'length));
    carry <= '1' when cnt = 9 else '0';
end Behavioral;
