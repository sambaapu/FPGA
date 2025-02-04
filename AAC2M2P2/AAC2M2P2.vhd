LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.ALL;

ENTITY RAM128_32 IS
	PORT
	(
		address	: IN STD_LOGIC_VECTOR (6 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END RAM128_32;

architecture RAM_arch of RAM128_32 is
type t_vector is array (0 to 2**7) of std_logic_vector (31 downto 0);
signal reg: t_vector;
begin
process(clock)
begin
if(rising_edge(clock)) then
	if(wren = '1') then
		reg(to_integer(unsigned(address))) <= data;
	end if;
end if;
q <= reg(to_integer(unsigned(address)));
end process;
end architecture;
