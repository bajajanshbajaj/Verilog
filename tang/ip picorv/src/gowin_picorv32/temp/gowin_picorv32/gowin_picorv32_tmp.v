//Copyright (C)2014-2025 Gowin Semiconductor Corporation.
//All rights reserved.
//File Title: Template file for instantiation
//Tool Version: V1.9.11.01 Education (64-bit)
//Part Number: GW2AR-LV18QN88C8/I7
//Device: GW2AR-18
//Device Version: C
//Created Time: Sat May 10 02:50:25 2025

//Change the instance name and port connections to the signal names
//--------Copy here to design--------

	Gowin_PicoRV32_Top your_instance_name(
		.ser_tx(ser_tx), //output ser_tx
		.ser_rx(ser_rx), //input ser_rx
		.jtag_TDI(jtag_TDI), //input jtag_TDI
		.jtag_TDO(jtag_TDO), //output jtag_TDO
		.jtag_TCK(jtag_TCK), //input jtag_TCK
		.jtag_TMS(jtag_TMS), //input jtag_TMS
		.clk_in(clk_in), //input clk_in
		.resetn_in(resetn_in) //input resetn_in
	);

//--------Copy end-------------------
