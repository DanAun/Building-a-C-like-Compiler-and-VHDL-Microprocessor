----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:27:33 PM
-- Design Name: 
-- Module Name: Memoire_des_donnees - Behavioral
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

entity Memoire_des_donnees is
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Input : in STD_LOGIC_VECTOR (7 downto 0);
           Rw : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
end Memoire_des_donnees;

architecture Behavioral of Memoire_des_donnees is
type Memoire_array is array (0 to 255) of STD_LOGIC_VECTOR (7 downto 0);
signal memoire : Memoire_array;
begin

process
    begin
    
        wait until Clk'event and Clk = '1';
        if (Rst = '0') then
            for i in Memoire_array'RANGE loop
                memoire(i) <= x"00";
            end loop;
        else
            if (Rw = '1') then
                -- Read
                Output <= memoire(TO_INTEGER(unsigned(adr)));
            else
                -- Write
                memoire(TO_INTEGER(unsigned(adr))) <= Input;
            end if;
        end if;
        
    end process;
end Behavioral;
