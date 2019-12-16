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

-- DATE "12/15/2019 16:51:04"

-- 
-- Device: Altera EP4CGX15BF14C6 Package FBGA169
-- 

-- 
-- This VHDL file should be used for ModelSim-Altera (VHDL) only
-- 

LIBRARY ALTERA;
LIBRARY CYCLONEIV;
LIBRARY IEEE;
USE ALTERA.ALTERA_PRIMITIVES_COMPONENTS.ALL;
USE CYCLONEIV.CYCLONEIV_COMPONENTS.ALL;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY 	single_port_ram IS
    PORT (
	clk : IN std_logic;
	i_ram_data : IN std_logic_vector(3 DOWNTO 0);
	i_ram_wr_en : IN std_logic;
	i_lin_addr : IN std_logic_vector(1 DOWNTO 0);
	i_col_addr : IN std_logic_vector(1 DOWNTO 0);
	o_ram_data : OUT std_logic_vector(3 DOWNTO 0)
	);
END single_port_ram;

-- Design Ports Information
-- o_ram_data[0]	=>  Location: PIN_D11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_ram_data[1]	=>  Location: PIN_B11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_ram_data[2]	=>  Location: PIN_B13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- o_ram_data[3]	=>  Location: PIN_A13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_col_addr[1]	=>  Location: PIN_D12,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_col_addr[0]	=>  Location: PIN_E10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_lin_addr[1]	=>  Location: PIN_F10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_lin_addr[0]	=>  Location: PIN_F9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ram_data[0]	=>  Location: PIN_F11,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- clk	=>  Location: PIN_J7,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ram_wr_en	=>  Location: PIN_D10,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ram_data[1]	=>  Location: PIN_C13,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ram_data[2]	=>  Location: PIN_G9,	 I/O Standard: 2.5 V,	 Current Strength: Default
-- i_ram_data[3]	=>  Location: PIN_E13,	 I/O Standard: 2.5 V,	 Current Strength: Default


