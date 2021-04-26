# Project
## Info
* Github repository link : https://github.com/xsisol01/Digital-electronics-1/tree/main/Labs
* Topic n.2 - Door lock system with PIN (4-digit) terminal, 4x3 push buttons, 4-digit 7-segment display, relay for door lock control.
* Collaborators:
  1. Filip Šišolák
  2. Barbora Šimková
  3. Bohuslav Šotola
  4. Tomáš Škurla

## KeyPad controll module

este dopisat nejake info k modulu

* VHDL code of KeyPad controll - keypad_to_num.vhdl

```vhdl
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

------------------------------------------------------------------------
-- Entity declaration for traffic light controller
------------------------------------------------------------------------
entity keypad_to_num is
    port(
        clk         : in  std_logic;
        reset       : in  std_logic;
        row_i       : in  std_logic_vector(4 - 1 downto 0);     -- input from keypad
        
        col_o       : out std_logic_vector(3 - 1 downto 0);     -- output to keypad
        num_o       : out std_logic_vector(4 - 1 downto 0)      --Output signal with 4bit number 0-9, enter, delete
        
    );
end entity keypad_to_num;

------------------------------------------------------------------------
-- Architecture declaration for traffic light controller
------------------------------------------------------------------------
architecture Behavioral of keypad_to_num is

    -- Define the states
    type t_state is (SET_COLH,      --after reset
                     SET_COL1,
                     SET_COL2,
                     SET_COL3
                     );
        
    -- Define the signal that uses different states
    signal s_state  : t_state;
    -- Internal clock enable
    signal s_en     : std_logic; --not needed in this case
    -- Local delay counter
    signal   s_cnt  : unsigned(5 - 1 downto 0);
   
   
    constant c_DELAY_100ms : unsigned(5 - 1 downto 0) := b"0_0010"; --one pulse every 100ms
    constant c_ZERO        : unsigned(5 - 1 downto 0) := b"0_0000";


begin


    clk_en0 : entity work.clock_enable
        generic map(
            g_MAX => 5000000       -- g_MAX = 50 ms / (1/100 MHz) 
        )
        port map(
            clk   => clk,
            reset => reset,
            ce_o  => s_en
        );

    --Process sensitive to clock change, defining state machine rules
    p_in_to_num_out : process(clk)
    begin
        if rising_edge(clk) then
            if (reset = '1') then          -- Synchronous reset
                s_state <= SET_COLH ;      -- Set initial state
                --s_cnt <= c_ZERO;

            elsif (s_en = '1') then
            
                case s_state is
                    when SET_COLH =>
                        if (s_cnt < c_DELAY_100ms) then
                            s_cnt <= s_cnt + 1;   
                        else
                            s_state <= SET_COL1;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when SET_COL1 =>
                        if (s_cnt < c_DELAY_100ms) then
                            s_cnt <= s_cnt + 1;
                        else
                            s_state <= SET_COL2;
                            s_cnt <= c_ZERO;
                       end if;
                           
                    when SET_COL2 =>
                        if (s_cnt < c_DELAY_100ms) then
                            s_cnt <= s_cnt + 1; 
                        else
                            s_state <= SET_COL3;
                            s_cnt <= c_ZERO;
                        end if;
                        
                    when SET_COL3 =>
                        if (s_cnt < c_DELAY_100ms) then
                            s_cnt <= s_cnt + 1; 
                        else
                            s_state <= SET_COL1;
                            s_cnt <= c_ZERO;
                        end if; 
                           
                    when others =>
                        s_state <= SET_COLH;                   
               end case;            
            end if; -- Synchronous reset
        end if; -- Rising edge
    end process p_in_to_num_out;

    --Process senstitive on current state and setting output to columns
    p_output_statechanger : process(s_state)
    begin
        case s_state is
            when SET_COLH =>
                col_o <= "111";   
            when SET_COL1 =>
                col_o <= "011";    
            when SET_COL2 =>
                col_o <= "101";     
            when SET_COL3 =>
                col_o <= "110";
            when others =>
                col_o <= "111";
        end case;
    end process p_output_statechanger;
    
    
    --Process sensitive to row_i changes and setting output based on current state
    p_output_row_check_out : process(row_i)
    begin
        case s_state is
            when SET_COLH =>
                num_o <= "1101";                -- default
                
            when SET_COL1 =>
                if(row_i = "0111") then
                    num_o <= "0001";            --set output 1 - pressed
                               
                elsif(row_i = "1011") then  
                    num_o <= "0100";            --set output 4 - pressed
                                
                elsif(row_i = "1101") then  
                    num_o <= "0111";            --set output 7 - pressed  
                                
                elsif(row_i = "1110") then  
                    num_o <= "1110";            --set output *(delete) - pressed
                else 
                    num_o <= "1101";            --defult            
                end if;
                
            when SET_COL2 =>
                if(row_i = "0111") then
                    num_o <= "0010";            --set output 2 - pressed
                            
                elsif(row_i = "1011") then  
                    num_o <= "0101";            --set output 5 - pressed
                            
                elsif(row_i = "1101") then  
                     num_o <= "1000";           --set output 8 - pressed  
                            
                elsif(row_i = "1110") then  
                     num_o <= "0000";           --set output 0 - pressed 
                else 
                     num_o <= "1101";           --defult no output          
                end if;
                
            when SET_COL3 =>
                if(row_i = "0111") then
                     num_o <= "0011";           --set output 3 - pressed
                                
                elsif(row_i = "1011") then  
                     num_o <= "0110";           --set output 6 - pressed
                                
                elsif(row_i = "1101") then  
                       num_o <= "1001";         --set output 9 - pressed  
                                
                elsif(row_i = "1110") then  
                       num_o <= "1111";         --set output #(enter) - pressed
                else 
                     num_o <= "1101";           --defult         
                end if; 
                
            when others =>
                num_o <= "1101";
          end case;
      end process p_output_row_check_out;  
end architecture Behavioral;
```

