section .text
	global _ft_atoi_base
	extern _ft_strlen

; int ft_atoi_base(const char *str, const char *base);
_ft_atoi_base:
	

.atoi_error:
	xor rax, rax
	ret

; int isspace(int c);
ft_isspace:
	cmp rdi, 32
	je .isspace_true
	cmp rdi, 9
	jl .isspace_false
	cmp rdi, 13
	jg .isspace_false

.isspace_true:
	mov rax, 1
	ret

.isspace_false:
	xor rax, rax
	ret

; char *ft_strchr(const char *s, int c);
ft_strchr:
	mov rcx, -1

.strchr_loop:
	inc rcx
	cmp BYTE [rdi + rcx], sil
	je .strchr_found
	cmp BYTE [rdi + rcx], 0
	jne .strchr_loop
	xor rax, rax
	ret

.strchr_found:
	lea rax, [rdi + rcx]
	ret
