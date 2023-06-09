; int ft_strcmp(const char *s1, const char *s2);

section .text
	global ft_strcmp

;ft_strcmp:
;	; prologue
;	push rbp
;	mov rbp, rsp
;
;	xor rax, rax	; int i = 0;
;	jmp loop
;
;increment:
;	inc rax
;
;loop:
;	cmp byte [rdi + rax], [rsi + rax]
;
;	je end
;	and byte [rdi + rax], [rsi + rax]
;	jz end
;
;end:
