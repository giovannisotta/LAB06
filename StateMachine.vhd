library IEEE;
use IEEE.std_logic_1164.all;

entity StateMachine is
    port(
        I         : in  std_logic;
        clk       : in  std_logic;
        reset_n   : in  std_logic;
        S         : out std_logic;
        state_out : out std_logic_vector(2 downto 0)
    );
end entity StateMachine;

architecture Behavioral of StateMachine is
    signal state : std_logic_vector(2 downto 0) := (others => '0');
begin
    process(clk, reset_n)
    begin
        if reset_n = '0' then
            state <= "000";
        elsif rising_edge(clk) then
            case state is
                when "000" =>
                    if I = '0' then state <= "001"; else state <= "000"; end if;
                when "001" =>
                    if I = '0' then state <= "001"; else state <= "010"; end if;
                when "010" =>
                    if I = '0' then state <= "001"; else state <= "011"; end if;
                when "011" =>
                    if I = '0' then state <= "100"; else state <= "000"; end if;
                when "100" =>
                    if I = '0' then state <= "001"; else state <= "101"; end if;
                when "101" =>
                    if I = '0' then state <= "110"; else state <= "011"; end if;
                when "110" =>
                    if I = '0' then state <= "111"; else state <= "010"; end if;
                when "111" =>
                    if I = '0' then state <= "001"; else state <= "010"; end if;
                when others =>
                    state <= "000";
            end case;
        end if;
    end process;

    state_out <= state;
    S <= '1' when state = "111" else '0';
end architecture Behavioral;
