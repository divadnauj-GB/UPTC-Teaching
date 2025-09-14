`default_nettype none

module nanorv32_wb_soc #(
	parameter SIM = 0,
	parameter PROGADDR_RESET = 32'h 0000_0000,
	parameter PROGADDR_IRQ = 32'h 0000_0010,
	parameter BOOTROM_MEMFILE = "",
	parameter BOOTROM_MEMDEPTH = 1024,

	parameter SRAM0_TECHNOLOGY = "GENERIC",
	parameter SRAM0_MEMDEPTH = 65536,//16384,

	parameter SDRAM_CLK_FREQ_MHZ	= 100,	// sdram_clk freq in MHZ
	parameter SDRAM_POWERUP_DELAY	= 200,	// power up delay in us
	parameter SDRAM_REFRESH_MS	= 64,	// time to wait between refreshes in ms
	parameter SDRAM_BURST_LENGTH	= 8,	// 0, 1, 2, 4 or 8 (0 = full page)
	// FIXME: SDRAM_WB_PORTS: localparam
	parameter SDRAM_WB_PORTS	= 2,	// Number of wishbone ports
	parameter SDRAM_BUF_WIDTH	= 3,	// Buffer size = 2^BUF_WIDTH
	parameter SDRAM_ROW_WIDTH	= 13,	// Row width
	parameter SDRAM_COL_WIDTH	= 9,	// Column width
	parameter SDRAM_BA_WIDTH	= 2,	// Ba width
	parameter SDRAM_tCAC		= 2,	// CAS Latency
	parameter SDRAM_tRAC		= 5,	// RAS Latency
	parameter SDRAM_tRP		= 2,	// Command Period (PRE to ACT)
	parameter SDRAM_tRC		= 7,	// Command Period (REF to REF / ACT to ACT)
	parameter SDRAM_tMRD		= 2	// Mode Register Set To Command Delay time
	)
	(
	input  clock,
	input  reset,
	output [31:0] wb_iadr_o,

	input				sdram_clk,
	input				sdram_rst,
	output [SDRAM_BA_WIDTH-1:0]	sdram_ba_pad_o,
	output [12:0]			sdram_a_pad_o,
	output				sdram_cs_n_pad_o,
	output				sdram_ras_pad_o,
	output				sdram_cas_pad_o,
	output				sdram_we_pad_o,
	output [15:0]			sdram_dq_o,
	input  [15:0]			sdram_dq_i,
	output				sdram_dq_oe,
	output [1:0]			sdram_dqm_pad_o,
	output				sdram_cke_pad_o,

	input  uart_rx,
	output uart_tx,

	output spi0_cs0,
	output spi0_sclk,
	output spi0_mosi,
	input spi0_miso,

	input [7:0] gpio0_i,
	output [7:0] gpio0_o,
	output [7:0] gpio0_dir_o
	);

	wire wb_clk;
	assign wb_clk = clock;
	wire wb_rst;
	assign wb_rst = reset;

`include "wb_common_params.v"
`include "wb_intercon.vh"

	wb_sdram_ctrl #(
`ifndef SIM
		.TECHNOLOGY	("ALTERA"),
`endif
		.CLK_FREQ_MHZ	(SDRAM_CLK_FREQ_MHZ),
		.POWERUP_DELAY	(SDRAM_POWERUP_DELAY),
		.REFRESH_MS	(SDRAM_REFRESH_MS),
		.BURST_LENGTH	(SDRAM_BURST_LENGTH),
		.WB_PORTS	(SDRAM_WB_PORTS),
		.BUF_WIDTH	(SDRAM_BUF_WIDTH),
		.ROW_WIDTH	(SDRAM_ROW_WIDTH),
		.COL_WIDTH	(SDRAM_COL_WIDTH),
		.BA_WIDTH	(SDRAM_BA_WIDTH),
		.tCAC		(SDRAM_tCAC),
		.tRAC		(SDRAM_tRAC),
		.tRP		(SDRAM_tRP),
		.tRC		(SDRAM_tRC),
		.tMRD		(SDRAM_tMRD)
	)
	wb_sdram_ctrl0 (
		.wb_clk		(wb_clk),
		.wb_rst		(wb_rst),

		.ba_pad_o	(sdram_ba_pad_o[1:0]),
		.a_pad_o	(sdram_a_pad_o[12:0]),
		.cs_n_pad_o	(sdram_cs_n_pad_o),
		.ras_pad_o	(sdram_ras_pad_o),
		.cas_pad_o	(sdram_cas_pad_o),
		.we_pad_o	(sdram_we_pad_o),
		.dq_i		(sdram_dq_i[15:0]),
		.dq_o		(sdram_dq_o[15:0]),
		.dq_oe		(sdram_dq_oe),
		.dqm_pad_o	(sdram_dqm_pad_o[1:0]),
		.cke_pad_o	(sdram_cke_pad_o),
		.sdram_clk	(sdram_clk),
		.sdram_rst	(sdram_rst),

	// unused: wb_s2m_sdram*_err, wb_s2m_sdram*_rty

		.wb_adr_i	({
				{7'h00, wb_sdram_reserved0_adr[24:0]},
				{7'h00, wb_sdram0_adr[24:0]}
				}),
		.wb_stb_i	({wb_sdram_reserved0_stb, wb_sdram0_stb}),
		.wb_cyc_i	({wb_sdram_reserved0_cyc, wb_sdram0_cyc}),
		.wb_cti_i	({wb_sdram_reserved0_cti, wb_sdram0_cti}),
		.wb_bte_i	({wb_sdram_reserved0_bte, wb_sdram0_bte}),
		.wb_we_i	({wb_sdram_reserved0_we,  wb_sdram0_we}),
		.wb_sel_i	({wb_sdram_reserved0_sel, wb_sdram0_sel}),
		.wb_dat_i	({wb_sdram_reserved0_dat, wb_sdram0_dat}),
		.wb_dat_o	({wb_sdram_reserved0_rdt, wb_sdram0_rdt}),
		.wb_ack_o	({wb_sdram_reserved0_ack, wb_sdram0_ack})
	);

	wb_spimemio spi0memio (
		.wb_clk_i(wb_clk),
		.wb_rst_i(wb_rst),

		.wb_adr_i(wb_spi0memio_adr),
		.wb_stb_i(wb_spi0memio_stb),
		.wb_cyc_i(wb_spi0memio_cyc),
		.wb_dat_o(wb_spi0memio_rdt),
		.wb_ack_o(wb_spi0memio_ack),

		.spi_cs(spi0_cs0),
		.spi_sclk(spi0_sclk),
		.spi_mosi(spi0_mosi),
		.spi_miso(spi0_miso)
	);

	wb_ram #(
		.TECHNOLOGY (SRAM0_TECHNOLOGY),
		.depth (SRAM0_MEMDEPTH)
	)
	sram0 (
		.wb_clk_i		(wb_clk),
		.wb_rst_i		(wb_rst),

		.wb_adr_i		(wb_sram0_adr),
		.wb_dat_i		(wb_sram0_dat),
		.wb_sel_i		(wb_sram0_sel),
		.wb_we_i		(wb_sram0_we),
		.wb_cyc_i		(wb_sram0_cyc),
		.wb_stb_i		(wb_sram0_stb),
		.wb_cti_i		(wb_sram0_cti),
		.wb_bte_i		(wb_sram0_bte),
		.wb_dat_o		(wb_sram0_rdt),
		.wb_ack_o		(wb_sram0_ack),
		.wb_err_o		(wb_sram0_err)
	);

	wb_bootrom #(
		.DEPTH (BOOTROM_MEMDEPTH),
		.MEMFILE (BOOTROM_MEMFILE)
	)
	bootrom(
		.wb_clk_i(wb_clk),
		.wb_rst_i(wb_rst),

		.wb_adr_i(wb_rom0_adr),
		.wb_stb_i(wb_rom0_stb),
		.wb_cyc_i(wb_rom0_cyc),
		.wb_dat_o(wb_rom0_rdt),
		.wb_ack_o(wb_rom0_ack)
	);

	uart_top #(
		.SIM (SIM)
	)
	uart16550(
		.wb_clk_i(wb_clk),
		.wb_rst_i(wb_rst),

		.wb_adr_i(wb_uart0_adr),
		.wb_dat_i(wb_uart0_dat),
		.wb_sel_i(wb_uart0_sel),
		.wb_we_i(wb_uart0_we),
		.wb_cyc_i(wb_uart0_cyc),
		.wb_stb_i(wb_uart0_stb),
		.wb_dat_o(wb_uart0_rdt),
		.wb_ack_o(wb_uart0_ack),

		.stx_pad_o(uart_tx),
		.srx_pad_i(uart_rx)
	);

	gpio gpio0 (
		// GPIO bus
		.gpio_i		(gpio0_i),
		.gpio_o		(gpio0_o),
		.gpio_dir_o	(gpio0_dir_o),

		// Wishbone slave interface
		.wb_adr_i	(wb_gpio0_adr[2]),
		.wb_dat_i	(wb_gpio0_dat),
		.wb_we_i	(wb_gpio0_we),
		.wb_cyc_i	(wb_gpio0_cyc),
		.wb_stb_i	(wb_gpio0_stb),
		.wb_cti_i	(wb_gpio0_cti),
		.wb_bte_i	(wb_gpio0_bte),
		.wb_dat_o	(wb_gpio0_rdt),
		.wb_ack_o	(wb_gpio0_ack),
		.wb_err_o	(wb_gpio0_err),
		.wb_rty_o	(wb_gpio0_rty),

		.wb_clk		(wb_clk),
		.wb_rst		(wb_rst)
	);

	nanorv32_wb #(
		.PROGADDR_RESET (PROGADDR_RESET),
		.PROGADDR_IRQ (PROGADDR_IRQ),
		.COMPRESSED_ISA (0),
		.ENABLE_MUL (1),
		.ENABLE_DIV (1),
		.MACHINE_ISA (1),
		.ENABLE_IRQ_EXTERNAL (0)
	)
	nanorv32_wb (
		.wb_clk_i(wb_clk),
		.wb_rst_i(wb_rst),

		.wbm_adr_o(wb_nanorv32_adr),
		.wbm_dat_i(wb_nanorv32_rdt),
		.wbm_stb_o(wb_nanorv32_stb),
		.wbm_ack_i(wb_nanorv32_ack),
		.wbm_cyc_o(wb_nanorv32_cyc),
		.wbm_dat_o(wb_nanorv32_dat),
		.wbm_we_o(wb_nanorv32_we),
		.wbm_sel_o(wb_nanorv32_sel)
	);
	assign wb_nanorv32_cti = CTI_CLASSIC;

	assign wb_iadr_o = wb_nanorv32_adr;
endmodule
