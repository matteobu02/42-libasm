; char *ft_strcpy(char *dest, const char *src);


section .text
	global _ft_strcpy

_ft_strcpy:
	push rbp
	mov rbp, rsp
	mov rcx, -1

L1:
	inc rcx
	mov al, BYTE [rsi + rcx]
	mov BYTE [rdi + rcx], al
	cmp al, 0
	jne L1

	mov rax, rdi
	mov rsp, rbp
	pop rbp
	ret
