; char *ft_strdup(const char *s);

section .text
	global _ft_strdup
	extern _ft_strlen
	extern malloc
	extern _ft_strcpy

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
	call _ft_strcpy

	;mov rsp, rbp
	;pop rbp
	ret
