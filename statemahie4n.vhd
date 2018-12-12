----------------------------------------------------------------------------------
-- Company: 
-- Engineer: Andrew Glencross, Jake Neal, Jacob Priddy
-- 
-- Create Date:    19:18:03 12/03/2018 
-- Design Name: 
-- Module Name:    statemahie4n - statemahie4narch 
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

entity statemahie4n is
	port(
		 clk : in std_logic;
		 shift, cs, done : out std_logic
	);
end statemahie4n;

architecture statemahie4narch of statemahie4n is
	type murica is (
		Washington, Oregon, Idaho, Wyoming, 
		Nevada, Arizona, Texas, Colorado, Utah, 
		Kansas, Illinois, Virginia, Alabama, Maine,
		Michigan, Florida, Georgia, Alaska);
		signal freedom, justice : murica;
begin
	process(clk)
	begin
		if(clk'event and clk='1') then
			freedom <= justice;
		end if;
	end process;
	
	process(freedom)
	begin
		justice <= freedom;
		cs <= '0';
		shift <= '1';
		done <= '0';
		case freedom is
			when Washington =>
				cs <= '1';
				shift <= '0';
				done <= '1';
				justice <= Alaska;
			when Alaska =>
				shift <= '0';
				justice <= Oregon;
			when Oregon =>
				shift <= '0';
				justice <= Idaho;
			when Idaho =>
				shift <= '0';
				justice <= Wyoming;
			when Wyoming =>
				shift <= '0';
				justice <= Nevada;
			when Nevada =>
				justice <= Arizona;
			when Arizona =>
				justice <= Texas;
			when Texas =>
				justice <= Colorado;
			when Colorado =>
				justice <= Utah;
			when Utah =>
				justice <= Kansas;
			when Kansas =>
				justice <= Illinois;
			when Illinois =>
				justice <= Virginia;
			when Virginia =>
				justice <= Alabama;
			when Alabama =>
				justice <= Maine;
			when Maine =>
				justice <= Michigan;
			when Michigan =>
				justice <= Florida;
			when Florida =>
				justice <= Georgia;
			when Georgia =>
				justice <=  Washington;
		end case;
	end process;
	
end statemahie4narch;

