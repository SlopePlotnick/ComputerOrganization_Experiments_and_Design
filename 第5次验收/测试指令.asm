addiu $8, $0, 3
addiu $9, $0, 2
add $10, $8, $9
sub $11, $8, $9
ori $12, $8, 4
add $13, $8, $9
beq $10, $13, beq_test
addiu $15, $0, 9
addiu $16, $0, 9
beq_test: sw $10, 3($0)
lw $14, 3($0)
j exit
addiu $17, $0, 9
addiu $18, $0, 9
exit: