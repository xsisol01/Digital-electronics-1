----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:41:21
-- Design Name: 
-- Module Name: tb_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_top is
--  Port ( );
end tb_top;

architecture Behavioral of tb_top is

    constant c_CLK_100MHZ_PERIOD : time    := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_col        :std_logic_vector(3-1 downto 0);
    
    signal s_row        :std_logic_vector( 4 - 1 downto 0);
    
    signal s_a        :std_logic;
    signal s_b        :std_logic;
    signal s_c        :std_logic;
    signal s_d        :std_logic;
    signal s_e        :std_logic;
    signal s_f        :std_logic;
    signal s_g        :std_logic;
    
    signal s_dig      :std_logic_vector(4-1 downto 0);
    
    signal s_led :std_logic_vector(3-1 downto 0);
    signal s_relay :std_logic;
    
begin

    uut_top : entity work.top
        port map(
            CLK100MHZ     => s_CLK_100MHz,
            SW   => s_reset,
            COL  => s_col,
            
            ROW  => s_row,
            
            SEG_DISP(6)  => s_a,
            SEG_DISP(5)   => s_b,
            SEG_DISP(4)   => s_c,
            SEG_DISP(3)   => s_d,
            SEG_DISP(2)   => s_e,
            SEG_DISP(1)   => s_f,
            SEG_DISP(0)   => s_g,
            
            DIG => s_dig,
            LED => s_led,
            RELAY => s_relay
            
            
        );
    

    --------------------------------------------------------------------
    -- Clock generation process
    --------------------------------------------------------------------
    p_clk_gen : process
    begin
        while now < 5 ms loop         
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

p_stimulus : process
begin 

        s_reset <= '1';
        
        s_row <= "1111"; 
        wait for 26ns;
        s_reset <= '0'; 
        wait for 56ns;
    
        s_row <= "0111";
        wait for 65 ns; 
        
        s_row <= "1111";  
        wait for 56 ns; 
        
        s_row <= "0111";
        wait for 56 ns;
        
        s_row <= "1111";  
        wait for 57 ns; 
        
        s_row <= "0111";
        wait for 53 ns;
        
        s_row <= "1111";  
        wait for 70ns;
    
        s_row <= "1011";
        wait for 150 ns; 
        
        s_row <= "1111";  
        wait for 157 ns; 
        
        s_row <= "1101";
        wait for 152 ns;
        
        s_row <= "1111";  
        wait for 157 ns; 
        
        s_row <= "1011";
        wait for 152 ns;
        
        s_row <= "1111";  
        wait for 57 ns;
        
        s_row <= "1101";
        wait for 152 ns;
        
        s_row <= "1111";  
        wait for 157 ns; 
        
        s_row <= "1011";
        wait for 152 ns;
        
        
        s_row <= "1111";  
        wait;
end process p_stimulus;

end Behavioral;
