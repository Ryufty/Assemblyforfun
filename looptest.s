.text
.globl    _start

start = 0                       /* starting value for the loop index; note that this is a symbol (constant), not a variable */
max = 31                        /* loop exits when the index hits this number (loop condition is i<max) */

_start:
    mov     $start,%r15         /* loop index */

loop:
    mov     %r15, %r14
    /*add     $48, %r14b*/
    mov     %r15d, %edx
    mov     $10, %ebx
    idiv    %ebx
    add     $48, %eax
    add     $48, %edx
    mov     %eax, msg+6
    mov     %edx, msg+7
    mov     $len, %edx     /* file descriptor: 1 is stdout */ 
    mov     $msg, %ecx     /* message location (memory address) */
    mov     $1, %ebx       /* message length (bytes)*/
    mov     $4, %eax       /* write is syscall #4 */
    int     $0x80
    inc     %r15                /* increment index */
    cmp     $max,%r15           /* see if we're done */
    jne     loop                /* loop if we're not */

    mov     $0, %ebx       /* exit status: 0 (good) */
    mov     $1, %eax       /* kernel syscall number: 1 is sys_exit */
    int     $0x80

.data
msg:
     .ascii "Loop:          \n"
     len = . - msg + 2

