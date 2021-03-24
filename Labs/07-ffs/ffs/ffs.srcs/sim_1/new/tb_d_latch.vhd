----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 24.03.2021 15:21:58
-- Design Name: 
-- Module Name: tb_d_latch - Behavioral
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

entity tb_d_latch is
Port(
    signal s_en     : std_logic;
    signal s_arst   : std_logic;
    signal s_d      : std_logic;  
    signal s_q      : std_logic;
    signal s_q_bar  : std_logic
    );
end tb_d_latch;

architecture Behavioral of tb_d_latch is

begin
    uut_d_latch : entity work.d_latch
    port map(
        en => s_en,
        arst => s_arst,
        d => s_d,
        q => s_q,
        q_bar => s_q_bar          
    );
         
         
    p_reset_gen : process
    begin
        s_arst <= '0';    
    
    end process p_reset_gen;
    
    p_stimulus : process
    begin
        report "stimulus process start" severity note;
        s_d  <= '0';
        s_en <= '0';
        
    
    end process p_stimulus;
    
       

end Behavioral;
