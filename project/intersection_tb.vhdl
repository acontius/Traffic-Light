library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity tb_intersection is
end tb_intersection;

architecture Behavioral of tb_intersection is

    -- Component declaration for the Unit Under Test (UUT)
    component intersection
        Port ( clk           : in  STD_LOGIC;
               reset         : in  STD_LOGIC;
               car_sensor_N  : in  STD_LOGIC;
               car_sensor_S  : in  STD_LOGIC;
               car_sensor_E  : in  STD_LOGIC;
               car_sensor_W  : in  STD_LOGIC;
               red_light_N   : out STD_LOGIC;
               green_light_N : out STD_LOGIC;
               red_light_S   : out STD_LOGIC;
               green_light_S : out STD_LOGIC;
               red_light_E   : out STD_LOGIC;
               green_light_E : out STD_LOGIC;
               red_light_W   : out STD_LOGIC;
               green_light_W : out STD_LOGIC;
               seven_seg_N   : out STD_LOGIC_VECTOR (7 downto 0);
               seven_seg_S   : out STD_LOGIC_VECTOR (7 downto 0);
               seven_seg_E   : out STD_LOGIC_VECTOR (7 downto 0);
               seven_seg_W   : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Signals for the test bench
    signal clk          : STD_LOGIC := '0';
    signal reset        : STD_LOGIC := '0';
    signal car_sensor_N : STD_LOGIC := '0';
    signal car_sensor_S : STD_LOGIC := '0';
    signal car_sensor_E : STD_LOGIC := '0';
    signal car_sensor_W : STD_LOGIC := '0';
    signal red_light_N  : STD_LOGIC;
    signal green_light_N: STD_LOGIC;
    signal red_light_S  : STD_LOGIC;
    signal green_light_S: STD_LOGIC;
    signal red_light_E  : STD_LOGIC;
    signal green_light_E: STD_LOGIC;
    signal red_light_W  : STD_LOGIC;
    signal green_light_W: STD_LOGIC;
    signal seven_seg_N  : STD_LOGIC_VECTOR (7 downto 0);
    signal seven_seg_S  : STD_LOGIC_VECTOR (7 downto 0);
    signal seven_seg_E  : STD_LOGIC_VECTOR (7 downto 0);
    signal seven_seg_W  : STD_LOGIC_VECTOR (7 downto 0);

    -- Clock generation process
    constant clk_period : time := 10 ns;
    begin
        clk_process : process
        begin
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end process;

    -- Instantiate the Unit Under Test (UUT)
    uut: intersection
        port map (
            clk           => clk,
            reset         => reset,
            car_sensor_N  => car_sensor_N,
            car_sensor_S  => car_sensor_S,
            car_sensor_E  => car_sensor_E,
            car_sensor_W  => car_sensor_W,
            red_light_N   => red_light_N,
            green_light_N => green_light_N,
            red_light_S   => red_light_S,
            green_light_S => green_light_S,
            red_light_E   => red_light_E,
            green_light_E => green_light_E,
            red_light_W   => red_light_W,
            green_light_W => green_light_W,
            seven_seg_N   => seven_seg_N,
            seven_seg_S   => seven_seg_S,
            seven_seg_E   => seven_seg_E,
            seven_seg_W   => seven_seg_W
        );

    -- Stimulus process
    stimulus: process
    begin
        -- Apply reset
        reset <= '1';
        wait for 20 ns;
        reset <= '0';
        
        -- No cars at the intersection initially
        car_sensor_N <= '0';
        car_sensor_S <= '0';
        car_sensor_E <= '0';
        car_sensor_W <= '0';
        wait for 100 ns;

        -- Car arrives at North sensor
        car_sensor_N <= '1';
        wait for 200 ns;

        -- Car leaves North sensor, arrives at South sensor
        car_sensor_N <= '0';
        car_sensor_S <= '1';
        wait for 200 ns;

        -- Car leaves South sensor, arrives at East sensor
        car_sensor_S <= '0';
        car_sensor_E <= '1';
        wait for 200 ns;

        -- Car leaves East sensor, arrives at West sensor
        car_sensor_E <= '0';
        car_sensor_W <= '1';
        wait for 200 ns;

        -- Cars leave all sensors
        car_sensor_W <= '0';
        wait for 200 ns;

        -- Multiple cars arrive simultaneously
        car_sensor_N <= '1';
        car_sensor_E <= '1';
        wait for 200 ns;

        -- Cars leave simultaneously
        car_sensor_N <= '0';
        car_sensor_E <= '0';
        wait for 200 ns;

        -- End of simulation
        wait;
    end process;

end Behavioral;
