--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:52:52 11/17/2023
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/Xilinx ISE/Y4 HDL/RS232_Rx/Rx_testbench.vhd
-- Project Name:  RS232_Rx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Rx
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
 
ENTITY Rx_testbench IS
END Rx_testbench;
 
ARCHITECTURE behavior OF Rx_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rx
    PORT(
         clk : IN  std_logic;
         data : IN  std_logic;
         disp : OUT  std_logic_vector(7 downto 0);
         cl9600_deb : OUT  std_logic;
         idle_deb : OUT  std_logic;
         datareg_deb : OUT  std_logic_vector(7 downto 0);
         count8bit_deb : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data : std_logic := '0';

 	--Outputs
   signal disp : std_logic_vector(7 downto 0);
   signal cl9600_deb : std_logic;
   signal idle_deb : std_logic;
   signal datareg_deb : std_logic_vector(7 downto 0);
   signal count8bit_deb : std_logic_vector(2 downto 0);

   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rx PORT MAP (
          clk => clk,
          data => data,
          disp => disp,
          cl9600_deb => cl9600_deb,
          idle_deb => idle_deb,
          datareg_deb => datareg_deb,
          count8bit_deb => count8bit_deb
        );
		  
		  
		  
	-- 50MHz clk
	process 
	begin
	
		clk <= '0';
		wait for 10 ns;
		clk <= '1';
		wait for 10 ns;
	
	end process;

   
 

   -- Stimulus process
   stim_proc: process
   begin		
	
	data <= '1';			-- idle
	wait for 312.5 us;
	
	data <= '0';			-- start bit
	wait for 104 us;
	
	
	-- send "10010110"
	data <= '1';
	wait for 104 us;
	
	data <= '0';
	wait for 104 us;
	
	
	data <= '0';
	wait for 104 us;
	
	data <= '1';
	wait for 104 us;
	
	data <= '0';
	wait for 104 us;
	
	data <= '1';
	wait for 104 us;
	
	data <= '1';
	wait for 104 us;
	
	data <= '0';
	wait for 104 us;
	
	
	
	data <= '1';			-- idle
	wait for 312.5 us;
	
	
	
	
	
      
   end process;

END;
