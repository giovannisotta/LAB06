library IEEE;
use IEEE.std_logic_1164.all;

entity LAB06 is
    port(
        PB0   : in  std_logic;                       -- clock
        PB1   : in  std_logic;                       -- reset
        SW0   : in  std_logic;                       -- bit de entrada I
        LEDR0 : out std_logic;                       -- S
        HEX0  : out std_logic_vector(6 downto 0)     -- ou (7 downto 0)
    );
end entity LAB06;

architecture Structural of LAB06 is

    component StateMachine is
        port(
            I         : in  std_logic;
            clk       : in  std_logic;
            reset_n   : in  std_logic;
            S         : out std_logic;
            state_out : out std_logic_vector(2 downto 0)
        );
    end component;

    component dec7seg is
        port(
            S   : in  std_logic_vector(3 downto 0);
            HEX : out std_logic_vector(6 downto 0)
        );
    end component;

    signal estado  : std_logic_vector(2 downto 0);
    signal estado4 : std_logic_vector(3 downto 0);
    signal clk_n   : std_logic;
begin
    clk_n   <= not PB0;
    estado4 <= '0' & estado;                        -- 3 bits -> 4 bits
    FSM : StateMachine
        port map(
            I         => SW0,
            clk       => clk_n,
            reset_n   => PB1,
            S         => LEDR0,
            state_out => estado
        );

    DISP : dec7seg
        port map(
            S   => estado4,
            HEX => HEX0
        );

end architecture Structural;
