-- Simple DDS tone generator.
-- 13-bit tuning word
-- 16-bit phase register
-- 65536 x 8-bit ROM.
-- Additional Features:
-- Alternate Waveforms (Square)
-- Smoothed notes with reduced clicking


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
	-- Register to drive the address input of the ROM
	SIGNAL phase_register : STD_LOGIC_VECTOR(15	DOWNTO 0); --16 bits same as bus
	-- Register to hold the step size of the address incrementation
	SIGNAL tuning_word    : STD_LOGIC_VECTOR(12 DOWNTO 0); -- 13 bits
	-- Signal to carry the output of the ROM
	SIGNAL sounddata      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	-- Signal to carry the output of the SQUARE wave ROM
	SIGNAL sounddataSQ      : STD_LOGIC_VECTOR(7 DOWNTO 0);
	
	
BEGIN

	-- ROM to hold the waveform
	SOUND_LUT : altsyncram
	GENERIC MAP (
		lpm_type => "altsyncram",
		width_a => 8,
		widthad_a => 16,
		numwords_a => 65536, -- Size of sine wave
		--
		-- TO USE DIFFERENT WAVEFORMS: replace "SOUND_SINE.mif" with "SOUND_SQUARE.mif"
		--
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
		address_a => phase_register(15 downto 0),
		q_a => sounddata -- output is amplitude
	);

	
	-- 8-bit sound data is used as bits 12-5 of the 16-bit output.
	-- This is to prevent the output from being too loud.
	
	L_DATA(15 DOWNTO 13) <= sounddata(7)&sounddata(7)&sounddata(7); -- sign extend
	L_DATA(12 DOWNTO 5) <= sounddata;
	L_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
