wire [31:0] wb_nanorv32_adr;
wire [31:0] wb_nanorv32_dat;
wire  [3:0] wb_nanorv32_sel;
wire        wb_nanorv32_we;
wire        wb_nanorv32_cyc;
wire        wb_nanorv32_stb;
wire  [2:0] wb_nanorv32_cti;
wire  [1:0] wb_nanorv32_bte;
wire [31:0] wb_nanorv32_rdt;
wire        wb_nanorv32_ack;
wire        wb_nanorv32_err;
wire        wb_nanorv32_rty;
wire [31:0] wb_rom0_adr;
wire [31:0] wb_rom0_dat;
wire  [3:0] wb_rom0_sel;
wire        wb_rom0_we;
wire        wb_rom0_cyc;
wire        wb_rom0_stb;
wire  [2:0] wb_rom0_cti;
wire  [1:0] wb_rom0_bte;
wire [31:0] wb_rom0_rdt;
wire        wb_rom0_ack;
wire        wb_rom0_err;
wire        wb_rom0_rty;
wire [31:0] wb_spi0memio_adr;
wire [31:0] wb_spi0memio_dat;
wire  [3:0] wb_spi0memio_sel;
wire        wb_spi0memio_we;
wire        wb_spi0memio_cyc;
wire        wb_spi0memio_stb;
wire  [2:0] wb_spi0memio_cti;
wire  [1:0] wb_spi0memio_bte;
wire [31:0] wb_spi0memio_rdt;
wire        wb_spi0memio_ack;
wire        wb_spi0memio_err;
wire        wb_spi0memio_rty;
wire [31:0] wb_sram0_adr;
wire [31:0] wb_sram0_dat;
wire  [3:0] wb_sram0_sel;
wire        wb_sram0_we;
wire        wb_sram0_cyc;
wire        wb_sram0_stb;
wire  [2:0] wb_sram0_cti;
wire  [1:0] wb_sram0_bte;
wire [31:0] wb_sram0_rdt;
wire        wb_sram0_ack;
wire        wb_sram0_err;
wire        wb_sram0_rty;
wire [31:0] wb_sdram0_adr;
wire [31:0] wb_sdram0_dat;
wire  [3:0] wb_sdram0_sel;
wire        wb_sdram0_we;
wire        wb_sdram0_cyc;
wire        wb_sdram0_stb;
wire  [2:0] wb_sdram0_cti;
wire  [1:0] wb_sdram0_bte;
wire [31:0] wb_sdram0_rdt;
wire        wb_sdram0_ack;
wire        wb_sdram0_err;
wire        wb_sdram0_rty;
wire [31:0] wb_uart0_adr;
wire  [7:0] wb_uart0_dat;
wire  [3:0] wb_uart0_sel;
wire        wb_uart0_we;
wire        wb_uart0_cyc;
wire        wb_uart0_stb;
wire  [2:0] wb_uart0_cti;
wire  [1:0] wb_uart0_bte;
wire  [7:0] wb_uart0_rdt;
wire        wb_uart0_ack;
wire        wb_uart0_err;
wire        wb_uart0_rty;
wire [31:0] wb_gpio0_adr;
wire [31:0] wb_gpio0_dat;
wire  [3:0] wb_gpio0_sel;
wire        wb_gpio0_we;
wire        wb_gpio0_cyc;
wire        wb_gpio0_stb;
wire  [2:0] wb_gpio0_cti;
wire  [1:0] wb_gpio0_bte;
wire [31:0] wb_gpio0_rdt;
wire        wb_gpio0_ack;
wire        wb_gpio0_err;
wire        wb_gpio0_rty;
wire [31:0] wb_sdram_reserved0_adr;
wire [31:0] wb_sdram_reserved0_dat;
wire  [3:0] wb_sdram_reserved0_sel;
wire        wb_sdram_reserved0_we;
wire        wb_sdram_reserved0_cyc;
wire        wb_sdram_reserved0_stb;
wire  [2:0] wb_sdram_reserved0_cti;
wire  [1:0] wb_sdram_reserved0_bte;
wire [31:0] wb_sdram_reserved0_rdt;
wire        wb_sdram_reserved0_ack;
wire        wb_sdram_reserved0_err;
wire        wb_sdram_reserved0_rty;

