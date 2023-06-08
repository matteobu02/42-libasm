; main

section .data
    test_string db "Hello", 0

section .text
	extern ft_strlen
    global _start

_start:
	mov rdi, test_string
	call ft_strlen

	mov rdi, rax
	mov rax, 60
	syscall
