# 07-Latches and Flip-Flops

### GitHub repository link
https://github.com/xsisol01/Digital-electronics-1.git

## 1. Preparation tasks
* characteristic equation and table for D flip-flop

   | **D** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 |  |  |
   | 0 | 1 |  |  |
   | 1 |  |  |  |
   | 1 |  |  |  |

* characteristic equation and table for JK flip-flop

   | **J** | **K** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-: | :-- |
   | 0 | 0 | 0 | 0 | No change |
   | 0 | 0 | 1 | 1 | No change |
   | 0 |  |  |  |  |
   | 0 |  |  |  |  |
   | 1 |  |  |  |  |
   | 1 |  |  |  |  |
   | 1 |  |  |  |  |
   | 1 |  |  |  |  |

* characteristic equation and table for T flip-flop

   | **T** | **Qn** | **Q(n+1)** | **Comments** |
   | :-: | :-: | :-: | :-- |
   | 0 | 0 |  |  |
   | 0 | 1 |  |  |
   | 1 |  |  |  |
   | 1 |  |  |  |


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
