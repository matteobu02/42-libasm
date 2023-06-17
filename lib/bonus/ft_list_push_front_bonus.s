section .text
	global _ft_list_push_front
	extern malloc

; void ft_list_push_front(t_list **begin_list, void *data);
_ft_list_push_front:
	push rdi
	mov rdi, rsi
	call ft_create_elem
	pop rdi
	cmp rax, 0
	je endfunc
	mov r10, QWORD [rdi]
	mov QWORD [rax], r10
	mov QWORD [rdi], rax
	jmp endfunc

; t_list *ft_create_elem(void *data);
ft_create_elem:
	mov r10, rdi
	mov rdi, 16			; sizeof(t_list) = 16
	call malloc wrt ..plt
	cmp rax, 0
	je endfunc
	mov QWORD [rax], 0	; ret->next = NULL
	mov QWORD [rax + 8], r10

endfunc:
	ret
