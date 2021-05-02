library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity relay_to_door is
    port(
        keypad_i     : in  std_logic;
        clk          : in  std_logic;
        reset        : in  std_logic;
        
        door_o      : out  std_logic; 
        LED_o : out std_logic_vector(3 - 1 downto 0)

    );
end entity relay_to_door;


architecture Behavioral of relay_to_door is

                
    type   t_state is (close_door, open_door);                   

    signal s_state  : t_state;

   
    signal s_en             : std_logic;
    signal s_keypad         : std_logic;
    
    
    signal   s_cnt  : unsigned(5 - 1 downto 0);

    
    constant c_DELAY_7SEC : unsigned(5 - 1 downto 0) := b"1_1100";
    constant c_DELAY_3SEC : unsigned(5 - 1 downto 0) := b"0_1100";
    constant c_DELAY_1SEC : unsigned(5 - 1 downto 0) := b"0_0100";
    constant c_ZERO       : unsigned(5 - 1 downto 0) := b"0_0000";
   

begin

clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 1      -- g_MAX = 50 ms / (1/100 MHz) 
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en   
        );
    
    p_state_changer : process(clk,reset,keypad_i)
    begin
        if rising_edge(clk) then
            if (reset = '1') then          -- Synchronous reset
                s_state <= close_door ;      -- Set initial state
                s_cnt <= c_ZERO;

            elsif (s_en = '1') then
            
                case s_state is
                    when close_door =>
                        if (keypad_i = '1') then
                            s_state <= open_door;
                            s_cnt   <= c_ZERO;  
                        else
                            s_state <= close_door;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when open_door =>
                        if (s_cnt < c_DELAY_7SEC) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= close_door;
                            s_cnt <= c_ZERO;
                       end if;
                                  
                    when others =>
                        s_state <= close_door;                   
               end case;            
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_state_changer;


    p_output_door : process(s_state)
    begin
        case s_state is
        
 
            when close_door =>
                LED_o <= "100";
                door_o <='0'; --dveøe jsou zavøené
                
            when open_door =>
                LED_o <= "010";   
                door_o <='1'; --dveøe jsou otevøené
           
        end case;
    end process p_output_door;
    
   
 
end architecture Behavioral;
