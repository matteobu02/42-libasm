; mbucci
;
; int ft_strlen(const char *s);

global ft_strlen
section .text

ft_strlen:
	; prologue
	push rbp
	mov rbp, rsp

	; rax usually stores the functions's
	; return value. But since the counter
	; is the return value, we place it there.
	mov 0x0, rax ; int count = 0;

loop:
	; byte is used when performing an operation
	; on a single byte.
	cmp byte [rdi + rax], 0
	je end
	inc rax
	jmp loop

end:
	; epilogue
	mov rsp, rbp
	pop rbp

	ret
