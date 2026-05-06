----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Brančík
-- 
-- Create Date: 04/09/2026 01:12:34 PM
-- Design Name: Pulse
-- Module Name: Pulse - Behavioral
-- Project Name: Moodlamp
-- Target Devices: VHDL
-- Tool Versions: 
-- Description: 
-- Vytváří 3 rampové signály v hodnotách 0-255 otočené o 120 °
-- Lze měnit rychlost časové osy a jas
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
use ieee.math_real;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Pulse is
    Port ( count    : in STD_LOGIC_VECTOR (7 downto 0);
           addspeed : in STD_LOGIC;
           lvspeed  : in STD_LOGIC;
           addpower : in STD_LOGIC;
           lvpower  : in STD_LOGIC;
           clk      : in STD_LOGIC;
           pwm1     : out STD_LOGIC_VECTOR (7 downto 0);
           pwm2     : out STD_LOGIC_VECTOR (7 downto 0);
           pwm3     : out STD_LOGIC_VECTOR (7 downto 0));
end Pulse;

architecture Behavioral of Pulse is
    
    signal power    : integer range 1 to 255 := 1;
    signal speed    : integer range 1 to 255 := 1;
    signal time     : integer range 0 to 4096 := 0;
    signal adjtime  : integer range 0 to 255 := 0;
    signal fa       : integer range 0 to 255 := 0;
    signal fb       : integer range 0 to 255 := 0;
    constant dmax   : integer := 2550000;
    constant ofset  : integer := 2400;
    
    signal delay    : integer range 0 to dmax := 0;
    constant ovf    : integer := 255;
    
    
    
    
begin

    clock : process (clk) is
    begin
        if rising_edge(clk) then
            
            if delay > 0 then
                delay <= delay - 1;
            end if;
            if delay = 0 then
                if lvspeed = '1' then
                    if speed < 255 then
                        speed <= speed + 1;
                        delay <= dmax;
                    end if;
                end if;
            
                if addspeed = '1' then
                    if speed > 1 then
                        speed <= speed - 1;
                        delay <= dmax;
                    end if;
                end if;
            
                if addpower = '1' then
                    if power < 255 then
                        power <= power + 1;
                        delay <= dmax;
                    end if;
                end if;
            
                if lvpower = '1' then
                    if power > 1 then
                        power <= power - 1;
                        delay <= dmax;
                    end if;
                end if;
            end if;
        
            if count = "00000000" then
                time <= time + 1;
                if time > (4*speed + ofset) then
                
                    time <= 0;
                    
                    adjtime <= adjtime + 1;
                    if adjtime + 85 > 255 then
                        fa <= adjtime + 85 - ovf;
                    else
                        fa <= adjtime + 85;
                    end if;
                    
                    if adjtime + 170 > 255 then
                        fb <= adjtime + 170 - ovf;
                    else
                        fb <= adjtime + 170;
                    end if;
                    
                    if adjtime = 255 then
                        adjtime <= 0;
                    end if;
                end if;
            end if;
        end if;
    end process clock;
    
    pwm1 <= std_logic_vector(to_unsigned((adjtime * power) / 255, 8));
    pwm2 <= std_logic_vector(to_unsigned((fa * power) / 255, 8));
    pwm3 <= std_logic_vector(to_unsigned((fb * power) / 255, 8));


end Behavioral;
