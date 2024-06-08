----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 02:42:26 PM
-- Design Name: 
-- Module Name: Memoire_des_donnees_tb - Behavioral
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

entity Memoire_des_donnees_tb is
end Memoire_des_donnees_tb;
 
architecture Behavioral of Memoire_des_donnees_tb is
    component Memoire_des_donnees
    Port ( adr : in STD_LOGIC_VECTOR (7 downto 0);
           Input : in STD_LOGIC_VECTOR (7 downto 0);
           Rw : in STD_LOGIC;
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Output : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal adr_tb, Input_tb, Output_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal Rw_tb, Rst_tb, Clk_tb : STD_LOGIC;
    
    constant CLK_PERIOD : time := 50 ns; -- Clock period

begin
    DUT: Memoire_des_donnees
    port map (
        adr => adr_tb,
        Input => Input_tb,
        Rw => Rw_tb,
        Rst => Rst_tb,
        Clk => Clk_tb,
        Output => Output_tb
    );
    
    process
        begin
            
            adr_tb <= x"00";
            Input_tb <= x"ff";
            Rw_tb <= '1';
            Rst_tb <= '0';
            
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            Rst_tb <= '1';
            Rw_tb <= '0';
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            
            Clk_tb <= '1';
            Rw_tb <= '1';
            wait for CLK_PERIOD;
            Clk_tb <= '0';
            Rw_tb <= '0';
            wait for CLK_PERIOD;
            
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            Clk_tb <= '0';
            Rw_tb <= '1';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            
            wait;
        end process;
end Behavioral;
