----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/17/2024 08:32:37 AM
-- Design Name: 
-- Module Name: Chemin_des_donnees - Behavioral
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

entity Chemin_des_donnees is
    Port (
    rst : in STD_LOGIC;
    A_Out : out std_logic_vector(7 downto 0);
    B_Out : out std_logic_vector(7 downto 0);
    Clk : in STD_LOGIC);
end Chemin_des_donnees;

architecture Behavioral of Chemin_des_donnees is

signal AdrOut_mem_instruct : STD_LOGIC_VECTOR(31 downto 0);
signal ip : STD_LOGIC_VECTOR(7 downto 0) := x"ff";
signal Clk_mem_instruct : STD_LOGIC;

signal adrA_reg, adrB_reg, adrW_reg : STD_LOGIC_VECTOR(3 downto 0);
signal W_reg, Rst_reg, Clk_reg : STD_LOGIC;
signal Data_reg, QA_reg, QB_reg : STD_LOGIC_VECTOR(7 downto 0);

signal A_alu, B_alu, S_alu : STD_LOGIC_VECTOR(7 downto 0);
signal Carry_alu, Overflow_alu, Negatif_alu : STD_LOGIC;
signal Control_alu : STD_LOGIC_VECTOR(2 downto 0);

signal A_LI_DI, A_DI_EX, A_EX_Mem, A_Mem_RE : STD_LOGIC_VECTOR (7 downto 0); 
signal OP_LI_DI, OP_DI_EX, OP_EX_Mem, OP_Mem_RE : STD_LOGIC_VECTOR (7 downto 0); 
signal B_LI_DI, B_DI_EX, B_EX_Mem, B_Mem_RE : STD_LOGIC_VECTOR (7 downto 0); 
signal C_LI_DI, C_DI_EX : STD_LOGIC_VECTOR (7 downto 0); 

signal tmp_etage2_B, tmp_etage2_C, tmp_etage3_B, tmp_etage4_B : STD_LOGIC_VECTOR (7 downto 0); 

signal adr_memDon, Input_memDon, Output_memDon : STD_LOGIC_VECTOR(7 downto 0);
signal Rw_memDon, Rst_memDon, Clk_memDon : STD_LOGIC;

signal alea : STD_LOGIC_VECTOR(2 downto 0) := "111";

begin

Mem_Instruction: entity work.Memoire_des_instructions
    port map (
        adr => ip,
        Clk => Clk_mem_instruct,
        Output => AdrOut_mem_instruct
    );
    
Banc_de_registre: entity work.Banc_de_registres
    port map (
        adrA => adrA_reg,
        adrB => adrB_reg,
        adrW => adrW_reg,
        W => W_reg,
        Rst => Rst_reg,
        Data => Data_reg,
        Clk => Clk_reg,
        QA => QA_reg,
        QB => QB_reg
    );
    
ALU_8bit: entity work.ALU_8bit
    port map (
        A => A_alu,
        B => B_alu,
        S => S_alu,
        C => Carry_alu,
        O => Overflow_alu,
        N => Negatif_alu,
        Control => Control_alu
    );
    
Memoire_des_donnees: entity work.Memoire_des_donnees
    port map (
        adr => adr_memDon,
        Input => Input_memDon,
        Rw => Rw_memDon,
        Rst => Rst_memDon,
        Clk => Clk_memDon,
        Output => Output_memDon
    );
    
 ---- Output sync ----
A_Out <= A_Mem_RE;
B_Out <= B_Mem_RE;
Rst_memDon <= rst;
Rst_reg <= rst;

---- Clock synchronization ----
Clk_reg <= Clk;
Clk_memDon <= Clk;
Clk_mem_instruct <= Clk;

---- Banc de registre ----
-- We need to write to the register when the Operation is 1,2,3,4,5,6 or 7
W_reg <= '1' when OP_Mem_RE = x"01" OR OP_Mem_RE = x"02" OR OP_Mem_RE = x"03" OR OP_Mem_RE = x"05" OR OP_Mem_RE = x"06" OR OP_Mem_RE = x"07" else '0';
adrW_reg <= A_Mem_RE (3 downto 0);
Data_reg <= B_Mem_RE;
    -- MUX
adrA_reg <= B_LI_DI (3 downto 0);
adrB_reg <= C_LI_DI (3 downto 0);
tmp_etage2_B <= QA_reg when OP_LI_DI = x"05" OR OP_LI_DI = x"01" OR OP_LI_DI = x"02" OR OP_LI_DI = x"03" OR OP_LI_DI = x"08" else B_LI_DI;
tmp_etage2_C <= QB_reg;
---- ALU ----
A_alu <= B_DI_EX;
B_alu <= C_DI_EX;
    -- ALU LC
