----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:29:26 PM
-- Design Name: 
-- Module Name: Memoire_des_instructions - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memoire_des_instructions is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (31 downto 0));
end Memoire_des_instructions;

architecture Behavioral of Memoire_des_instructions is
type Memoire_array is array (0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
signal memoire : Memoire_array := ( X"06040300", X"05000400", X"06040400", X"05030400", X"06040800", X"05020400", X"05040000", X"05050300", X"01040405", X"05050000", X"05060200", X"01050506", X"02040405", X"05010400", others => X"00000000");
begin

process
    begin
    
        wait until Clk'event and Clk = '1';
        Output <= memoire(TO_INTEGER(unsigned(adr)));
        
    end process;
end Behavioral;
