	.file	"final.c"
	.option nopic
	.attribute arch, "rv32i2p0"
	.attribute unaligned_access, 0
	.attribute stack_align, 16
	.text
.Ltext0:
	.cfi_sections	.debug_frame
	.file 0 "/home/ubuntu/soc/lab_final/testbench/final" "final.c"
	.align	2
	.type	flush_cpu_icache, @function
flush_cpu_icache:
.LFB21:
	.file 1 "../../firmware/system.h"
	.loc 1 15 1
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 26 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE21:
	.size	flush_cpu_icache, .-flush_cpu_icache
	.align	2
	.type	flush_cpu_dcache, @function
flush_cpu_dcache:
.LFB22:
	.loc 1 29 1
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 1 33 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE22:
	.size	flush_cpu_dcache, .-flush_cpu_dcache
	.align	2
	.type	csr_write_simple, @function
csr_write_simple:
.LFB23:
	.file 2 "../../firmware/hw/common.h"
	.loc 2 33 1
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	sw	a1,-24(s0)
	.loc 2 34 5
	lw	a5,-24(s0)
	.loc 2 34 32
	lw	a4,-20(s0)
	sw	a4,0(a5)
	.loc 2 35 1
	nop
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE23:
	.size	csr_write_simple, .-csr_write_simple
	.align	2
	.type	user_irq_0_ev_enable_write, @function
user_irq_0_ev_enable_write:
.LFB209:
	.file 3 "../../firmware/csr.h"
	.loc 3 805 59
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	.loc 3 806 2
	li	a5,-268406784
	addi	a1,a5,-2028
	lw	a0,-20(s0)
	call	csr_write_simple
	.loc 3 807 1
	nop
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE209:
	.size	user_irq_0_ev_enable_write, .-user_irq_0_ev_enable_write
	.globl	taps
	.section	.fir_tap,"aw"
	.align	2
	.type	taps, @object
	.size	taps, 44
taps:
	.zero	44
	.globl	inputsignal
	.section	.fir_x,"aw"
	.align	2
	.type	inputsignal, @object
	.size	inputsignal, 64
inputsignal:
	.zero	64
	.globl	outputsignal
	.section	.fir_y,"aw"
	.align	2
	.type	outputsignal, @object
	.size	outputsignal, 64
outputsignal:
	.zero	64
	.globl	Am
	.section	.mm_a,"aw"
	.align	2
	.type	Am, @object
	.size	Am, 64
Am:
	.zero	64
	.globl	Bm
	.section	.mm_b,"aw"
	.align	2
	.type	Bm, @object
	.size	Bm, 64
Bm:
	.zero	64
	.globl	Mo
	.section	.mm_o,"aw"
	.align	2
	.type	Mo, @object
	.size	Mo, 64
Mo:
	.zero	64
	.globl	Aq
	.section	.qs_a,"aw"
	.align	2
	.type	Aq, @object
	.size	Aq, 64
Aq:
	.zero	64
	.globl	Vo
	.section	.qs_o,"aw"
	.align	2
	.type	Vo, @object
	.size	Vo, 64
Vo:
	.zero	64
	.text
	.align	2
	.globl	init_data
	.type	init_data, @function
