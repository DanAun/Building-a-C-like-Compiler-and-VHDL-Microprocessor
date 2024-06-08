----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 12:43:49 PM
-- Design Name: 
-- Module Name: Banc_de_registres - Behavioral
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

entity Banc_de_registres is
    Port ( adrA : in STD_LOGIC_VECTOR (3 downto 0);
           adrB : in STD_LOGIC_VECTOR (3 downto 0);
           adrW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
end Banc_de_registres;

architecture Behavioral of Banc_de_registres is
type Banc_array is array (0 to 15) of STD_LOGIC_VECTOR (7 downto 0);
signal banc : Banc_array;
begin

QA <= banc(TO_INTEGER(unsigned(adrA)));
QB <= banc(TO_INTEGER(unsigned(adrB)));

process
    begin
           
        wait until Clk'event and Clk = '1';
        if (Rst = '0') then
            for i in Banc_array'RANGE loop
                banc(i) <= x"00";
            end loop;
        else
            if (W = '1') then
                banc(TO_INTEGER(unsigned(adrW))) <= Data;
            end if;
        end if;
    
    end process;

end Behavioral;
