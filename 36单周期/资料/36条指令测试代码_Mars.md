```mips
start: addiu $1, $0,1 	# r1 = 1
sll		$2, $1,4 		# r2 = 1 << 4 = 16
addu	$3, $2,$1 		# r3 = r2 + r1 = 17
srl     $4, $2,2 		# r4 = r2 >> 2 = 4
slti    $25,$4,5 		# r25 = r4 < 5 = 1
bgez 	$25,Loop1 		# if(r25 >= 0) go to line 22 (√)
subu  	$5, $3,$4 		# r5 = r3 - r4 = 13
sw		$5, 20($0)		# mem[20] = r5 = 13
nor    	$6, $5,$2 		# r6 = ~(r5 | r2) = 0xffffffe2
or      $7, $6,$3 		# r7 = r6 | r3 = 0xfffffff3
xor    	$8, $7,$6 		# r8 = r7 ^ r6 = 17
sw     	$8, 28($0) 		# mem[28] = r8 = 17
beq    	$8, $3,Loop2 	# if(r8 == r3) go to line 15 (√)
slt     $9, $6,$7 		# r9 = r6 < r7 = 1 (不执行)
Loop2: addiu $1, $0,8 	# r1 = 8
lw      $10,20($1) 		# r10 = mem[r1+20] = mem[28] = 17
bne    	$10,$5,Loop3 	# if(r10 != r5) go to line 21 (√)
and    	$11,$2,$1 		# r11 = r2 & r1 = 0 (不执行)
sw     	$11,28($1) 		# mem[36] = r11 = 0 (不执行)
sw     	$4, 16($1) 		# mem[24] = r4 = 4 (不执行)
Loop3: jal Loop4 		# r31 = &(line 22), go to line 27
Loop1: lui $12,12 		# r12 = 0x000c0000
srav   	$26,$12,$2 		# r26 = r12 >>> r2 = 12
sllv    $27,$26,$1 		# r27 = r26 << r1 = 0x00000018(24)
addiu   $27, $27, 0x00003000	# r27 = 0x00003018
jalr    $27				# r31 = &(line 27), go to line 7
Loop4: sb $26,5($3) 	# mem[20] = 0x000c000d
sltu    $13,$3,$3 		# r13 = r3 < r3 = 0
bgtz   	$13,Loop5 		# if(r13 > 0) go to line 33 (不跳转)
sllv    $14,$6,$4 		# r14 = r6 << r4 = 0xfffffe20
sra     $15,$14,2 		# r15 = r14 >>> 2 = 0xffffff88
srlv    $16,$15,$1 		# r16 = r15 >> r1 = 0x00ffffff
Loop5: blez $16,Loop6 	# if(r16 <= 0) go to line 42 (不跳转)
srav    $16,$15,$1 		# r16 = r15 >>> r1 = 0xffffffff
addiu 	$11,$0,140 		# r11 = 0x0000008c (140)
addiu	$11, $11, 0x00003008	# r11 = 0x00003090
bltz    $16, Loop7 		# if(r16 < 0) go to line 43 (√)
lw     	$28,3($10) 		# r28 = mem[20] = 0x000c000d/0x000c880d
bne   	$28,$29,Loop8 	# if(r28 != r29) go to line 46(X/√)
sb     	$15,8($5) 		# mem[20] = 0x000c88od
lb     	$18,8($5) 		# r18 = (signed)mem[21] = 0xffffff88
Loop6: lbu $19,8($5) 	# r19 = (unsigned)mem[21] = 0x00000088
Loop7: sltiu $24,$15,-1 # r24 = r15 < (signed_ext)0xFFFF = 1
or    	$29,$12,$5 		# r29 = r12 | r5 = 0x000c000d
jr     	$11 			# go to r11 (line 38)
Loop8: andi $20,$15,0xFFFF 	# r20 = r15 & 0xffff = 0x0000ff88
ori   	$21,$15,0xFFFF 	# r21 = r15 | 0xffff = 0xffffffff
xori 	$22,$15,0xFFFF 	# r22 = r15 ^ 0xffff = 0xffff0077
j 		start			# go to line 1
```

执行顺序：1->6, 22->26, 7->13, 15->17, 21, 27->37, 43->45, 38->45, 38->39, 46->49

**在代码中，更改 im.v 的取指逻辑，npc.v 的下地址逻辑**
