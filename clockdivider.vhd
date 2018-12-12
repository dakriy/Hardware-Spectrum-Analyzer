----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jacob Priddy, Andrew Glencross, Jake Neal
-- 
-- Create Date:    19:05:45 12/03/2018 
-- Design Name: 
-- Module Name:    clockdivider - clockdividerarch 
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clockdivider is
	port(
		mclk : in std_logic;
		sclk : out std_logic
	);
end clockdivider;

architecture clockdividerarch of clockdivider is
	signal count, count_next : unsigned(6 downto 0);
begin
	-- memz
	process(mclk)
	begin
		if(mclk'event and mclk='1') then
			count <= count_next;
		end if;
	end process;

	-- logic
	count_next <= (others=>'0') when count=54 else count+1;
	
	sclk <= '1' when count > 27 else '0';
end clockdividerarch;

