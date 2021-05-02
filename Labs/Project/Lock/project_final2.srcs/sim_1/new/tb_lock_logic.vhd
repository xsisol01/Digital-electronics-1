----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.04.2021 14:33:59
-- Design Name: 
-- Module Name: tb_lock_logic - Behavioral
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
use ieee.numeric_std.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tb_lock_logic is
--  Port ( );
end tb_lock_logic;

architecture testbench of tb_lock_logic is
    signal s_num    : std_logic_vector( 4 - 1 downto 0); 
        
    signal s_data0  : std_logic_vector( 4 - 1 downto 0); 
    signal s_data1  : std_logic_vector( 4 - 1 downto 0);
    signal s_data2  : std_logic_vector( 4 - 1 downto 0); 
    signal s_data3  : std_logic_vector( 4 - 1 downto 0);
        
    signal s_relay  : std_logic;
begin
    
    uut_lock_logic  : entity work.locker_logic
        port map(
            num_i   => s_num,
            data0_o => s_data0,
            data1_o => s_data1,
            data2_o => s_data2,
            data3_o => s_data3,
            relay_o => s_relay 
        );
        
    p_stimulus : process
    begin
    
       s_num <= "1101";
        wait for 20ns;
        
        s_num <= "0001";
        wait for 12ns;
        
        s_num <= "1101";
        wait for 20ns;
        
        s_num <= "0010";
        wait for 12ns;
        
        s_num <= "1101";
        wait for 20ns;
        
        s_num <= "0011";
        wait for 12ns;
        
        s_num <= "1101";
        wait for 20ns;
        
        s_num <= "0100";
        wait for 12ns;
        
        s_num <= "1101";
        wait;  
               
    end process p_stimulus;

end architecture testbench;

