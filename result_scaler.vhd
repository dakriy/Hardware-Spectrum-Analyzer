----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:48:02 12/06/2016 
-- Design Name: 
-- Module Name:    result_scaler - result_scaler_arch 
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

entity result_scaler is
	Port (
		d_in : in  STD_LOGIC_VECTOR (28 downto 0);
		d_out : out  STD_LOGIC_VECTOR (7 downto 0)
	);
end result_scaler;

architecture result_scaler_arch of result_scaler is
	signal b0,b1,b2,b3,b4,b5,b6,b7 : STD_LOGIC;
	signal d : STD_LOGIC_VECTOR(27 downto 0);
begin
	d(27 downto 0) <= d_in(27 downto 0) when d_in(28) = '0'
		else not d_in(27 downto 0);

	b0 <= d(0) or d(1) or d(2) or d(3);
	b1 <= d(4) or d(5) or d(6);
	b2 <= d(7) or d(8) or d(9);
	b3 <= d(10) or d(11) or d(12) or d(13);
	b4 <= d(14) or d(15) or d(16);
	b5 <= d(17) or d(18) or d(19);
	b6 <= d(20) or d(21) or d(22) or d(23);
	b7 <= d(24) or d(25) or d(26) or d(27);
	
	d_out(0) <= b0 or b1 or b2 or b3 or b4 or b5 or b6 or b7;
	d_out(1) <= b1 or b2 or b3 or b4 or b5 or b6 or b7;
	d_out(2) <= b2 or b3 or b4 or b5 or b6 or b7;
	d_out(3) <= b3 or b4 or b5 or b6 or b7;
	d_out(4) <= b4 or b5 or b6 or b7;
	d_out(5) <= b5 or b6 or b7;
	d_out(6) <= b6 or b7;
	d_out(7) <= b7;	
	
end result_scaler_arch;

