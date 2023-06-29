
section .text
	global _ft_list_size

; int ft_list_size(t_list *begin_list);
_ft_list_size:
	xor rax, rax

.loop:
	cmp rdi, 0
	je .endfunc
	inc rax
	mov rdi, QWORD [rdi + 8]
	jmp .loop

.endfunc:
	ret
