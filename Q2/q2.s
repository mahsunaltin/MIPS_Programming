    .data

			list:
				.word       213, 16, 32, 64, 128, 256
			msg_min:
				.asciiz     "Min: "
			msg_max:
				.asciiz     "\nMax: "
			msg_interval:
				.asciiz     "\nInterval: "

    .text

    .globl  main

main:
			# get List
			    la $s0,list    
			# endOfTheList = p + 6*4
			    addi $s1,$s0,24

			# get List again
			    la $s4,list    
			# endOfTheList = p + 6*4
			    addi $s5,$s0,24

			# min = list[0]
			    lw $s2,0($s0)
			
			# max = list[0]
			    lw $s3,0($s0)

FindMAX:
			# if (p == end) goto L2
			    beq $s0,$s1,FindMIN
			# $t0 = *p
			    lw $t0,0($s0)
			# p++
			    addi $s0,$s0,4
			# *p > max?
			    bgt $t0,$s3,BetterValueFORMAX

			    j FindMAX

FindMIN:
			# if (p == end) goto L2
			    beq $s4,$s5,PrintValue
			# $t0 = *p
			    lw $t0,0($s4)
			# p++
			    addi $s4,$s4,4
			# *p < min?
			    slt $t2,$t0,$s2
			# if, jump BetterValue
			    bne $t2,$zero,BetterValueFORMIN

			    j FindMIN

PrintValue:
			# print message
			    li $v0,4
			    la $a0,msg_min
			    syscall

			    li $v0,1
			# get min value
			    move $a0,$s2 
			    syscall

			# print message
			    li $v0,4
			    la $a0,msg_max
			    syscall

			    li $v0,1
			# get max value
			    move $a0,$s3 
			    syscall

			#calculate interval
			    sub $s6, $s3, $s2
				
			# print message
				li $v0,4
			    la $a0,msg_interval
			    syscall

			    li $v0,1
			# get interval value
			    move $a0,$s6 
			    syscall

			# exit program
			    li $v0,10
			    syscall

BetterValueFORMIN:
			# set new/better min value
			    move $s2,$t0
			    j FindMIN


BetterValueFORMAX:
			# set new/better min value
			    move $s3,$t0
			    j FindMAX