ARCHITECTURE structure OF single_port_ram IS
SIGNAL gnd : std_logic := '0';
SIGNAL vcc : std_logic := '1';
SIGNAL unknown : std_logic := 'X';
SIGNAL devoe : std_logic := '1';
SIGNAL devclrn : std_logic := '1';
SIGNAL devpor : std_logic := '1';
SIGNAL ww_devoe : std_logic;
SIGNAL ww_devclrn : std_logic;
SIGNAL ww_devpor : std_logic;
SIGNAL ww_clk : std_logic;
SIGNAL ww_i_ram_data : std_logic_vector(3 DOWNTO 0);
SIGNAL ww_i_ram_wr_en : std_logic;
SIGNAL ww_i_lin_addr : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_i_col_addr : std_logic_vector(1 DOWNTO 0);
SIGNAL ww_o_ram_data : std_logic_vector(3 DOWNTO 0);
SIGNAL \clk~inputclkctrl_INCLK_bus\ : std_logic_vector(3 DOWNTO 0);
SIGNAL \memory~53_q\ : std_logic;
SIGNAL \memory~29_q\ : std_logic;
SIGNAL \memory~33_q\ : std_logic;
SIGNAL \memory~25_q\ : std_logic;
SIGNAL \memory~75_combout\ : std_logic;
SIGNAL \memory~37_q\ : std_logic;
SIGNAL \memory~76_combout\ : std_logic;
SIGNAL \memory~9_q\ : std_logic;
SIGNAL \memory~21_q\ : std_logic;
SIGNAL \memory~69_q\ : std_logic;
SIGNAL \memory~30_q\ : std_logic;
SIGNAL \memory~14_q\ : std_logic;
SIGNAL \memory~85_combout\ : std_logic;
SIGNAL \memory~26_q\ : std_logic;
SIGNAL \memory~42_q\ : std_logic;
SIGNAL \memory~10_q\ : std_logic;
SIGNAL \memory~87_combout\ : std_logic;
SIGNAL \memory~58_q\ : std_logic;
SIGNAL \memory~88_combout\ : std_logic;
SIGNAL \memory~70_q\ : std_logic;
SIGNAL \memory~31_q\ : std_logic;
SIGNAL \memory~27_q\ : std_logic;
SIGNAL \memory~93_combout\ : std_logic;
SIGNAL \memory~47_q\ : std_logic;
SIGNAL \memory~51_q\ : std_logic;
SIGNAL \memory~43_q\ : std_logic;
SIGNAL \memory~95_combout\ : std_logic;
SIGNAL \memory~55_q\ : std_logic;
SIGNAL \memory~96_combout\ : std_logic;
SIGNAL \memory~23_q\ : std_logic;
SIGNAL \memory~63_q\ : std_logic;
SIGNAL \memory~59_q\ : std_logic;
SIGNAL \memory~100_combout\ : std_logic;
SIGNAL \memory~16_q\ : std_logic;
SIGNAL \memory~64_q\ : std_logic;
SIGNAL \memory~20_q\ : std_logic;
SIGNAL \memory~28_q\ : std_logic;
SIGNAL \memory~12_q\ : std_logic;
SIGNAL \memory~107_combout\ : std_logic;
SIGNAL \memory~56_q\ : std_logic;
SIGNAL \memory~24_q\ : std_logic;
SIGNAL \memory~110_combout\ : std_logic;
SIGNAL \memory~125_combout\ : std_logic;
SIGNAL \memory~126_combout\ : std_logic;
SIGNAL \memory~129_combout\ : std_logic;
SIGNAL \clk~input_o\ : std_logic;
SIGNAL \clk~inputclkctrl_outclk\ : std_logic;
SIGNAL \memory~53feeder_combout\ : std_logic;
SIGNAL \memory~69feeder_combout\ : std_logic;
SIGNAL \memory~37feeder_combout\ : std_logic;
SIGNAL \memory~12feeder_combout\ : std_logic;
SIGNAL \memory~16feeder_combout\ : std_logic;
SIGNAL \memory~24feeder_combout\ : std_logic;
SIGNAL \memory~20feeder_combout\ : std_logic;
SIGNAL \o_ram_data[0]~output_o\ : std_logic;
SIGNAL \o_ram_data[1]~output_o\ : std_logic;
SIGNAL \o_ram_data[2]~output_o\ : std_logic;
SIGNAL \o_ram_data[3]~output_o\ : std_logic;
SIGNAL \i_col_addr[0]~input_o\ : std_logic;
SIGNAL \i_ram_data[0]~input_o\ : std_logic;
SIGNAL \i_lin_addr[0]~input_o\ : std_logic;
SIGNAL \i_col_addr[1]~input_o\ : std_logic;
SIGNAL \memory~137_combout\ : std_logic;
SIGNAL \i_ram_wr_en~input_o\ : std_logic;
SIGNAL \memory~138_combout\ : std_logic;
SIGNAL \memory~61_q\ : std_logic;
SIGNAL \memory~141_combout\ : std_logic;
SIGNAL \memory~142_combout\ : std_logic;
SIGNAL \memory~57_q\ : std_logic;
SIGNAL \memory~139_combout\ : std_logic;
SIGNAL \memory~140_combout\ : std_logic;
SIGNAL \memory~65_q\ : std_logic;
SIGNAL \memory~80_combout\ : std_logic;
SIGNAL \memory~81_combout\ : std_logic;
SIGNAL \i_lin_addr[1]~input_o\ : std_logic;
SIGNAL \memory~131_combout\ : std_logic;
SIGNAL \memory~132_combout\ : std_logic;
SIGNAL \memory~13_q\ : std_logic;
SIGNAL \memory~77_combout\ : std_logic;
SIGNAL \memory~130_combout\ : std_logic;
SIGNAL \memory~17_q\ : std_logic;
SIGNAL \memory~78_combout\ : std_logic;
SIGNAL \memory~79_combout\ : std_logic;
SIGNAL \memory~41feeder_combout\ : std_logic;
SIGNAL \memory~117_combout\ : std_logic;
SIGNAL \memory~118_combout\ : std_logic;
SIGNAL \memory~41_q\ : std_logic;
SIGNAL \memory~115_combout\ : std_logic;
SIGNAL \memory~116_combout\ : std_logic;
SIGNAL \memory~45_q\ : std_logic;
SIGNAL \memory~73_combout\ : std_logic;
SIGNAL \memory~113_combout\ : std_logic;
SIGNAL \memory~114_combout\ : std_logic;
SIGNAL \memory~49_q\ : std_logic;
SIGNAL \memory~74_combout\ : std_logic;
SIGNAL \memory~82_combout\ : std_logic;
SIGNAL \i_ram_data[1]~input_o\ : std_logic;
SIGNAL \memory~18feeder_combout\ : std_logic;
SIGNAL \memory~18_q\ : std_logic;
SIGNAL \memory~50_q\ : std_logic;
SIGNAL \memory~83_combout\ : std_logic;
SIGNAL \memory~123_combout\ : std_logic;
SIGNAL \memory~124_combout\ : std_logic;
SIGNAL \memory~34_q\ : std_logic;
SIGNAL \memory~66_q\ : std_logic;
SIGNAL \memory~84_combout\ : std_logic;
SIGNAL \memory~62_q\ : std_logic;
SIGNAL \memory~46_q\ : std_logic;
SIGNAL \memory~86_combout\ : std_logic;
SIGNAL \memory~89_combout\ : std_logic;
SIGNAL \memory~127_combout\ : std_logic;
SIGNAL \memory~128_combout\ : std_logic;
SIGNAL \memory~38_q\ : std_logic;
SIGNAL \memory~22feeder_combout\ : std_logic;
SIGNAL \memory~135_combout\ : std_logic;
SIGNAL \memory~136_combout\ : std_logic;
SIGNAL \memory~22_q\ : std_logic;
SIGNAL \memory~90_combout\ : std_logic;
SIGNAL \memory~119_combout\ : std_logic;
SIGNAL \memory~120_combout\ : std_logic;
SIGNAL \memory~54_q\ : std_logic;
SIGNAL \memory~91_combout\ : std_logic;
SIGNAL \memory~92_combout\ : std_logic;
SIGNAL \i_ram_data[2]~input_o\ : std_logic;
SIGNAL \memory~143_combout\ : std_logic;
SIGNAL \memory~144_combout\ : std_logic;
SIGNAL \memory~71_q\ : std_logic;
SIGNAL \memory~67_q\ : std_logic;
SIGNAL \memory~101_combout\ : std_logic;
SIGNAL \memory~133_combout\ : std_logic;
SIGNAL \memory~134_combout\ : std_logic;
SIGNAL \memory~11_q\ : std_logic;
SIGNAL \memory~19_q\ : std_logic;
SIGNAL \memory~97_combout\ : std_logic;
SIGNAL \memory~15_q\ : std_logic;
SIGNAL \memory~98_combout\ : std_logic;
SIGNAL \memory~99_combout\ : std_logic;
SIGNAL \memory~39_q\ : std_logic;
SIGNAL \memory~35_q\ : std_logic;
SIGNAL \memory~94_combout\ : std_logic;
SIGNAL \memory~102_combout\ : std_logic;
SIGNAL \i_ram_data[3]~input_o\ : std_logic;
SIGNAL \memory~48_q\ : std_logic;
SIGNAL \memory~103_combout\ : std_logic;
SIGNAL \memory~121_combout\ : std_logic;
SIGNAL \memory~122_combout\ : std_logic;
SIGNAL \memory~32_q\ : std_logic;
SIGNAL \memory~104_combout\ : std_logic;
SIGNAL \memory~60_q\ : std_logic;
SIGNAL \memory~44_q\ : std_logic;
SIGNAL \memory~108_combout\ : std_logic;
SIGNAL \memory~36_q\ : std_logic;
SIGNAL \memory~105_combout\ : std_logic;
SIGNAL \memory~52_q\ : std_logic;
SIGNAL \memory~68_q\ : std_logic;
SIGNAL \memory~106_combout\ : std_logic;
SIGNAL \memory~109_combout\ : std_logic;
SIGNAL \memory~40_q\ : std_logic;
SIGNAL \memory~72_q\ : std_logic;
SIGNAL \memory~111_combout\ : std_logic;
SIGNAL \memory~112_combout\ : std_logic;