* Simulation of keypad controller - tb_keypad_to_num.vhdl

```vhdl
library ieee;
use ieee.std_logic_1164.all;


entity tb_keypad_to_num is
    -- Entity of testbench is always empty
end entity tb_keypad_to_num;

architecture testbench of tb_keypad_to_num is

    -- Local constants
    constant c_CLK_100MHZ_PERIOD : time := 10 ns;

    --Local signals
    signal s_clk_100MHz : std_logic;
    signal s_reset      : std_logic;
    signal s_row        : std_logic_vector(4 - 1 downto 0);
    signal s_col        : std_logic_vector(3 - 1 downto 0);
    signal s_num        : std_logic_vector(4 - 1 downto 0);

begin

    uut_tlc : entity work.keypad_to_num
        port map(
            clk     => s_clk_100MHz,
            reset   => s_reset, 
            row_i   => s_row,
            col_o   => s_col,
            num_o   => s_num
        );


    p_clk_gen : process
    begin
        while now < 800 ms loop   
            s_clk_100MHz <= '0';
            wait for c_CLK_100MHZ_PERIOD / 2;
            s_clk_100MHz <= '1';
            wait for c_CLK_100MHZ_PERIOD / 2;
        end loop;
        wait;
    end process p_clk_gen;

    p_stimulus : process
    begin
    
        s_row <= "1111";  
        wait for 57 ms;
    
        s_row <= "0111";
        wait for 50 ms; 
        
        s_row <= "1111";  
        wait for 157 ms; 
        
        s_row <= "1101";
        wait for 52 ms;
        
        s_row <= "1111";  
        wait for 157 ms; 
        
        s_row <= "1011";
        wait for 52 ms;
        
        
        s_row <= "1111";  
        wait;
    end process p_stimulus;

end architecture testbench;  
```

* Image of simulation waveforms - simulating KeyPad controller module

![Keypad simulation waveforms](Images/TB_keypad.png)
