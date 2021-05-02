----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01.05.2021 11:11:37
-- Design Name: 
-- Module Name: top - Behavioral
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


entity top is
  Port (
        CLK100MHZ    : in std_logic;
        ROW          : in std_logic_vector( 4 - 1 downto 0);
        SW           : in std_logic;
        
        COL          : out std_logic_vector( 3 - 1 downto 0);
        
        SEG_DISP     : out std_logic_vector ( 7 - 1 downto 0);
        
        DIG          : out std_logic_vector( 4 - 1 downto 0);
        LED          : out std_logic_vector( 3 - 1 downto 0);
        RELAY        : out std_logic
        
  
   );
end top;

architecture Behavioral of top is
    
    -- Signals to connect each module
    signal s_data0  : std_logic_vector( 4 - 1 downto 0);
    signal s_data1  : std_logic_vector( 4 - 1 downto 0);
    signal s_data2  : std_logic_vector( 4 - 1 downto 0);
    signal s_data3  : std_logic_vector( 4 - 1 downto 0);
    
    signal s_rel    : std_logic;
    signal s_num    : std_logic_vector ( 4 - 1 downto 0);
        
begin
    
    driver_seg_4 : entity work.driver_7seg_4digits
        port map(
            clk     => CLK100MHZ,
            reset   => SW,
            
            data0_i  => s_data0,
            data1_i  => s_data1,
            data2_i  => s_data2,
            data3_i  => s_data3,
            
            dig_o   => DIG,
            
            seg_o(6)   => SEG_DISP(6),
            seg_o(5)   => SEG_DISP(5),
            seg_o(4)   => SEG_DISP(4),
            seg_o(3)   => SEG_DISP(3),
            seg_o(2)   => SEG_DISP(2),
            seg_o(1)   => SEG_DISP(1),
            seg_o(0)   => SEG_DISP(0)   
        );
    
    keypad_to_num : entity work.keypad_to_num
        port map(
            clk     => CLK100MHZ,
            reset   => SW,
            
            col_o   => COL,
            row_i   => ROW,
            
            num_o   => s_num
        
        );
        
    locker_logic : entity work.locker_logic
        port map(
            clk     => CLK100MHZ,
            reset   => SW,
            
            num_i   => s_num,
            
            data0_o => s_data0,
            data1_o => s_data1, 
            data2_o => s_data2, 
            data3_o => s_data3, 
            
            relay_o => s_rel 
        
        );
        
     relay_to_door : entity work.relay_to_door
        port map(
            clk     => CLK100MHZ,
            reset   => SW,
            
            keypad_i => s_rel,
            
            LED_o   => LED,
            door_o  => RELAY
        
        );

end Behavioral;
