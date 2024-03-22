----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:49:35 10/25/2023 
-- Design Name: 
-- Module Name:    Rx - Behavioral 
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
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Rx is
    Port ( clk : in STD_LOGIC;			-- 50MHz clock
			  data : in  STD_LOGIC;
			  disp0 : out STD_LOGIC_VECTOR (3 downto 0);
			  disp1 : out STD_LOGIC_VECTOR (3 downto 0);
			  
			  cl9600_deb : out STD_LOGIC;
			  
			  idle_deb : out STD_LOGIC;
			  
			  
			  datareg_deb : out STD_LOGIC_VECTOR (7 downto 0);
			  count8bit_deb : out STD_LOGIC_VECTOR (2 downto 0)			  
			  );
end Rx;



architecture Behavioral of Rx is

-- component declaration
component clk_div_38400 is
    Port ( clk_in : in  STD_LOGIC;    -- 50MHz
           clk_out : out  STD_LOGIC; -- 38400Hz
			  clk_seq_debug : out STD_LOGIC_VECTOR (9 downto 0));
end component;

component Clock_divider is
    Port ( clk_in : in  STD_LOGIC;
           clk_out_d2 : out  STD_LOGIC;
			  clk_out_d4 : out  STD_LOGIC;
			  clk_out_d8 : out  STD_LOGIC;
			  clk_out_d16 : out  STD_LOGIC);
end component;



-- signal declaration

signal clk_38400, clk_9600 : STD_LOGIC;


signal idle : STD_LOGIC := '1';

signal data_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal count8bit : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');


begin


-- state 1 : idle
-- state 2 : falling edge detected, clock(delayed) started and data registered
-- state 3 : after 8/9/10 clock cycle, 8/9/10 bit of data registered, data bus sent, back to idle



		-- attempt to do everything in 1 process
		-- so far working correctly
		-- no reset
		
		process (clk_9600)
		begin
				if (clk_9600' event and clk_9600 = '1') then
				
						data_reg(7) <= data;				-- data_reg(7) is MSB
						data_reg(6) <= data_reg(7);
						data_reg(5) <= data_reg(6);
						data_reg(4) <= data_reg(5);
						data_reg(3) <= data_reg(4);
						data_reg(2) <= data_reg(3);
						data_reg(1) <= data_reg(2);
						data_reg(0) <= data_reg(1);
						
						
						if (data_reg(7) = '0' and data_reg(6) = '1' and idle = '1') then
										
								idle <= '0';
										
						elsif (idle = '0') then						-- start counting from 1 clock cycle after the start bit
								
								count8bit <= count8bit + '1';
										
								if (count8bit = "111") then  	-- count until 7 instead of 8 because it starts counting from 0
										
										idle <= '1';
										count8bit <= "000";
												
										
										disp1(3) <= data_reg(7);		-- MSB
										disp1(2) <= data_reg(6);
										disp1(1) <= data_reg(5);
										disp1(0) <= data_reg(4);
										disp0(3) <= data_reg(3);
										disp0(2) <= data_reg(2);
										disp0(1) <= data_reg(1);
										disp0(0) <= data_reg(0);		-- LSB
										
								end if;
						end if;			
				end if;
		end process;
		
		
		
		cl9600_deb <= clk_9600;
		idle_deb <= idle;
		
		datareg_deb <= data_reg;
		count8bit_deb <= count8bit;
		















--		-- controller (only assign values to state variables)
--		process (clk_9600, data)
--		begin
--				if (clk_9600' event and clk_9600 = '1') then
--				
--				detect(1) <= data;
--				detect(0) <= detect(1);
--				
--						if (detect = "01" and idle = '1') then
--						
--								idle <= '0';
--								start <= '1';
--								
--								count8bit <= count8bit + '1';
--								
--								if (count8bit = "1001") then  	-- register 9 times instead of 8 times for debug
--										
--										idle <= '1';
--										
--										start <= '0';
--										
--										count8bit = "0000";
--								
--								end if;
--						end if;
--				end if;
--		end process;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
clk_div1 : clk_div_38400 port map( clk_in => clk,					-- 50MHz 
												clk_out => clk_38400 );		-- 38400Hz
												
												
clk_div2 : Clock_divider port map( clk_in => clk_38400,			-- 38400Hz
												clk_out_d4 => clk_9600 ); 	-- 9600Hz
		












end Behavioral;

