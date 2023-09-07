LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY LPM;
USE LPM.LPM_COMPONENTS.ALL;

ENTITY DAC_INTERFACE IS
	PORT(
		SOUND_DAT_L : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		SOUND_DAT_R : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
		DAC_WCLK    : IN STD_LOGIC;
		DAC_BCLK    : IN STD_LOGIC;
		DAC_DAT     : OUT STD_LOGIC
	);
END DAC_INTERFACE;

ARCHITECTURE a OF DAC_INTERFACE IS
	
	BEGIN
	
	-- shift register to serialize the data to the DAC
	serialize : lpm_shiftreg
	GENERIC MAP (
		lpm_direction => "LEFT",
		lpm_type => "LPM_SHIFTREG",
		lpm_width => 32
	)
	PORT MAP (
		load => DAC_WCLK,
		clock => NOT(DAC_BCLK), -- update data on falling edges
		data => SOUND_DAT_L & SOUND_DAT_R, -- Shift out left and right data
		shiftout => DAC_DAT
	);

			
END a;






