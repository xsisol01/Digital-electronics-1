# 07-Latches and Flip-Flops

### GitHub repository link
https://github.com/xsisol01/Digital-electronics-1.git

## 1. Preparation tasks
\begin{align*}
    q_{n+1}^D =& d \\
    q_{n+1}^{JK} =&\\
    q_{n+1}^T =&\\
\end{align*}-->

   | **clk** | **d** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 0 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Input signal is sampled at the rising edge of clk and stored to FF |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 1 | Input signal is sampled at the rising edge of clk and stored to FF |

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

   | **clk** | **t** | **q(n)** | **q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | ![rising](Images/eq_uparrow.png) | 0 | 0 | 0 | No change |
   | ![rising](Images/eq_uparrow.png) | 0 | 1 | 1 | No change |
   | ![rising](Images/eq_uparrow.png) | 1 | 0 | 1 | Invert |
   | ![rising](Images/eq_uparrow.png) | 1 | 1 | 0 | Invert |


## 2. D-Latch
* VHDL code of the process p_d_latch

```vhdl
 
```    
* VHDL reset and stimulus processes from tb_d_latch

```vhdl
      
```

* Screenshot with simulated time waveforms  

![Dlatch waveform](Images/.PNG)

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
