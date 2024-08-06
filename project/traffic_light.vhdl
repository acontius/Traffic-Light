library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity traffic_light is
    Port ( clk          : in  STD_LOGIC;
           reset        : in  STD_LOGIC;
           sensor       : in  STD_LOGIC;
           red_light    : out STD_LOGIC;
           green_light  : out STD_LOGIC;
           seven_seg    : out STD_LOGIC_VECTOR (7 downto 0));
end traffic_light;

architecture Behavioral of traffic_light is
    signal count        : STD_LOGIC_VECTOR (7 downto 0);
    signal state        : STD_LOGIC := '0';  -- 0 for green, 1 for red
    signal sec_reset    : STD_LOGIC := '0';

    component counter_60sec is
        Port ( clk    : in  STD_LOGIC;
               reset  : in  STD_LOGIC;
               count  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin
    counter_inst: counter_60sec
        port map (
            clk    => clk,
            reset  => sec_reset,
            count  => count
        );

    process (clk, reset,count,sensor)
    begin
        if reset = '1' then
            state <= '1';
            sec_reset <= '1';
        elsif rising_edge(clk) then
            sec_reset <= '0';
            if count = "0110000" or sensor = '0' then  -- 60 seconds in BCD (assuming your counter counts 0 to 59)
                state <= not state;
                sec_reset <= '1';
            end if;
        end if;
    end process;

    -- Control the traffic lights based on the state
    red_light <= not state;
    green_light <= state;

    -- Control the seven segment display based on the state
    process (state,count)
    begin
        if state = '0' then
            seven_seg <= count;  -- Display "HI" on seven-segment
        else
            seven_seg <= "00000000";  -- Display "LO" on seven-segment
        end if;
    end process;
end Behavioral;
