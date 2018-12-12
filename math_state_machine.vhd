----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:46:16 12/08/2018 
-- Design Name: 
-- Module Name:    math_state_machine - math_state_machine_arch 
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

entity math_state_machine is
	port(
		max, done, mclk : in std_logic;
		we, rst_cnt, inc_addr : out std_logic
	);
end math_state_machine;

architecture math_state_machine_arch of math_state_machine is
type math_state is (Solid, Liquid, Gas, Plasma);
signal present_state, next_state : math_state;

begin

	process(mclk)
	begin
		if rising_edge(mclk) then
			present_state <= next_state;
		end if;
	end process;

	-- next state logic
	process(max, done, present_state)
	begin 
		next_state <= present_state;
		case present_state is
			when solid => 
				if (done = '1') then
					next_state <= liquid;
				end if;
			when liquid =>
				next_state <= gas;
			when gas =>
				next_state <= plasma;
			when plasma =>
				if (max = '0') then
					next_state <= liquid;
				else
					next_state <= solid;
				end if;
		end case;
	end process;
	
	-- Output logic
	process(present_state)
	begin
		rst_cnt<= '0';
		inc_addr <= '0';
		we <= '0';
		case present_state is
			when solid =>
				rst_cnt <= '1';
			when gas =>
			when liquid =>
			when plasma =>
				inc_addr <= '1';
				we <= '1';
		end case;
	end process;

end math_state_machine_arch;

