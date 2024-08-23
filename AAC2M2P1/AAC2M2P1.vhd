LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

entity AAC2M2P1 is port (                 	
   CP: 	in std_logic; 	-- clock
   SR:  in std_logic;  -- Active low, synchronous reset
   P:    in std_logic_vector(3 downto 0);  -- Parallel input
   PE:   in std_logic;  -- Parallel Enable (Load)
   CEP: in std_logic;  -- Count enable parallel input
   CET:  in std_logic; -- Count enable trickle input
   Q:   out std_logic_vector(3 downto 0);            			
    TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;
architecture binary_counter of AAC2M2P1 is
signal count: std_logic_vector(3 downto 0);
begin
count_process: process(CP)
begin
   if(rising_edge(CP)) then
	if(SR='0') then
		count <= "0000";
	elsif(PE='0') then
		count <= P;
	elsif(PE='1' AND CET='1' AND CEP='1') then
		count <=std_logic_vector(unsigned(count)+ 1);
	end if;
end if;
end process count_process;
Q <= count;
TC <= count(3) and count(2) and count(1) and count(0) and CET;
end architecture binary_counter;