BEGIN

ww_clk <= clk;
ww_i_ram_data <= i_ram_data;
ww_i_ram_wr_en <= i_ram_wr_en;
ww_i_lin_addr <= i_lin_addr;
ww_i_col_addr <= i_col_addr;
o_ram_data <= ww_o_ram_data;
ww_devoe <= devoe;
ww_devclrn <= devclrn;
ww_devpor <= devpor;

\clk~inputclkctrl_INCLK_bus\ <= (vcc & vcc & vcc & \clk~input_o\);

-- Location: FF_X27_Y24_N17
\memory~53\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~53feeder_combout\,
	ena => \memory~120_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~53_q\);

-- Location: FF_X27_Y26_N1
\memory~29\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~122_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~29_q\);

-- Location: FF_X30_Y27_N17
\memory~33\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~124_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~33_q\);

-- Location: FF_X30_Y27_N11
\memory~25\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~126_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~25_q\);

-- Location: LCCOMB_X30_Y27_N16
\memory~75\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~75_combout\ = (\i_col_addr[0]~input_o\ & (((\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & ((\i_col_addr[1]~input_o\ & ((\memory~33_q\))) # (!\i_col_addr[1]~input_o\ & (\memory~25_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~25_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~33_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~75_combout\);

-- Location: FF_X27_Y25_N25
\memory~37\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~37feeder_combout\,
	ena => \memory~128_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~37_q\);

-- Location: LCCOMB_X27_Y26_N0
\memory~76\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~76_combout\ = (\i_col_addr[0]~input_o\ & ((\memory~75_combout\ & (\memory~37_q\)) # (!\memory~75_combout\ & ((\memory~29_q\))))) # (!\i_col_addr[0]~input_o\ & (((\memory~75_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~37_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~29_q\,
	datad => \memory~75_combout\,
	combout => \memory~76_combout\);

-- Location: FF_X30_Y28_N11
\memory~9\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~9_q\);

-- Location: FF_X30_Y29_N11
\memory~21\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~136_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~21_q\);

-- Location: FF_X27_Y25_N3
\memory~69\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~69feeder_combout\,
	ena => \memory~144_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~69_q\);

-- Location: FF_X27_Y26_N21
\memory~30\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~122_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~30_q\);

-- Location: FF_X30_Y28_N9
\memory~14\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~14_q\);

-- Location: LCCOMB_X27_Y26_N20
\memory~85\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~85_combout\ = (\i_lin_addr[1]~input_o\ & (((\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & ((\i_lin_addr[0]~input_o\ & ((\memory~30_q\))) # (!\i_lin_addr[0]~input_o\ & (\memory~14_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \memory~14_q\,
	datac => \memory~30_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~85_combout\);

-- Location: FF_X31_Y22_N13
\memory~26\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~126_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~26_q\);

-- Location: FF_X26_Y26_N11
\memory~42\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~118_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~42_q\);

-- Location: FF_X30_Y28_N19
\memory~10\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~10_q\);

-- Location: LCCOMB_X26_Y26_N10
\memory~87\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~87_combout\ = (\i_lin_addr[0]~input_o\ & (((\i_lin_addr[1]~input_o\)))) # (!\i_lin_addr[0]~input_o\ & ((\i_lin_addr[1]~input_o\ & ((\memory~42_q\))) # (!\i_lin_addr[1]~input_o\ & (\memory~10_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[0]~input_o\,
	datab => \memory~10_q\,
	datac => \memory~42_q\,
	datad => \i_lin_addr[1]~input_o\,
	combout => \memory~87_combout\);

-- Location: FF_X26_Y26_N13
\memory~58\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~142_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~58_q\);

-- Location: LCCOMB_X31_Y22_N12
\memory~88\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~88_combout\ = (\memory~87_combout\ & ((\memory~58_q\) # ((!\i_lin_addr[0]~input_o\)))) # (!\memory~87_combout\ & (((\memory~26_q\ & \i_lin_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~87_combout\,
	datab => \memory~58_q\,
	datac => \memory~26_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~88_combout\);

-- Location: FF_X27_Y25_N31
\memory~70\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~144_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~70_q\);

-- Location: FF_X27_Y26_N9
\memory~31\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~122_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~31_q\);

-- Location: FF_X31_Y22_N23
\memory~27\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~126_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~27_q\);

-- Location: LCCOMB_X27_Y26_N8
\memory~93\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~93_combout\ = (\i_col_addr[0]~input_o\ & (((\memory~31_q\) # (\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & (\memory~27_q\ & ((!\i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~27_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~31_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~93_combout\);

-- Location: FF_X27_Y24_N7
\memory~47\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~116_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~47_q\);

-- Location: FF_X31_Y22_N25
\memory~51\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~114_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~51_q\);

-- Location: FF_X26_Y26_N23
\memory~43\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~118_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~43_q\);

-- Location: LCCOMB_X31_Y22_N24
\memory~95\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~95_combout\ = (\i_col_addr[0]~input_o\ & (((\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & ((\i_col_addr[1]~input_o\ & ((\memory~51_q\))) # (!\i_col_addr[1]~input_o\ & (\memory~43_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_col_addr[0]~input_o\,
	datab => \memory~43_q\,
	datac => \memory~51_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~95_combout\);

-- Location: FF_X27_Y24_N25
\memory~55\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~120_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~55_q\);

-- Location: LCCOMB_X27_Y24_N6
\memory~96\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~96_combout\ = (\memory~95_combout\ & ((\memory~55_q\) # ((!\i_col_addr[0]~input_o\)))) # (!\memory~95_combout\ & (((\memory~47_q\ & \i_col_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~95_combout\,
	datab => \memory~55_q\,
	datac => \memory~47_q\,
	datad => \i_col_addr[0]~input_o\,
	combout => \memory~96_combout\);

-- Location: FF_X30_Y29_N3
\memory~23\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~136_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~23_q\);

-- Location: FF_X27_Y26_N19
\memory~63\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~138_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~63_q\);

-- Location: FF_X26_Y26_N1
\memory~59\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~142_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~59_q\);

-- Location: LCCOMB_X27_Y26_N18
\memory~100\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~100_combout\ = (\i_col_addr[0]~input_o\ & (((\memory~63_q\) # (\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & (\memory~59_q\ & ((!\i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~59_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~63_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~100_combout\);

-- Location: FF_X30_Y28_N21
\memory~16\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~16feeder_combout\,
	ena => \memory~132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~16_q\);

-- Location: FF_X27_Y26_N7
\memory~64\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~138_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~64_q\);

-- Location: FF_X30_Y29_N13
\memory~20\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~20feeder_combout\,
	ena => \memory~130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~20_q\);

-- Location: FF_X31_Y22_N5
\memory~28\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~126_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~28_q\);

