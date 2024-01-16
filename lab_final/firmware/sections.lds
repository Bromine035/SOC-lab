/* INCLUDE ../../generated/output_format.ld */

OUTPUT_FORMAT("elf32-littleriscv")

ENTRY(_start)

__DYNAMIC = 0;

/* INCLUDE ../../generated/regions.ld */

MEMORY {
	vexriscv_debug : ORIGIN = 0xf00f0000, LENGTH = 0x00000100
	dff : ORIGIN = 0x00000000, LENGTH = 0x00000400
	dff2 : ORIGIN = 0x00000400, LENGTH = 0x00000200
	flash : ORIGIN = 0x10000000, LENGTH = 0x01000000
	mprj : ORIGIN = 0x30000000, LENGTH = 0x00100000
    /* mprjram : ORIGIN = 0x38000000, LENGTH = 0x00400000 */
	fir_tap : ORIGIN = 0x38000000, LENGTH = 0x00000040
    fir_x : ORIGIN = 0x38000040, LENGTH = 0x00000040
    fir_y : ORIGIN = 0x38000080, LENGTH = 0x00000040
    mm_a : ORIGIN = 0x380000c0, LENGTH = 0x00000040
    mm_b : ORIGIN = 0x38000100, LENGTH = 0x00000040
    mm_o : ORIGIN = 0x38000140, LENGTH = 0x00000040
    qs_a : ORIGIN = 0x38000180, LENGTH = 0x00000040
    qs_o : ORIGIN = 0x380001c0, LENGTH = 0x00000040
    mprjram : ORIGIN = 0x38000200, LENGTH = 0x00000200
	hk : ORIGIN = 0x26000000, LENGTH = 0x00100000
	csr : ORIGIN = 0xf0000000, LENGTH = 0x00010000
}

SECTIONS
{
	.text :
	{
		_ftext = .;
		/* Make sure crt0 files come first, and they, and the isr */
		/* don't get disposed of by greedy optimisation */
		*crt0*(.text)
		KEEP(*crt0*(.text))
		KEEP(*(.text.isr))

		/* *(.text .stub .text.* .gnu.linkonce.t.*) */
		_etext = .;
	} > flash

	.rodata :
	{
		. = ALIGN(8);
		_frodata = .;
		*(.rodata .rodata.* .gnu.linkonce.r.*)
		*(.rodata1)
		. = ALIGN(8);
		_erodata = .;
	} > flash

	.data :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > dff AT > flash

	.bss :
	{
		. = ALIGN(8);
		_fbss = .;
		*(.dynsbss)
		*(.sbss .sbss.* .gnu.linkonce.sb.*)
		*(.scommon)
		*(.dynbss)
		*(.bss .bss.* .gnu.linkonce.b.*)
		*(COMMON)
		. = ALIGN(8);
		_ebss = .;
		_end = .;
	} > dff AT > flash

    .fir_tap :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > fir_tap AT > flash

    .fir_x :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > fir_x AT > flash

    .fir_y :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > fir_y AT > flash

    .mm_a :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > mm_a AT > flash

    .mm_b :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > mm_b AT > flash

    .mm_o :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > mm_o AT > flash

    .qs_a :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > qs_a AT > flash

    .qs_o :
	{
		. = ALIGN(8);
		_fdata = .;
		*(.data .data.* .gnu.linkonce.d.*)
		*(.data1)
		_gp = ALIGN(16);
		*(.sdata .sdata.* .gnu.linkonce.s.*)
		. = ALIGN(8);
		_edata = .;
	} > qs_o AT > flash

	.mprjram :
	{
		. = ALIGN(8);
		_fsram = .;
		*libgcc.a:*(.text .text.*)
	} > mprjram AT > flash
}

PROVIDE(_fstack = ORIGIN(dff2) + LENGTH(dff2));

PROVIDE(_fdata_rom = LOADADDR(.data));
PROVIDE(_edata_rom = LOADADDR(.data) + SIZEOF(.data));

PROVIDE(_esram = ORIGIN(mprjram) + SIZEOF(.mprjram));
PROVIDE(_esram_rom = LOADADDR(.mprjram));
