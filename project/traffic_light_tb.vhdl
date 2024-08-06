library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_traffic_light is
end tb_traffic_light;

architecture Structural of tb_traffic_light is
    signal clk         : STD_LOGIC := '0';
    signal reset       : STD_LOGIC := '0';
    signal sensor  : STD_LOGIC := '0';
    signal red_light   : STD_LOGIC;
    signal green_light : STD_LOGIC;

    constant clk_period : time := 10 ns;

    component traffic_light is
        Port ( clk         : in  STD_LOGIC;
               reset       : in  STD_LOGIC;
               sensor  : in  STD_LOGIC;
               red_light   : out STD_LOGIC;
               green_light : out STD_LOGIC);
    end component;

begin
    -- Instantiate the Unit Under Test (UUT)
    uut: traffic_light
        port map (
            clk         => clk,
            reset       => reset,
            sensor  => sensor,
            red_light   => red_light,
            green_light => green_light
        );

    -- Clock process definitions
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period / 2;
        clk <= '1';
        wait for clk_period / 2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Initialize Inputs
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        
        -- Simulate car presence
		  wait for 100 ns;
		  sensor <= '1';
		  wait for 100 ns;
		  sensor <= '0';
        wait for 600 ns;
        wait;
    end process;

end Structural;
