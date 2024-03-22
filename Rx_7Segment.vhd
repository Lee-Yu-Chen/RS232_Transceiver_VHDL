----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:25:44 11/22/2023 
-- Design Name: 
-- Module Name:    Rx_7Segment - Behavioral 
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






--NET "digits[3]" LOC = F15;
--NET "digits[2]" LOC = C18;
--NET "digits[1]" LOC = H17;
--NET "digits[0]" LOC = F17;
--NET "segments[7]" LOC = L18;
--NET "segments[6]" LOC = F18;
--NET "segments[5]" LOC = D17;
--NET "segments[4]" LOC = D16;
--NET "segments[3]" LOC = G14;
--NET "segments[2]" LOC = J17;
--NET "segments[1]" LOC = H14;
--NET "segments[0]" LOC = C17;
--NET "rx_clk" LOC = B8;
--NET "rx_data" LOC = U6;



-- working successfully 
-- no reset
-- this code configure the Rx to the 7segment display




entity Rx_7Segment is
    Port ( rx_clk : in  STD_LOGIC;
           rx_data : in  STD_LOGIC;
			  rx_reset : in STD_LOGIC;
			  segments : out STD_LOGIC_VECTOR (7 downto 0);
			  digits : out STD_LOGIC_VECTOR (3 downto 0)
			  );
end Rx_7Segment;





architecture Behavioral of Rx_7Segment is

-- component declaration
component Rx is
    Port ( clk : in STD_LOGIC;			-- 50MHz clock
			  data : in  STD_LOGIC;
			  reset : in STD_LOGIC;
			  disp0 : out STD_LOGIC_VECTOR (3 downto 0);
			  disp1 : out STD_LOGIC_VECTOR (3 downto 0);
			  
			  cl9600_deb : out STD_LOGIC;
			  
			  idle_deb : out STD_LOGIC;
			  
			  
			  datareg_deb : out STD_LOGIC_VECTOR (7 downto 0);
			  count8_deb : out STD_LOGIC_VECTOR (2 downto 0)			  
			  );
end component;





component Clock_divider is
    Port ( clk_in : in  STD_LOGIC;
           clk_out_d2 : out  STD_LOGIC;
			  clk_out_d4 : out  STD_LOGIC;
			  clk_out_d8 : out  STD_LOGIC;
			  clk_out_d16 : out  STD_LOGIC);
end component;






-- signal declaration

signal four_bits0 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
signal four_bits1 : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');

signal digit0 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
signal digit1 : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');

signal clksig0, clksig1, clksig2, clksig3 : STD_LOGIC;

signal count : STD_LOGIC;


begin


		process (clksig3)
		begin
				if (clksig3' event and clksig3 = '1') then
				
						count <= not count;
				end if;
		end process;

		
		
		
		with count select 
		
		digits <=
		"1110" when '0',		-- 1 is off and 0 is on
		"1101" when '1',
		"1111" when others;
		
		
		
		with count select
		
		segments <=
		digit0 when '0',
		digit1 when '1',
		"10101010" when others;
		
		
		
		with four_bits0 select
		
		digit0 <=
		"00000011" when "0000", -- 0
		"10011111" when "0001", -- 1
		"00100101" when "0010", -- 2
		"00001101" when "0011", -- 3
		"10011001" when "0100", -- 4
		"01001001" when "0101", -- 5
		"01000001" when "0110", -- 6
		"00011111" when "0111", -- 7
		"00000001" when "1000", -- 8
		"00001001" when "1001",	-- 9
		"00010001" when "1010", -- A
		"11000001" when "1011", -- b
		"01100011" when "1100", -- C
		"10000101" when "1101", -- d
		"01100001" when "1110", -- E
		"01110001" when "1111", -- F
		"11111110" when others;
		
		
		with four_bits1 select
		
		digit1 <=
		"00000011" when "0000", -- 0
		"10011111" when "0001", -- 1
		"00100101" when "0010", -- 2
		"00001101" when "0011", -- 3
		"10011001" when "0100", -- 4
		"01001001" when "0101", -- 5
		"01000001" when "0110", -- 6
		"00011111" when "0111", -- 7
		"00000001" when "1000", -- 8
		"00001001" when "1001",	-- 9
		"00010001" when "1010", -- A
		"11000001" when "1011", -- b
		"01100011" when "1100", -- C
		"10000101" when "1101", -- d
		"01100001" when "1110", -- E
		"01110001" when "1111", -- F
		"11111110" when others;











rx1 : Rx port map(clk => rx_clk,
						data => rx_data,
						reset => rx_reset,
						disp0 => four_bits0,
						disp1 => four_bits1);
						
														 
														 
														 
														 
														 
clk_div1 : Clock_divider port map (clk_in => rx_clk,
												clk_out_d16 => clksig0);
												
												
clk_div2 : Clock_divider port map (clk_in => clksig0,
												clk_out_d16 => clksig1);
												

clk_div3 : Clock_divider port map (clk_in => clksig1,
												clk_out_d16 => clksig2);
												
												
												
clk_div4 : Clock_divider port map (clk_in => clksig2,
												clk_out_d16 => clksig3);
														 
														 
														 


end Behavioral;

