--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   03:55:01 11/21/2023
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/Xilinx ISE/Y4 HDL/RS232_Rx/Tx_testbench.vhd
-- Project Name:  RS232_Rx
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: Tx
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
 
ENTITY Tx_testbench IS
END Tx_testbench;
 
ARCHITECTURE behavior OF Tx_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Tx
    PORT(
         switch : IN  std_logic_vector(7 downto 0);
         button : IN  std_logic;
         clk : IN  std_logic;
         data_out : OUT  std_logic;
         state_debug : OUT  std_logic_vector(3 downto 0);
         send_debug : OUT  std_logic;
			clk_9600_debug : OUT std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal switch : std_logic_vector(7 downto 0) := (others => '0');
   signal button : std_logic := '0';
   signal clk : std_logic := '0';

 	--Outputs
   signal data_out : std_logic;
   signal state_debug : std_logic_vector(3 downto 0);
   signal send_debug : std_logic;
	signal clk_9600_debug : std_logic;

   
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Tx PORT MAP (
          switch => switch,
          button => button,
          clk => clk,
          data_out => data_out,
          state_debug => state_debug,
          send_debug => send_debug,
			 clk_9600_debug => clk_9600_debug
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
	
	
		switch <= "10010110";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 1 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
		
		
		switch <= "10101010";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 1 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
		
		
		
		
		
		switch <= "11001100";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 1 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
		
		
		
		switch <= "01100110";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 1 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
		
		
		
		
		switch <= "00000000";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 3 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
		
		
		
		
		
		switch <= "11111111";
		wait for 312.5 us;
		
		
		button <= '1';
		wait for 0.1 ms;
		
		button <= '0';
		wait for 1 ms;
		
		
      
   end process;

END;
