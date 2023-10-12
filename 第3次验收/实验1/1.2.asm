		.data #定义数据段
Array:	.word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 #数组赋值
num: 	.word 5
		.text #定义代码段
		
set_array:  addi $sp, $sp, -52
			sw $ra, 48($sp)
			sw $fp, 44($sp)
			sw $s1, 40($sp)
			addi $fp, $sp, 48
			la $s1, Array
			lw $a0, num
			move $t0, $a0
			move $t2, $zero
for_loop:   slti $t1, $t2, 10
			beq $t1, $zero, exit1
			move $a0, $t0
			move $a1, $t2
			jal compare
			sll $t1, $t2, 2
			add $t1, $s1, $t1
			sw $v0, 0($t1)
			addi $t2, $t2, 1
			j for_loop
exit1:		lw $ra, 48($sp)
			lw $fp, 44($sp)
			lw $s1, 40($sp)
			addi $sp, $sp, 52
			j over
compare:	addi $sp, $sp, -8
			sw $ra, 4($sp)
			sw $fp, 0($sp)
			addi $fp, $sp, 4
			jal sub
			slt $t1, $v0, $zero
			beq $t1, $zero, else
			move $v0, $zero
			j exit2
else:		ori $v0, $zero, 1
exit2:		lw $fp, 0($sp)
			lw $ra, 4($sp)
			addi $sp, $sp, 8
			jr $ra
sub:		sub $v0, $a0, $a1
			jr $ra
over: