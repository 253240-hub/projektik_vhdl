----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/16/2026 01:23:13 PM
-- Design Name: 
-- Module Name: moodlamp_top - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
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

entity moodlamp_top is
    Port ( clk   : in STD_LOGIC;
           btn_u : in STD_LOGIC;
           btn_d : in STD_LOGIC;
           btn_l : in STD_LOGIC;
           btn_r : in STD_LOGIC;
           btn_c : in STD_LOGIC;
           led_r : out STD_LOGIC;
           led_g : out STD_LOGIC;
           led_b : out STD_LOGIC);
end moodlamp_top;

architecture Behavioral of moodlamp_top is

    component clk_en is
        generic ( G_MAX : integer );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            ce  : out std_logic
        );
    end component clk_en;

    component counter is
        generic ( G_BITS : positive );
        port (
            clk : in  std_logic;
            rst : in  std_logic;
            en  : in  std_logic;
            cnt : out std_logic_vector(G_BITS - 1 downto 0)
        );
    end component counter;

    component pwm is
        generic ( G_BITS : positive );
        Port ( count    : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
               led1     : out STD_LOGIC;
               led2     : out STD_LOGIC;
               led3     : out STD_LOGIC;
               p1       : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
               p2       : in STD_LOGIC_VECTOR (G_BITS-1 downto 0);
               p3       : in STD_LOGIC_VECTOR (G_BITS-1 downto 0));
    end component pwm;
    
    component Pulse is
        Port ( count    : in STD_LOGIC_VECTOR (7 downto 0);
               addspeed : in STD_LOGIC;
               lvspeed  : in STD_LOGIC;
               addpower : in STD_LOGIC;
               lvpower  : in STD_LOGIC;
               clk      : in STD_LOGIC;
               pwm1     : out STD_LOGIC_VECTOR (7 downto 0);
               pwm2     : out STD_LOGIC_VECTOR (7 downto 0);
               pwm3     : out STD_LOGIC_VECTOR (7 downto 0));
    end component Pulse;

    signal sig_en       : STD_LOGIC;
    signal sig_count    : STD_LOGIC_VECTOR (7 downto 0);
    signal sig_p1       : STD_LOGIC_VECTOR (7 downto 0);
    signal sig_p2       : STD_LOGIC_VECTOR (7 downto 0);
    signal sig_p3       : STD_LOGIC_VECTOR (7 downto 0);

begin

    clock_0 : clk_en
        generic map ( G_MAX => 500)
        port map (
            clk     => clk,
            rst     => btn_c,
            ce      => sig_en
        );
    
    counter_0 : counter
        generic map ( G_BITS => 8 )
        port map (
            clk     => clk,
            rst     => btn_c,
            en      => sig_en,
            cnt     => sig_count
        );
       
    pwm0 : pwm
        generic map ( G_BITS => 8 )
        port map ( 
           count    => sig_count,
           led1     => led_r,
           led2     => led_g,
           led3     => led_b,
           p1       => sig_p1,
           p2       => sig_p2,
           p3       => sig_p3
        );
    
    pulse0 : Pulse
        port map (
           count    => sig_count,
           addspeed => btn_r,
           lvspeed  => btn_l,
           addpower => btn_u,
           lvpower  => btn_d,
           clk      => clk,
           pwm1     => sig_p1,
           pwm2     => sig_p2,
           pwm3     => sig_p3
        );
       

end Behavioral;
