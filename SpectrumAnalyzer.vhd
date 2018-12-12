----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:43:11 12/09/2018 
-- Design Name: 
-- Module Name:    SpectrumAnalyzer - Behavioral 
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

entity SpectrumAnalyzer is
	port (
		mclk : in std_logic;
		extin0 : in std_logic;
		extout0 : out std_logic;
		extout1 : out std_logic;
		extout2 : out std_logic;
		extout3 : out std_logic;
		extout4 : out std_logic;
		extout5 : out std_logic;
		extout6 : out std_logic;
		extout7 : out std_logic;
		extout8 : out std_logic;
		extin7 : out std_logic
	);
end SpectrumAnalyzer;

architecture Behavioral of SpectrumAnalyzer is	
	signal new_measurement, new_measurement_fast : std_logic;
	signal shift : std_logic;
	signal new_number : std_logic_vector(11 downto 0);
	signal new_res : std_logic;
	signal new_res_addr : std_logic_vector(3 downto 0);
	signal new_res_data : std_logic_vector(28 downto 0);
	signal ram_data : ram_dat_type(0 to 31);
	signal led_output_matrix_data : std_logic_vector(7 downto 0);
	signal slow_clk : std_logic;
begin

	done_emitter : SlowToFastSM port map (
		clk => mclk,
		sig => new_measurement,
		out_sig1 => shift,
		out_sig2 => new_measurement_fast
	);

	adc_component : ADC port map (
		CS => extin7,
		done => new_measurement,
		dwn_clk => slow_clk,
		datain => extin0,
		mclk => mclk,
		num => new_number
	);
	
	 extout8 <= slow_clk;

	memory : RAM port map (
		clk =>  mclk,
		we => new_measurement,
		shift => shift,
		new_val => new_number,
		data => ram_data
	);

	math_module : MATH port map (
		new_data => new_measurement_fast,
		clk => mclk,
		ram_data => ram_data,
		new_res => new_res,
		new_res_addr => new_res_addr,
		new_res_data => new_res_data
	);

	display : DisplayDriver port map (
		clk => mclk,
		write_enable => new_res,
		number => new_res_data,
		write_addr => new_res_addr,
		led_array => led_output_matrix_data
	);
	
	extout0  <= led_output_matrix_data(0);
	extout1  <= led_output_matrix_data(1);
	extout2  <= led_output_matrix_data(2);
	extout3  <= led_output_matrix_data(3);
	extout4  <= led_output_matrix_data(4);
	extout5  <= led_output_matrix_data(5);
	extout6  <= led_output_matrix_data(6);
	extout7  <= led_output_matrix_data(7);

end Behavioral;

