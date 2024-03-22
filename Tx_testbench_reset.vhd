--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:39:52 12/20/2023
-- Design Name:   
-- Module Name:   C:/Users/ACER/Desktop/Xilinx ISE/Y4 HDL/RS232_w_Reset/Tx_testbench_reset.vhd
-- Project Name:  RS232_w_Reset
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
 
ENTITY Tx_testbench_reset IS
END Tx_testbench_reset;
 
ARCHITECTURE behavior OF Tx_testbench_reset IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Tx
    PORT(
         switch : IN  std_logic_vector(7 downto 0);
         button : IN  std_logic;
         clk : IN  std_logic;
         data_out : OUT  std_logic;
         tx_reset : IN  std_logic;
         clk_9600_debug : OUT  std_logic;
         state_debug : OUT  std_logic_vector(3 downto 0);
         send_debug : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal switch : std_logic_vector(7 downto 0) := (others => '0');
   signal button : std_logic := '0';
   signal clk : std_logic := '0';
   signal tx_reset : std_logic := '0';

 	--Outputs
   signal data_out : std_logic;
   signal clk_9600_debug : std_logic;
   signal state_debug : std_logic_vector(3 downto 0);
   signal send_debug : std_logic;


  
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Tx PORT MAP (
          switch => switch,
          button => button,
          clk => clk,
          data_out => data_out,
          tx_reset => tx_reset,
          clk_9600_debug => clk_9600_debug,
          state_debug => state_debug,
          send_debug => send_debug
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
		
		tx_reset <= '1';
		wait for 10 us;
		tx_reset <= '0';
		wait for 10 us;
	
		switch <= "01001011";			
		wait for 200 us;
		button <= '1';
		wait for 100 us;
		button <= '0';
		wait for 10 ms;
   end process;

END;
