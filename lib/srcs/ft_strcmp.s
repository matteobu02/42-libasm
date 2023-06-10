; int ft_strcmp(const char *s1, const char *s2);

section .text
	global _ft_strcmp

_ft_strcmp:
	; prologue
	push rbp
	mov rbp, rsp

	mov rcx, -1

L1:
	inc rcx
	cmp BYTE [rdi + rcx], 0
	je endfunc
	cmp BYTE [rsi + rcx], 0
	je endfunc
	mov al, BYTE [rdi + rcx]
	cmp al, BYTE [rsi + rcx]
	je L1

endfunc:
	movzx rax, BYTE [rdi + rcx]
	movzx rbx, BYTE [rsi + rcx]
	sub rax, rbx

	; epilogue
	mov rsp, rbp
	pop rbp
	ret
