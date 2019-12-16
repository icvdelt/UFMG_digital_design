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

-- DATE "12/15/2019 20:05:27"

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

ENTITY 	comparator IS
    PORT (
	en : IN std_logic;
	i_ref : IN std_logic_vector(3 DOWNTO 0);
	i_data : IN std_logic_vector(3 DOWNTO 0);
	lt : OUT std_logic;
	eq : OUT std_logic
	);
END comparator;

-- Design Ports Information
-- lt	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- eq	=>  Location: PIN_K8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- en	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ref[3]	=>  Location: PIN_K12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data[3]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ref[1]	=>  Location: PIN_K11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ref[0]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data[0]	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data[1]	=>  Location: PIN_L13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data[2]	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ref[2]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF comparator IS
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
SIGNAL ww_i_ref : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_i_data : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_lt : std_logic;
SIGNAL ww_eq : std_logic;
SIGNAL \i_ref[0]~input_o\ : std_logic;
SIGNAL \lt~output_o\ : std_logic;
SIGNAL \eq~output_o\ : std_logic;
SIGNAL \i_data[1]~input_o\ : std_logic;
SIGNAL \i_ref[1]~input_o\ : std_logic;
SIGNAL \i_data[0]~input_o\ : std_logic;
SIGNAL \lt~1_combout\ : std_logic;
SIGNAL \i_ref[2]~input_o\ : std_logic;
SIGNAL \i_data[2]~input_o\ : std_logic;
SIGNAL \lt~2_combout\ : std_logic;
SIGNAL \en~input_o\ : std_logic;
SIGNAL \i_ref[3]~input_o\ : std_logic;
SIGNAL \i_data[3]~input_o\ : std_logic;
SIGNAL \lt~3_combout\ : std_logic;
SIGNAL \lt~0_combout\ : std_logic;
SIGNAL \eq~0_combout\ : std_logic;
SIGNAL \eq~1_combout\ : std_logic;

BEGIN

ww_en <= en;
ww_i_ref <= i_ref;
ww_i_data <= i_data;
lt <= ww_lt;
eq <= ww_eq;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOIBUF_X31_Y31_N8
\i_ref[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ref(0),
	o => \i_ref[0]~input_o\);

-- Location: IOOBUF_X33_Y10_N9
\lt~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \lt~3_combout\,
	devoe => ww_devoe,
	o => \lt~output_o\);

-- Location: IOOBUF_X22_Y0_N9
\eq~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \eq~1_combout\,
	devoe => ww_devoe,
	o => \eq~output_o\);

-- Location: IOIBUF_X33_Y12_N8
\i_data[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data(1),
	o => \i_data[1]~input_o\);

-- Location: IOIBUF_X33_Y11_N1
\i_ref[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ref(1),
	o => \i_ref[1]~input_o\);

-- Location: IOIBUF_X33_Y15_N1
\i_data[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data(0),
	o => \i_data[0]~input_o\);

-- Location: LCCOMB_X32_Y12_N2
\lt~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \lt~1_combout\ = (\i_data[1]~input_o\ & (\i_ref[0]~input_o\ & (\i_ref[1]~input_o\ & !\i_data[0]~input_o\))) # (!\i_data[1]~input_o\ & ((\i_ref[1]~input_o\) # ((\i_ref[0]~input_o\ & !\i_data[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0011000010110010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_ref[0]~input_o\,
	datab => \i_data[1]~input_o\,
	datac => \i_ref[1]~input_o\,
	datad => \i_data[0]~input_o\,
	combout => \lt~1_combout\);

-- Location: IOIBUF_X33_Y24_N8
\i_ref[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ref(2),
	o => \i_ref[2]~input_o\);

-- Location: IOIBUF_X33_Y12_N1
\i_data[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data(2),
	o => \i_data[2]~input_o\);

-- Location: LCCOMB_X32_Y12_N12
\lt~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \lt~2_combout\ = (\lt~0_combout\ & ((\lt~1_combout\ & ((\i_ref[2]~input_o\) # (!\i_data[2]~input_o\))) # (!\lt~1_combout\ & (\i_ref[2]~input_o\ & !\i_data[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000010101000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \lt~0_combout\,
	datab => \lt~1_combout\,
	datac => \i_ref[2]~input_o\,
	datad => \i_data[2]~input_o\,
	combout => \lt~2_combout\);

-- Location: IOIBUF_X33_Y14_N8
\en~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_en,
	o => \en~input_o\);

-- Location: IOIBUF_X33_Y11_N8
\i_ref[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ref(3),
	o => \i_ref[3]~input_o\);

-- Location: IOIBUF_X33_Y15_N8
\i_data[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data(3),
	o => \i_data[3]~input_o\);

-- Location: LCCOMB_X32_Y12_N30
\lt~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \lt~3_combout\ = (\lt~2_combout\) # ((\en~input_o\ & (\i_ref[3]~input_o\ & !\i_data[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \lt~2_combout\,
	datab => \en~input_o\,
	datac => \i_ref[3]~input_o\,
	datad => \i_data[3]~input_o\,
	combout => \lt~3_combout\);

-- Location: LCCOMB_X32_Y12_N24
\lt~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \lt~0_combout\ = (\en~input_o\ & (\i_ref[3]~input_o\ $ (!\i_data[3]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000000001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \en~input_o\,
	datac => \i_ref[3]~input_o\,
	datad => \i_data[3]~input_o\,
	combout => \lt~0_combout\);

-- Location: LCCOMB_X32_Y12_N0
\eq~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \eq~0_combout\ = (\i_ref[0]~input_o\ & (\i_data[0]~input_o\ & (\i_data[1]~input_o\ $ (!\i_ref[1]~input_o\)))) # (!\i_ref[0]~input_o\ & (!\i_data[0]~input_o\ & (\i_data[1]~input_o\ $ (!\i_ref[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000001001000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_ref[0]~input_o\,
	datab => \i_data[1]~input_o\,
	datac => \i_ref[1]~input_o\,
	datad => \i_data[0]~input_o\,
	combout => \eq~0_combout\);

-- Location: LCCOMB_X32_Y12_N26
\eq~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \eq~1_combout\ = (\lt~0_combout\ & (\eq~0_combout\ & (\i_ref[2]~input_o\ $ (!\i_data[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \lt~0_combout\,
	datab => \eq~0_combout\,
	datac => \i_ref[2]~input_o\,
	datad => \i_data[2]~input_o\,
	combout => \eq~1_combout\);

ww_lt <= \lt~output_o\;

ww_eq <= \eq~output_o\;
END structure;


