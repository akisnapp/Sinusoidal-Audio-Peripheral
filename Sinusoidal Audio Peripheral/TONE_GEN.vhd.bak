-- Simple DDS tone generator.
-- 5-bit tuning word
-- 9-bit phase register
-- 256 x 8-bit ROM.

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

LIBRARY ALTERA_MF;
USE ALTERA_MF.ALTERA_MF_COMPONENTS.ALL;


ENTITY TONE_GEN IS 
	PORT
	(
		CMD        : IN  STD_LOGIC_VECTOR(15 DOWNTO 0);
		CS         : IN  STD_LOGIC;
		SAMPLE_CLK : IN  STD_LOGIC;
		RESETN     : IN  STD_LOGIC;
		L_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
		R_DATA     : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END TONE_GEN;

ARCHITECTURE gen OF TONE_GEN IS 

	SIGNAL phase_register : STD_LOGIC_VECTOR(8 DOWNTO 0);
	SIGNAL tuning_word    : STD_LOGIC_VECTOR(4 DOWNTO 0);
	SIGNAL sounddata      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
BEGIN

	-- ROM to hold the waveform
	SOUND_LUT : altsyncram
	GENERIC MAP (
		lpm_type => "altsyncram",
		width_a => 8,
		widthad_a => 8,
		numwords_a => 256,
		init_file => "SOUND_SINE.mif",
		intended_device_family => "Cyclone II",
		lpm_hint => "ENABLE_RUNTIME_MOD=NO",
		operation_mode => "ROM",
		outdata_aclr_a => "NONE",
		outdata_reg_a => "UNREGISTERED",
		power_up_uninitialized => "FALSE"
	)
	PORT MAP (
		clock0 => NOT(SAMPLE_CLK),
		-- In this design, one bit of the phase register is a fractional bit
		address_a => phase_register(8 downto 1),
		q_a => sounddata -- output is amplitude
	);
	
	-- 8-bit sound data is used as bits 12-5 of the 16-bit output.
	-- This is to prevent the output from being too loud.
	L_DATA(15 DOWNTO 13) <= sounddata(7)&sounddata(7)&sounddata(7); -- sign extend
	L_DATA(12 DOWNTO 5) <= sounddata;
	L_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
	-- Right channel is the same.
	R_DATA(15 DOWNTO 13) <= sounddata(7)&sounddata(7)&sounddata(7); -- sign extend
	R_DATA(12 DOWNTO 5) <= sounddata;
	R_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
	-- process to perform DDS
	PROCESS(RESETN, SAMPLE_CLK) BEGIN
		IF RESETN = '0' THEN
			phase_register <= "000000000";
		ELSIF RISING_EDGE(SAMPLE_CLK) THEN
			IF tuning_word = "00000" THEN  -- if command is 0, return to 0 output.
				phase_register <= "000000000";
			ELSE
				-- Increment the phase register by the tuning word.
				phase_register <= phase_register + ("0000" & tuning_word);
			END IF;
		END IF;
	END PROCESS;

	-- process to latch command data from SCOMP
	PROCESS(RESETN, CS) BEGIN
		IF RESETN = '0' THEN
			tuning_word <= "00000";
		ELSIF RISING_EDGE(CS) THEN
			tuning_word <= CMD(4 DOWNTO 0);
		END IF;
	END PROCESS;
END gen;