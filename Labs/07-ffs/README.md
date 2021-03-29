# 07-Latches and Flip-Flops

### GitHub repository link
https://github.com/xsisol01/Digital-electronics-1.git

## 1. Preparation tasks
* Characteristic equations

![Characteristic equations](Images/chareq.gif)
<!--
\begin{align*}
    q_{n+1}^D = &~ d &\\
    q_{n+1}^{JK} = &~ j\cdot \overline{q_n}\ +\overline{k}\cdot q_n &\\
    q_{n+1}^T =&~ t\cdot \overline{q_n}\ +\overline{t}\cdot q_n &\\
\end{align*}-->

* Completed table for D FF

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | Input signal is sampled at the rising edge of clk and stored to FF |
   
   
* Completed table for JK FF

   | **clk** | **j** | **k** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | 0 | Reset |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 0 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | 1 | Set |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | 1 | Toggle |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | 0 | Toggle |

* Completed table for T FF

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Invert |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | Invert |


## 2. D-Latch
* VHDL code of the process p_d_latch

```vhdl
p_d_latch : process (d, arst, en)
    begin
        if (arst = '1') then
            q <= '0';
            q_bar <= '1';
        elsif(en = '1') then 
            q <= d;
            q_bar <= not d;    
        end if;
 end process p_d_latch;
```    
* VHDL reset and stimulus processes from tb_d_latch

```vhdl
p_reset_gen : process
 begin
	 s_arst <= '0';
	 wait for 38 ns;
	 
	 -- Reset activated
	 s_arst <= '1';
	 wait for 53 ns;

	 --Reset deactivated
	 s_arst <= '0';
	
	 wait for 80 ns;
	 s_arst <= '1';

	 wait;
 end process p_reset_gen;

--------------------------------------------------------------------
-- Data generation process
--------------------------------------------------------------------
p_stimulus : process
begin
	report "Stimulus process started" severity note;
	
	s_d  <= '0';
	s_en <= '0';
	wait for 10 ns;
	
	--remember/hold values (no value to hold)
	s_d  <= '1';
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	--reset set to 1 -> all values '0' except q_bar
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	wait for 10 ns;

	--Reseting output q
	s_d  <= '0';
	s_en <= '1';
	assert ((s_arst = '0') and (s_en = '1'))
	report "s_en setted to one -> Reseting output q" severity note;	
	wait for 10 ns;
	
	--Seting output q - en is setted to 1
	s_d  <= '1';
	assert ((s_arst = '0') and (s_en = '1'))
	report "s_en setted to one -> Seting output q" severity note;	
	wait for 10 ns;
	
	
	s_d  <= '0';
	wait for 10 ns;   
	s_d  <= '1';
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	--reset set to 0 - again operating 
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	wait for 10 ns;


	-- Remember/hold values 
	s_en <= '0';
	assert ((s_arst = '0') and (s_en = '0'))
	report "s_en setted to zero -> remember/hold value" severity note;
	wait for 10 ns;
	
	s_d  <= '1';
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	--reset set to 1 - all values should be '0'
	wait for 10 ns;
	s_d  <= '0';
	wait for 10 ns;
	s_d  <= '1';
	wait for 10 ns;
	s_d  <= '0';
	
	report "Stimulus process finished" severity note;
	wait;
end process p_stimulus;
      
```

* Screenshot with simulated time waveforms  

![Dlatch waveform](Images/dlatchsim.PNG)

## 3. Flip-flops

* VHDL code of p_d_ff_arst

```vhdl

```
* VHDL code of p_d_ff_rst

```vhdl

```
* VHDL code of p_jk_ff_rst

```vhdl

```
* VHDL code of p_t_ff_rst

```vhdl

```

* VHDL clock, reset, stimulus processes from testbech files

```vhdl

```
* Screenshot with simulated time waveforms

![ff wave forms](Images/.PNG)



## 4. Shift register

* Image of the shift register schenatic

![shift register schematic](Images/.jpeg)
