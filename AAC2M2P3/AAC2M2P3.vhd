library ieee;
use ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

entity FSM is
generic(
	A:  std_logic_vector(1 downto 0) := "00";
	B:  std_logic_vector(1 downto 0) := "01";
	C:  std_logic_vector(1 downto 0) := "10" );
port (In1: in std_logic;
   RST: in std_logic; 
   CLK: in std_logic;
   Out1 : inout std_logic);
end entity FSM;
architecture state_machine of FSM is

signal curr_state, next_state: std_logic_vector(1 downto 0);

begin

clock_process: process(CLK, RST)
begin
	if(RST='1') then curr_state <= A;
	elsif (rising_edge(CLK)) then curr_state <= next_state;
	end if;
end process clock_process;

comb_process: process(curr_state, In1)
begin
Out1<='0';

case curr_state is

when A =>
Out1 <= '0';
if (In1='0') then next_state <= A;
else next_state <= B;
end if;

when B =>
Out1 <= '0';
if (In1='1') then next_state <= B;
else next_state <= C;
end if;

when C =>
Out1 <= '1';
if (In1='0') then next_state <= C;
else next_state <= A;
end if;

when others =>
Out1<='0';
next_state <= A;

end case;

end process comb_process;
end architecture;
