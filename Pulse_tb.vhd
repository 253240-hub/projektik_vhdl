library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Pulse_tb is
end Pulse_tb;

architecture Behavioral of Pulse_tb is

    -- DUT declaration
    component Pulse
        Port (
            count    : in STD_LOGIC_VECTOR (7 downto 0);
            addspeed : in STD_LOGIC;
            lvspeed  : in STD_LOGIC;
            addpower : in STD_LOGIC;
            lvpower  : in STD_LOGIC;
            clk      : in STD_LOGIC;
            pwm1     : out STD_LOGIC_VECTOR (7 downto 0);
            pwm2     : out STD_LOGIC_VECTOR (7 downto 0);
            pwm3     : out STD_LOGIC_VECTOR (7 downto 0)
        );
    end component;

    -- Signals
    signal clk      : STD_LOGIC := '0';
    signal count    : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal addspeed : STD_LOGIC := '0';
    signal lvspeed  : STD_LOGIC := '0';
    signal addpower : STD_LOGIC := '0';
    signal lvpower  : STD_LOGIC := '0';

    signal pwm1     : STD_LOGIC_VECTOR(7 downto 0);
    signal pwm2     : STD_LOGIC_VECTOR(7 downto 0);
    signal pwm3     : STD_LOGIC_VECTOR(7 downto 0);

    constant clk_period : time := 1 ns;

begin

    -- Instantiate DUT
    uut: Pulse
        port map (
            count    => count,
            addspeed => addspeed,
            lvspeed  => lvspeed,
            addpower => addpower,
            lvpower  => lvpower,
            clk      => clk,
            pwm1     => pwm1,
            pwm2     => pwm2,
            pwm3     => pwm3
        );

    -- Clock generator (100 MHz)
    clk_process : process
    begin
        while true loop
            clk <= '0';
            wait for clk_period/2;
            clk <= '1';
            wait for clk_period/2;
        end loop;
    end process;

    -- Counter (drives your "count" input)
    count_process : process(clk)
    begin
        if rising_edge(clk) then
            count <= std_logic_vector(unsigned(count) + 1);
        end if;
    end process;

    -- Stimulus process
    stim_proc : process
    begin
        -- Initial delay
        wait for 100 ns;

        -- 🔼 Increase speed (short pulses!)

        -- Let PWM run
        wait for 20000 ns;

        -- End simulation
        wait;
    end process;

end Behavioral;