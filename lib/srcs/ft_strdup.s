; char *ft_strdup(const char *s);

section .text
	global _ft_strdup
	extern _ft_strlen
	extern malloc
	extern strcpy

_ft_strdup:
	;push rbp
	;mov rbp, rsp

	push rdi
	call _ft_strlen
	mov rdi, rax
	inc rdi
	call malloc wrt ..plt
	cmp rax, 0
	;jz malloc_failed
	pop rsi
	mov rdi, rax
	call strcpy wrt ..plt

	;mov rsp, rbp
	;pop rbp
	ret
