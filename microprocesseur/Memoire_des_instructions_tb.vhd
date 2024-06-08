----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:43:23 PM
-- Design Name: 
-- Module Name: Memoire_des_instructions_tb - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Memoire_des_instructions_tb is
end Memoire_des_instructions_tb;

architecture Behavioral of Memoire_des_instructions_tb is
    component Memoire_des_instructions
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Clk : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (31 downto 0));
    end component;
    
    signal adr_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal Clk_tb : STD_LOGIC;
    signal Output_tb : STD_LOGIC_VECTOR(31 downto 0);
    
    constant CLK_PERIOD : time := 50 ns; -- Clock period

begin
    DUT: Memoire_des_instructions
    port map (
        adr => adr_tb,
        Clk => Clk_tb,
        Output => Output_tb
    );
    
    process
        begin
            
            adr_tb <= x"00";
            
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            
            adr_tb <= x"05";
            
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            
            
            wait;
        end process;
end Behavioral;
