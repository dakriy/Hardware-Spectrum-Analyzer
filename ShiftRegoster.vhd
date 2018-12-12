----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Jake Neal, Jacob Priddy, Andrew Glencross
-- 
-- Create Date:    18:46:24 12/03/2018 
-- Design Name: 
-- Module Name:    ShiftRegoster - ShiftRegosterArch 
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

entity ShiftRegoster is
	port(
		mode, dat_in, clk : in std_logic;
		parrarer_out : out std_logic_vector(11 downto 0)
	);
end ShiftRegoster;

architecture ShiftRegosterArch of ShiftRegoster is
	signal present_state, next_state : std_logic_vector(11 downto 0);
begin
	-- Memory
	process(clk)
	begin
		if (clk'event and clk='1') then
			present_state <= next_state;
		end if;
	end process;
	
	-- Next state logic
	process(mode, present_state, dat_in)
	begin
		next_state <= present_state;
		if (mode='1') then
			next_state <= dat_in & present_state(11 downto 1);
		end if;
	end process;
	
	-- output logic
	parrarer_out <= present_state;

end ShiftRegosterArch;