Control_alu <=
    "000" when OP_DI_EX = x"01" else
    "010" when OP_DI_EX = x"02" else
    "001" when OP_DI_EX = x"03";
    -- ALU MUX
tmp_etage3_B <= S_alu when (OP_DI_EX = x"01" OR OP_DI_EX = x"02" OR OP_DI_EX = x"03") else B_DI_EX;

---- Memoire des donnees ----
    -- First MUX, STORE
adr_memDon <= A_EX_Mem when (OP_EX_Mem = x"08") else B_EX_Mem;   
Input_memDon <= B_EX_Mem;
    -- LC, LOAD, STORE
Rw_memDon <='0' when OP_EX_Mem = x"08" else '1';
-- Second MUX
tmp_etage4_B  <= Output_memDon when OP_EX_Mem = x"07" OR OP_EX_Mem = x"08" else B_EX_Mem;

etage_propagation: process
variable alea : std_logic_vector (2 downto 0) := "111";
begin
    wait until Clk'event and Clk = '1';
    
    -- Etage 1 - 2
    -- Mapping from input adr
    OP_LI_DI <= AdrOut_mem_instruct (31 downto 24);
    A_LI_DI <= AdrOut_mem_instruct (23 downto 16);
    B_LI_DI <= AdrOut_mem_instruct (15 downto 8);
    C_LI_DI <= AdrOut_mem_instruct (7 downto 0);
    
    -- Alea check --
   
    if (AdrOut_mem_instruct (31 downto 24) = x"05"
     OR AdrOut_mem_instruct (31 downto 24) = x"01"
     OR AdrOut_mem_instruct (31 downto 24) = x"02"
     OR AdrOut_mem_instruct (31 downto 24) = x"03"
     ) then -- COP, ADD, MUL, SOU
    
        if ((OP_LI_DI = x"05"
         OR OP_LI_DI = x"01"
         OR OP_LI_DI = x"02"
         OR OP_LI_DI = x"03"
         OR OP_LI_DI = x"06") 
         AND (A_LI_DI = AdrOut_mem_instruct (15 downto 8) OR A_LI_DI = AdrOut_mem_instruct (7 downto 0))) then -- case of cop right after afc
            alea := "000";
        elsif ((OP_DI_EX = x"05"
         OR OP_DI_EX = x"01"
         OR OP_DI_EX = x"02"
         OR OP_DI_EX = x"03"
         OR OP_DI_EX = x"06") 
         AND (A_DI_EX = AdrOut_mem_instruct (15 downto 8) OR A_DI_EX = AdrOut_mem_instruct (7 downto 0))) then -- case cop one etage after afc
            alea := "001";
        elsif ((OP_EX_Mem = x"05"
         OR OP_EX_Mem = x"01"
         OR OP_EX_Mem = x"02"
         OR OP_EX_Mem = x"03"
         OR OP_EX_Mem = x"06") 
         AND (A_EX_Mem = AdrOut_mem_instruct (15 downto 8) OR A_EX_Mem = AdrOut_mem_instruct (7 downto 0))) then -- case cop two etage after afc
            alea := "010";
        elsif ((OP_Mem_RE = x"05"
         OR OP_Mem_RE = x"01"
         OR OP_Mem_RE = x"02"
         OR OP_Mem_RE = x"03"
         OR OP_Mem_RE = x"06") 
         AND (A_Mem_RE = AdrOut_mem_instruct (15 downto 8) OR A_Mem_RE = AdrOut_mem_instruct (7 downto 0))) then -- case cop third etage after afc
            alea := "011";
        end if;
    end if;
    
    if (alea < "100") then
    
        -- Etage 1 - 2
            -- NOP (00000000)
        OP_LI_DI <= x"00";
        A_LI_DI <= x"00";
        B_LI_DI <= x"00";
        C_LI_DI <= x"00";
        
        -- Increment alea
        alea := std_logic_vector(unsigned(alea) + 1);
    else
    -- If no alea, increment ip 
        ip <= std_logic_vector(unsigned(ip) + 1);
    end if;    
    
    -- Etage 2 - 3
    OP_DI_EX <= OP_LI_DI;
    A_DI_EX <= A_LI_DI;
    B_DI_EX <= tmp_etage2_B;
    C_DI_EX <= tmp_etage2_C;  
    
    -- Etage 3 - 4
    OP_EX_Mem <= OP_DI_EX;
    A_EX_Mem <= A_DI_EX;
    B_EX_Mem <= tmp_etage3_B;
    
    -- Etage 4 - 5
    OP_Mem_RE <= OP_EX_Mem;
    A_Mem_RE <= A_EX_Mem;
    B_Mem_RE <= B_EX_Mem;
    
end process;

end Behavioral;
