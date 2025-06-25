.data
    prompt:     .asciiz "Enter an integer between 0 and 100 (0 to exit): "
    error_msg:  .asciiz "Invalid input. Please enter a number between 0 and 100.\n"
    result_msg: .asciiz "The sum of double integers from 0 to "
    is_msg:     .asciiz " is: "
    newline:    .asciiz "\n"
    array:      .word 101    

.text
.globl main

main:
   
    loop:
    
        li $v0, 4
        la $a0, prompt
        syscall

        
        li $v0, 5
        syscall
        move $s0, $v0   

        beqz $s0, exit


        blez $s0, invalid_input
        bgt $s0, 100, invalid_input
        
        la $t0, array    
        li $t1, 0        
        li $t2, 0        

        init_array:
            sw $t2, ($t0)        
            addi $t0, $t0, 4     
            addi $t1, $t1, 1    
            add $t2, $t2, 2      
            ble $t1, $s0, init_array

        la $t0, array    
        li $t1, 0   
        li $t3, 0       

        sum_array:
            lw $t2, ($t0)        
            add $t3, $t3, $t2  
            addi $t0, $t0, 4     
            addi $t1, $t1, 1     
            ble $t1, $s0, sum_array

       
        li $v0, 4
        la $a0, result_msg
        syscall

        li $v0, 1
        move $a0, $s0
        syscall

        li $v0, 4
        la $a0, is_msg
        syscall

        li $v0, 1
        move $a0, $t3
        syscall

        li $v0, 4
        la $a0, newline
        syscall

        j loop   

    invalid_input:
        li $v0, 4
        la $a0, error_msg
        syscall
        j loop

exit:
    li $v0, 10
    syscall
