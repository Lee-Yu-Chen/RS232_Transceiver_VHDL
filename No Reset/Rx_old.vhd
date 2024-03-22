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

entity Rx_old is
    Port ( clk : in STD_LOGIC;			-- 50MHz clock
			  data : in  STD_LOGIC;
			  disp : out STD_LOGIC_VECTOR (9 downto 0);
			  
			  st9600_deb : out STD_LOGIC;
			  st38400_deb : out STD_LOGIC;
			  cl38400_deb : out STD_LOGIC;
			  cl9600_deb : out STD_LOGIC;
			  
			  idle_deb : out STD_LOGIC;
			  count_deb : out STD_LOGIC;
			  
			  cl38400e_deb : out STD_LOGIC;
			  cl9600e_deb : out STD_LOGIC;
			  
			  datareg_deb : out STD_LOGIC_VECTOR (9 downto 0);
			  count8bit_deb : out STD_LOGIC_VECTOR (3 downto 0)			  
			  );
end Rx_old;



architecture Behavioral of Rx_old is

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

signal start_9600 : STD_LOGIC := '0';
signal start_38400 : STD_LOGIC := '0';		-- state signal

signal idle : STD_LOGIC := '1';

signal count : STD_LOGIC := '0';

signal clk_9600e : STD_LOGIC := '0';
signal clk_38400e : STD_LOGIC := '0';


signal data_reg : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');

signal count8bit : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');





begin


-- state 1 : idle
-- state 2 : falling edge detected, clock(delayed) started and data registered
-- state 3 : after 8/9/10 clock cycle, 8/9/10 bit of data registered, data bus sent, back to idle



-- (Debug and realise) 17 Nov 2023
-- the following code attempts to do the receiving process (detect start bit, register data, end registering) in multiple process, 
-- i.e. 1 process for detecting start bit, 1 for register data, 1 for ending and restarting
-- cannot work cuz those state variables (idle, start_38400, start_9600) cannot be assigned value in more than 1 process


		-- detect start bit
		process (data)
		begin
				if (data' event and data = '0' and idle = '1') then			-- detect fallng edge of "data" i.e. start bit
				
						start_38400 <= '1';		
						idle <= '0';
						
				end if;
		end process;
		
		
		
		
		
		
		
		clk_38400e <= clk_38400 and start_38400;
		
		process (clk_38400e)
		begin
				if (clk_38400e' event and clk_38400e = '1') then
						
						count <= not count;
						
						if (count' event and count = '0') then
						
								start_38400 <= '0';
								
								start_9600 <= '1';
								
						end if;
				end if;
		end process;
		
		
		
		
		
		
		clk_9600e <= clk_9600 and start_9600;
		
		process (clk_9600e)
		begin
				if (clk_9600e' event and clk_9600e = '1') then
				
						count8bit <= count8bit + '1';
						
						data_reg(9) <= data_reg(8);
						data_reg(8) <= data_reg(7);
						data_reg(7) <= data_reg(6);
						data_reg(6) <= data_reg(5);
						data_reg(5) <= data_reg(4);
						data_reg(4) <= data_reg(3);
						data_reg(3) <= data_reg(2);
						data_reg(2) <= data_reg(1);
						data_reg(1) <= data_reg(0);
						data_reg(0) <= data;
						
						if (count8bit = "1000") then
								count8bit <= "0000";
								
								start_9600 <= '0';
								
								idle <= '1';
								
						end if;
				end if;
		end process;
		
		
		
		disp (9) <= data_reg(9) and idle;
		disp (8) <= data_reg(8) and idle;
		disp (7) <= data_reg(7) and idle;
		disp (6) <= data_reg(6) and idle;
		disp (5) <= data_reg(5) and idle;
		disp (4) <= data_reg(4) and idle;
		disp (3) <= data_reg(3) and idle;
		disp (2) <= data_reg(2) and idle;
		disp (1) <= data_reg(1) and idle;
		disp (0) <= data_reg(0) and idle;
		
		
		
		-- rounting signal out to debug in testbench
		st9600_deb <= start_9600;
		st38400_deb <= start_38400;
		
		cl9600_deb <= clk_9600;
		cl38400_deb <= clk_38400;
			  
		idle_deb <= idle;
		count_deb <= count;
		
		cl9600e_deb <= clk_9600e;
		cl38400e_deb <= clk_38400e;
			  
		datareg_deb <= data_reg;
		count8bit_deb <= count8bit;
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
clk_div1 : clk_div_38400 port map( clk_in => clk,					-- 50MHz 
												clk_out => clk_38400 );		-- 38400Hz
												
												
clk_div2 : Clock_divider port map( clk_in => clk_38400,			-- 38400Hz
												clk_out_d4 => clk_9600 ); 	-- 9600Hz
		













end Behavioral;

