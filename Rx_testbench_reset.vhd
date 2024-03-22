--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   22:15:22 12/14/2023
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/Xilinx ISE/Y4 HDL/RS232_w_Reset/Rx_testbench_reset.vhd
-- Project Name:  RS232_w_Reset
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
 
ENTITY Rx_testbench_reset IS
END Rx_testbench_reset;
 
ARCHITECTURE behavior OF Rx_testbench_reset IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Rx
    PORT(
         clk : IN  std_logic;
         data : IN  std_logic;
         reset : IN  std_logic;
         disp0 : OUT  std_logic_vector(3 downto 0);
         disp1 : OUT  std_logic_vector(3 downto 0);
         cl9600_deb : OUT  std_logic;
         idle_deb : OUT  std_logic;
         datareg_deb : OUT  std_logic_vector(7 downto 0);
         count8_deb : OUT  std_logic_vector(2 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal data : std_logic := '1';
   signal reset : std_logic := '0';

 	--Outputs
   signal disp0 : std_logic_vector(3 downto 0);
   signal disp1 : std_logic_vector(3 downto 0);
   signal cl9600_deb : std_logic;
   signal idle_deb : std_logic;
   signal datareg_deb : std_logic_vector(7 downto 0);
   signal count8_deb : std_logic_vector(2 downto 0);

   -- Clock period definitions
   --constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Rx PORT MAP (
          clk => clk,
          data => data,
          reset => reset,
          disp0 => disp0,
          disp1 => disp1,
          cl9600_deb => cl9600_deb,
          idle_deb => idle_deb,
          datareg_deb => datareg_deb,
          count8_deb => count8_deb
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
	
	wait for 10 us;
	reset <= '1';
	wait for 4 us;
	reset <= '0';
	wait for 4 us;




	
   data <= '1';			-- idle
	wait for 312.5 us;
	
	data <= '0';			-- start bit
	wait for 104 us;
	
	-- send "01010001"
	data <= '1';			-- LSB 
	wait for 104 us;
	data <= '0';
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
	data <= '0';			-- MSB
	wait for 104 us;
	
	data <= '1';			-- return to idle
	wait for 500 us;
	
	
	
	
	
	-- 2nd cycle (with reset)
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
	
--	reset <= '1';
--	wait for 4 us;
--	reset <= '0';
	
	
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
