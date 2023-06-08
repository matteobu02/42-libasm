; main

global _start
extern ft_strlen

section .data
str: db "hello world!", 10, 0

section .text

_start:
	mov rdi, str
	call ft_strlen
	ret
