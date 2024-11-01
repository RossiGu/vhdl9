library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; 

entity multimodo is
    Port ( SW : in STD_LOGIC_VECTOR (17 downto 0); 
           KEY : in STD_LOGIC_VECTOR (1 downto 0); 
           LEDR : out STD_LOGIC_VECTOR (15 downto 0) 
           );
end multimodo;

architecture Behavioral of multimodo is
    signal reg_out, mux_out, A : STD_LOGIC_VECTOR (15 downto 0); 
    signal sel_op : STD_LOGIC_VECTOR (1 downto 0); 
    signal enable : STD_LOGIC; 

    signal mult_result, add_result : STD_LOGIC_VECTOR (31 downto 0);

    component registrador
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               enable : in STD_LOGIC;
               D : in STD_LOGIC_VECTOR(15 downto 0);
               Q : out STD_LOGIC_VECTOR(15 downto 0));
    end component;

    component mux41
        Port ( sel : in STD_LOGIC_VECTOR(1 downto 0);
               A, B, C, D : in STD_LOGIC_VECTOR(15 downto 0);
               Y : out STD_LOGIC_VECTOR(15 downto 0));
    end component;

begin
    A <= SW(15 downto 0);
    sel_op <= SW(17 downto 16);
    enable <= '1'; 

    mult_result <= STD_LOGIC_VECTOR(UNSIGNED(reg_out(15 downto 0)) * UNSIGNED(A(15 downto 0)));
    add_result <= STD_LOGIC_VECTOR(UNSIGNED(reg_out(15 downto 0)) * UNSIGNED(reg_out(15 downto 0))); 

    U1_mux : mux41
        port map ( sel => sel_op,
                   A => A(15 downto 0),
                   B => mult_result(15 downto 0),
                   C => add_result(15 downto 0),
                   D => reg_out(15 downto 0),
                   Y => mux_out(15 downto 0));

    U2_reg : registrador
        port map ( clk => KEY(1),
                   reset => KEY(0),
                   enable => enable,
                   D => mux_out(15 downto 0),
                   Q => reg_out(15 downto 0));

    LEDR <= reg_out;

end Behavioral;