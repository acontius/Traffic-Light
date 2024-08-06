library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity intersection is
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
end intersection;

architecture Behavioral of intersection is

    signal next_NS      : STD_LOGIC := '0';  -- Next signal between North and South
    signal next_WE      : STD_LOGIC := '0';  -- Next signal between East and West
    signal prev_NS      : STD_LOGIC := '0';  -- Previous signal between North and South
    signal prev_WE      : STD_LOGIC := '0';  -- Previous signal between East and West

    component traffic_light is
        Port ( clk          : in  STD_LOGIC;
               reset        : in  STD_LOGIC;
               car_sensor   : in  STD_LOGIC;
               prev         : in  STD_LOGIC;
               next         : out STD_LOGIC;
               red_light    : out STD_LOGIC;
               green_light  : out STD_LOGIC;
               seven_seg    : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

begin 
    -- North-South Traffic Light (North)
    traffic_light_N: traffic_light
        port map (
            clk         => clk,
            reset       => reset,
            car_sensor  => car_sensor_N,
            prev        => prev_NS,
            next        => next_NS,
            red_light   => red_light_N,
            green_light => green_light_N,
            seven_seg   => seven_seg_N
        );

    -- South Traffic Light (controlled with North)
    traffic_light_S: traffic_light
        port map (
            clk         => clk,
            reset       => reset,
            car_sensor  => car_sensor_S,
            prev        => next_NS,  -- Controlled by North
            next        => open,     -- No next signal needed for South
            red_light   => red_light_S,
            green_light => green_light_S,
            seven_seg   => seven_seg_S
        );

    -- East-West Traffic Light (East)
    traffic_light_E: traffic_light
        port map (
            clk         => clk,
            reset       => reset,
            car_sensor  => car_sensor_E,
            prev        => prev_WE,
            next        => next_WE,
            red_light   => red_light_E,
            green_light => green_light_E,
            seven_seg   => seven_seg_E
        );

    -- West Traffic Light (controlled with East)
    traffic_light_W: traffic_light
        port map (
            clk         => clk,
            reset       => reset,
            car_sensor  => car_sensor_W,
            prev        => next_WE,  -- Controlled by East
            next        => open,     -- No next signal needed for West
            red_light   => red_light_W,
            green_light => green_light_W,
            seven_seg   => seven_seg_W
        );

    -- Synchronize prev_NS and prev_WE signals
    prev_NS <= next_WE;
    prev_WE <= next_NS;

end Behavioral;
