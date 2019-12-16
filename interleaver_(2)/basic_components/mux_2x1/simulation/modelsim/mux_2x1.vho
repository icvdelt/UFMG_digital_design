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

-- DATE "11/20/2019 01:39:38"

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

ENTITY 	mux_2x1 IS
    PORT (
	en : IN std_logic;
	i_index : IN std_logic;
	i_data_0 : IN std_logic_vector(3 DOWNTO 0);
	i_data_1 : IN std_logic_vector(3 DOWNTO 0);
	o_data : OUT std_logic_vector(3 DOWNTO 0)
	);
END mux_2x1;

-- Design Ports Information
-- o_data[0]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_data[1]	=>  Location: PIN_N8,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_data[2]	=>  Location: PIN_C12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_data[3]	=>  Location: PIN_M13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- en	=>  Location: PIN_N13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_1[0]	=>  Location: PIN_H12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_0[0]	=>  Location: PIN_H10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_index	=>  Location: PIN_C11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_1[1]	=>  Location: PIN_K13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_0[1]	=>  Location: PIN_J13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_1[2]	=>  Location: PIN_G10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_0[2]	=>  Location: PIN_M9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_1[3]	=>  Location: PIN_L12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_data_0[3]	=>  Location: PIN_G13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF mux_2x1 IS
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
SIGNAL ww_i_index : std_logic;
SIGNAL ww_i_data_0 : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_i_data_1 : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_o_data : std_logic_vector(3 DOWNTO 0);
SIGNAL \o_data[0]~output_o\ : std_logic;
SIGNAL \o_data[1]~output_o\ : std_logic;
SIGNAL \o_data[2]~output_o\ : std_logic;
SIGNAL \o_data[3]~output_o\ : std_logic;
SIGNAL \en~input_o\ : std_logic;
SIGNAL \i_data_0[0]~input_o\ : std_logic;
SIGNAL \i_index~input_o\ : std_logic;
SIGNAL \i_data_1[0]~input_o\ : std_logic;
SIGNAL \o_data~0_combout\ : std_logic;
SIGNAL \i_data_1[1]~input_o\ : std_logic;
SIGNAL \i_data_0[1]~input_o\ : std_logic;
SIGNAL \o_data~1_combout\ : std_logic;
SIGNAL \i_data_0[2]~input_o\ : std_logic;
SIGNAL \i_data_1[2]~input_o\ : std_logic;
SIGNAL \o_data~2_combout\ : std_logic;
SIGNAL \i_data_1[3]~input_o\ : std_logic;
SIGNAL \i_data_0[3]~input_o\ : std_logic;
SIGNAL \o_data~3_combout\ : std_logic;

BEGIN

ww_en <= en;
ww_i_index <= i_index;
ww_i_data_0 <= i_data_0;
ww_i_data_1 <= i_data_1;
o_data <= ww_o_data;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

-- Location: IOOBUF_X26_Y31_N2
\o_data[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \o_data~0_combout\,
	devoe => ww_devoe,
	o => \o_data[0]~output_o\);

-- Location: IOOBUF_X20_Y0_N9
\o_data[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \o_data~1_combout\,
	devoe => ww_devoe,
	o => \o_data[1]~output_o\);

-- Location: IOOBUF_X31_Y31_N9
\o_data[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \o_data~2_combout\,
	devoe => ww_devoe,
	o => \o_data[2]~output_o\);

-- Location: IOOBUF_X33_Y10_N2
\o_data[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \o_data~3_combout\,
	devoe => ww_devoe,
	o => \o_data[3]~output_o\);

-- Location: IOIBUF_X33_Y10_N8
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
\i_data_0[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_0(0),
	o => \i_data_0[0]~input_o\);

-- Location: IOIBUF_X31_Y31_N1
\i_index~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_index,
	o => \i_index~input_o\);

-- Location: IOIBUF_X33_Y14_N8
\i_data_1[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_1(0),
	o => \i_data_1[0]~input_o\);

-- Location: LCCOMB_X32_Y14_N16
\o_data~0\ : cycloneiv_lcell_comb
-- Equation(s):
-- \o_data~0_combout\ = (\en~input_o\ & ((\i_index~input_o\ & ((\i_data_1[0]~input_o\))) # (!\i_index~input_o\ & (\i_data_0[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010100000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en~input_o\,
	datab => \i_data_0[0]~input_o\,
	datac => \i_index~input_o\,
	datad => \i_data_1[0]~input_o\,
	combout => \o_data~0_combout\);

-- Location: IOIBUF_X33_Y15_N1
\i_data_1[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_1(1),
	o => \i_data_1[1]~input_o\);

-- Location: IOIBUF_X33_Y15_N8
\i_data_0[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_0(1),
	o => \i_data_0[1]~input_o\);

-- Location: LCCOMB_X32_Y14_N18
\o_data~1\ : cycloneiv_lcell_comb
-- Equation(s):
-- \o_data~1_combout\ = (\en~input_o\ & ((\i_index~input_o\ & (\i_data_1[1]~input_o\)) # (!\i_index~input_o\ & ((\i_data_0[1]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000101010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \en~input_o\,
	datab => \i_data_1[1]~input_o\,
	datac => \i_index~input_o\,
	datad => \i_data_0[1]~input_o\,
	combout => \o_data~1_combout\);

-- Location: IOIBUF_X24_Y0_N1
\i_data_0[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_0(2),
	o => \i_data_0[2]~input_o\);

-- Location: IOIBUF_X33_Y22_N8
\i_data_1[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_1(2),
	o => \i_data_1[2]~input_o\);

-- Location: LCCOMB_X32_Y14_N12
\o_data~2\ : cycloneiv_lcell_comb
-- Equation(s):
-- \o_data~2_combout\ = (\en~input_o\ & ((\i_index~input_o\ & ((\i_data_1[2]~input_o\))) # (!\i_index~input_o\ & (\i_data_0[2]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_index~input_o\,
	datab => \i_data_0[2]~input_o\,
	datac => \i_data_1[2]~input_o\,
	datad => \en~input_o\,
	combout => \o_data~2_combout\);

-- Location: IOIBUF_X33_Y12_N1
\i_data_1[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_1(3),
	o => \i_data_1[3]~input_o\);

-- Location: IOIBUF_X33_Y16_N22
\i_data_0[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_data_0(3),
	o => \i_data_0[3]~input_o\);

-- Location: LCCOMB_X32_Y14_N6
\o_data~3\ : cycloneiv_lcell_comb
-- Equation(s):
-- \o_data~3_combout\ = (\en~input_o\ & ((\i_index~input_o\ & (\i_data_1[3]~input_o\)) # (!\i_index~input_o\ & ((\i_data_0[3]~input_o\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_index~input_o\,
	datab => \i_data_1[3]~input_o\,
	datac => \i_data_0[3]~input_o\,
	datad => \en~input_o\,
	combout => \o_data~3_combout\);

ww_o_data(0) <= \o_data[0]~output_o\;

ww_o_data(1) <= \o_data[1]~output_o\;

ww_o_data(2) <= \o_data[2]~output_o\;

ww_o_data(3) <= \o_data[3]~output_o\;
END structure;


