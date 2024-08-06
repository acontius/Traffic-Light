library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity tb_counter_60sec is
end tb_counter_60sec;

architecture Behavioral of tb_counter_60sec is
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal count  : STD_LOGIC_VECTOR (7 downto 0);

    constant clk_period : time := 10 ns;
    
begin
    -- Instantiate the Unit Under Test (UUT)
    uut: entity work.counter_60sec
        port map (
            clk    => clk,
            reset  => reset,
            count  => count
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
        -- hold reset state for 100 ns.
        reset <= '1';
        wait for 100 ns;  
        
        reset <= '0';
        wait for 100 ns;

        -- Observe the count for 70 seconds
        wait for 70 * 1 sec; 
        
        -- End of simulation
        wait;
    end process;

end Behavioral;
