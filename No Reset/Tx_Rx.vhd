----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:13:16 11/24/2023 
-- Design Name: 
-- Module Name:    Tx_Rx - Behavioral 
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



entity Tx_Rx is
    Port ( clk_50MHz : in  STD_LOGIC;
           rx_data_in : in  STD_LOGIC;
           tx_data_out : out  STD_LOGIC;
           rx_digits : out  STD_LOGIC_VECTOR (3 downto 0);
           rx_segments : out  STD_LOGIC_VECTOR (7 downto 0);
           tx_switch : in  STD_LOGIC_VECTOR (7 downto 0);
           tx_button : in  STD_LOGIC);
end Tx_Rx;

architecture Behavioral of Tx_Rx is

-- component declaration
component Tx is
    Port ( switch : in  STD_LOGIC_VECTOR (7 downto 0);		-- connect to 8 toggle switches
			  button : in STD_LOGIC;									-- connect to one of the button to send data
           clk : in  STD_LOGIC;										-- 50MHz
           data_out : out  STD_LOGIC;
			  
			  clk_9600_debug : out STD_LOGIC;
			  state_debug : out STD_LOGIC_VECTOR (3 downto 0);
			  send_debug : out STD_LOGIC
			  );
end component;



component Rx_7Segment is
    Port ( rx_clk : in  STD_LOGIC;
           rx_data : in  STD_LOGIC;
			  segments : out STD_LOGIC_VECTOR (7 downto 0);
			  digits : out STD_LOGIC_VECTOR (3 downto 0)
			  );
end component;


signal clksig : STD_LOGIC;


begin


tx1 : Tx port map(switch => tx_switch,
						button => tx_button,
						clk => clk_50MHz,
						data_out => tx_data_out
							);
							
							
rx1 : Rx_7Segment port map(rx_clk => clk_50MHz,
									rx_data => rx_data_in,
									segments => rx_segments,
									digits => rx_digits
									);







end Behavioral;

