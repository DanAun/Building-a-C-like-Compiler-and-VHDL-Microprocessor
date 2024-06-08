----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/22/2024 09:15:48 AM
-- Design Name: 
-- Module Name: Chemin_des_donnees_tb - Behavioral
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

entity Chemin_des_donnees_tb is
end Chemin_des_donnees_tb;
 
architecture Behavioral of Chemin_des_donnees_tb is
    component Chemin_des_donnees
    Port ( A_Out, B_Out : out STD_LOGIC_VECTOR (7 downto 0);
           Clk, rst : in STD_LOGIC);
    end component;

    signal A_Out_tb, B_Out_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal Clk_tb, rst_tb : STD_LOGIC;
    
    constant CLK_PERIOD : time := 10 ns; -- Clock period

begin
    DUT: Chemin_des_donnees
    port map (
        Clk => Clk_tb,
        rst => rst_tb,
        A_Out => A_Out_tb,
        B_Out => B_Out_tb
    );
    
    process
        begin
        
            rst_tb <= '0';
            -- TESTING AFC BEGIN
        
            -- AFC
            --adrOut_tb <= x"06000000";
            
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            rst_tb <= '1';
            -- AFC
            --adrOut_tb <= x"06010100";
            
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- AFC
            --adrOut_tb <= x"06020200";
            
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- AFC
            --adrOut_tb <= x"06030300";
            
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- TESTING AFC END
            
            -- TESTING COP BEGIN
            
            -- COP
            --adrOut_tb <= x"05040000";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- TESTING COP END
            
            -- Wait length of pipe-line to let last instruction finish
            for i in 0 to 3 loop
                -- Nothing
                --adrOut_tb <= x"00000000";
                Clk_tb <= '0';
                wait for CLK_PERIOD;
                Clk_tb <= '1';
                wait for CLK_PERIOD;
            end loop;
            
            -- TESTING ADD, SUB, MUL BEGIN
            
            -- ADD
            --adrOut_tb <= x"01050100";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- ADD
            --adrOut_tb <= x"01060001";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- SUB
            --adrOut_tb <= x"03070302";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- SUB
            --adrOut_tb <= x"03080203";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- MUL
            --adrOut_tb <= x"02090203";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- MUL
            --adrOut_tb <= x"020a0003";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- TESTING ADD, SUB, MUL END
            
            -- TESTING LOAD, STORE BEGIN
            
            -- STORE
            --adrOut_tb <= x"08000000";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- STORE
            --adrOut_tb <= x"08010100";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;          

            -- STORE
            --adrOut_tb <= x"08020200";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;
            
            -- LOAD
            --adrOut_tb <= x"070b0200";
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            Clk_tb <= '1';
            wait for CLK_PERIOD;  

            -- Wait length of pipe-line to let last instruction finish
            for i in 0 to 30 loop
                -- Nothing
                --adrOut_tb <= x"00000000";
                Clk_tb <= '0';
                wait for CLK_PERIOD;
                Clk_tb <= '1';
                wait for CLK_PERIOD;
            end loop;
            
            Clk_tb <= '0';
            wait for CLK_PERIOD;
            
            wait;
        end process;
end Behavioral;
