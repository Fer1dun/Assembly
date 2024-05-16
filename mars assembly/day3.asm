.data
   my_string: .asciiz "Hello,  is cool!"  # ��lenecek olan string

.text
   la $t0, my_string  # Stringin ba�lang�� adresini $t0'e y�kle

print_k:
   lb $t1, 0($t0)     # $t0 i�aret etti�i yerdeki byte'� $t1'e y�kle

   # E�er $t1 0'a e�itse, stringin sonuna gelinmi� demektir.
   beqz $t1, end_print_k

   # E�er $t1 'k' karakterine e�itse, ekrana yazd�r
   li $v0, 11          # Print character system call number
   move $a0, $t1       # Yazd�r�lacak karakteri $a0'e y�kle
   syscall

   addi $t0, $t0, 1    # Bir sonraki karaktere ge�

   j print_k           # D�ng�y� tekrarla

end_print_k:
   # Program�n sonu
