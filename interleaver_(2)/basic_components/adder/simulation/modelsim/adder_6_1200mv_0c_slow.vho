-- Copyright (C) 1991-2012 Altera Corporation
-- Your use of Altera Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Altera Program License 
-- Subscription Agreement, Altera MegaCore Function License 
-- Agreement, or other applicable license agreement, including, 
-- without limitation, that your use is for the sole purpose of 
-- programming logic devices manufactured by Altera and sold by 
-- Altera or its authorized distributors.  Please refer to the 
-- applicable agreement for further details.

-- VENDOR "Altera"
-- PROGRAM "Quartus II 32-bit"
-- VERSION "Version 12.0 Build 178 05/31/2012 SJ Web Edition"

-- DATE "11/20/2019 07:43:30"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	adder IS
    PORT (
	en : IN std_logic;
	i_operand_0 : IN std_logic_vector(3 DOWNTO 0);
	i_operand_1 : IN std_logic_vector(3 DOWNTO 0);
	o_result : OUT std_logic_vector(3 DOWNTO 0);
	o_carry : OUT std_logic
	);
END adder;

-- Design Ports Information
-- o_result[0]	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_result[1]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_result[2]	=>  Location: PIN_M11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_result[3]	=>  Location: PIN_N10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_carry	=>  Location: PIN_N11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- en	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_1[0]	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_0[0]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_1[1]	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_0[1]	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_1[2]	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_0[2]	=>  Location: PIN_K11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_1[3]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_operand_0[3]	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF adder IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_en : std_logic;
SIGNAL ww_i_operand_0 : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_i_operand_1 : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_o_result : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_o_carry : std_logic;
SIGNAL \i_operand_1[0]~input_o\ : std_logic;
SIGNAL \i_operand_1[1]~input_o\ : std_logic;
SIGNAL \i_operand_1[2]~input_o\ : std_logic;
SIGNAL \i_operand_0[3]~input_o\ : std_logic;
SIGNAL \o_result[0]~output_o\ : std_logic;
SIGNAL \o_result[1]~output_o\ : std_logic;
SIGNAL \o_result[2]~output_o\ : std_logic;
SIGNAL \o_result[3]~output_o\ : std_logic;
SIGNAL \o_carry~output_o\ : std_logic;
SIGNAL \en~input_o\ : std_logic;
SIGNAL \i_operand_0[0]~input_o\ : std_logic;
SIGNAL \output[0]~0_combout\ : std_logic;
SIGNAL \Add0~0_combout\ : std_logic;
SIGNAL \i_operand_0[1]~input_o\ : std_logic;
SIGNAL \output[0]~1\ : std_logic;
SIGNAL \output[1]~2_combout\ : std_logic;
SIGNAL \Add0~1_combout\ : std_logic;
SIGNAL \i_operand_0[2]~input_o\ : std_logic;
SIGNAL \output[1]~3\ : std_logic;
SIGNAL \output[2]~4_combout\ : std_logic;
SIGNAL \Add0~2_combout\ : std_logic;
SIGNAL \i_operand_1[3]~input_o\ : std_logic;
SIGNAL \output[2]~5\ : std_logic;
SIGNAL \output[3]~6_combout\ : std_logic;
SIGNAL \Add0~3_combout\ : std_logic;
SIGNAL \output[3]~7\ : std_logic;
SIGNAL \Add0~4_combout\ : std_logic;
SIGNAL \Add0~6_combout\ : std_logic;

BEGIN

ww_en <= en;
ww_i_operand_0 <= i_operand_0;
ww_i_operand_1 <= i_operand_1;
o_result <= ww_o_result;
o_carry <= ww_o_carry;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOIBUF_X33_Y12_N8
\i_operand_1[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_1(0),
	o => \i_operand_1[0]~input_o\);

-- Location: IOIBUF_X33_Y10_N8
\i_operand_1[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_1(1),
	o => \i_operand_1[1]~input_o\);

-- Location: IOIBUF_X33_Y15_N1
\i_operand_1[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_1(2),
	o => \i_operand_1[2]~input_o\);

-- Location: IOIBUF_X33_Y10_N1
\i_operand_0[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_0(3),
	o => \i_operand_0[3]~input_o\);

-- Location: IOOBUF_X22_Y0_N9
\o_result[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~0_combout\,
	devoe => ww_devoe,
	o => \o_result[0]~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\o_result[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~1_combout\,
	devoe => ww_devoe,
	o => \o_result[1]~output_o\);

-- Location: IOOBUF_X29_Y0_N9
\o_result[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~2_combout\,
	devoe => ww_devoe,
	o => \o_result[2]~output_o\);

-- Location: IOOBUF_X26_Y0_N9
\o_result[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~3_combout\,
	devoe => ww_devoe,
	o => \o_result[3]~output_o\);

-- Location: IOOBUF_X26_Y0_N2
\o_carry~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \Add0~6_combout\,
	devoe => ww_devoe,
	o => \o_carry~output_o\);

-- Location: IOIBUF_X33_Y11_N8
\en~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_en,
	o => \en~input_o\);

-- Location: IOIBUF_X33_Y14_N1
\i_operand_0[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_0(0),
	o => \i_operand_0[0]~input_o\);

