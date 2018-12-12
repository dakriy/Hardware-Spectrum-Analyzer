----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:49:23 12/05/2018 
-- Design Name: 
-- Module Name:    addreg - addreg_arch 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity addreg is
	port(
		new_res : in std_logic_vector(28 downto 0);
		stored : out std_logic_vector(28 downto 0);
		rst, clk, en : in std_logic
	);
end addreg;

architecture addreg_arch of addreg is
	signal storedval, storedval_next : std_logic_vector(28 downto 0);
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if (en='1') then
				storedval <= storedval_next;
			end if;
		end if;
	end process;
	
	with rst select
		storedval_next <= 	new_res when '0',
													(others=>'0') when others;
	
	stored <= storedval;
end addreg_arch;

