library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity FIFO8x9 is
   port(
      clk, rst:		in std_logic;
      RdPtrClr, WrPtrClr:	in std_logic;    
      RdInc, WrInc:	in std_logic;
      DataIn:	 in std_logic_vector(8 downto 0);
      DataOut: out std_logic_vector(8 downto 0);
      rden, wren: in std_logic
	);
end entity FIFO8x9;

architecture RTL of FIFO8x9 is
	--signal declarations
	type fifo_array is array(7 downto 0) of std_logic_vector(8 downto 0);  -- makes use of VHDL’s enumerated type
	signal fifo:  fifo_array;
	signal wrptr, rdptr: unsigned(2 downto 0);
	--signal en: std_logic_vector(7 downto 0);
	signal dmuxout: std_logic_vector(8 downto 0);
begin
wrptr <= "000" when rising_edge(clk) and WrPtrClr ='1'
else
wrptr + 1 when rising_edge(clk) and WrInc = '1'
else
wrptr;

rdptr <= "000" when rising_edge(clk) and RdPtrClr = '1'
else
rdptr + 1 when rising_edge(clk) and RdInc = '1'
else
rdptr;

DataOut <= dmuxout when rden = '1'
else
"ZZZZZZZZZ" when rden = '0';

fifo(to_integer(wrptr)) <= DataIn when rising_edge(clk) and wren = '1'
else
fifo(to_integer(wrptr));

dmuxout <= fifo(to_integer(rdptr));
end architecture RTL;