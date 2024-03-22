----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    01:42:26 11/21/2023 
-- Design Name: 
-- Module Name:    Tx - Behavioral 
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




--NET "switch[7]" LOC = R17;
--NET "switch[6]" LOC = N17;
--NET "switch[5]" LOC = L13;
--NET "switch[4]" LOC = L14;
--NET "switch[3]" LOC = K17;
--NET "switch[2]" LOC = K18;
--NET "switch[1]" LOC = H18;
--NET "switch[0]" LOC = G18;
--NET "button" LOC = B18;
--NET "clk" LOC = B8;
--NET "data_out" LOC = P9;



-- working successfully
-- no reset



entity Tx is
    Port ( switch : in  STD_LOGIC_VECTOR (7 downto 0);		-- connect to 8 toggle switches
			  button : in STD_LOGIC;									-- connect to one of the button to send data
           clk : in  STD_LOGIC;										-- 50MHz
           data_out : out  STD_LOGIC;
			  
			  clk_9600_debug : out STD_LOGIC;
			  state_debug : out STD_LOGIC_VECTOR (3 downto 0);
			  send_debug : out STD_LOGIC
			  );
end Tx;



architecture Behavioral of Tx is

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

signal clk_9600, clk_38400 : STD_LOGIC;

signal state : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

signal send : STD_LOGIC := '0';

signal pressed : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');



begin







		-- seems working
		-- no reset

		process (clk_9600, button)
		begin
		
				if (clk_9600' event and clk_9600 = '1') then
				
						pressed(1) <= button;
						pressed(0) <= pressed(1);
				
				
						if (pressed(1) = '1' and pressed(0) = '0') then		-- detect rising edge of button signal to avoid sending a continuous burst of signal 
						
								send <= '1';			-- start sending
						end if;
						
						
				
						if (send = '1') then			-- sending process
						
								state <= state + '1';
								
								
								case state is
										
										when "0000" => data_out <= '0'; 				-- start bit
										when "0001" => data_out <= switch(0);		-- bit 0 (LSB)
										when "0010" => data_out <= switch(1);		-- bit 1
										when "0011" => data_out <= switch(2);		-- bit 2
										when "0100" => data_out <= switch(3);		-- bit 3
										when "0101" => data_out <= switch(4);		-- bit 4
										when "0110" => data_out <= switch(5);		-- bit 5
										when "0111" => data_out <= switch(6);		-- bit 6
										when "1000" => data_out <= switch(7);		-- bit 7 (MSB)
										when others => data_out <= '1';				-- needed for syntax 
										
								end case;
									
--								-- with-select cannot used in process?
--								
--								with state select
--						
--								data_out <= 
--						
--								'0' when "0000",	-- start bit
--								switch(0) when "0001",	-- bit 0 (LSB)
--								switch(1) when "0010",	-- bit 1
--								switch(2) when "0011",	-- bit 2
--								switch(3) when "0100",	-- bit 3
--								switch(4) when "0101",	-- bit 4
--								switch(5) when "0110",	-- bit 5
--								switch(6) when "0111",	-- bit 6
--								switch(7) when "1000";	-- bit 7 (MSB)
--								--'1' when others;
								
								
								
								if (state = "1000") then
								
										state <= "0000";
										send <= '0';
								end if;
							
							
						else 
								data_out <= '1';
						
						end if;
				end if;
		end process;
		
		
		state_debug <= state;
		send_debug <= send;
		clk_9600_debug <= clk_9600;







clk_div1 : clk_div_38400 port map( clk_in => clk,					-- 50MHz 
												clk_out => clk_38400 );		-- 38400Hz
												
												
clk_div2 : Clock_divider port map( clk_in => clk_38400,			-- 38400Hz
												clk_out_d4 => clk_9600 ); 	-- 9600Hz




end Behavioral;

