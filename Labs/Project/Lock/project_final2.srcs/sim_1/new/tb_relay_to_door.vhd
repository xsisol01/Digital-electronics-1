------------------------------------------------------------------------
--
-- Traffic lights controller testbench.
-- Nexys A7-50T, Vivado v2020.1.1, EDA Playground
--
-- Copyright (c) 2020-Present Tomas Fryza
-- Dept. of Radio Electronics, Brno University of Technology, Czechia
-- This work is licensed under the terms of the MIT license.
--
------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity tb_relay_to_door is
    -- Entity of testbench is always empty
end entity tb_relay_to_door;


architecture testbench of tb_relay_to_door is

    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_keypad         : std_logic;
    
    signal s_LED      : std_logic_vector(3 - 1 downto 0);


begin
    uut_relay_to_door : entity work.relay_to_door
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset,
            keypad_i =>s_keypad,
            LED_o => s_LED

        );


    p_clk_gen : process
    begin
        while now < 10000 ns loop 
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;


    p_reset_gen : process
    begin
        s_reset <= '0';
        s_keypad <= '1'; wait for 200ns;
        s_keypad <= '0';wait for 100ns;
        s_keypad <= '1';
        wait;
    end process p_reset_gen;


    p_stimulus : process
    begin
        
        wait;
    end process p_stimulus;

end architecture testbench;
