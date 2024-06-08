----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2024 12:41:12 PM
-- Design Name: 
-- Module Name: ALU_8bit_Greaker - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_8bit is
    Port ( A : in STD_LOGIC_VECTOR (7 downto 0);
           B : in STD_LOGIC_VECTOR (7 downto 0);
           S : out STD_LOGIC_VECTOR (7 downto 0);
           C : out STD_LOGIC;
           O : out STD_LOGIC;
           N : out STD_LOGIC;
           Z : out STD_LOGIC;
           Control : in STD_LOGIC_VECTOR (2 downto 0));
end ALU_8bit;

architecture Behavioral of ALU_8bit is
signal tmp_res : std_logic_vector(16 downto 0) := '0' & x"0000";
begin

C <= '1' when tmp_res(8) = '1' else '0';
N <= '1' when (B > A and Control = "001") else '0';
O <= '1' when tmp_res(16 downto 8) > x"00" else '0';
Z <= '1' when tmp_res(7 downto 0) = x"00" else '0';

process (A, B, Control)
    begin
            
        case Control is
        when "000" => --Addition
            tmp_res <= x"00" & (('0' & A) + ('0' & B));
            
        when "001" => --Substraction
            tmp_res <= '0' & x"00" & (A - B);  
            
        when "010" => --Multiplicaton
            tmp_res <= '0' & (A * B);
            
                                  
        
        when "011" => --AND
            tmp_res <= '0' & x"00" & (A AND B);
            
        when "100" => --OR
            tmp_res <= '0' & x"00" & (A OR B);
            
        when "101" => --XOR
            tmp_res <= '0' & x"00" & (A XOR B);
            
        when "110" => --NOT (I interperated this as NOT A)
            tmp_res <= '0' & x"00" & (NOT A);
        
        
            
        when others => -- Should never happen
        end case;
                     
    end process;
    
S <= tmp_res(7 downto 0);

end Behavioral;
