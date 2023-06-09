; char *ft_strcpy(char *dest, const char *src);

section .text
	global _ft_strcpy

_ft_strcpy:
	; prologue
	;push rbp
	;mov rbp, rsp

	mov rax, rdi
	xor rcx, rcx
	jmp L1

increment:
	inc rcx

L1:
	mov al, BYTE [rsi + rcx]
	mov BYTE [rax + rcx], al
	cmp al, 0
	jne increment

	; epilogue
	;mov rsp, rbp
	;pop rbp
	ret
