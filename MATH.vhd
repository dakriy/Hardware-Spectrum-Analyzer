----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:12:39 12/09/2018 
-- Design Name: 
-- Module Name:    MATH - MATHArch 
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

entity MATH is
	port(
		new_data, clk : in std_logic;
		ram_data : ram_dat_type(0 to 31);
		new_res : out std_logic;
		new_res_addr : out std_logic_vector(3 downto 0);
		new_res_data : out std_logic_vector(28 downto 0)
	);
end MATH;

architecture MATHArch of MATH is	
	type math_result is array(0 to 31) of signed(28 downto 0);
	
	signal coefficient_array : rom_dat_type(0 to 31);
	signal index_address : std_logic_vector(3 downto 0);
	signal max_count, display_we : std_logic;
	signal reset_count, inc_addr : std_logic;
	signal multiply_results, add_results : math_result;
begin

	state_machine : math_state_machine port map (
		max => max_count,
		done => new_data,
		mclk => clk,
		we => display_we,
		rst_cnt => reset_count,
		inc_addr => inc_addr
	);

	counter : four_bit_counter port map (
		mclk => clk,
		inc => inc_addr,
		rst => reset_count,
		en => max_count,
		c_out => index_address
	);

	coefficients : ROM port map (
		dataout => coefficient_array,
		addr => index_address
	);
	
	new_res <= display_we;
	new_res_addr <= index_address;
	
	gen_multiply:
	for i in 0 to 31 generate
		multiply : multiplier port map (
			num1 => ram_data(i),
			num2 => coefficient_array(i),
			result => multiply_results(i)
		);
	end generate gen_multiply;
	
	add_results(0) <= multiply_results(0);
	
	new_res_data <= std_logic_vector(add_results(31));
	
	gen_adder:
	for i in 1 to 31 generate
		add : adder port map (
			num1 => add_results(i - 1),
			num2 => multiply_results(i),
			result => add_results(i)
		);
	end generate gen_adder;
end MATHArch;

