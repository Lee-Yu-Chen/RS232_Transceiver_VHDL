--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   16:34:34 11/03/2023
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/Xilinx ISE/Year 4 HDL/RS232_Rx/clk_div_38400_testbench.vhd
-- Project Name:  RS232_Rx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: clk_div_38400
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY clk_div_38400_testbench IS
END clk_div_38400_testbench;
 
ARCHITECTURE behavior OF clk_div_38400_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT clk_div_38400
    PORT(
         clk_in : IN  std_logic;
         clk_out : OUT  std_logic;
			clk_seq_debug : out STD_LOGIC_VECTOR (9 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk_in : std_logic := '0';

 	--Outputs
   signal clk_out : std_logic;
	signal clk_seq_debug : STD_LOGIC_VECTOR (9 downto 0);

   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: clk_div_38400 PORT MAP (
          clk_in => clk_in,
          clk_out => clk_out,
			 clk_seq_debug => clk_seq_debug
        );

   
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      clk_in <= '1';
		wait for 10ns;
		
		clk_in <= '0';
		wait for 10ns;
		
		
		
		
   end process;

END;
