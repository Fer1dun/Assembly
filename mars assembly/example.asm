	lw $t0,zero
				lb $t1,bomb
				la $s0,input
				la $s1,bomb_map
				lw $t4,colum
				lw $t6,zero
			loop3:
				
				lb $t3,0($s0)
				addi $s0,$s0,1
				addi $s1,$s1,1
				
				beq $t3,$t1,big_if 
					big_if:
						divu $t0,$t4
						mfhi $t5
						bne $t5,$zero,if_1
						sw $s1,dot
						add $s1,$s1,$t4
						sw $s1,dot
						sub $s1,$s1,$t4
						sub $s1,$s1,$t4
						sw $s1,dot
						add $s1,$s1,$t4
						addi $t0,$t0,1
						divu $t0,$t4
						mfhi $t5
						bne $t5,$zero,if_2
						
						if_1:
							subi $s1,$s1,1
							sw $s1,dot
							addi $s1,$s1,1
						if_2:
							addi $s1,$s1,1
							sw $s1,dot
							subi $s1,$s1,1
							
							
								
					bne $t2,$t0,case3
					beq $t2,$t0,exit2	
				
				
				case3:
					addi $t0,$t0,1
					
					
				
				exit2:
					jr $ra
			  