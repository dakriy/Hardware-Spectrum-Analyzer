----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    20:46:17 12/08/2018 
-- Design Name: 
-- Module Name:    five_bit_counter - Behavioral 
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

entity five_bit_counter is
	port(
		mclk, rst : in std_logic;
		c_out : out std_logic_vector(4 downto 0);
		en : out std_logic
	);
end five_bit_counter;

architecture Five_Counter_Arch of five_bit_counter is
signal count, count_next : unsigned(4 downto 0);
begin

	process(rst, mclk)
	begin
		if (rst='1') then
			count <= (others => '0');
		elsif rising_edge(mclk) then
			count <= count_next;
		end if;
	end process;
	
	process(rst, count)
	begin
		if (rst='1') then
			count_next <= (others=>'0');
		else
			if (count = 31) then
				count_next <= (others => '0');
			else
				count_next <= count+1;
			end if;
		end if;
	end process;
	
	
	en <= '1' when count = 31 else '0';
	
	c_out <= std_logic_vector(count);

end Five_Counter_Arch;

