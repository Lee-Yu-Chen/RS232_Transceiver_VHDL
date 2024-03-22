----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:12:11 10/25/2023 
-- Design Name: 
-- Module Name:    Clock_divider_behav - Behavioral 
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





-- this is a behavioural code for clock divider, the divider clocks (clkd4, clkd8, clkd16) have a half period delay





entity Clock_divider is
    Port ( clk_in : in  STD_LOGIC;
           clk_out_d2 : out  STD_LOGIC;
			  clk_out_d4 : out  STD_LOGIC;
			  clk_out_d8 : out  STD_LOGIC;
			  clk_out_d16 : out  STD_LOGIC);
end Clock_divider;

architecture Behavioral of Clock_divider is

signal clock_seq : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

begin

	process (clk_in)
	begin

		if (clk_in' event and clk_in = '1') then

		clock_seq <= clock_seq + '1';

		end if;

	end process;

clk_out_d2 <= clock_seq(0);
clk_out_d4 <= clock_seq(1);
clk_out_d8 <= clock_seq(2);
clk_out_d16 <= clock_seq(3);






end Behavioral;

