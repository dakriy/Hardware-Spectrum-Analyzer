----------------------------------------------------------------------------------
-- Company: 		Walla Walla University
-- Engineer:		L.Aamodt
-- 
-- Create Date:    21:14:50 12/06/2015 
-- Design Name: 	 led_8x16_driver
-- Module Name:    led_8x16_driver - led_8x16_driver_arch 
-- Project Name: 	 led_8x16_driver
-- Target Devices: Spartan 3e
-- Tool versions:	 ISE 14.7
-- Description: 	 Driver to send data to a 8x16 LED array arranged as
--							8 rows of 16 bits (i.e. 16 columns).  Data is read
--							asynchronously as bytes from a 16 byte RAM, bits in
--							the byte are selected sequentially with a multiplexer,
--							and together with an address are used to select one
--							LED at a time for potential turn on.  All 128 bits are
--							scanned about 79 times per second.
--
-- Dependencies: 
--
-- Revision: 
-- Revision 2.0     12/7/16
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity led_8x16_driver is
    Port (
			mclk : in  STD_LOGIC;						-- 50 Mhz clock
			sys_clk : in  STD_LOGIC;					-- clock from game
			we : in  STD_LOGIC;						-- write enable
			data_in : in  STD_LOGIC_VECTOR (7 downto 0);
			wrt_addr : in  STD_LOGIC_VECTOR (3 downto 0);
			out_to_display : out  STD_LOGIC_VECTOR (7 downto 0)
		);
end led_8x16_driver;

architecture led_8x16_driver_arch of led_8x16_driver is
	signal r_reg1: unsigned(11 downto 0);
	signal r_next1: unsigned(11 downto 0);
	signal led_addr: unsigned(6 downto 0);
	signal led_next: unsigned(6 downto 0);
	signal ram_data: STD_LOGIC_VECTOR(7 downto 0);
	signal clk_20k: STD_LOGIC;
	signal clk_10k: STD_LOGIC;
	signal Bclk_10k: STD_LOGIC;
	signal led_data: STD_LOGIC;
	
	type ram_type is array (0 to 15) of std_logic_vector(7 downto 0);
	signal RAM: ram_type := (
--		X"81", X"82", X"84", X"88",		-- initial data, pattern 1
--		X"44", X"42", X"41", x"40",
--		X"81", X"82", X"84", X"88",
--		X"44", X"42", X"41", x"40"	

		X"01", X"02", X"04", X"08",		-- initial data, pattern 2
		X"10", X"20", X"40", x"80",
		X"80", X"40", X"20", x"10",		
		X"08", X"04", X"02", x"01"	
		);
	
begin
------------------------------------------------------------
--    Scan clock generator - 10khz output to run LED update
------------------------------------------------------------
	process(mclk,r_reg1)  -- create 20000hz signal
	begin
		if (mclk'event and mclk='1') then
			if (r_reg1 = 2499) then
				r_reg1 <= (others=>'0');
			else
				r_reg1 <= r_next1;
			end if;
		end if;
	end process;
	r_next1 <= r_reg1 + 1;
   clk_20k <= '1' when r_reg1 = 2499 else '0';

	process(mclk,clk_20k)  -- create square 10khz clock
	begin
		if (mclk'event and mclk='1') then
			if (clk_20k = '1') then
				clk_10k <= NOT clk_10k;
			end if;
		end if;
	end process;

	Clk_Buffer: BUFG			-- create 10khz buffered clock
		port map ( I => clk_10k, O => Bclk_10k);
------------------------------------------------------------
--		Dual ported RAM that holds an image of what is to be displayed
--			synchronous write and asynchronous read
------------------------------------------------------------
	process(sys_clk)
	begin
		if (sys_clk'event and sys_clk = '1') then
			if (we = '1') then
				RAM(to_integer(unsigned(wrt_addr))) <= data_in;
			end if;
		end if;
	end process;
	ram_data <= RAM(to_integer(unsigned(led_addr(6 downto 3))));
	
------------------------------------------------------------
--		LED address generator, a 7 bit binary counter
------------------------------------------------------------
	process(Bclk_10k)
	begin
		if (Bclk_10k'event and Bclk_10k='1') then
			if (led_addr = 127) then
				led_addr <= (others=>'0');
			else
				led_addr <= led_next;
			end if;
		end if;
	end process;
	led_next <= led_addr + 1;
	out_to_display(7 downto 1) <= std_logic_vector(led_addr);

-------------------------------------------------------------
--		Multiplexer to get one led data bit from a data byte
-------------------------------------------------------------
	process(led_addr, ram_data)
	begin
		case led_addr(2 downto 0) is
			when "000" => 
				led_data <= ram_data(7);
			when "001" =>
				led_data <= ram_data(6);
			when "010" =>
				led_data <= ram_data(5);
			when "011" =>
				led_data <= ram_data(4);
			when "100" =>
				led_data <= ram_data(3);
			when "101" =>
				led_data <= ram_data(2);
			when "110" =>
				led_data <= ram_data(1);
			when others =>
				led_data <= ram_data(0);
		end case;
	end process;
	out_to_display(0) <= led_data;
end led_8x16_driver_arch;

