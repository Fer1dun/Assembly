.data
   my_string: .asciiz "Hello,  is cool!"  # Ýþlenecek olan string

.text
   la $t0, my_string  # Stringin baþlangýç adresini $t0'e yükle

print_k:
   lb $t1, 0($t0)     # $t0 iþaret ettiði yerdeki byte'ý $t1'e yükle

   # Eðer $t1 0'a eþitse, stringin sonuna gelinmiþ demektir.
   beqz $t1, end_print_k

   # Eðer $t1 'k' karakterine eþitse, ekrana yazdýr
   li $v0, 11          # Print character system call number
   move $a0, $t1       # Yazdýrýlacak karakteri $a0'e yükle
   syscall

   addi $t0, $t0, 1    # Bir sonraki karaktere geç

   j print_k           # Döngüyü tekrarla

end_print_k:
   # Programýn sonu
