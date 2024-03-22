----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    16:22:24 11/03/2023 
-- Design Name: 
-- Module Name:    clk_div_38400 - Behavioral 
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

entity clk_div_38400 is
    Port ( clk_in : in  STD_LOGIC;    -- 50MHz
           clk_out : out  STD_LOGIC; -- 38400Hz
			  clk_seq_debug : out STD_LOGIC_VECTOR (9 downto 0));
end clk_div_38400;




architecture Behavioral of clk_div_38400 is


signal clock_seq : STD_LOGIC_VECTOR (9 downto 0) := (others => '0');

signal clk_38400 : STD_LOGIC := '0';

begin

		process (clk_in)
		begin
		
		if (clk_in' event and clk_in = '1') then      -- freq/2
		
				clock_seq <= clock_seq + '1';
				
				if (clock_seq = "1010001010") then      -- freq/651
				
						clock_seq <= "0000000000";
						clk_38400 <= not clk_38400;    -- toggle the 38400 clock for every 1300 50M_clk cycle
				
				
				end if;
		
		end if;
		
		end process;
		
		
		
		clk_out <= clk_38400;
		
		clk_seq_debug <= clock_seq;
		
		
		


end Behavioral;

