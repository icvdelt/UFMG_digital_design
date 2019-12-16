transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {C:/Users/Gabriel_Ricardo/Documents/Documentos_Gabriel/Quartus_projects/Lifi/basic_components/reg/reg.vhd}

vcom -93 -work work {C:/Users/Gabriel_Ricardo/Documents/Documentos_Gabriel/Quartus_projects/Lifi/basic_components/reg/testbench_reg.vhd}

vsim -t 1ps -L altera -L lpm -L sgate -L altera_mf -L altera_lnsim -L cycloneiv_hssi -L cycloneiv_pcie_hip -L cycloneiv -L rtl_work -L work -voptargs="+acc"  testbench_reg

add wave *
view structure
view signals
run 1 us