init_data:
.LFB316:
	.file 4 "final.h"
	.loc 4 42 17
	.cfi_startproc
	addi	sp,sp,-16
	.cfi_def_cfa_offset 16
	sw	s0,12(sp)
	.cfi_offset 8, -4
	addi	s0,sp,16
	.cfi_def_cfa 8, 0
	.loc 4 43 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	sw	zero,0(a5)
	.loc 4 44 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,-10
	sw	a4,4(a5)
	.loc 4 45 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,-9
	sw	a4,8(a5)
	.loc 4 46 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,23
	sw	a4,12(a5)
	.loc 4 47 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,56
	sw	a4,16(a5)
	.loc 4 48 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,63
	sw	a4,20(a5)
	.loc 4 49 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,56
	sw	a4,24(a5)
	.loc 4 50 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,23
	sw	a4,28(a5)
	.loc 4 51 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,-9
	sw	a4,32(a5)
	.loc 4 52 13
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	li	a4,-10
	sw	a4,36(a5)
	.loc 4 53 14
	lui	a5,%hi(taps)
	addi	a5,a5,%lo(taps)
	sw	zero,40(a5)
	.loc 4 55 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,1
	sw	a4,0(a5)
	.loc 4 56 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,2
	sw	a4,4(a5)
	.loc 4 57 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,3
	sw	a4,8(a5)
	.loc 4 58 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,4
	sw	a4,12(a5)
	.loc 4 59 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,5
	sw	a4,16(a5)
	.loc 4 60 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,6
	sw	a4,20(a5)
	.loc 4 61 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,7
	sw	a4,24(a5)
	.loc 4 62 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,8
	sw	a4,28(a5)
	.loc 4 63 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,9
	sw	a4,32(a5)
	.loc 4 64 20
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,10
	sw	a4,36(a5)
	.loc 4 65 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,11
	sw	a4,40(a5)
	.loc 4 66 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,12
	sw	a4,44(a5)
	.loc 4 67 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,13
	sw	a4,48(a5)
	.loc 4 68 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,14
	sw	a4,52(a5)
	.loc 4 69 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,15
	sw	a4,56(a5)
	.loc 4 70 21
	lui	a5,%hi(inputsignal)
	addi	a5,a5,%lo(inputsignal)
	li	a4,16
	sw	a4,60(a5)
	.loc 4 84 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	sw	zero,0(a5)
	.loc 4 85 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,1
	sw	a4,4(a5)
	.loc 4 86 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,2
	sw	a4,8(a5)
	.loc 4 87 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,3
	sw	a4,12(a5)
	.loc 4 88 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	sw	zero,16(a5)
	.loc 4 89 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,1
	sw	a4,20(a5)
	.loc 4 90 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,2
	sw	a4,24(a5)
	.loc 4 91 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,3
	sw	a4,28(a5)
	.loc 4 92 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	sw	zero,32(a5)
	.loc 4 93 11
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,1
	sw	a4,36(a5)
	.loc 4 94 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,2
	sw	a4,40(a5)
	.loc 4 95 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,3
	sw	a4,44(a5)
	.loc 4 96 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	sw	zero,48(a5)
	.loc 4 97 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,1
	sw	a4,52(a5)
	.loc 4 98 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,2
	sw	a4,56(a5)
	.loc 4 99 12
	lui	a5,%hi(Am)
	addi	a5,a5,%lo(Am)
	li	a4,3
	sw	a4,60(a5)
	.loc 4 101 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,1
	sw	a4,0(a5)
	.loc 4 102 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,2
	sw	a4,4(a5)
	.loc 4 103 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,3
	sw	a4,8(a5)
	.loc 4 104 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,4
	sw	a4,12(a5)
	.loc 4 105 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,5
	sw	a4,16(a5)
	.loc 4 106 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,6
	sw	a4,20(a5)
	.loc 4 107 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,7
	sw	a4,24(a5)
	.loc 4 108 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,8
	sw	a4,28(a5)
	.loc 4 109 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,9
	sw	a4,32(a5)
	.loc 4 110 11
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,10
	sw	a4,36(a5)
	.loc 4 111 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,11
	sw	a4,40(a5)
	.loc 4 112 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,12
	sw	a4,44(a5)
	.loc 4 113 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,13
	sw	a4,48(a5)
	.loc 4 114 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,14
	sw	a4,52(a5)
	.loc 4 115 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,15
	sw	a4,56(a5)
	.loc 4 116 12
	lui	a5,%hi(Bm)
	addi	a5,a5,%lo(Bm)
	li	a4,16
	sw	a4,60(a5)
	.loc 4 118 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,893
	sw	a4,0(a5)
	.loc 4 119 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,40
	sw	a4,4(a5)
	.loc 4 120 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,-863
	sw	a4,8(a5)
	.loc 4 121 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,171
	sw	a4,12(a5)
	.loc 4 122 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,1
	sw	a4,16(a5)
	.loc 4 123 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,-1555
	sw	a4,20(a5)
	.loc 4 124 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,8192
	addi	a4,a4,881
	sw	a4,24(a5)
	.loc 4 125 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,1927
	sw	a4,28(a5)
	.loc 4 126 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,1585
	sw	a4,32(a5)
	.loc 4 127 11
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,526
	sw	a4,36(a5)
	.loc 4 128 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,4096
	addi	a4,a4,526
	sw	a4,40(a5)
	.loc 4 129 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,-1234
	sw	a4,44(a5)
	.loc 4 130 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,-4096
	addi	a4,a4,-1582
	sw	a4,48(a5)
	.loc 4 131 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,-1234
	sw	a4,52(a5)
	.loc 4 132 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	sw	zero,56(a5)
	.loc 4 133 12
	lui	a5,%hi(Aq)
	addi	a5,a5,%lo(Aq)
	li	a4,-1
	sw	a4,60(a5)
	.loc 4 135 1
	nop
	lw	s0,12(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 16
	addi	sp,sp,16
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE316:
	.size	init_data, .-init_data
	.align	2
	.type	irq_getmask, @function
irq_getmask:
.LFB319:
	.file 5 "../../firmware/irq_vex.h"
	.loc 5 23 1
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	.loc 5 25 2
 #APP
# 25 "../../firmware/irq_vex.h" 1
	csrr a5, 3008
# 0 "" 2
 #NO_APP
	sw	a5,-20(s0)
	.loc 5 26 9
	lw	a5,-20(s0)
	.loc 5 27 1
	mv	a0,a5
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE319:
	.size	irq_getmask, .-irq_getmask
	.align	2
	.type	irq_setmask, @function
irq_setmask:
.LFB320:
	.loc 5 30 1
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	s0,28(sp)
	.cfi_offset 8, -4
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	sw	a0,-20(s0)
	.loc 5 31 2
	lw	a5,-20(s0)
 #APP
# 31 "../../firmware/irq_vex.h" 1
	csrw 3008, a5
# 0 "" 2
	.loc 5 32 1
 #NO_APP
	nop
	lw	s0,28(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE320:
	.size	irq_setmask, .-irq_setmask
	.align	2
	.globl	main
	.type	main, @function
main:
.LFB322:
	.file 6 "final.c"
	.loc 6 47 1
	.cfi_startproc
	addi	sp,sp,-32
	.cfi_def_cfa_offset 32
	sw	ra,28(sp)
	sw	s0,24(sp)
	.cfi_offset 1, -4
	.cfi_offset 8, -8
	addi	s0,sp,32
	.cfi_def_cfa 8, 0
	.loc 6 79 6
	li	a5,-268419072
	addi	a5,a5,-2048
	.loc 6 79 53
	li	a4,1
	sw	a4,0(a5)
	.loc 6 81 6
	li	a5,637534208
	addi	a5,a5,160
	.loc 6 81 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 82 6
	li	a5,637534208
	addi	a5,a5,156
	.loc 6 82 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 83 6
	li	a5,637534208
	addi	a5,a5,152
	.loc 6 83 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 84 6
	li	a5,637534208
	addi	a5,a5,148
	.loc 6 84 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 85 6
	li	a5,637534208
	addi	a5,a5,144
	.loc 6 85 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 86 6
	li	a5,637534208
	addi	a5,a5,140
	.loc 6 86 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 87 6
	li	a5,637534208
	addi	a5,a5,136
	.loc 6 87 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 88 6
	li	a5,637534208
	addi	a5,a5,132
	.loc 6 88 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 89 6
	li	a5,637534208
	addi	a5,a5,128
	.loc 6 89 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 90 6
	li	a5,637534208
	addi	a5,a5,124
	.loc 6 90 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 91 6
	li	a5,637534208
	addi	a5,a5,120
	.loc 6 91 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 92 6
	li	a5,637534208
	addi	a5,a5,116
	.loc 6 92 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 93 6
	li	a5,637534208
	addi	a5,a5,112
	.loc 6 93 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 94 6
	li	a5,637534208
	addi	a5,a5,108
	.loc 6 94 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 95 6
	li	a5,637534208
	addi	a5,a5,104
	.loc 6 95 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 96 6
	li	a5,637534208
	addi	a5,a5,100
	.loc 6 96 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 98 6
	li	a5,637534208
	addi	a5,a5,96
	.loc 6 98 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 99 6
	li	a5,637534208
	addi	a5,a5,92
	.loc 6 99 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 100 6
	li	a5,637534208
	addi	a5,a5,88
	.loc 6 100 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 101 6
	li	a5,637534208
	addi	a5,a5,84
	.loc 6 101 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 102 6
	li	a5,637534208
	addi	a5,a5,80
	.loc 6 102 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 103 6
	li	a5,637534208
	addi	a5,a5,76
	.loc 6 103 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 104 6
	li	a5,637534208
	addi	a5,a5,72
	.loc 6 104 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 105 6
	li	a5,637534208
	addi	a5,a5,68
	.loc 6 105 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 106 6
	li	a5,637534208
	addi	a5,a5,64
	.loc 6 106 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 107 6
	li	a5,637534208
	addi	a5,a5,60
	.loc 6 107 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 108 6
	li	a5,637534208
	addi	a5,a5,56
	.loc 6 108 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 109 6
	li	a5,637534208
	addi	a5,a5,52
	.loc 6 109 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 110 6
	li	a5,637534208
	addi	a5,a5,48
	.loc 6 110 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 111 6
	li	a5,637534208
	addi	a5,a5,44
	.loc 6 111 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 112 6
	li	a5,637534208
	addi	a5,a5,40
	.loc 6 112 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 113 6
	li	a5,637534208
	addi	a5,a5,36
	.loc 6 113 39
	li	a4,8192
	addi	a4,a4,-2039
	sw	a4,0(a5)
	.loc 6 115 6
	li	a5,637534208
	addi	a5,a5,172
	.loc 6 115 39
	li	a4,8192
	addi	a4,a4,-2040
	sw	a4,0(a5)
	.loc 6 116 6
	li	a5,637534208
	addi	a5,a5,168
	.loc 6 116 39
	li	a4,1026
	sw	a4,0(a5)
	.loc 6 117 6
	li	a5,637534208
	addi	a5,a5,164
	.loc 6 117 39
	li	a4,8192
	addi	a4,a4,-2040
	sw	a4,0(a5)
	.loc 6 125 3
	li	a5,637534208
	.loc 6 125 36
	li	a4,1
	sw	a4,0(a5)
	.loc 6 126 8
	nop
.L10:
	.loc 6 126 10 discriminator 1
	li	a5,637534208
	lw	a4,0(a5)
	.loc 6 126 43 discriminator 1
	li	a5,1
	beq	a4,a5,.L10
	.loc 6 130 60
	li	a5,-268423168
	addi	a4,a5,12
	.loc 6 130 114
	li	a5,0
	sw	a5,0(a4)
	.loc 6 130 3
	li	a4,-268423168
	addi	a4,a4,28
	.loc 6 130 57
	sw	a5,0(a4)
	.loc 6 131 59
	li	a5,-268423168
	addi	a4,a5,8
	.loc 6 131 112
	li	a5,-1
	sw	a5,0(a4)
	.loc 6 131 3
	li	a4,-268423168
	addi	a4,a4,24
	.loc 6 131 56
	sw	a5,0(a4)
	.loc 6 132 59
	li	a5,-268423168
	addi	a4,a5,4
	.loc 6 132 112
	li	a5,0
	sw	a5,0(a4)
	.loc 6 132 3
	li	a4,-268423168
	addi	a4,a4,20
	.loc 6 132 56
	sw	a5,0(a4)
	.loc 6 133 53
	li	a4,-268423168
	.loc 6 133 100
	li	a5,0
	sw	a5,0(a4)
	.loc 6 133 3
	li	a4,-268423168
	addi	a4,a4,16
	.loc 6 133 50
	sw	a5,0(a4)
	.loc 6 137 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 137 36
	li	a4,-1419771904
	sw	a4,0(a5)
	.loc 6 140 3
	li	a5,-268423168
	addi	a5,a5,56
	.loc 6 140 56
	sw	zero,0(a5)
	.loc 6 143 59
	li	a5,-268423168
	addi	a4,a5,8
	.loc 6 143 112
	li	a5,0
	sw	a5,0(a4)
	.loc 6 143 3
	li	a4,-268423168
	addi	a4,a4,24
	.loc 6 143 56
	sw	a5,0(a4)
	.loc 6 145 5
	call	init_data
	.loc 6 149 9
	call	irq_getmask
	mv	a5,a0
	.loc 6 149 7
	sw	a5,-32(s0)
	.loc 6 150 7
	lw	a5,-32(s0)
	ori	a5,a5,4
	sw	a5,-32(s0)
	.loc 6 151 2
	lw	a5,-32(s0)
	mv	a0,a5
	call	irq_setmask
	.loc 6 153 2
	li	a0,1
	call	user_irq_0_ev_enable_write
	.loc 6 157 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 157 36
	li	a4,-1421869056
	sw	a4,0(a5)
	.loc 6 160 3
	li	a5,-268423168
	addi	a5,a5,56
	.loc 6 160 56
	sw	zero,0(a5)
	.loc 6 163 59
	li	a5,-268423168
	addi	a4,a5,8
	.loc 6 163 112
	li	a5,0
	sw	a5,0(a4)
	.loc 6 163 3
	li	a4,-268423168
	addi	a4,a4,24
	.loc 6 163 56
	sw	a5,0(a4)
	.loc 6 165 11
	nop
.L11:
	.loc 6 165 13 discriminator 1
	li	a5,-268423168
	addi	a5,a5,44
	lw	a5,0(a5)
	.loc 6 165 67 discriminator 1
	beq	a5,zero,.L11
.LBB2:
	.loc 6 166 13
	sw	zero,-20(s0)
	.loc 6 166 5
	j	.L12
.L13:
	.loc 6 167 57 discriminator 3
	lui	a5,%hi(outputsignal)
	addi	a4,a5,%lo(outputsignal)
	lw	a5,-20(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 6 167 10 discriminator 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 167 43 discriminator 3
	sw	a4,0(a5)
	.loc 6 166 33 discriminator 3
	lw	a5,-20(s0)
	addi	a5,a5,1
	sw	a5,-20(s0)
.L12:
	.loc 6 166 24 discriminator 1
	lw	a4,-20(s0)
	li	a5,15
	ble	a4,a5,.L13
.LBE2:
.LBB3:
	.loc 6 169 13
	sw	zero,-24(s0)
	.loc 6 169 5
	j	.L14
.L15:
	.loc 6 170 47 discriminator 3
	lui	a5,%hi(Mo)
	addi	a4,a5,%lo(Mo)
	lw	a5,-24(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 6 170 10 discriminator 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 170 43 discriminator 3
	sw	a4,0(a5)
	.loc 6 169 33 discriminator 3
	lw	a5,-24(s0)
	addi	a5,a5,1
	sw	a5,-24(s0)
.L14:
	.loc 6 169 24 discriminator 1
	lw	a4,-24(s0)
	li	a5,15
	ble	a4,a5,.L15
.LBE3:
.LBB4:
	.loc 6 172 13
	sw	zero,-28(s0)
	.loc 6 172 5
	j	.L16
.L17:
	.loc 6 173 47 discriminator 3
	lui	a5,%hi(Vo)
	addi	a4,a5,%lo(Vo)
	lw	a5,-28(s0)
	slli	a5,a5,2
	add	a5,a4,a5
	lw	a4,0(a5)
	.loc 6 173 10 discriminator 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 173 43 discriminator 3
	sw	a4,0(a5)
	.loc 6 172 33 discriminator 3
	lw	a5,-28(s0)
	addi	a5,a5,1
	sw	a5,-28(s0)
.L16:
	.loc 6 172 24 discriminator 1
	lw	a4,-28(s0)
	li	a5,15
	ble	a4,a5,.L17
.LBE4:
	.loc 6 176 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 176 36
	li	a4,-1420754944
	sw	a4,0(a5)
	.loc 6 177 3
	li	a5,637534208
	addi	a5,a5,12
	.loc 6 177 36
	li	a4,-1419706368
	sw	a4,0(a5)
	.loc 6 178 1
	nop
	lw	ra,28(sp)
	.cfi_restore 1
	lw	s0,24(sp)
	.cfi_restore 8
	.cfi_def_cfa 2, 32
	addi	sp,sp,32
	.cfi_def_cfa_offset 0
	jr	ra
	.cfi_endproc
.LFE322:
	.size	main, .-main
.Letext0:
	.file 7 "/opt/riscv/lib/gcc/riscv32-unknown-elf/12.1.0/include/stdint-gcc.h"
	.section	.debug_info,"",@progbits
.Ldebug_info0:
	.4byte	0x256
	.2byte	0x5
	.byte	0x1
	.byte	0x4
	.4byte	.Ldebug_abbrev0
	.byte	0xc
	.4byte	.LASF20
	.byte	0x1d
	.4byte	.LASF0
	.4byte	.LASF1
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	.Ldebug_line0
	.byte	0x1
	.byte	0x1
	.byte	0x6
	.4byte	.LASF2
	.byte	0x1
	.byte	0x2
	.byte	0x5
	.4byte	.LASF3
	.byte	0x1
	.byte	0x4
	.byte	0x5
	.4byte	.LASF4
	.byte	0x1
	.byte	0x8
	.byte	0x5
	.4byte	.LASF5
	.byte	0x1
	.byte	0x1
	.byte	0x8
	.4byte	.LASF6
	.byte	0x1
	.byte	0x2
	.byte	0x7
	.4byte	.LASF7
	.byte	0xd
	.4byte	.LASF21
	.byte	0x7
	.byte	0x34
	.byte	0x1b
	.4byte	0x5c
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF8
	.byte	0x1
	.byte	0x8
	.byte	0x7
	.4byte	.LASF9
	.byte	0xe
	.byte	0x4
	.byte	0x5
	.string	"int"
	.byte	0x1
	.byte	0x4
	.byte	0x7
	.4byte	.LASF10
	.byte	0x5
	.4byte	0x6a
	.4byte	0x88
	.byte	0x6
	.4byte	0x71
	.byte	0xa
	.byte	0
	.byte	0x3
	.4byte	.LASF11
	.byte	0x1d
	.byte	0x32
	.4byte	0x78
	.byte	0x5
	.byte	0x3
	.4byte	taps
	.byte	0x5
	.4byte	0x6a
	.4byte	0xa9
	.byte	0x6
	.4byte	0x71
	.byte	0xf
	.byte	0
	.byte	0x3
	.4byte	.LASF12
	.byte	0x1e
	.byte	0x30
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	inputsignal
	.byte	0x3
	.4byte	.LASF13
	.byte	0x1f
	.byte	0x30
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	outputsignal
	.byte	0x2
	.string	"Am"
	.byte	0x22
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	Am
	.byte	0x2
	.string	"Bm"
	.byte	0x23
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	Bm
	.byte	0x2
	.string	"Mo"
	.byte	0x24
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	Mo
	.byte	0x2
	.string	"Aq"
	.byte	0x27
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	Aq
	.byte	0x2
	.string	"Vo"
	.byte	0x28
	.4byte	0x99
	.byte	0x5
	.byte	0x3
	.4byte	Vo
	.byte	0xf
	.4byte	.LASF22
	.byte	0x6
	.byte	0x2e
	.byte	0x6
	.4byte	.LFB322
	.4byte	.LFE322-.LFB322
	.byte	0x1
	.byte	0x9c
	.4byte	0x186
	.byte	0x7
	.4byte	.LASF14
	.byte	0x6
	.byte	0x31
	.byte	0x9
	.4byte	0x6a
	.byte	0x2
	.byte	0x91
	.byte	0x60
	.byte	0x8
	.4byte	.LBB2
	.4byte	.LBE2-.LBB2
	.4byte	0x155
	.byte	0x4
	.string	"i0"
	.byte	0xa6
	.4byte	0x6a
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0x8
	.4byte	.LBB3
	.4byte	.LBE3-.LBB3
	.4byte	0x16f
	.byte	0x4
	.string	"i1"
	.byte	0xa9
	.4byte	0x6a
	.byte	0x2
	.byte	0x91
	.byte	0x68
	.byte	0
	.byte	0x10
	.4byte	.LBB4
	.4byte	.LBE4-.LBB4
	.byte	0x4
	.string	"i2"
	.byte	0xac
	.4byte	0x6a
	.byte	0x2
	.byte	0x91
	.byte	0x64
	.byte	0
	.byte	0
	.byte	0x9
	.4byte	.LASF15
	.byte	0x5
	.byte	0x1d
	.4byte	.LFB320
	.4byte	.LFE320-.LFB320
	.byte	0x1
	.byte	0x9c
	.4byte	0x1ab
	.byte	0x11
	.4byte	.LASF14
	.byte	0x5
	.byte	0x1d
	.byte	0x2d
	.4byte	0x71
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0x12
	.4byte	.LASF23
	.byte	0x5
	.byte	0x16
	.byte	0x1c
	.4byte	0x71
	.4byte	.LFB319
	.4byte	.LFE319-.LFB319
	.byte	0x1
	.byte	0x9c
	.4byte	0x1d5
	.byte	0x7
	.4byte	.LASF14
	.byte	0x5
	.byte	0x18
	.byte	0xf
	.4byte	0x71
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0x13
	.4byte	.LASF24
	.byte	0x4
	.byte	0x2a
	.byte	0x6
	.4byte	.LFB316
	.4byte	.LFE316-.LFB316
	.byte	0x1
	.byte	0x9c
	.byte	0x14
	.4byte	.LASF16
	.byte	0x3
	.2byte	0x325
	.byte	0x14
	.4byte	.LFB209
	.4byte	.LFE209-.LFB209
	.byte	0x1
	.byte	0x9c
	.4byte	0x20d
	.byte	0x15
	.string	"v"
	.byte	0x3
	.2byte	0x325
	.byte	0x38
	.4byte	0x50
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0
	.byte	0x9
	.4byte	.LASF17
	.byte	0x2
	.byte	0x20
	.4byte	.LFB23
	.4byte	.LFE23-.LFB23
	.byte	0x1
	.byte	0x9c
	.4byte	0x239
	.byte	0xa
	.string	"v"
	.byte	0x33
	.4byte	0x5c
	.byte	0x2
	.byte	0x91
	.byte	0x6c
	.byte	0xa
	.string	"a"
	.byte	0x44
	.4byte	0x5c
	.byte	0x2
	.byte	0x91
	.byte	0x68
	.byte	0
	.byte	0xb
	.4byte	.LASF18
	.byte	0x1c
	.4byte	.LFB22
	.4byte	.LFE22-.LFB22
	.byte	0x1
	.byte	0x9c
	.byte	0xb
	.4byte	.LASF19
	.byte	0xe
	.4byte	.LFB21
	.4byte	.LFE21-.LFB21
	.byte	0x1
	.byte	0x9c
	.byte	0
	.section	.debug_abbrev,"",@progbits
.Ldebug_abbrev0:
	.byte	0x1
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0xe
	.byte	0
	.byte	0
	.byte	0x2
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x4
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x2f
	.byte	0x49
	.byte	0x13
	.byte	0x3f
	.byte	0x19
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x3
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x4
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x3f
	.byte	0x19
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x4
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x6
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0xd
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x5
	.byte	0x1
	.byte	0x1
	.byte	0x49
	.byte	0x13
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x6
	.byte	0x21
	.byte	0
	.byte	0x49
	.byte	0x13
	.byte	0x2f
	.byte	0xb
	.byte	0
	.byte	0
	.byte	0x7
	.byte	0x34
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x8
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x9
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x14
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xa
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0x21
	.byte	0x2
	.byte	0x3b
	.byte	0x21
	.byte	0x20
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0xb
	.byte	0x2e
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0x21
	.byte	0x1
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0x21
	.byte	0x25
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0xc
	.byte	0x11
	.byte	0x1
	.byte	0x25
	.byte	0xe
	.byte	0x13
	.byte	0xb
	.byte	0x3
	.byte	0x1f
	.byte	0x1b
	.byte	0x1f
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x10
	.byte	0x17
	.byte	0
	.byte	0
	.byte	0xd
	.byte	0x16
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0xe
	.byte	0x24
	.byte	0
	.byte	0xb
	.byte	0xb
	.byte	0x3e
	.byte	0xb
	.byte	0x3
	.byte	0x8
	.byte	0
	.byte	0
	.byte	0xf
	.byte	0x2e
	.byte	0x1
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x10
	.byte	0xb
	.byte	0x1
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0
	.byte	0
	.byte	0x11
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0x12
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x49
	.byte	0x13
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x13
	.byte	0x2e
	.byte	0
	.byte	0x3f
	.byte	0x19
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0xb
	.byte	0x39
	.byte	0xb
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7a
	.byte	0x19
	.byte	0
	.byte	0
	.byte	0x14
	.byte	0x2e
	.byte	0x1
	.byte	0x3
	.byte	0xe
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.byte	0x27
	.byte	0x19
	.byte	0x11
	.byte	0x1
	.byte	0x12
	.byte	0x6
	.byte	0x40
	.byte	0x18
	.byte	0x7c
	.byte	0x19
	.byte	0x1
	.byte	0x13
	.byte	0
	.byte	0
	.byte	0x15
	.byte	0x5
	.byte	0
	.byte	0x3
	.byte	0x8
	.byte	0x3a
	.byte	0xb
	.byte	0x3b
	.byte	0x5
	.byte	0x39
	.byte	0xb
	.byte	0x49
	.byte	0x13
	.byte	0x2
	.byte	0x18
	.byte	0
	.byte	0
	.byte	0
	.section	.debug_aranges,"",@progbits
	.4byte	0x1c
	.2byte	0x2
	.4byte	.Ldebug_info0
	.byte	0x4
	.byte	0
	.2byte	0
	.2byte	0
	.4byte	.Ltext0
	.4byte	.Letext0-.Ltext0
	.4byte	0
	.4byte	0
	.section	.debug_line,"",@progbits
.Ldebug_line0:
	.section	.debug_str,"MS",@progbits,1
.LASF12:
	.string	"inputsignal"
.LASF14:
	.string	"mask"
.LASF18:
	.string	"flush_cpu_dcache"
.LASF17:
	.string	"csr_write_simple"
.LASF6:
	.string	"unsigned char"
.LASF8:
	.string	"long unsigned int"
.LASF7:
	.string	"short unsigned int"
.LASF20:
	.string	"GNU C17 12.1.0 -mabi=ilp32 -mtune=rocket -misa-spec=2.2 -march=rv32i -g -ffreestanding"
.LASF22:
	.string	"main"
.LASF24:
	.string	"init_data"
.LASF23:
	.string	"irq_getmask"
.LASF15:
	.string	"irq_setmask"
.LASF10:
	.string	"unsigned int"
.LASF11:
	.string	"taps"
.LASF16:
	.string	"user_irq_0_ev_enable_write"
.LASF9:
	.string	"long long unsigned int"
.LASF19:
	.string	"flush_cpu_icache"
.LASF13:
	.string	"outputsignal"
.LASF5:
	.string	"long long int"
.LASF3:
	.string	"short int"
.LASF21:
	.string	"uint32_t"
.LASF4:
	.string	"long int"
.LASF2:
	.string	"signed char"
	.section	.debug_line_str,"MS",@progbits,1
.LASF0:
	.string	"final.c"
.LASF1:
	.string	"/home/ubuntu/soc/lab_final/testbench/final"
	.ident	"GCC: (g1ea978e3066) 12.1.0"
