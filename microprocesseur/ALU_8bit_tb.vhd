----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2024 12:43:43 PM
-- Design Name: 
-- Module Name: ALU_8bit_Greaker_tb - Behavioral
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

entity ALU_8bit_tb is
end ALU_8bit_tb;

architecture Behavioral of ALU_8bit_tb is
    component ALU_8bit
        Port (
            A, B : in STD_LOGIC_VECTOR (7 downto 0);
            S : out STD_LOGIC_VECTOR (7 downto 0);
            C, O, N : out STD_LOGIC;
            Control : in STD_LOGIC_VECTOR(2 downto 0)
        );
    end component;

    signal A_tb, B_tb, S_tb : STD_LOGIC_VECTOR(7 downto 0);
    signal Carry_tb, Overflow_tb, Negatif_tb : STD_LOGIC;
    signal Control_tb : STD_LOGIC_VECTOR(2 downto 0);
   
begin
    DUT: ALU_8bit
    port map (
        A => A_tb,
        B => B_tb,
        S => S_tb,
        C => Carry_tb,
        O => Overflow_tb,
        N => Negatif_tb,
        Control => Control_tb
    );


    process
    begin
    
        A_tb <= x"02";
        B_tb <= x"01";
        Control_tb <= "000"; -- Testing addition (should give 0x03)
        wait for 50 ns;
        Control_tb <= "001"; -- Testing substraction
        wait for 50 ns;
        Control_tb <= "010"; -- Testing multiplication
        wait for 50 ns;
        wait for 50 ns;
        A_tb <= x"01";
        B_tb <= x"02";
        Control_tb <= "000"; -- Testing addition (should give 0x03)
        wait for 50 ns;
        Control_tb <= "001"; -- Testing substraction
        wait for 50 ns;
        Control_tb <= "010"; -- Testing multiplication
        wait for 50 ns;       
        
        
        
        
        Control_tb <= "011"; -- Testing AND
        wait for 50 ns;
        Control_tb <= "100"; -- Testing OR
        wait for 50 ns;
        Control_tb <= "101"; -- Testing XOR
        wait for 50 ns;
        Control_tb <= "110"; -- Testing NOT
        wait for 50 ns;
        
        -- Testing raising Carry flag
        A_tb <= "11111111";
        B_tb <= "00000001";
        Control_tb <= "000";
        wait for 50 ns;
       
        -- Testing raising Overflow flag
        A_tb <= "11111111";
        B_tb <= "00000010";
        Control_tb <= "010";
        wait for 50 ns;
        
         -- Testing raising Negatif flag
        A_tb <= "00001001";
        B_tb <= "00100101";
        Control_tb <= "001";
        wait for 50 ns;
         
         -- Testing raising Zero flag
        A_tb <= "00000000";
        B_tb <= "00000000";
        Control_tb <= "001";
        wait for 50 ns;
        
        wait;
    end process;
   
end Behavioral;
