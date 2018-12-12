----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:27:28 12/04/2018 
-- Design Name: 
-- Module Name:    multiplexer - Behavioral 
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

use Spectrum_Analyzer.all;

entity RAM is
	port(
		clk, we, shift : in std_logic;
		new_val : in std_logic_vector(11 downto 0);
		data : out ram_dat_type(0 to 31)
	);
end RAM;

architecture RAM_arch of RAM is
	type sr is array(0 to 11) of std_logic_vector(31 downto 0);
	signal RAM : sr;
begin
	process(clk)
	begin
		if rising_edge(clk) then
			if we = '1' then
				setloop : for k in 0 to 11 loop
					RAM(k)(0) <= new_val(k);
				end loop;
			end if;
			
			if shift='1' then
				shiftloop : for k in 0 to 11 loop
					shiftloop1 : for n in 1 to 31 loop
						RAM(k)(n) <= RAM(k)(n-1);
					end loop shiftloop1;
				end loop shiftloop;
			end if;
			
			sendloop : for i in 0 to 11 loop
				sendloop1 : for j in 0 to 31 loop
					data(j)(i) <= RAM(i)(j);
				end loop;
			end loop;
		end if;
	end process;

end RAM_arch;

