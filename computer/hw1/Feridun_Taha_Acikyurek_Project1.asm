.data
	row: .word 0      #keeps the number of rows
	colum: .word 0	   #keeps the number of colums	
	msg: .asciiz "enter row and colum\n"    
	input: .space 1024	#matrix entered by the user
	dot: .asciiz "."	
	bomb: .asciiz "o"
	newline: .asciiz "\n"
	zero: .word 0            
	bomb_map: .space 1024      #It's a map with bombs everywhere
	statu: .asciiz "case1"
	statu2: .asciiz "case2"
	statu3: .asciiz "case3"
.text
	.globl main
	main:
		li $v0,4		#prints the message in the string
		la $a0,msg
		syscall			#calls operations performed on the operating system	
		
		li $v0,5		#Gets row information from the user
		syscall
		sw  $v0,row		#Saves row information to the row
		
		li $v0,5		#Gets colum information from the user
		syscall
		sw  $v0,colum		#Saves colum information to the colum
		
		li $v0,8		#Gets bomba map information from the user
		la $a0,input
		li $a1,1024		#Holds  a maximum of 1024 words of entry	
		syscall
		
 		li $v0,4		#prints case 1 message
 		la $a0,statu
 		syscall
 		
 		li $v0,4		#prints newline
		la $a0,newline
		syscall
		
		
		jal print_scren		#its calls print_scren funciton
		jal bomb_planet		#its calls bomb_planet
		jal bomb_control	#its calls bomb_control
		jal print_final		#its calls print_final
		
		li $v0,10		#indicates that main is end
		syscall			#calls operations performed on the operating system
		
		
	print_scren:		#This function prints the status entered by the user on the screen.
			addi $t6,$zero,0	#We assigned a temporary zero to t6 register
			addi $t7,$zero,0	#We assigned a temporary zero to t7 register
			lw $t0,row		#We assigned row to t0 register
			lw $t1,colum		#We assigned colum to t1 register
			mul  $t2,$t0,$t1	#We calculated the total matrix size
			la $s0,input		#we load adres input to s0 register 
			
			
		
			
			loop:		
				lb $t4,0($s0)			#We assigned the first element of inptu to the register t4
				addi $s0,$s0,1			#We increased the starting address where the input is located by one.
				li $v0,11			#prints one character of input array
				move $a0,$t4			
				syscall				#calls operations performed on the operating system
				addi $t6,$t6,1			#We increase the total number of characters here
				addi $t7,$t7,1			#I increased the value for newline here
				
				bne $t7,$t1,case1		#If column number is not equal to t7, go to case 1
				li $v0,4			#prits newline
				la $a0,newline
				syscall
				lw $t7,zero			#resets t7 register
				
				case1:
				beq  $t6,$t2,exit		#Exit the loop if it reaches the last character
				j loop				#jump loop
				
				
			
			exit:
				jr $ra				#return main 
				
	bomb_planet:					#It is the function that places all bobs on the map
			lw $t0,row			#save row to t0 register
			lw $t1,colum			#save colum to t1 register
			mul $t2,$t0,$t1
			la $s0,bomb_map			#saves the bomb_map at address s0
			lb $t3,bomb			#save "o" to t3
			lw $t7,zero			
			lw $t6,zero
			addi $t4,$zero,0
			
			li $v0,4			#prints "case2"
			la $a0,statu2
			syscall
			
			li $v0,4			#prints newline
			la $a0,newline
			syscall
			
			
			loop1:				
				sb $t3,0($s0)		#assigns the first character of the bomb map to t3
				addi $s0,$s0,1		#incress  bomba_map address once
				addi $t4,$t4,1		#incress t4 register once
				li $v0,11		#prints character of bomb map array
				move $a0,$t3		
				syscall			
				addi $t7,$t7,1		#incress t7 register once t register for  hold size of array
				
				
				
				bne $t4,$t1,case2	#t4 not eqgual colum jump case
				li $v0,4		#prints newline
				la $a0,newline
				syscall
				addi $t4,$zero,0	#reset t4 register
				
				case2:
					beq $t7,$t2,exit1	#if t7 register size of array fump exit
					j loop1
				
			exit1:
				jr $ra			#return main
					
	bomb_control:						#Checks the status of the bomb and detonates it
				addi $t0,$zero,0		
				lb $t1,bomb			#load "o" to t1 register
				lw $t4,colum			#load colum to t4 register
				lw $t7,row			#load row to t7 register
				la $s1,bomb_map			#lad adress bomba_map to s1 register
				la $s0,input			#load adress input array to s0 register
				addi $t6,$zero,0		
				lb $t9,dot			#load "." to t9 register
				mul  $t2,$t7,$t4
			loop3:					#head loop
				
				lb $t3,0($s0)			#assigns the first character of the input array to t3
				beq $t1,$t3,big_if		#If the input character  equals bomb("o"), go big if
				j case_loop			#else case loop
				
					big_if:			#head if
						sb $t9,0($s1)		#assigns the first character of the bomb map array to t9
						add $s1,$s1,$t4		#Move forward columns from the start address of the bomb map
						sb $t9,0($s1)		#save character to t9
						sub $s1,$s1,$t4		#We take it up to the column so that it returns to where it started.
						sub $s1,$s1,$t4		#This time, go to the address as far back as the column.
						sb $t9,0($s1)		#save character to t9
						add $s1,$s1,$t4		#We take it up to the column so that it returns to where it started.
						divu $t0,$t4		#We calculated the mode for it to look left and right.
						mfhi $t5
						bne $t5,$zero,if_1	#if mod ==0 go if_1
						j case_if_2		#else case_if_2
						if_1:
							subi $s1,$s1,1		#we subtracted one for the place on the left
							sb $t9,0($s1)		#save charavter to t9
							addi $s1,$s1,1		#We added 1 to get it to where it is after the subtraction process
							j case_if_2		#check case_if_2
						case_if_2:
							addi $t0,$t0,1		#we addition one for the place on the right for  adress bomb _map
							divu $t0,$t4		#we calculated the mod for right
							mfhi $t5
							bne $t5,$zero,if_2	#if mod ==0 go if_2
							j case_loop		#else go case_loop
						if_2:
							subi $t0,$t0,1		#We increased the value of t for control purposes and we are taking it back.
							addi $s1,$s1,1		#we addition one for the place on the right for  adress bomb _map
							sb $t9,0($s1)		#save character 
							subi $s1,$s1,1		#We sub 1 to get it to where it is after the addition process
							j case_loop
						
					
						
	
					case_loop:		#Index increasing operations are done here
					
					addi $s0,$s0,1		#increes adress of input once  move to the next index of array
					addi $s1,$s1,1		#incress adress of bomb_map once because move to the next index of array
					bne $t2,$t0,case3	#if it doesnt reaches the last character go case3
					beq $t2,$t0,exit2	#else go exit

				
				
				case3:
					beq $t2,$t0,exit2	#Exit the loop if it reaches the last character
					addi $t0,$t0,1		#We increased the number of characters checked
					j loop3			#jump head loop
					
					
				
				exit2:
					jr $ra			#jump main
			
			
	print_final:		#prints final bomb_map array
	
				addi $t6,$zero,0		#temporary register hold zero
				addi $t7,$zero,0		#temporary register hold zero
				lw $t0,row			#load row value
				lw $t1,colum			#load colum value 
				mul  $t2,$t0,$t1
				la $s1,bomb_map			#load adrees of the bomb map 
			
			li $v0,4				#prints "case3"
			la $a0,statu3
			syscall		
			
			li $v0,4				#prints newline
			la $a0,newline
			syscall
			
			loop4:
				lb $t4,0($s1)			#assigns the first character of the bomb map array to t4
				addi $s1,$s1,1			#incress adress of the bomb array once
				li $v0,11			#prints character of bomb array
				move $a0,$t4
				syscall
				addi $t6,$t6,1			#We increase the total number of characters here
				addi $t7,$t7,1			#I increased the value for newline here
				
				bne $t7,$t1,case4		#If column number is not equal to t7, go to case 1
				li $v0,4
				la $a0,newline			#prints newline
				syscall
				addi $t7,$zero,0		#reset t7 register
				
				case4:
				beq  $t6,$t2,exit		#Exit the loop if it reaches the last character
				j loop4				
				
				
			
			exit4:
				jr $ra				#jump main
				
						
				
		
		
	
