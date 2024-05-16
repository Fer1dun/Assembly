.data
	array: .word 2,5,6
		.word 3,4,9
		.word 1,3,9
	size: .word 3
	.eqv Data_size 4
.text

	main:
		la $a0,array
		lw $a1,size
		jal sumDiagonal
		move $a0,$v0 #v0 has the sum
		
		li $v0,1
		syscall
		
		li $v0,10
		syscall
		
	sumDiagonal:
		li $v0,0	#sum=0
		li $t0,0	#t0 as the index
		
		sumloop:
			mul $t1,$t0,$a1		#t1=rowindex * colsize
			add $t1,$t1,$t0		# 		*colindex
			mul $t1,$t1,Data_size	#*data size
			add $t1,$t1,$a0		#base adress
			
			lw $t2,($t1)
			add $v0,$v0,$t2		#sum=sum+array[1][1]
			
			addi $t0,$t0,1		#i=i+1
			blt $t0,$a1,sumloop
		jr $ra
			
			
			
		
		