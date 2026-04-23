## VHDL projekt 
**RGB Mood Lamp na NEXYS A7-50T**
#### Uchak Reshat
* Dokumentace projektu, tvorba programu
#### Brančík Jan
* tvorba programu, navrh simulace
## Cíl projektu
Tento projekt je zaměřen na vyvoj a softwarovou implementaci řídiciho ovladače RGB lampy na bazi desky NEXYS A7-50T. System poskytuje přizpusobit nastavení osvetlení pomoci tlačitek desky.

## Zakladní funkce
* **Změna barvy**
(Umožňuje měnit barvu)
* **Změna rychlostí**
(pomocí tlačitek měnit rychlost záře)
* **Tlačítko reset**
(restart desky)


## Blok 1. Architecture

#### Blokove schema

<img width="1133" height="528" alt="image" src="https://github.com/user-attachments/assets/f8e39583-b8b4-4aa1-995e-8f6fe20842e4" />



#### Tlačítka
* **BTNU/BTND**  zvyšení/snížení jasu
* **BTNR** zvyšení rychlosti animace
* **BTNL** snížení rychlosti animace
* **BTNC** reset
#### RGB
* **led17** pro zobrazení barev
  


## Blok 2. Unit Design
#### Pulse
[popis]

| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`count`| in|`std_logic_vector(7 downto 0)`| Vstupní čítač   |
|`addspeed`| in|`std_logic`|zvýšení rychlosti změny barev |
|`lvspeed`|in|`std_logic`| snížení rychlosti změny barev|
|`addpower`|in|`std_logic`| zvýšení celkového jasu|
|`lvpower`|in|`std_logic`| snížení celkového jasu|
|`clk`|in|`std_logic`|hodinový signál|
|`pwm1`|out|`STD_LOGIC_VECTOR(7 downto 0)`|Duty Cycle pro signal RED|
|`pwm2`|out|`STD_LOGIC_VECTOR(7 downto 0)`|Duty Cycle pro signal GREEN|
|`pwm3`|out|`STD_LOGIC_VECTOR(7 downto 0)`|Duty Cycle pro signal BLUE|

* [Pulse_tb](Pulse_tb.vhd)
* [Testbench img](pulse_tb1.png)



#### PWM generator
[popis]

| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`count`| in|`std_logic_vector(G_BITS-1 downto 0)`| ....   |
|`led1`|out|`std_logic`|Výstupní PWM signál pro RED barvu|
|`led2`|out|`std_logic`|Výstupní PWM signál pro GREEN barvu|
|`led3`|out|`std_logic`|Výstupní PWM signál pro BLUE barvu|
|`p1`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|
|`p2`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|
|`p3`|in|`std_logic_vector(G_BITS-1 downto 0)`|...|

* [PWM_tb](pwm_tb)
* [Testbench img](pwm_tb.png)



#### counter
[popis]

| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`clk`|in|`std_logic`| Hlavní hodiny|
|`rst`|in|`std_logic`|Vysoce aktivní synchronní reset|
|`en`|in|`std_logic`|Vstup aktivace hodin|
|`cnt`|out|`std_logic_vektor(G_BITS - 1 downto 0)`|Hodnota počítadla|



#### clk
[popis]

| **Port name** | **Derection** | **Type**   | **Description**   |
|--- | --- | ---| ---|
|`clk`|in|`std_logic`| Hlavní hodiny|
|`rst`|in|`std_logic`|Vysoce aktivní synchronní reset|
|`ce`|out|`std_logic`|Povolovací impuls s jedním taktovacím cyklem|































