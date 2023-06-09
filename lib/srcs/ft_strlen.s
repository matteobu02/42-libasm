; int ft_strlen(const char *s);

global _ft_strlen
section .text

_ft_strlen:
	push rbp
	mov rbp, rsp
	mov rax, -1

L1:
	inc rax
	cmp byte [rdi + rax], 0
	jne L1

	mov rsp, rbp
	pop rbp
	ret