wb_intercon wb_intercon0
   (.wb_clk_i                 (wb_clk),
    .wb_rst_i                 (wb_rst),
    .wb_nanorv32_adr_i        (wb_nanorv32_adr),
    .wb_nanorv32_dat_i        (wb_nanorv32_dat),
    .wb_nanorv32_sel_i        (wb_nanorv32_sel),
    .wb_nanorv32_we_i         (wb_nanorv32_we),
    .wb_nanorv32_cyc_i        (wb_nanorv32_cyc),
    .wb_nanorv32_stb_i        (wb_nanorv32_stb),
    .wb_nanorv32_cti_i        (wb_nanorv32_cti),
    .wb_nanorv32_bte_i        (wb_nanorv32_bte),
    .wb_nanorv32_rdt_o        (wb_nanorv32_rdt),
    .wb_nanorv32_ack_o        (wb_nanorv32_ack),
    .wb_nanorv32_err_o        (wb_nanorv32_err),
    .wb_nanorv32_rty_o        (wb_nanorv32_rty),
    .wb_rom0_adr_o            (wb_rom0_adr),
    .wb_rom0_dat_o            (wb_rom0_dat),
    .wb_rom0_sel_o            (wb_rom0_sel),
    .wb_rom0_we_o             (wb_rom0_we),
    .wb_rom0_cyc_o            (wb_rom0_cyc),
    .wb_rom0_stb_o            (wb_rom0_stb),
    .wb_rom0_cti_o            (wb_rom0_cti),
    .wb_rom0_bte_o            (wb_rom0_bte),
    .wb_rom0_rdt_i            (wb_rom0_rdt),
    .wb_rom0_ack_i            (wb_rom0_ack),
    .wb_rom0_err_i            (wb_rom0_err),
    .wb_rom0_rty_i            (wb_rom0_rty),
    .wb_spi0memio_adr_o       (wb_spi0memio_adr),
    .wb_spi0memio_dat_o       (wb_spi0memio_dat),
    .wb_spi0memio_sel_o       (wb_spi0memio_sel),
    .wb_spi0memio_we_o        (wb_spi0memio_we),
    .wb_spi0memio_cyc_o       (wb_spi0memio_cyc),
    .wb_spi0memio_stb_o       (wb_spi0memio_stb),
    .wb_spi0memio_cti_o       (wb_spi0memio_cti),
    .wb_spi0memio_bte_o       (wb_spi0memio_bte),
    .wb_spi0memio_rdt_i       (wb_spi0memio_rdt),
    .wb_spi0memio_ack_i       (wb_spi0memio_ack),
    .wb_spi0memio_err_i       (wb_spi0memio_err),
    .wb_spi0memio_rty_i       (wb_spi0memio_rty),
    .wb_sram0_adr_o           (wb_sram0_adr),
    .wb_sram0_dat_o           (wb_sram0_dat),
    .wb_sram0_sel_o           (wb_sram0_sel),
    .wb_sram0_we_o            (wb_sram0_we),
    .wb_sram0_cyc_o           (wb_sram0_cyc),
    .wb_sram0_stb_o           (wb_sram0_stb),
    .wb_sram0_cti_o           (wb_sram0_cti),
    .wb_sram0_bte_o           (wb_sram0_bte),
    .wb_sram0_rdt_i           (wb_sram0_rdt),
    .wb_sram0_ack_i           (wb_sram0_ack),
    .wb_sram0_err_i           (wb_sram0_err),
    .wb_sram0_rty_i           (wb_sram0_rty),
    .wb_sdram0_adr_o          (wb_sdram0_adr),
    .wb_sdram0_dat_o          (wb_sdram0_dat),
    .wb_sdram0_sel_o          (wb_sdram0_sel),
    .wb_sdram0_we_o           (wb_sdram0_we),
    .wb_sdram0_cyc_o          (wb_sdram0_cyc),
    .wb_sdram0_stb_o          (wb_sdram0_stb),
    .wb_sdram0_cti_o          (wb_sdram0_cti),
    .wb_sdram0_bte_o          (wb_sdram0_bte),
    .wb_sdram0_rdt_i          (wb_sdram0_rdt),
    .wb_sdram0_ack_i          (wb_sdram0_ack),
    .wb_sdram0_err_i          (wb_sdram0_err),
    .wb_sdram0_rty_i          (wb_sdram0_rty),
    .wb_uart0_adr_o           (wb_uart0_adr),
    .wb_uart0_dat_o           (wb_uart0_dat),
    .wb_uart0_sel_o           (wb_uart0_sel),
    .wb_uart0_we_o            (wb_uart0_we),
    .wb_uart0_cyc_o           (wb_uart0_cyc),
    .wb_uart0_stb_o           (wb_uart0_stb),
    .wb_uart0_cti_o           (wb_uart0_cti),
    .wb_uart0_bte_o           (wb_uart0_bte),
    .wb_uart0_rdt_i           (wb_uart0_rdt),
    .wb_uart0_ack_i           (wb_uart0_ack),
    .wb_uart0_err_i           (wb_uart0_err),
    .wb_uart0_rty_i           (wb_uart0_rty),
    .wb_gpio0_adr_o           (wb_gpio0_adr),
    .wb_gpio0_dat_o           (wb_gpio0_dat),
    .wb_gpio0_sel_o           (wb_gpio0_sel),
    .wb_gpio0_we_o            (wb_gpio0_we),
    .wb_gpio0_cyc_o           (wb_gpio0_cyc),
    .wb_gpio0_stb_o           (wb_gpio0_stb),
    .wb_gpio0_cti_o           (wb_gpio0_cti),
    .wb_gpio0_bte_o           (wb_gpio0_bte),
    .wb_gpio0_rdt_i           (wb_gpio0_rdt),
    .wb_gpio0_ack_i           (wb_gpio0_ack),
    .wb_gpio0_err_i           (wb_gpio0_err),
    .wb_gpio0_rty_i           (wb_gpio0_rty),
    .wb_sdram_reserved0_adr_o (wb_sdram_reserved0_adr),
    .wb_sdram_reserved0_dat_o (wb_sdram_reserved0_dat),
    .wb_sdram_reserved0_sel_o (wb_sdram_reserved0_sel),
    .wb_sdram_reserved0_we_o  (wb_sdram_reserved0_we),
    .wb_sdram_reserved0_cyc_o (wb_sdram_reserved0_cyc),
    .wb_sdram_reserved0_stb_o (wb_sdram_reserved0_stb),
    .wb_sdram_reserved0_cti_o (wb_sdram_reserved0_cti),
    .wb_sdram_reserved0_bte_o (wb_sdram_reserved0_bte),
    .wb_sdram_reserved0_rdt_i (wb_sdram_reserved0_rdt),
    .wb_sdram_reserved0_ack_i (wb_sdram_reserved0_ack),
    .wb_sdram_reserved0_err_i (wb_sdram_reserved0_err),
    .wb_sdram_reserved0_rty_i (wb_sdram_reserved0_rty));

