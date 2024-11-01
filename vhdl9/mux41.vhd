library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity mux41 is
    Port ( sel : in STD_LOGIC_VECTOR(1 downto 0);
           A, B, C, D : in STD_LOGIC_VECTOR(15 downto 0);
           Y : out STD_LOGIC_VECTOR(15 downto 0));
end mux41;

architecture Behavioral of mux41 is
begin
    process (sel, A, B, C, D)
    begin
        case sel is
            when "00" => Y <= A;
            when "01" => Y <= B;
            when "10" => Y <= C;
            when others => Y <= D;
        end case;
    end process;
end Behavioral;