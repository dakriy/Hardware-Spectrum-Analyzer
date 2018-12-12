----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:15:23 12/08/2018 
-- Design Name: 
-- Module Name:    four_bit_counter - Behavioral 
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

entity four_bit_counter is
	port(
		mclk, inc, rst : in std_logic;
		en : out std_logic;
		c_out : out std_logic_vector(3 downto 0)
	);
end four_bit_counter;

architecture four_bit_counter_arch of four_bit_counter is
signal count, count_next : unsigned(3 downto 0);

begin
	process(mclk)
	begin
		if rising_edge(mclk) then
			count <= count_next;
		end if;
	end process;
	
	process(inc, count, rst)
	begin
		count_next <= count;
		if (rst='0') then
			if(inc='1') then
				if (count=15) then
					count_next <= (others=>'0');
				else
					count_next <= count + 1;
				end if;
			end if;
		else
			count_next <= (others => '0');
		end if;
	end process;
			
	
	c_out <= std_logic_vector(count);
	en <= '1' when count = 15 else '0';
end four_bit_counter_arch;