-- Location: LCCOMB_X29_Y9_N0
\output[0]~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \output[0]~0_combout\ = (\i_operand_1[0]~input_o\ & (\i_operand_0[0]~input_o\ $ (VCC))) # (!\i_operand_1[0]~input_o\ & (\i_operand_0[0]~input_o\ & VCC))
-- \output[0]~1\ = CARRY((\i_operand_1[0]~input_o\ & \i_operand_0[0]~input_o\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110011010001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_operand_1[0]~input_o\,
	datab => \i_operand_0[0]~input_o\,
	datad => VCC,
	combout => \output[0]~0_combout\,
	cout => \output[0]~1\);

-- Location: LCCOMB_X29_Y9_N26
\Add0~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~0_combout\ = (\en~input_o\ & \output[0]~0_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \en~input_o\,
	datad => \output[0]~0_combout\,
	combout => \Add0~0_combout\);

-- Location: IOIBUF_X33_Y12_N1
\i_operand_0[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_0(1),
	o => \i_operand_0[1]~input_o\);

-- Location: LCCOMB_X29_Y9_N2
\output[1]~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \output[1]~2_combout\ = (\i_operand_1[1]~input_o\ & ((\i_operand_0[1]~input_o\ & (\output[0]~1\ & VCC)) # (!\i_operand_0[1]~input_o\ & (!\output[0]~1\)))) # (!\i_operand_1[1]~input_o\ & ((\i_operand_0[1]~input_o\ & (!\output[0]~1\)) # 
-- (!\i_operand_0[1]~input_o\ & ((\output[0]~1\) # (GND)))))
-- \output[1]~3\ = CARRY((\i_operand_1[1]~input_o\ & (!\i_operand_0[1]~input_o\ & !\output[0]~1\)) # (!\i_operand_1[1]~input_o\ & ((!\output[0]~1\) # (!\i_operand_0[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \i_operand_1[1]~input_o\,
	datab => \i_operand_0[1]~input_o\,
	datad => VCC,
	cin => \output[0]~1\,
	combout => \output[1]~2_combout\,
	cout => \output[1]~3\);

-- Location: LCCOMB_X29_Y9_N28
\Add0~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~1_combout\ = (\output[1]~2_combout\ & \en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \output[1]~2_combout\,
	datac => \en~input_o\,
	combout => \Add0~1_combout\);

-- Location: IOIBUF_X33_Y11_N1
\i_operand_0[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_0(2),
	o => \i_operand_0[2]~input_o\);

-- Location: LCCOMB_X29_Y9_N4
\output[2]~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \output[2]~4_combout\ = ((\i_operand_1[2]~input_o\ $ (\i_operand_0[2]~input_o\ $ (!\output[1]~3\)))) # (GND)
-- \output[2]~5\ = CARRY((\i_operand_1[2]~input_o\ & ((\i_operand_0[2]~input_o\) # (!\output[1]~3\))) # (!\i_operand_1[2]~input_o\ & (\i_operand_0[2]~input_o\ & !\output[1]~3\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0110100110001110",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \i_operand_1[2]~input_o\,
	datab => \i_operand_0[2]~input_o\,
	datad => VCC,
	cin => \output[1]~3\,
	combout => \output[2]~4_combout\,
	cout => \output[2]~5\);

-- Location: LCCOMB_X29_Y9_N30
\Add0~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~2_combout\ = (\en~input_o\ & \output[2]~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en~input_o\,
	datac => \output[2]~4_combout\,
	combout => \Add0~2_combout\);

-- Location: IOIBUF_X33_Y15_N8
\i_operand_1[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_operand_1(3),
	o => \i_operand_1[3]~input_o\);

-- Location: LCCOMB_X29_Y9_N6
\output[3]~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \output[3]~6_combout\ = (\i_operand_0[3]~input_o\ & ((\i_operand_1[3]~input_o\ & (\output[2]~5\ & VCC)) # (!\i_operand_1[3]~input_o\ & (!\output[2]~5\)))) # (!\i_operand_0[3]~input_o\ & ((\i_operand_1[3]~input_o\ & (!\output[2]~5\)) # 
-- (!\i_operand_1[3]~input_o\ & ((\output[2]~5\) # (GND)))))
-- \output[3]~7\ = CARRY((\i_operand_0[3]~input_o\ & (!\i_operand_1[3]~input_o\ & !\output[2]~5\)) # (!\i_operand_0[3]~input_o\ & ((!\output[2]~5\) # (!\i_operand_1[3]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1001011000010111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	dataa => \i_operand_0[3]~input_o\,
	datab => \i_operand_1[3]~input_o\,
	datad => VCC,
	cin => \output[2]~5\,
	combout => \output[3]~6_combout\,
	cout => \output[3]~7\);

-- Location: LCCOMB_X29_Y9_N24
\Add0~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~3_combout\ = (\output[3]~6_combout\ & \en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \output[3]~6_combout\,
	datac => \en~input_o\,
	combout => \Add0~3_combout\);

-- Location: LCCOMB_X29_Y9_N8
\Add0~4\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~4_combout\ = !\output[3]~7\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000111100001111",
	sum_lutc_input => "cin")
-- pragma translate_on
PORT MAP (
	cin => \output[3]~7\,
	combout => \Add0~4_combout\);

-- Location: LCCOMB_X29_Y9_N18
\Add0~6\ : cycloneiv_lcell_comb
-- Equation(s):
-- \Add0~6_combout\ = (\en~input_o\ & \Add0~4_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en~input_o\,
	datac => \Add0~4_combout\,
	combout => \Add0~6_combout\);

ww_o_result(0) <= \o_result[0]~output_o\;

ww_o_result(1) <= \o_result[1]~output_o\;

ww_o_result(2) <= \o_result[2]~output_o\;

ww_o_result(3) <= \o_result[3]~output_o\;

ww_o_carry <= \o_carry~output_o\;
END structure;


