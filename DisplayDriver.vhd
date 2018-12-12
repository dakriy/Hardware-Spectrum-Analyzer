----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:32:30 12/09/2018 
-- Design Name: 
-- Module Name:    DisplayDriver - DisplayDriver_arch 
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

entity DisplayDriver is
	port(
		clk, write_enable : in std_logic;
		number : in std_logic_vector(28 downto 0);
		write_addr : in std_logic_vector(3 downto 0);
		led_array : out std_logic_vector(7 downto 0)
	);
end DisplayDriver;

architecture DisplayDriver_arch of DisplayDriver is
	component led_8x16_driver is
		 Port (
			mclk : in  STD_LOGIC;						-- 50 Mhz clock
			sys_clk : in  STD_LOGIC;					-- clock from game
			we : in  STD_LOGIC;						-- write enable
			data_in : in  STD_LOGIC_VECTOR (7 downto 0);
			wrt_addr : in  STD_LOGIC_VECTOR (3 downto 0);
			out_to_display : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	
	component result_scaler is
		Port (
			d_in : in  STD_LOGIC_VECTOR (28 downto 0);
			d_out : out  STD_LOGIC_VECTOR (7 downto 0)
		);
	end component;
	
	signal actual_number : std_logic_vector(7 downto 0);
begin
	scale_block : result_scaler port map (
			d_in => number,
			d_out => actual_number
	);
	
		led_matrix : led_8x16_driver port map (
			mclk => clk,
			sys_clk => clk,
			we => write_enable,
			data_in => actual_number,
			wrt_addr => write_addr,
			out_to_display => led_array
		);

end DisplayDriver_arch;

