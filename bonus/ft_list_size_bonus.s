; int ft_list_size(t_list *begin_list);

global _ft_list_size

section .text

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
