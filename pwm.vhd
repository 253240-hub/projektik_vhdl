----------------------------------------------------------------------------------
-- Company: VUT
-- Engineer: Brančík
-- 
-- Create Date: 04/02/2026 01:57:05 PM
-- Design Name: pwm
-- Module Name: pwm - Behavioral
-- Project Name: Moodlamp
-- Target Devices: VHDL
-- Tool Versions: 
-- Description: 
-- Převádí hodnotu z čítače na 3 pwm signály podle prahových hodnot
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pwm is
    generic ( G_BITS : positive := 8 );
    Port ( count : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
           led1 : out STD_LOGIC;
           led2 : out STD_LOGIC;
           led3 : out STD_LOGIC;
           led12 : out STD_LOGIC;
           led22 : out STD_LOGIC;
           led32 : out STD_LOGIC;
           p1 : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
           p2 : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
           p3 : in STD_LOGIC_VECTOR (G_BITS-1 downto 0));
end pwm;

architecture Behavioral of pwm is

begin
    led1 <= '1' when count < p1 else '0';
    led2 <= '1' when count < p2 else '0';
    led3 <= '1' when count < p3 else '0';
    led12 <= '1' when count < p1 else '0';
    led22 <= '1' when count < p2 else '0';
    led32 <= '1' when count < p3 else '0';

end Behavioral;
