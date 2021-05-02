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
