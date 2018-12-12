----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    10:28:13 12/05/2018 
-- Design Name: 
-- Module Name:    multiplier - multiplier_arch 
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

entity multiplier is
	port(
		num1 : in std_logic_vector(11 downto 0);
		num2 : in signed(11 downto 0);
		result : out signed(28 downto 0)
	);
end multiplier;

architecture multiplier_arch of multiplier is
begin
	result <= resize(signed(signed(num1) + to_signed(-2048, 12)) * num2, result'length);
end multiplier_arch;

