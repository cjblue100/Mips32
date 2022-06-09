.data
array: .space 20
primos: .space 20
noprimos: .space 20
msg: .asciiz "\n Numero: "

.text
.globl main


main:

li $t0, 0
la $t1, array
while:
    #imprimir mensaje
    la $a0, msg
    li $v0, 4
    syscall

    #leer entero  de consola
    li $v0, 5
    syscall
    move $t2, $v0

    #incrementar posicion en array
    sw $t2, 0($t1)
    #incrementar contador
    addi $t1, $t1,4
    addi $t0, $t0, 1

    blt $t0, 5, while


    li $t0, 5
    li $t1, 1
    sub $t0, $t0, $t1 # n-1
    li $t1, 0 #i, iteraodr
    la $t2, array
    la $t8, primos # pos arreglo prime
for:
    
    #sacar arr[i]
    li $t3, 4
    mult $t1, $t3
    mflo $t3
    add $t3,$t2,$t3 
    lw $t4, 0($t3) # arr[i]

    #check if prime
    li $t5, 2 #iterador j
    beq $t4, $t5,prime
    div $t4, $t5
    mflo $t6
for_inner:

    div $t4, $t5
    mfhi $t7
    beq $t7, $zero, else 




    addi $t5, $t5, 1
    blt $t5, $t6, for_inner
    
    prime:
    sw $t4, 0($t8)
    addi $t8, 4
    
    else:
    addi $t1, $t1,1
    ble $t1, $t0, for


#meter no primos
    li $t0, 5
    li $t1, 1
    sub $t0, $t0, $t1 # n-1
    li $t1, 0 #i, iteraodr
    la $t2, array
    
for_noprimo:
    
    #sacar arr[i]
    li $t3, 4
    mult $t1, $t3
    mflo $t3
    add $t3,$t2,$t3 
    lw $t4, 0($t3) # arr[i]

    #check if prime
    li $t5, 1 
    beq $t4, $t5,noprime
    li $t5, 2 #iterador j
    beq $t4, $t5,else_noprimo
    
    div $t4, $t5
    mflo $t6
for_inner_noprimo:

    div $t4, $t5
    mfhi $t7
    bne $t7, $zero, else_noprimo




    addi $t5, $t5, 1
    blt $t5, $t6, for_inner_noprimo
    
    noprime:
    sw $t4, 0($t8)
    addi $t8, 4
    
    else_noprimo:
    addi $t1, $t1,1
    ble $t1, $t0, for_noprimo




  








 #!imprimir array
    la $t0, primos
    li $t1, 0

for_print:

    li $t2, 4
    mult $t1, $t2
    mflo $t2
    add $t2,$t0,$t2 
    lw $t2, 0($t2) # arr[j]

    #print number
    move $a0, $t2
    li $v0, 1
    syscall

    # print space, 32 is ASCII code for space
    li $a0, 32
    li $v0, 11  
    syscall
    addi $t1, $t1,1
blt $t1, 5, for_print

    li $v0, 10 #end program
    syscall  


