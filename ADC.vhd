----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrew Glencross, Jacob Priddy, Jake Neal
-- 
-- Create Date:    19:37:49 12/03/2018 
-- Design Name: 
-- Module Name:    ADC - ADCArch 
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

use Spectrum_Analyzer.all;

entity ADC is
	port(
		CS, done, dwn_clk : out std_logic;
		datain, mclk : in std_logic;
		num : out std_logic_vector(11 downto 0)
	);
end ADC;

architecture ADCArch of ADC is	
	signal shift_mode , clk : std_logic;
	signal datastuff : std_logic_vector(11 downto 0);
begin

	hulk_hogan : clockdivider port map (mclk, clk);
	
	the_undertaker : ShiftRegoster port map (shift_mode, datain, clk, datastuff);
	
	john_CENAAAAA : statemahie4n port map (
		clk 									=> clk,
		shift 								=> shift_mode,
		cs 									=> CS,
		done								=> done
	);
	
	num <= datastuff;
	
	dwn_clk <=  clk;
	
	-- num(11) <= datastuff(0);
	-- num(10) <= datastuff(1);
	-- num(9) <= datastuff(2);
	-- num(8) <= datastuff(3);
	-- num(7) <= datastuff(4);
	-- num(6) <= datastuff(5);
	-- num(5) <= datastuff(6);
	-- num(4) <= datastuff(7);
	-- num(3) <= datastuff(8);
	-- num(2)  <= datastuff(9);
	-- num(1) <= datastuff(10);
	-- num(0)  <= datastuff(11);

end ADCArch;

