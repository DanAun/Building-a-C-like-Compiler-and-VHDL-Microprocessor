----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/07/2024 01:16:16 PM
-- Design Name: 
-- Module Name: Banc_de_registres_tb - Behavioral
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

entity Banc_de_registres_tb is
end Banc_de_registres_tb;

architecture Behavioral of Banc_de_registres_tb is
    component Banc_de_registres
        Port ( adrA : in STD_LOGIC_VECTOR (3 downto 0);
           adrB : in STD_LOGIC_VECTOR (3 downto 0);
           adrW : in STD_LOGIC_VECTOR (3 downto 0);
           W : in STD_LOGIC;
           Data : in STD_LOGIC_VECTOR (7 downto 0);
           Rst : in STD_LOGIC;
           Clk : in STD_LOGIC;
           QA : out STD_LOGIC_VECTOR (7 downto 0);
           QB : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    signal adrA_tb, adrB_tb, adrW_tb : STD_LOGIC_VECTOR(3 downto 0);
    signal W_tb, Rst_tb, Clk_tb : STD_LOGIC;
    signal Data_tb, QA_tb, QB_tb : STD_LOGIC_VECTOR(7 downto 0);
    
    constant CLK_PERIOD : time := 50 ns; -- Clock period

begin
    DUT: Banc_de_registres
    port map (
        adrA => adrA_tb,
        adrB => adrB_tb,
        adrW => adrW_tb,
        W => W_tb,
        Data => Data_tb,
        Rst => Rst_tb,
        Clk => Clk_tb,
        QA => QA_tb,
        QB => QB_tb
    );

    process
    begin
    
        adrA_tb <= "0100";
        adrB_tb <= "1001";
        Rst_tb <= '0';
        Data_tb <= x"ff";
        W_tb <= '0';
        adrW_tb <= "0100";
        wait for CLK_PERIOD;
    
        for i in 0 to 3 loop
            Clk_tb <= '1';

            wait for CLK_PERIOD;
            Clk_tb <= '0';
            Rst_tb <= '1';
            W_tb <= '1';
            wait for CLK_PERIOD;
        end loop;
        
        
    
        wait;
    end process;

end Behavioral;
