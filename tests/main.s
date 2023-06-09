; main

section .data
    test_string db "Hello", 10, 0

section .text
    global _start
	extern _ft_strdup
	extern _ft_strlen

_start:
	mov rdi, test_string
	call _ft_strdup

	mov rdi, rax
	call _ft_strlen

	mov rdx, rax
	mov rsi, rdi

	mov rax, 1
	mov rdi, 1
	syscall

	mov rax, 60
	xor rdi, rdi
	syscall
