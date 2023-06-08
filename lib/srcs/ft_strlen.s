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

;section .data
;    test_string db "Hello", 0
;
;section .text
;	extern ft_strlen
;    global _start
;
;_start:
;	mov rdi, test_string
;	call ft_strlen
;
;	mov rdi, rax
;	mov rax, 60
;	syscall
