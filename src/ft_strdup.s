; char *ft_strdup(const char *s);

global _ft_strdup
extern _ft_strlen
extern malloc
extern _ft_strcpy

section .text

_ft_strdup:
	push rdi
	call _ft_strlen
	inc rax
	mov rdi, rax
	call malloc wrt ..plt
	cmp rax, 0
	je .endfunc
	pop rsi
	mov rdi, rax
	call _ft_strcpy

.endfunc:
	ret

