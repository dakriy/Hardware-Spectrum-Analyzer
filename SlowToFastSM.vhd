----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:01:04 12/09/2018 
-- Design Name: 
-- Module Name:    SlowToFastSM - SlowToFastSM_Arch 
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

entity SlowToFastSM is
	port (
		clk, sig : in std_logic;
		out_sig1, out_sig2 : out std_logic
	);
end SlowToFastSM;

architecture SlowToFastSM_Arch of SlowToFastSM is
type slow_to_fast_states is (wait_for_sig, emit_pre_sig, emit_sig, wait_for_stop);
signal state : slow_to_fast_states := wait_for_sig;
signal next_state : slow_to_fast_states := wait_for_sig;
begin

	process(clk)
	begin
		if rising_edge(clk) then
			state <= next_state;
		end if;
	end process;
	
	process(state)
	begin
		out_sig1 <= '0';
		out_sig2 <= '0';
		case state is
			when wait_for_sig =>
			when emit_pre_sig =>
				out_sig1 <= '1';
			when emit_sig =>
				out_sig2 <= '1';
			when wait_for_stop =>
		end case;
	end process;
	
	process(state, sig)
	begin
		next_state <= state ;
		case state is
			when wait_for_sig =>
				if	(sig = '1') then
					next_state <= emit_pre_sig;
				end if;
			when emit_pre_sig =>
				next_state <= emit_sig;
			when emit_sig =>
				next_state <= wait_for_stop;
			when wait_for_stop =>
				if (sig='0') then
					next_state <= wait_for_sig;
				end if;
		end case;
	end process;

end SlowToFastSM_Arch;

