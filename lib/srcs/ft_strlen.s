; mbucci
;
; int ft_strlen(const char *s);

global ft_strlen
section .text

ft_strlen:
	; prologue
	push rbp
	mov rbp, rsp

	xor rax, rax ; int count = 0;

loop:
	cmp byte [rdi + rax], 0
	je end
	inc rax
	jmp loop

end:
	; epilogue
	mov rsp, rbp
	pop rbp

	ret
