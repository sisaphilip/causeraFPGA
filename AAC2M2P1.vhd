

--work of Philip Sisa M. sisaphilip@gmail.com

--4bit counter

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
use ieee. std_logic_arith.all;
use ieee. std_logic_unsigned.all;


entity AAC2M2P1 is port (                 	
     CP: 	in std_logic; 	-- clock
     SR:  in std_logic;  -- Active low, synchronous reset
      P:  in std_logic_vector(3 downto 0);  -- Parallel input
     PE:  in std_logic;  -- Parallel Enable (Load)
    CEP:  in std_logic;  -- Count enable parallel input
    CET:  in std_logic; -- Count enable trickle input
   
      Q:  out std_logic_vector(3 downto 0);            			
     TC:  out std_logic  -- Terminal Count
);            		
end AAC2M2P1;

--architecture

architecture AAC2M2P1arc of AAC2M2P1 is 
--signals
   signal J0,K0,Q0,NQ0,A : std_logic;
   signal and01,and02,and03,and04,nor01,nor02 : std_logic;
   --signals inputs
   signal INV_CEP, INV_CET, and00,nand00,nor001,nor002 : std_logic;
   --signals stage 1
   signal J1,K1,Q1,NQ1,B : std_logic;      
   signal and11,and12,and13,and14,nor11,nor12 : std_logic;
   
  --signals stage2 
   signal J2,K2,Q2,NQ2,C : std_logic;      
   signal and21,and22,and23,and24,nor21,nor22 : std_logic;
   --stages3 signals
   signal J3,K3,Q3,NQ3,D : std_logic;      
   signal and31,and32,and33,and34,nor31,nor32 : std_logic;
   
begin
  --outer inputs
      and00   <= SR and SR;
      nand00  <= and00 nand PE;
      INV_CEP <= not CEP;
      INV_CET <= not CET;
      nor001  <= not(INV_CET or INV_CEP or nand00);
      nor002  <= not (INV_CET or NQ0 or NQ1 or NQ3 or NQ2);
      TC      <= nor002;

   --stage0
      and01  <= Q0 and nor001;
      and02  <= nand00 and nor02;
      nor01  <= and01 nor and02;
      K0     <= nor01;


      and03  <= (A and and00 and nand00);
      and04  <= nor001 and NQ0;
      nor02  <= and03 nor and04;
      J0     <= nor02;


   --0jkff
   PROCESS(CP)
   variable TMP0: std_logic;
   variable CLOCK: std_logic := not CP;
   

begin
if(CLOCK ='1' and CLOCK'EVENT) then
if(J0='0' and K0='0')then
TMP0:= TMP0;
elsif(J0='1' and K0='1')then
TMP0:= not TMP0;
elsif(J0='0' and K0='1')then
TMP0:='0';
else
TMP0:='1';
end if;
end if;
Q0  <= TMP0;
NQ0 <= not TMP0;
end PROCESS;


--stage1

      and11  <= (Q1 and nor001 and Q0);
      and12  <= nand00 and nor12;
      nor11  <= and11 nor and12;
      K1     <= nor11;

      and13  <= (B and and00 and nand00);
      and14  <= (Q0 and nor001 and NQ1);
      nor12  <= and13 nor and14;
      J1     <= nor12;
PROCESS(CP)
   variable TMP1: std_logic;
   variable CLOCK: std_logic := not CP;
   

begin
if(CLOCK ='1' and CLOCK'EVENT) then
if(J1='0' and K1='0')then
TMP1:= TMP1;
elsif(J1='1' and K1='1')then
TMP1:= not TMP1;
elsif(J1='0' and K1='1')then
TMP1:='0';
else
TMP1:='1';
end if;
end if;
Q1  <= TMP1;
NQ1 <= not TMP1;
end PROCESS;

--stage2
      and21  <= (Q2 and nor001 and Q1 and Q0);
      and22  <= nand00 and nor22;
      nor21  <= and22 nor and21;
      K2     <= nor21;

      and23  <= (C and and00 and nand00);     
      and24  <= (Q0 and Q1 and nor001 and NQ2);                                                        
      nor22  <= and23 nor and24;                                                                
      J2     <= nor22;                                                                          
PROCESS(CP)                                                                                     
   variable TMP2: std_logic;                                                                    
   variable CLOCK: std_logic := not CP;                                                         
                                                                                                
                                                                                                
begin                                                                                           
if(CLOCK ='1' and CLOCK'EVENT) then                                                             
if(J2='0' and K2='0')then
TMP2:= TMP2;
elsif(J2='1' and K2='1')then
TMP2:= not TMP2;
elsif(J2='0' and K2='1')then
TMP2:='0';
else
TMP2:='1';
end if;
end if;
Q2  <= TMP2;
NQ2 <= not TMP2;
end PROCESS;


--stage3
      and31  <= (Q3 and nor001 and Q2 and Q1 and Q0);
      and32  <= nand00 and nor32;
      nor31  <= and31 nor and32;
      K3     <= nor31;                   
                                         
      and33  <= (D and and00 and nand00);     
      and34  <= (Q0 and Q1 and nor001 and NQ3 and Q2);                                                  
      nor32  <= and33 nor and34;                                                                
      J3     <= nor32;                                                                          
PROCESS(CP)                                                                                     
   variable TMP3: std_logic;                                                                    
   variable CLOCK: std_logic := not CP;                                                         
                                                                                                
                                                                                                
begin                                                                                           
if(CLOCK ='1' and CLOCK'EVENT) then                                                             
if(J3='0' and K3='0')then
TMP3 := TMP3;
elsif(J3='1' and K3='1')then
TMP3:= not TMP3;
elsif(J3='0' and K3='1')then
TMP3 :='0';
else
TMP3 :='1';
end if;
end if;
Q3  <= TMP3;
NQ3 <= not TMP3;
end PROCESS;



 Q <= Q0 & Q1 & Q2 & Q3;
end AAC2M2P1arc;


