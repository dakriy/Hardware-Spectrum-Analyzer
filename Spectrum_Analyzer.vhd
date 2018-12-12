--
--	Package File Template
--
--	Purpose: This package defines supplemental types, subtypes, 
--		 constants, and functions 
--
--   To use any of the example code shown below, uncomment the lines and modify as necessary
--

library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.NUMERIC_STD.ALL;

package Spectrum_Analyzer is
	  type ram_dat_type is array(natural range <>) of std_logic_vector(11 downto 0);
	  type rom_dat_type is array(natural range <>) of signed(11 downto 0);
	  
	  
	  
	 component ROM is
		port(
			dataout : out rom_dat_type(0 to 31);
			addr : in std_logic_vector(3 downto 0)
		);
	end component;
	
	component four_bit_counter is
		port(
			mclk, inc, rst : in std_logic;
			en : out std_logic;
			c_out : out std_logic_vector(3 downto 0)
		);
	end component;
	
	component math_state_machine is
		port(
			max, done, mclk : in std_logic;
			we, rst_cnt, inc_addr : out std_logic
		);
	end component;
	
	component adder is
		port(
				num1: in signed(28 downto 0);
				num2: in signed(28 downto 0);
				result : out signed(28 downto 0)
			);
	end component;
	
	component multiplier is
		port(
			num1 : in std_logic_vector(11 downto 0);
			num2 : in signed(11 downto 0);
			result : out signed(28 downto 0)
		);
	end component;
	
	
	component ShiftRegoster is
		port(
			mode, dat_in, clk : in std_logic;
			parrarer_out : out std_logic_vector(11 downto 0)
		);
	end component;
	
	component clockdivider is
		port(
			mclk : in std_logic;
			sclk : out std_logic
		);
	end component;
	
	component statemahie4n is
		port(
			 clk : in std_logic;
			 shift, cs, done : out std_logic
		);
	end component;
	
	component ADC is 
		port(
			CS, done, dwn_clk : out std_logic;
			datain, mclk : in std_logic;
			num : out std_logic_vector(11 downto 0)
		);
	end component;
	
	component RAM is 
		port(
			clk, we, shift : in std_logic;
			new_val : in std_logic_vector(11 downto 0);
			data : out ram_dat_type(0 to 31)
		);
	end component;
	
	component MATH is
		port(
			new_data, clk : in std_logic;
			ram_data : ram_dat_type(0 to 31);
			new_res : out std_logic;
			new_res_addr : out std_logic_vector(3 downto 0);
			new_res_data : out std_logic_vector(28 downto 0)
		);
	end component;
	
	component DisplayDriver is
		port(
			clk, write_enable : in std_logic;
			number : in std_logic_vector(28 downto 0);
			write_addr : in std_logic_vector(3 downto 0);
			led_array : out std_logic_vector(7 downto 0)
		);
	end component;
	
	component SlowToFastSM is
		port(
			clk, sig : in std_logic;
			out_sig1, out_sig2 : out std_logic
		);
	end component;

end Spectrum_Analyzer;

package body Spectrum_Analyzer is

---- Example 1
--  function <function_name>  (signal <signal_name> : in <type_declaration>  ) return <type_declaration> is
--    variable <variable_name>     : <type_declaration>;
--  begin
--    <variable_name> := <signal_name> xor <signal_name>;
--    return <variable_name>; 
--  end <function_name>;

---- Example 2
--  function <function_name>  (signal <signal_name> : in <type_declaration>;
--                         signal <signal_name>   : in <type_declaration>  ) return <type_declaration> is
--  begin
--    if (<signal_name> = '1') then
--      return <signal_name>;
--    else
--      return 'Z';
--    end if;
--  end <function_name>;

---- Procedure Example
--  procedure <procedure_name>  (<type_declaration> <constant_name>  : in <type_declaration>) is
--    
--  begin
--    
--  end <procedure_name>;
 
end Spectrum_Analyzer;
