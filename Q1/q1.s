		.data

msg:   
			.asciiz "Enter a number: "

space:   
			.asciiz " "
        
        .text

        .globl main

main:
		#Print msg string 
			li $v0, 4
			la $a0, msg
			syscall
		#Read number
			li $v0, 5
			syscall
		#Copy to t0
			move $t0, $v0
			sub $t2, $t0, 1
		#t1 equals 1
			addi $t1, $zero, 1

ifZero:
		#Update the t3 every cyle
			sub $t3, $t1, 1
		#Print int value
			li $v0, 1
		#Copy to a0
			move $a0, $t3
			syscall
		#Print space
			li $v0, 4
			la $a0, space
			syscall

loop:
		#If greater than number exit
			bgt $t1, $t2, exit
		#Modular equation
			div $t4, $t1, 7
			mfhi $s0
		#Copy to t5
			move $t5, $s0
		#t1++
			addi $t1, $t1, 1
		#If equal zero
			beqz $t5, ifZero	
		#Jump		
			j loop

exit: