library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity registrador is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           enable : in STD_LOGIC;
           D : in STD_LOGIC_VECTOR(15 downto 0);
           Q : out STD_LOGIC_VECTOR(15 downto 0));
end registrador;

architecture Behavioral of registrador is
begin
    process (clk, reset, enable)
    begin
        if reset = '0' then
            Q <= "0000000000000000";
        elsif rising_edge(clk) then
            if enable = '1' then
                Q <= D;
            end if;
        end if;
    end process;
end Behavioral;