-- Location: FF_X30_Y28_N31
\memory~12\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~12feeder_combout\,
	ena => \memory~134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~12_q\);

-- Location: LCCOMB_X31_Y22_N4
\memory~107\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~107_combout\ = (\i_lin_addr[1]~input_o\ & (((\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & ((\i_lin_addr[0]~input_o\ & ((\memory~28_q\))) # (!\i_lin_addr[0]~input_o\ & (\memory~12_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \memory~12_q\,
	datac => \memory~28_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~107_combout\);

-- Location: FF_X27_Y24_N13
\memory~56\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~120_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~56_q\);

-- Location: FF_X30_Y29_N31
\memory~24\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~24feeder_combout\,
	ena => \memory~136_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~24_q\);

-- Location: LCCOMB_X27_Y24_N12
\memory~110\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~110_combout\ = (\i_lin_addr[1]~input_o\ & (((\memory~56_q\) # (\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & (\memory~24_q\ & ((!\i_lin_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~24_q\,
	datab => \i_lin_addr[1]~input_o\,
	datac => \memory~56_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~110_combout\);

-- Location: LCCOMB_X29_Y26_N12
\memory~125\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~125_combout\ = (!\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (!\i_col_addr[1]~input_o\ & \i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~125_combout\);

-- Location: LCCOMB_X29_Y25_N22
\memory~126\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~126_combout\ = (\memory~125_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~125_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~126_combout\);

-- Location: LCCOMB_X30_Y27_N12
\memory~129\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~129_combout\ = (!\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (!\i_lin_addr[0]~input_o\ & \i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~129_combout\);

-- Location: IOIBUF_X16_Y0_N15
\clk~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_clk,
	o => \clk~input_o\);

-- Location: CLKCTRL_G17
\clk~inputclkctrl\ : cycloneiv_clkctrl
-- pragma translate_off
GENERIC MAP (
	clock_type => "global clock",
	ena_register_mode => "none")
-- pragma translate_on
PORT MAP (
	inclk => \clk~inputclkctrl_INCLK_bus\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	outclk => \clk~inputclkctrl_outclk\);

-- Location: LCCOMB_X27_Y24_N16
\memory~53feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~53feeder_combout\ = \i_ram_data[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[0]~input_o\,
	combout => \memory~53feeder_combout\);

-- Location: LCCOMB_X27_Y25_N2
\memory~69feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~69feeder_combout\ = \i_ram_data[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[0]~input_o\,
	combout => \memory~69feeder_combout\);

-- Location: LCCOMB_X27_Y25_N24
\memory~37feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~37feeder_combout\ = \i_ram_data[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[0]~input_o\,
	combout => \memory~37feeder_combout\);

-- Location: LCCOMB_X30_Y28_N30
\memory~12feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~12feeder_combout\ = \i_ram_data[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[3]~input_o\,
	combout => \memory~12feeder_combout\);

-- Location: LCCOMB_X30_Y28_N20
\memory~16feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~16feeder_combout\ = \i_ram_data[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[3]~input_o\,
	combout => \memory~16feeder_combout\);

-- Location: LCCOMB_X30_Y29_N30
\memory~24feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~24feeder_combout\ = \i_ram_data[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[3]~input_o\,
	combout => \memory~24feeder_combout\);

-- Location: LCCOMB_X30_Y29_N12
\memory~20feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~20feeder_combout\ = \i_ram_data[3]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[3]~input_o\,
	combout => \memory~20feeder_combout\);

-- Location: IOOBUF_X33_Y28_N2
\o_ram_data[0]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \memory~82_combout\,
	devoe => ww_devoe,
	o => \o_ram_data[0]~output_o\);

-- Location: IOOBUF_X24_Y31_N2
\o_ram_data[1]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \memory~92_combout\,
	devoe => ww_devoe,
	o => \o_ram_data[1]~output_o\);

-- Location: IOOBUF_X26_Y31_N9
\o_ram_data[2]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \memory~102_combout\,
	devoe => ww_devoe,
	o => \o_ram_data[2]~output_o\);

-- Location: IOOBUF_X26_Y31_N2
\o_ram_data[3]~output\ : cycloneiv_io_obuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	open_drain_output => "false")
-- pragma translate_on
PORT MAP (
	i => \memory~112_combout\,
	devoe => ww_devoe,
	o => \o_ram_data[3]~output_o\);

-- Location: IOIBUF_X33_Y27_N1
\i_col_addr[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_col_addr(0),
	o => \i_col_addr[0]~input_o\);

-- Location: IOIBUF_X33_Y24_N8
\i_ram_data[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ram_data(0),
	o => \i_ram_data[0]~input_o\);

-- Location: IOIBUF_X33_Y25_N1
\i_lin_addr[0]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_lin_addr(0),
	o => \i_lin_addr[0]~input_o\);

-- Location: IOIBUF_X33_Y28_N8
\i_col_addr[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_col_addr(1),
	o => \i_col_addr[1]~input_o\);

-- Location: LCCOMB_X30_Y27_N20
\memory~137\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~137_combout\ = (\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (\i_lin_addr[0]~input_o\ & !\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~137_combout\);

-- Location: IOIBUF_X33_Y27_N8
\i_ram_wr_en~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ram_wr_en,
	o => \i_ram_wr_en~input_o\);

-- Location: LCCOMB_X30_Y27_N30
\memory~138\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~138_combout\ = (\memory~137_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~137_combout\,
	datac => \i_ram_wr_en~input_o\,
	combout => \memory~138_combout\);

