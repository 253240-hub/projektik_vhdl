## VHDL projekt 
**RGB Mood Lamp na NEXYS A7-50T**
#### Uchak Reshat
* Dokumentace projektu, tvorba programu
#### Brančík Jan
* tvorba programu, navrh simulace
## Cíl projektu
Tento projekt je zaměřen na vyvoj a softwarovou implementaci řídiciho ovladače RGB lampy na bazi desky NEXYS A7-50T. System poskytuje přizpusobit nastavení osvetlení pomoci tlačitek desky.

## Zakladní funkce
* **změna barvy**
(Umnožuje měnit barvu)
* **změna rychlostí**
(pomocí tlačitek měnit rychlost záře)


## Blok 1. Architecture

#### Blokove schema

[schema]



#### Tlačítka
* **BTNU/BTND**  zvyšení/snížení jasu
* **BTNR** zvyšení rychlosti animace
* **BTNL** snížení rzchlosti animace
* **BTNC** reset
#### RGB
* **led17** pro zobrazení barev
  


## Blok 2. Unit Design
#### Pulse.vhd

| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`count`| in|`std_logic_vector(7 downto 0)`| ....   |
|`addspeed`| in|`std_logic`| ...|
|`lvspeed`|in|`std_logic`|...|
|`addpower`|in|`std_logic`|...|
|`lvpower`|in|`std_logic`|...|
|`clk`|in|`std_logic`|...|
|`pwm1`|out|`STD_LOGIC_VECTOR(7 downto 0)`|...|
|`pwm2`|out|`STD_LOGIC_VECTOR(7 downto 0)`|...|
|`pwm3`|out|`STD_LOGIC_VECTOR(7 downto 0)`|...|

**Pulse_tb** 
* [Pulse_tb](Pulse_tb.vhd)
* [Testbench img](pulse_tb.png)





PWB generator_tb
* [vhdl] (odkaz)
* [Testbench](pwm_tb.png)


| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`count`| in|`std_logic_vector(G_BITS-1 downto 0)`| ....   |
|`led1`|out|`std_logic`|....|
|`led2`|out|`std_logic`|....|
|`led3`|out|`std_logic`|....|
|`p1`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|
|`p2`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|
|`p3`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|






















Testbench for Pulse module :
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/6a773813-e27b-498c-bdd0-4404752cc111" />
