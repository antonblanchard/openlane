#include "../../defs.h"
#include "../../stub.c"

// --------------------------------------------------------

void main(void)
{
	// Set LA[65] as output to act as a reset pin for microwatt and
	// LA[66] as output to specify reset location (RAM or FLASH)
	reg_la2_ena = 0xFFFFFFF9;

	// Put microwatt into reset and tell it to fetch from flash
	reg_la2_data = 0x00000002 | 0x00000004;

	// Communicate status with test case over GPIO 16-19
	reg_mprj_io_16 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_17 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_18 = GPIO_MODE_MGMT_STD_OUTPUT;
	reg_mprj_io_19 = GPIO_MODE_MGMT_STD_OUTPUT;

	// Signal to the tb that we are alive
	reg_mprj_datal = 0x00010000;

	// We need to terminate the bus or else microwatt
	// will consume X state and die
	reg_mprj_io_28 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_29 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_30 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_31 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_32 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_33 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_34 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_35 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;
	reg_mprj_io_36 = GPIO_MODE_USER_STD_INPUT_PULLDOWN;

	// Set uart_rx to user input so microwatt can use it
	reg_mprj_io_5 = GPIO_MODE_USER_STD_INPUT_NOPULL;

	// Set uart_tx to user output so microwatt can use it
	reg_mprj_io_6 = GPIO_MODE_USER_STD_OUTPUT;

	// Configure SPI for microwatt
	reg_mprj_io_8 = GPIO_MODE_USER_STD_OUTPUT;		// CSB
	reg_mprj_io_9 = GPIO_MODE_USER_STD_OUTPUT;		// SCK
	reg_mprj_io_10 = GPIO_MODE_USER_STD_OUTPUT;		// IO0/MOSI
	reg_mprj_io_11 = GPIO_MODE_USER_STD_INPUT_NOPULL;	// IO1/MISO

	// Now, apply the configuration
	reg_mprj_xfer = 1;
	while (reg_mprj_xfer == 1)
		/* Do Nothing */;

	// Configure LA bits 0-31 as inputs from Microwatt
	reg_la0_ena = 0xFFFFFFFF;	// [31:0]

	// Take microwatt out of reset
	reg_la2_data &= ~0x00000002;

	while (reg_la0_data != 0xbadc0ffe)
		/* Do Nothing */ ;

	// Signal to TB that microwatt is alive
	reg_mprj_datal = 0x00020000;

	while (1)
		/* Do Nothing */;
}