-- Location: FF_X27_Y26_N3
\memory~61\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~138_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~61_q\);

-- Location: LCCOMB_X30_Y27_N2
\memory~141\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~141_combout\ = (\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (\i_lin_addr[0]~input_o\ & !\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~141_combout\);

-- Location: LCCOMB_X30_Y27_N28
\memory~142\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~142_combout\ = (\memory~141_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~141_combout\,
	datac => \i_ram_wr_en~input_o\,
	combout => \memory~142_combout\);

-- Location: FF_X26_Y26_N17
\memory~57\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~142_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~57_q\);

-- Location: LCCOMB_X30_Y27_N0
\memory~139\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~139_combout\ = (\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (\i_lin_addr[0]~input_o\ & \i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0010000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~139_combout\);

-- Location: LCCOMB_X29_Y25_N18
\memory~140\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~140_combout\ = (\memory~139_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~139_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~140_combout\);

-- Location: FF_X29_Y25_N1
\memory~65\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~140_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~65_q\);

-- Location: LCCOMB_X29_Y25_N0
\memory~80\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~80_combout\ = (\i_col_addr[0]~input_o\ & (((\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & ((\i_col_addr[1]~input_o\ & ((\memory~65_q\))) # (!\i_col_addr[1]~input_o\ & (\memory~57_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_col_addr[0]~input_o\,
	datab => \memory~57_q\,
	datac => \memory~65_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~80_combout\);

-- Location: LCCOMB_X27_Y26_N2
\memory~81\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~81_combout\ = (\i_col_addr[0]~input_o\ & ((\memory~80_combout\ & (\memory~69_q\)) # (!\memory~80_combout\ & ((\memory~61_q\))))) # (!\i_col_addr[0]~input_o\ & (((\memory~80_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011101111000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~69_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~61_q\,
	datad => \memory~80_combout\,
	combout => \memory~81_combout\);

-- Location: IOIBUF_X33_Y24_N1
\i_lin_addr[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_lin_addr(1),
	o => \i_lin_addr[1]~input_o\);

-- Location: LCCOMB_X30_Y27_N8
\memory~131\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~131_combout\ = (!\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (!\i_lin_addr[0]~input_o\ & !\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~131_combout\);

-- Location: LCCOMB_X30_Y27_N26
\memory~132\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~132_combout\ = (\memory~131_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~131_combout\,
	datac => \i_ram_wr_en~input_o\,
	combout => \memory~132_combout\);

-- Location: FF_X30_Y28_N1
\memory~13\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~13_q\);

-- Location: LCCOMB_X30_Y28_N0
\memory~77\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~77_combout\ = (\i_col_addr[0]~input_o\ & (((\memory~13_q\) # (\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & (\memory~9_q\ & ((!\i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~9_q\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~13_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~77_combout\);

-- Location: LCCOMB_X30_Y27_N22
\memory~130\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~130_combout\ = (\memory~129_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010000010100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~129_combout\,
	datac => \i_ram_wr_en~input_o\,
	combout => \memory~130_combout\);

-- Location: FF_X30_Y29_N9
\memory~17\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~17_q\);

-- Location: LCCOMB_X30_Y29_N8
\memory~78\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~78_combout\ = (\memory~77_combout\ & ((\memory~21_q\) # ((!\i_col_addr[1]~input_o\)))) # (!\memory~77_combout\ & (((\memory~17_q\ & \i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~21_q\,
	datab => \memory~77_combout\,
	datac => \memory~17_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~78_combout\);

-- Location: LCCOMB_X30_Y28_N28
\memory~79\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~79_combout\ = (\i_lin_addr[1]~input_o\ & (((\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & ((\i_lin_addr[0]~input_o\ & (\memory~76_combout\)) # (!\i_lin_addr[0]~input_o\ & ((\memory~78_combout\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001111100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~76_combout\,
	datab => \i_lin_addr[1]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \memory~78_combout\,
	combout => \memory~79_combout\);

-- Location: LCCOMB_X29_Y26_N18
\memory~41feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~41feeder_combout\ = \i_ram_data[0]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[0]~input_o\,
	combout => \memory~41feeder_combout\);

-- Location: LCCOMB_X29_Y26_N26
\memory~117\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~117_combout\ = (!\i_lin_addr[0]~input_o\ & (!\i_col_addr[0]~input_o\ & (\i_lin_addr[1]~input_o\ & !\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000010000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[0]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[1]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~117_combout\);

-- Location: LCCOMB_X29_Y26_N20
\memory~118\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~118_combout\ = (\memory~117_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~117_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~118_combout\);

-- Location: FF_X29_Y26_N19
\memory~41\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~41feeder_combout\,
	ena => \memory~118_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~41_q\);

-- Location: LCCOMB_X29_Y26_N14
\memory~115\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~115_combout\ = (\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (!\i_col_addr[1]~input_o\ & !\i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~115_combout\);

-- Location: LCCOMB_X29_Y26_N8
\memory~116\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~116_combout\ = (\memory~115_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~115_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~116_combout\);

-- Location: FF_X29_Y26_N1
\memory~45\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~116_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~45_q\);

-- Location: LCCOMB_X29_Y26_N0
\memory~73\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~73_combout\ = (\i_col_addr[1]~input_o\ & (((\i_col_addr[0]~input_o\)))) # (!\i_col_addr[1]~input_o\ & ((\i_col_addr[0]~input_o\ & ((\memory~45_q\))) # (!\i_col_addr[0]~input_o\ & (\memory~41_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_col_addr[1]~input_o\,
	datab => \memory~41_q\,
	datac => \memory~45_q\,
	datad => \i_col_addr[0]~input_o\,
	combout => \memory~73_combout\);

-- Location: LCCOMB_X29_Y26_N4
\memory~113\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~113_combout\ = (\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (\i_col_addr[1]~input_o\ & !\i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000100000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~113_combout\);

-- Location: LCCOMB_X29_Y25_N6
\memory~114\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~114_combout\ = (\memory~113_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~113_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~114_combout\);

-- Location: FF_X31_Y22_N17
\memory~49\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[0]~input_o\,
	sload => VCC,
	ena => \memory~114_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~49_q\);

-- Location: LCCOMB_X31_Y22_N16
\memory~74\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~74_combout\ = (\memory~73_combout\ & ((\memory~53_q\) # ((!\i_col_addr[1]~input_o\)))) # (!\memory~73_combout\ & (((\memory~49_q\ & \i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~53_q\,
	datab => \memory~73_combout\,
	datac => \memory~49_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~74_combout\);

-- Location: LCCOMB_X30_Y28_N6
\memory~82\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~82_combout\ = (\memory~79_combout\ & ((\memory~81_combout\) # ((!\i_lin_addr[1]~input_o\)))) # (!\memory~79_combout\ & (((\i_lin_addr[1]~input_o\ & \memory~74_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~81_combout\,
	datab => \memory~79_combout\,
	datac => \i_lin_addr[1]~input_o\,
	datad => \memory~74_combout\,
	combout => \memory~82_combout\);

-- Location: IOIBUF_X29_Y31_N1
\i_ram_data[1]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ram_data(1),
	o => \i_ram_data[1]~input_o\);

-- Location: LCCOMB_X30_Y29_N20
\memory~18feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~18feeder_combout\ = \i_ram_data[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[1]~input_o\,
	combout => \memory~18feeder_combout\);

-- Location: FF_X30_Y29_N21
\memory~18\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~18feeder_combout\,
	ena => \memory~130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~18_q\);

-- Location: FF_X31_Y22_N11
\memory~50\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~114_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~50_q\);

-- Location: LCCOMB_X31_Y22_N10
\memory~83\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~83_combout\ = (\i_lin_addr[1]~input_o\ & (((\memory~50_q\) # (\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & (\memory~18_q\ & ((!\i_lin_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \memory~18_q\,
	datac => \memory~50_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~83_combout\);

-- Location: LCCOMB_X29_Y26_N2
\memory~123\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~123_combout\ = (!\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (\i_col_addr[1]~input_o\ & \i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0001000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~123_combout\);

-- Location: LCCOMB_X29_Y25_N20
\memory~124\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~124_combout\ = (\memory~123_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~123_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~124_combout\);

-- Location: FF_X29_Y25_N3
\memory~34\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~124_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~34_q\);

-- Location: FF_X29_Y25_N29
\memory~66\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~140_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~66_q\);

-- Location: LCCOMB_X29_Y25_N2
\memory~84\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~84_combout\ = (\i_lin_addr[0]~input_o\ & ((\memory~83_combout\ & ((\memory~66_q\))) # (!\memory~83_combout\ & (\memory~34_q\)))) # (!\i_lin_addr[0]~input_o\ & (\memory~83_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[0]~input_o\,
	datab => \memory~83_combout\,
	datac => \memory~34_q\,
	datad => \memory~66_q\,
	combout => \memory~84_combout\);

-- Location: FF_X27_Y26_N23
\memory~62\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~138_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~62_q\);

-- Location: FF_X27_Y24_N27
\memory~46\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~116_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~46_q\);

-- Location: LCCOMB_X27_Y24_N26
\memory~86\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~86_combout\ = (\memory~85_combout\ & ((\memory~62_q\) # ((!\i_lin_addr[1]~input_o\)))) # (!\memory~85_combout\ & (((\memory~46_q\ & \i_lin_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~85_combout\,
	datab => \memory~62_q\,
	datac => \memory~46_q\,
	datad => \i_lin_addr[1]~input_o\,
	combout => \memory~86_combout\);

-- Location: LCCOMB_X29_Y26_N28
\memory~89\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~89_combout\ = (\i_col_addr[0]~input_o\ & (((\memory~86_combout\) # (\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & (\memory~88_combout\ & ((!\i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~88_combout\,
	datab => \i_col_addr[0]~input_o\,
	datac => \memory~86_combout\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~89_combout\);

-- Location: LCCOMB_X29_Y26_N22
\memory~127\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~127_combout\ = (!\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (\i_col_addr[1]~input_o\ & \i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0100000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~127_combout\);

-- Location: LCCOMB_X29_Y25_N16
\memory~128\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~128_combout\ = (\memory~127_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~127_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~128_combout\);

-- Location: FF_X27_Y25_N21
\memory~38\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~128_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~38_q\);

-- Location: LCCOMB_X30_Y29_N22
\memory~22feeder\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~22feeder_combout\ = \i_ram_data[1]~input_o\

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111111100000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datad => \i_ram_data[1]~input_o\,
	combout => \memory~22feeder_combout\);

-- Location: LCCOMB_X30_Y27_N24
\memory~135\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~135_combout\ = (!\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (!\i_lin_addr[0]~input_o\ & \i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~135_combout\);

-- Location: LCCOMB_X30_Y27_N18
\memory~136\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~136_combout\ = (\memory~135_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~135_combout\,
	datac => \i_ram_wr_en~input_o\,
	combout => \memory~136_combout\);

-- Location: FF_X30_Y29_N23
\memory~22\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	d => \memory~22feeder_combout\,
	ena => \memory~136_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~22_q\);

-- Location: LCCOMB_X27_Y25_N20
\memory~90\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~90_combout\ = (\i_lin_addr[1]~input_o\ & (\i_lin_addr[0]~input_o\)) # (!\i_lin_addr[1]~input_o\ & ((\i_lin_addr[0]~input_o\ & (\memory~38_q\)) # (!\i_lin_addr[0]~input_o\ & ((\memory~22_q\)))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_lin_addr[0]~input_o\,
	datac => \memory~38_q\,
	datad => \memory~22_q\,
	combout => \memory~90_combout\);

-- Location: LCCOMB_X29_Y26_N30
\memory~119\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~119_combout\ = (\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (\i_col_addr[1]~input_o\ & !\i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000010000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~119_combout\);

-- Location: LCCOMB_X29_Y25_N8
\memory~120\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~120_combout\ = (\memory~119_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~119_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~120_combout\);

-- Location: FF_X27_Y24_N21
\memory~54\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[1]~input_o\,
	sload => VCC,
	ena => \memory~120_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~54_q\);

-- Location: LCCOMB_X27_Y24_N20
\memory~91\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~91_combout\ = (\memory~90_combout\ & ((\memory~70_q\) # ((!\i_lin_addr[1]~input_o\)))) # (!\memory~90_combout\ & (((\memory~54_q\ & \i_lin_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~70_q\,
	datab => \memory~90_combout\,
	datac => \memory~54_q\,
	datad => \i_lin_addr[1]~input_o\,
	combout => \memory~91_combout\);

-- Location: LCCOMB_X29_Y26_N6
\memory~92\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~92_combout\ = (\memory~89_combout\ & (((\memory~91_combout\) # (!\i_col_addr[1]~input_o\)))) # (!\memory~89_combout\ & (\memory~84_combout\ & (\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110000101100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~84_combout\,
	datab => \memory~89_combout\,
	datac => \i_col_addr[1]~input_o\,
	datad => \memory~91_combout\,
	combout => \memory~92_combout\);

-- Location: IOIBUF_X33_Y22_N1
\i_ram_data[2]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ram_data(2),
	o => \i_ram_data[2]~input_o\);

-- Location: LCCOMB_X30_Y27_N14
\memory~143\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~143_combout\ = (\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (\i_lin_addr[0]~input_o\ & \i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1000000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~143_combout\);

-- Location: LCCOMB_X29_Y25_N12
\memory~144\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~144_combout\ = (\memory~143_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \memory~143_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~144_combout\);

-- Location: FF_X27_Y25_N27
\memory~71\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~144_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~71_q\);

-- Location: FF_X29_Y25_N25
\memory~67\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~140_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~67_q\);

-- Location: LCCOMB_X29_Y25_N24
\memory~101\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~101_combout\ = (\memory~100_combout\ & ((\memory~71_q\) # ((!\i_col_addr[1]~input_o\)))) # (!\memory~100_combout\ & (((\memory~67_q\ & \i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~100_combout\,
	datab => \memory~71_q\,
	datac => \memory~67_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~101_combout\);

-- Location: LCCOMB_X30_Y27_N4
\memory~133\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~133_combout\ = (!\i_lin_addr[1]~input_o\ & (!\i_col_addr[0]~input_o\ & (!\i_lin_addr[0]~input_o\ & !\i_col_addr[1]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000000000000001",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~133_combout\);

-- Location: LCCOMB_X30_Y27_N6
\memory~134\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~134_combout\ = (\i_ram_wr_en~input_o\ & \memory~133_combout\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100000011000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datab => \i_ram_wr_en~input_o\,
	datac => \memory~133_combout\,
	combout => \memory~134_combout\);

-- Location: FF_X30_Y28_N23
\memory~11\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~134_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~11_q\);

-- Location: FF_X30_Y29_N25
\memory~19\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~130_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~19_q\);

-- Location: LCCOMB_X30_Y29_N24
\memory~97\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~97_combout\ = (\i_col_addr[0]~input_o\ & (((\i_col_addr[1]~input_o\)))) # (!\i_col_addr[0]~input_o\ & ((\i_col_addr[1]~input_o\ & ((\memory~19_q\))) # (!\i_col_addr[1]~input_o\ & (\memory~11_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111101001000100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_col_addr[0]~input_o\,
	datab => \memory~11_q\,
	datac => \memory~19_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~97_combout\);

-- Location: FF_X30_Y28_N13
\memory~15\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~132_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~15_q\);

-- Location: LCCOMB_X30_Y28_N12
\memory~98\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~98_combout\ = (\memory~97_combout\ & ((\memory~23_q\) # ((!\i_col_addr[0]~input_o\)))) # (!\memory~97_combout\ & (((\memory~15_q\ & \i_col_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~23_q\,
	datab => \memory~97_combout\,
	datac => \memory~15_q\,
	datad => \i_col_addr[0]~input_o\,
	combout => \memory~98_combout\);

-- Location: LCCOMB_X30_Y28_N24
\memory~99\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~99_combout\ = (\i_lin_addr[1]~input_o\ & ((\memory~96_combout\) # ((\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & (((!\i_lin_addr[0]~input_o\ & \memory~98_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100101111001000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~96_combout\,
	datab => \i_lin_addr[1]~input_o\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \memory~98_combout\,
	combout => \memory~99_combout\);

-- Location: FF_X27_Y25_N1
\memory~39\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~128_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~39_q\);

-- Location: FF_X29_Y25_N15
\memory~35\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[2]~input_o\,
	sload => VCC,
	ena => \memory~124_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~35_q\);

-- Location: LCCOMB_X29_Y25_N14
\memory~94\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~94_combout\ = (\memory~93_combout\ & ((\memory~39_q\) # ((!\i_col_addr[1]~input_o\)))) # (!\memory~93_combout\ & (((\memory~35_q\ & \i_col_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~93_combout\,
	datab => \memory~39_q\,
	datac => \memory~35_q\,
	datad => \i_col_addr[1]~input_o\,
	combout => \memory~94_combout\);

-- Location: LCCOMB_X30_Y28_N26
\memory~102\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~102_combout\ = (\memory~99_combout\ & ((\memory~101_combout\) # ((!\i_lin_addr[0]~input_o\)))) # (!\memory~99_combout\ & (((\i_lin_addr[0]~input_o\ & \memory~94_combout\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011110010001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~101_combout\,
	datab => \memory~99_combout\,
	datac => \i_lin_addr[0]~input_o\,
	datad => \memory~94_combout\,
	combout => \memory~102_combout\);

-- Location: IOIBUF_X33_Y25_N8
\i_ram_data[3]~input\ : cycloneiv_io_ibuf
-- pragma translate_off
GENERIC MAP (
	bus_hold => "false",
	simulate_z_as => "z")
-- pragma translate_on
PORT MAP (
	i => ww_i_ram_data(3),
	o => \i_ram_data[3]~input_o\);

-- Location: FF_X27_Y24_N11
\memory~48\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~116_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~48_q\);

-- Location: LCCOMB_X27_Y24_N10
\memory~103\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~103_combout\ = (\i_lin_addr[1]~input_o\ & (((\memory~48_q\) # (\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & (\memory~16_q\ & ((!\i_lin_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1100110011100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~16_q\,
	datab => \i_lin_addr[1]~input_o\,
	datac => \memory~48_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~103_combout\);

-- Location: LCCOMB_X29_Y26_N16
\memory~121\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~121_combout\ = (!\i_lin_addr[1]~input_o\ & (\i_col_addr[0]~input_o\ & (!\i_col_addr[1]~input_o\ & \i_lin_addr[0]~input_o\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "0000010000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \i_col_addr[0]~input_o\,
	datac => \i_col_addr[1]~input_o\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~121_combout\);

-- Location: LCCOMB_X29_Y25_N10
\memory~122\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~122_combout\ = (\memory~121_combout\ & \i_ram_wr_en~input_o\)

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111000000000000",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	datac => \memory~121_combout\,
	datad => \i_ram_wr_en~input_o\,
	combout => \memory~122_combout\);

-- Location: FF_X27_Y26_N29
\memory~32\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~122_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~32_q\);

-- Location: LCCOMB_X27_Y26_N28
\memory~104\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~104_combout\ = (\memory~103_combout\ & ((\memory~64_q\) # ((!\i_lin_addr[0]~input_o\)))) # (!\memory~103_combout\ & (((\memory~32_q\ & \i_lin_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1011100011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~64_q\,
	datab => \memory~103_combout\,
	datac => \memory~32_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~104_combout\);

-- Location: FF_X26_Y26_N5
\memory~60\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~142_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~60_q\);

-- Location: FF_X26_Y26_N27
\memory~44\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~118_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~44_q\);

-- Location: LCCOMB_X26_Y26_N26
\memory~108\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~108_combout\ = (\memory~107_combout\ & ((\memory~60_q\) # ((!\i_lin_addr[1]~input_o\)))) # (!\memory~107_combout\ & (((\memory~44_q\ & \i_lin_addr[1]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1101100010101010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~107_combout\,
	datab => \memory~60_q\,
	datac => \memory~44_q\,
	datad => \i_lin_addr[1]~input_o\,
	combout => \memory~108_combout\);

-- Location: FF_X29_Y25_N27
\memory~36\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~124_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~36_q\);

-- Location: LCCOMB_X29_Y25_N26
\memory~105\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~105_combout\ = (\i_lin_addr[1]~input_o\ & (((\i_lin_addr[0]~input_o\)))) # (!\i_lin_addr[1]~input_o\ & ((\i_lin_addr[0]~input_o\ & ((\memory~36_q\))) # (!\i_lin_addr[0]~input_o\ & (\memory~20_q\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1111110000100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~20_q\,
	datab => \i_lin_addr[1]~input_o\,
	datac => \memory~36_q\,
	datad => \i_lin_addr[0]~input_o\,
	combout => \memory~105_combout\);

-- Location: FF_X31_Y22_N3
\memory~52\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~114_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~52_q\);

-- Location: FF_X29_Y25_N5
\memory~68\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~140_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~68_q\);

-- Location: LCCOMB_X31_Y22_N2
\memory~106\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~106_combout\ = (\i_lin_addr[1]~input_o\ & ((\memory~105_combout\ & ((\memory~68_q\))) # (!\memory~105_combout\ & (\memory~52_q\)))) # (!\i_lin_addr[1]~input_o\ & (\memory~105_combout\))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110110001100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_lin_addr[1]~input_o\,
	datab => \memory~105_combout\,
	datac => \memory~52_q\,
	datad => \memory~68_q\,
	combout => \memory~106_combout\);

-- Location: LCCOMB_X29_Y26_N24
\memory~109\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~109_combout\ = (\i_col_addr[1]~input_o\ & (((\memory~106_combout\) # (\i_col_addr[0]~input_o\)))) # (!\i_col_addr[1]~input_o\ & (\memory~108_combout\ & ((!\i_col_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1010101011100100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \i_col_addr[1]~input_o\,
	datab => \memory~108_combout\,
	datac => \memory~106_combout\,
	datad => \i_col_addr[0]~input_o\,
	combout => \memory~109_combout\);

-- Location: FF_X27_Y25_N13
\memory~40\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~128_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~40_q\);

-- Location: FF_X27_Y25_N7
\memory~72\ : dffeas
-- pragma translate_off
GENERIC MAP (
	is_wysiwyg => "true",
	power_up => "low")
-- pragma translate_on
PORT MAP (
	clk => \clk~inputclkctrl_outclk\,
	asdata => \i_ram_data[3]~input_o\,
	sload => VCC,
	ena => \memory~144_combout\,
	devclrn => ww_devclrn,
	devpor => ww_devpor,
	q => \memory~72_q\);

-- Location: LCCOMB_X27_Y25_N12
\memory~111\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~111_combout\ = (\memory~110_combout\ & (((\memory~72_q\)) # (!\i_lin_addr[0]~input_o\))) # (!\memory~110_combout\ & (\i_lin_addr[0]~input_o\ & (\memory~40_q\)))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110101001100010",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~110_combout\,
	datab => \i_lin_addr[0]~input_o\,
	datac => \memory~40_q\,
	datad => \memory~72_q\,
	combout => \memory~111_combout\);

-- Location: LCCOMB_X29_Y26_N10
\memory~112\ : cycloneiv_lcell_comb
-- Equation(s):
-- \memory~112_combout\ = (\memory~109_combout\ & (((\memory~111_combout\) # (!\i_col_addr[0]~input_o\)))) # (!\memory~109_combout\ & (\memory~104_combout\ & ((\i_col_addr[0]~input_o\))))

-- pragma translate_off
GENERIC MAP (
	lut_mask => "1110001011001100",
	sum_lutc_input => "datac")
-- pragma translate_on
PORT MAP (
	dataa => \memory~104_combout\,
	datab => \memory~109_combout\,
	datac => \memory~111_combout\,
	datad => \i_col_addr[0]~input_o\,
	combout => \memory~112_combout\);

ww_o_ram_data(0) <= \o_ram_data[0]~output_o\;

ww_o_ram_data(1) <= \o_ram_data[1]~output_o\;

ww_o_ram_data(2) <= \o_ram_data[2]~output_o\;

ww_o_ram_data(3) <= \o_ram_data[3]~output_o\;
END structure;


