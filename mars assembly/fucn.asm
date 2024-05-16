.data 
	ms: .asciiz "enter your name::\n"
	input: .space 20
	
.text 
	#geting a name from input
	li $v0,8
	la $a0,input
	li $a1,20
	syscall
	
	li $v0,4
	la $a0,ms
	syscall
	
	#display name
	li $v0,4
	la $a0,input
	syscall
	
	#tell the system this is end of the main
	li $v0,10
	syscall
	