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

entity locker_logic is
    Port (
        clk         : in std_logic;
        reset       : in std_logic;
        num_i       : in std_logic_vector( 4 - 1 downto 0);     -- input value from keypad controler
         
        data0_o     : out std_logic_vector( 4 - 1 downto 0);    --output value for 1st display of 4dig 7 segment module
        data1_o     : out std_logic_vector( 4 - 1 downto 0);    --output value for 2nd display of 4dig 7 segment module
        data2_o     : out std_logic_vector( 4 - 1 downto 0);    --output value for 3rd display of 4dig 7 segment module
        data3_o     : out std_logic_vector( 4 - 1 downto 0);    --output value for 4th display of 4dig 7 segment module
        
        relay_o     : out std_logic     -- value 1/0 for relay module to open/lock
     );
end locker_logic;

architecture Behavioral of locker_logic is

    -- define the password, for this case PW is 1234 
    constant NUM1_PW : std_logic_vector(4 - 1 downto 0) := "0001";
    constant NUM2_PW : std_logic_vector(4 - 1 downto 0) := "0010";
    constant NUM3_PW : std_logic_vector(4 - 1 downto 0) := "0011";
    constant NUM4_PW : std_logic_vector(4 - 1 downto 0) := "0100";
    
    -- State definition
    -------------------------------
    type t_stateLO is ( LOCKED,
                        OPENED
                       );
                       
    type t_stateNUM is (NUM0, -- after reset
                        NUM1,
                        NUM2,
                        NUM3,
                        NUM4
                        
                       );
                       
    -- Define the signals that uses different states                   
    signal s_stateLO            : t_stateLO;
    signal s_stateNUM           : t_stateNUM;
    
    -- Signal for pw reset 
    signal s_password_reset     : std_logic;
  
    -- signals which are setted to '1' after correct number selected
    signal s_num1_corr      : std_logic;
    signal s_num2_corr      : std_logic;
    signal s_num3_corr      : std_logic;
    signal s_num4_corr      : std_logic;
    
    -- signals wich number was selected
    signal s_num1_displ     : std_logic_vector( 4 - 1 downto 0);
    signal s_num2_displ     : std_logic_vector( 4 - 1 downto 0);
    signal s_num3_displ     : std_logic_vector( 4 - 1 downto 0);
    signal s_num4_displ     : std_logic_vector( 4 - 1 downto 0);
       
begin

    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 1       -- g_MAX = 50 ms / (1/100 MHz) 
        )
        port map(
            clk   => clk,
            reset => reset   
        );
    
      
    -- process sensitive to num_i, reset, s_password_reset changes
    -- changing states
    p_stateNUM_changer : process(num_i,reset, s_password_reset)
    begin 
        if (s_password_reset = '1' or reset = '1') then 
            s_stateNUM <= NUM0;
            
            s_password_reset <= '0';
       else
            case s_stateNUM is
            
                when NUM0 =>                    --after reset 
                    if( num_i = "1101") then    -- when input from keypad is d - default staying in same state
                        s_stateNUM <= NUM0;                        
                    else                        -- else going to another
                        s_stateNUM <= NUM1;                           
                    end if;
                    
                when NUM1 =>
                    if( num_i = "1101") then
                        s_stateNUM <= NUM1;
                    else
                        s_stateNUM <= NUM2;                             
                    end if;
                    
                when NUM2 =>
                    if( num_i = "1101") then
                        s_stateNUM <= NUM2;
                    else  
                        s_stateNUM <= NUM3;                             
                    end if;
                    
                when NUM3 =>
                    if( num_i = "1101") then
                        s_stateNUM <= NUM3;
                    else
                        s_stateNUM <= NUM4;                             
                    end if;
                    
                when NUM4 =>
                    if( num_i = "1101") then
                        s_password_reset <= '1';    --auto reset after NUM4                           
                    end if;
          
                when others => 
                    s_stateNUM <= NUM0;             -- default state NUM0
            end case;  --stateNUM 
         end if;  
    end process p_stateNUM_changer;
    
    
    -- Process sensitive to s_stateNUM, s_num4_corr, s_num1_displ, s_num2_displ, s_num3_displ, s_num4_displ changes
    -- Checking if all numbers were selected corecctly and opening the relay
    -- Also working with display info
    p_correct_signal_changer : process (s_stateNUM, s_num4_corr, s_num1_displ, s_num2_displ, s_num3_displ, s_num4_displ)
    begin
        case s_stateNUM is 
        
           when NUM1 =>
               data3_o <= "1101";           -- defaultly giving output for display of previous state to default
               s_num1_displ <= num_i;       -- assigment of input information to signal 
               data0_o <= s_num1_displ;     -- ouputin input inforamtion to display 
               
               if(num_i = NUM1_PW) then 
                   s_num1_corr <= '1';    
               end if; 
               
           when NUM2 =>
               data0_o <= "1101";
               s_num2_displ <= num_i;
               data1_o <= s_num2_displ;
               
               if(num_i = NUM2_PW) then 
                   s_num2_corr <= '1';
                 
               end if; 
                    
           when NUM3 =>
               data1_o <= "1101";
               s_num3_displ <= num_i;
               data2_o <= s_num3_displ;
               
               if(num_i = NUM3_PW) then 
                   s_num3_corr <= '1';
               end if;
                   
           when NUM4 =>
               data2_o <= "1101";
               s_num4_displ <= num_i;
               data3_o <= s_num4_displ;
           
               if(num_i = NUM4_PW) then 
                   s_num4_corr <= '1';
                   if ( s_num1_corr = '1' and s_num2_corr = '1' and s_num3_corr = '1' and s_num4_corr = '1') then 
                       s_stateLO <= OPENED;
                   else
                       s_stateLO <= LOCKED;
                       
                   end if;
               end if;
    
          when others =>
               data0_o <= "1101";
               data1_o <= "1101";
               data2_o <= "1101";
               data3_o <= "1101";
               
               s_num1_displ <= "1101";
               s_num2_displ <= "1101";
               s_num3_displ <= "1101";
               s_num4_displ <= "1101";
               
               s_stateLO <= LOCKED;
               
               s_num1_corr <= '0';
               s_num2_corr <= '0';
               s_num3_corr <= '0';
               s_num4_corr <= '0';
            end case;

        
    end process p_correct_signal_changer;
    
    p_stateLO_defintion : process (clk)
    begin
        if rising_edge (clk) then
            case s_stateLO is 
            when LOCKED =>
                relay_o <= '0';
            when OPENED =>
                relay_o <= '1';
            when others =>
                relay_o <= '0';
            end case;
        end if;
    end process p_stateLO_defintion;
     
end Behavioral;

