# LAB 01-Gates
### Filip Sisolak (228030)

| **c** | **b** |**a** | **f(c,b,a)** |
| :-: | :-: | :-: | :-: |
| 0 | 0 | 0 | 1 |
| 0 | 0 | 1 | 0 |
| 0 | 1 | 0 | 0 |
| 0 | 1 | 1 | 0 |
| 1 | 0 | 0 | 1 |
| 1 | 0 | 1 | 1 |
| 1 | 1 | 0 | 0 |
| 1 | 1 | 1 | 0 |


```DeMorgan Laws Code
architecture dataflow of gates is
begin
    f_o  <= ((not b_i) and a_i) or ((not c_i) and (not b_i)) ;
    f_nor_o <= not(b_i or (not a_i)) or not(c_i or b_i);
    f_nand_o <= not(not(not b_i and  a_i) and not(not c_i and not b_i));
  
end architecture dataflow;
```
![Simulation of DeMorgan Laws](Images/DMLaws.PNG)

