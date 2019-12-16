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

-- DATE "12/15/2019 19:35:31"

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

ENTITY 	decrementer IS
    PORT (
	input : IN std_logic_vector(3 DOWNTO 0);
	output : OUT std_logic_vector(3 DOWNTO 0);
	carry_out : OUT std_logic
	);
END decrementer;

-- Design Ports Information
-- output[0]	=>  Location: PIN_M4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[1]	=>  Location: PIN_A6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[2]	=>  Location: PIN_L4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- output[3]	=>  Location: PIN_M6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- carry_out	=>  Location: PIN_N4,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[0]	=>  Location: PIN_N6,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[1]	=>  Location: PIN_A7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[2]	=>  Location: PIN_A8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- input[3]	=>  Location: PIN_B6,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF decrementer IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_input : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_output : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_carry_out : std_logic;
SIGNAL \output[0]~output_o\ : std_logic;
SIGNAL \output[1]~output_o\ : std_logic;
SIGNAL \output[2]~output_o\ : std_logic;
SIGNAL \output[3]~output_o\ : std_logic;
SIGNAL \carry_out~output_o\ : std_logic;
SIGNAL \input[0]~input_o\ : std_logic;
SIGNAL \input[1]~input_o\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:1:HSUX|output~combout\ : std_logic;
SIGNAL \input[2]~input_o\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:2:HSUX|output~combout\ : std_logic;
SIGNAL \input[3]~input_o\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:3:HSUX|output~combout\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:3:HSUX|c_out~combout\ : std_logic;
SIGNAL \ALT_INV_input[0]~input_o\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_c_out~combout\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_output~combout\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:2:HSUX|ALT_INV_output~combout\ : std_logic;
SIGNAL \GENERATE_HALF_ADDER_UNITS:1:HSUX|ALT_INV_output~combout\ : std_logic;

BEGIN

ww_input <= input;
output <= ww_output;
carry_out <= ww_carry_out;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;
\ALT_INV_input[0]~input_o\ <= NOT \input[0]~input_o\;
\GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_c_out~combout\ <= NOT \GENERATE_HALF_ADDER_UNITS:3:HSUX|c_out~combout\;
\GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_output~combout\ <= NOT \GENERATE_HALF_ADDER_UNITS:3:HSUX|output~combout\;
\GENERATE_HALF_ADDER_UNITS:2:HSUX|ALT_INV_output~combout\ <= NOT \GENERATE_HALF_ADDER_UNITS:2:HSUX|output~combout\;
\GENERATE_HALF_ADDER_UNITS:1:HSUX|ALT_INV_output~combout\ <= NOT \GENERATE_HALF_ADDER_UNITS:1:HSUX|output~combout\;

-- Location: IOOBUF_X8_Y0_N2
\output[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \ALT_INV_input[0]~input_o\,
	devoe => ww_devoe,
	o => \output[0]~output_o\);

-- Location: IOOBUF_X10_Y31_N2
\output[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \GENERATE_HALF_ADDER_UNITS:1:HSUX|ALT_INV_output~combout\,
	devoe => ww_devoe,
	o => \output[1]~output_o\);

-- Location: IOOBUF_X8_Y0_N9
\output[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \GENERATE_HALF_ADDER_UNITS:2:HSUX|ALT_INV_output~combout\,
	devoe => ww_devoe,
	o => \output[2]~output_o\);

-- Location: IOOBUF_X12_Y0_N9
\output[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_output~combout\,
	devoe => ww_devoe,
	o => \output[3]~output_o\);

-- Location: IOOBUF_X10_Y0_N9
\carry_out~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \GENERATE_HALF_ADDER_UNITS:3:HSUX|ALT_INV_c_out~combout\,
	devoe => ww_devoe,
	o => \carry_out~output_o\);

-- Location: IOIBUF_X12_Y0_N1
\input[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(0),
	o => \input[0]~input_o\);

-- Location: IOIBUF_X12_Y31_N1
\input[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(1),
	o => \input[1]~input_o\);

-- Location: LCCOMB_X12_Y12_N8
\GENERATE_HALF_ADDER_UNITS:1:HSUX|output\ : cycloneiv_lcell_comb
-- Equation(s):
-- \GENERATE_HALF_ADDER_UNITS:1:HSUX|output~combout\ = \input[0]~input_o\ $ (\input[1]~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011110000111100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \input[0]~input_o\,
	datac => \input[1]~input_o\,
	combout => \GENERATE_HALF_ADDER_UNITS:1:HSUX|output~combout\);

-- Location: IOIBUF_X12_Y31_N8
\input[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(2),
	o => \input[2]~input_o\);

-- Location: LCCOMB_X12_Y12_N2
\GENERATE_HALF_ADDER_UNITS:2:HSUX|output\ : cycloneiv_lcell_comb
-- Equation(s):
-- \GENERATE_HALF_ADDER_UNITS:2:HSUX|output~combout\ = \input[2]~input_o\ $ (((\input[1]~input_o\) # (\input[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001111000011110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \input[1]~input_o\,
	datab => \input[0]~input_o\,
	datac => \input[2]~input_o\,
	combout => \GENERATE_HALF_ADDER_UNITS:2:HSUX|output~combout\);

-- Location: IOIBUF_X14_Y31_N8
\input[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_input(3),
	o => \input[3]~input_o\);

-- Location: LCCOMB_X12_Y12_N28
\GENERATE_HALF_ADDER_UNITS:3:HSUX|output\ : cycloneiv_lcell_comb
-- Equation(s):
-- \GENERATE_HALF_ADDER_UNITS:3:HSUX|output~combout\ = \input[3]~input_o\ $ (((\input[1]~input_o\) # ((\input[0]~input_o\) # (\input[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \input[1]~input_o\,
	datab => \input[0]~input_o\,
	datac => \input[2]~input_o\,
	datad => \input[3]~input_o\,
	combout => \GENERATE_HALF_ADDER_UNITS:3:HSUX|output~combout\);

-- Location: LCCOMB_X12_Y12_N6
\GENERATE_HALF_ADDER_UNITS:3:HSUX|c_out\ : cycloneiv_lcell_comb
-- Equation(s):
-- \GENERATE_HALF_ADDER_UNITS:3:HSUX|c_out~combout\ = (\input[1]~input_o\) # ((\input[0]~input_o\) # ((\input[2]~input_o\) # (\input[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111111111110",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \input[1]~input_o\,
	datab => \input[0]~input_o\,
	datac => \input[2]~input_o\,
	datad => \input[3]~input_o\,
	combout => \GENERATE_HALF_ADDER_UNITS:3:HSUX|c_out~combout\);

ww_output(0) <= \output[0]~output_o\;

ww_output(1) <= \output[1]~output_o\;

ww_output(2) <= \output[2]~output_o\;

ww_output(3) <= \output[3]~output_o\;

ww_carry_out <= \carry_out~output_o\;
END structure;