--	L_DATA(15 DOWNTO 13) <= sounddataSQ(7)&sounddataSQ(7)&sounddataSQ(7); -- sign extend
--	L_DATA(12 DOWNTO 5) <= sounddataSQ;
--	L_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
--	
	
	-- Right channel is the same.
	R_DATA(15 DOWNTO 13) <= sounddata(7)&sounddata(7)&sounddata(7); -- sign extend
	R_DATA(12 DOWNTO 5) <= sounddata;
	R_DATA(4 DOWNTO 0) <= "00000"; -- pad right side with 0s
	
	
		-- process to perform DDS
	PROCESS(SAMPLE_CLK, RESETN) BEGIN
		IF RESETN = '0' THEN
			phase_register <= "0000000000000000";
		ELSIF RISING_EDGE(SAMPLE_CLK) THEN
			IF tuning_word = "0000000000000" THEN 
				phase_register <= "0000000000000000";
			ELSE
				-- Increment the phase register by the tuning word.
					phase_register <= phase_register + ("000" & tuning_word);
			END IF;
		END IF;
	END PROCESS;
	
	
	-- process to latch command data from SCOMP
	PROCESS(RESETN, cs) BEGIN
		IF RESETN = '0' THEN
			tuning_word <= "0000000000000"; -- Replace 0 with Frequency of first note

		END IF;
		
		--
		-- Active at any time CS ='1', not just rising edges, which stops the clicking
		--
		IF CS = '1' THEN
		--
		--	Ideally frequency -> function -> tuning word value -> phase register -> sound
		--
		
		
		--
		-- ***HOW TO ADD NOTES***
		
		--
		-- To create a note with a desired frequency, use formula below to find tuning word:
		--
		--	[ (Desired Frequency) X (2^16) ] / 48000  = tuning word
		--
		--
		-- >> Convert the decimal tuning word to binary, and assign it to "tuning_word" as can be seen above
		--	>> The "when" condition that sets the tuning word is what you will set your notes to. in order to output note in ASM
		-- >> You can choose any conditions for your new notes, as long as they haven't been used already
		-- >> Tuning word: 13 bits
		-- >> Note Conditon: 7 bits (can be controlled by switches 0-6)
		--
		--
		-- EXAMPLE:
		-- When a value of "0000010" is passed into peripheral, whether through switch combinations or an ASM load,
		-- the tuning word is set to "0000010010110", which then sets the phase register to a value that plays the note 
		-- "A2" when indexed on the sin wave
		--
		CASE CMD(6 DOWNTO 0) is

		when "0000000"=> tuning_word <= "0000000000000"; -- silent
 		when "0000001"=> tuning_word <= "0000010001110"; -- G2Sharp A2Flat
		when "0000010"=> tuning_word <= "0000010010110"; -- A2
		when "0000011"=> tuning_word <= "0000010011111"; -- A2Sharp B2Flat
		when "0000100"=> tuning_word <= "0000010101001"; -- B2
		when "0000101"=> tuning_word <= "0000010110011"; -- C3
		when "0000110"=> tuning_word <= "0000010111101"; -- C3Sharp D3Flat
		when "0000111"=> tuning_word <= "0000011011100"; -- D3
		when "0001000"=> tuning_word <= "0000011010100"; -- D3Sharp E3Flat
		when "0001001"=> tuning_word <= "0000011100001"; -- E3
		when "0001010"=> tuning_word <= "0000011101110"; -- F3
		when "0001011"=> tuning_word <= "0000011111101"; -- F3Sharp G3Flat
		when "0001100"=> tuning_word <= "0000100001100"; -- G3
		when "0001101"=> tuning_word <= "0000100011100"; -- G3Sharp A3Flat
		when "0001110"=> tuning_word <= "0000100101100"; -- A3
		when "0001111"=> tuning_word <= "0000100111110"; -- A3Sharp B3Flat
		when "0010000"=> tuning_word <= "0000101010001"; -- B3
		when "0010001"=> tuning_word <= "0000101100101"; -- C4
		when "0010010"=> tuning_word <= "0000101111010"; -- C4Sharp D4Flat
		when "0010011"=> tuning_word <= "0000110010001"; -- D4
		when "0010100"=> tuning_word <= "0000110101001"; -- D4Sharp E4Flat
		when "0010101"=> tuning_word <= "0000111000010"; -- E4
		when "0010110"=> tuning_word <= "0000111011101"; -- F4
		when "0010111"=> tuning_word <= "0000111111001"; -- F4Sharp G4Flat
		when "0011000"=> tuning_word <= "0001000010111"; -- G4
		when "0011001"=> tuning_word <= "0001000110111"; -- G4Sharp A4Flat
		when "0011010"=> tuning_word <= "0001001011001"; -- A4
		when "0011011"=> tuning_word <= "0001001111100"; -- A4Sharp B4Flat
		when "0011100"=> tuning_word <= "0001010100010"; -- B4
		when "0011101"=> tuning_word <= "0001011001011"; -- C5
		when "0011110"=> tuning_word <= "0001011110101"; -- C5Sharp, D5Flat
		when "0011111"=> tuning_word <= "0001110000100"; -- E5
		when "0100000"=> tuning_word <= "0001110111010"; -- F5
		when "0100001"=> tuning_word <= "0001111110010"; -- F5Sharp G5Flat
		when "0100010"=> tuning_word <= "0010000101110"; -- G5
		when "0100011"=> tuning_word <= "0010001101110"; -- G5Sharp A5Flat
		when "0100100"=> tuning_word <= "0010010110001"; -- A5
		when "0100101"=> tuning_word <= "0010011111001"; -- A5Sharp B5Flat
		when "0100110"=> tuning_word <= "0010101000101"; -- B5
		when "0100111"=> tuning_word <= "0010110010101"; -- C6
		when "0101000"=> tuning_word <= "0010111101010"; -- C6Sharp D6Flat
		when "0101001"=> tuning_word <= "0011001000100"; -- D6
		when "0101010"=> tuning_word <= "0011010100011"; -- D6Sharp, E6Flat
		when "0101011"=> tuning_word <= "0011100001000"; -- E6
		when "0101100"=> tuning_word <= "0011101110011"; -- F6
		when "0101101"=> tuning_word <= "0011111100101"; -- F6Sharp G6Flat
		when "0101110"=> tuning_word <= "0100001011101"; -- G6
		when "0101111"=> tuning_word <= "0100101100011"; -- A6
		when "0110000"=> tuning_word <= "0100111110010"; -- A6Sharp B6Flat
		when "0110001"=> tuning_word <= "0101010001001"; -- B6
		when "0110010"=> tuning_word <= "0101100101010"; -- C7
		when "0110011"=> tuning_word <= "0101111010100"; -- C7Sharp D7Flat
		when "0110100"=> tuning_word <= "0110010001000"; -- D7
		when "0110101"=> tuning_word <= "0110101000110"; -- D7Sharp E7Flat
		when "0110110"=> tuning_word <= "0111000010000"; -- E7
		when "0110111"=> tuning_word <= "0111011100111"; -- F7
		when "0111000"=> tuning_word <= "0111111001001"; -- F7Sharp G7Flat
		when "0111001"=> tuning_word <= "1001011000110"; -- A7
		when "0111010"=> tuning_word <= "1001111100100"; -- A7Sharp B7Flat
		when "0111011"=> tuning_word <= "1010100010011"; -- B7
		when "0111100"=> tuning_word <= "1011001010011"; -- C8
		when "0111101"=> tuning_word <= "1011110100111"; -- C8Sharp D8Flat
		when "0111110"=> tuning_word <= "1100100001111"; -- D8
		when "0111111"=> tuning_word <= "1101010001101"; -- D8Sharp E8Flat
		
		
		when others => tuning_word <= tuning_word;
		END CASE;
		END IF;
	END PROCESS;
END gen;