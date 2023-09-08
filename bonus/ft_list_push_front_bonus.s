; void ft_list_push_front(t_list **begin_list, void *data);

global _ft_list_push_front
extern malloc

section .text

_ft_list_push_front:
	cmp rdi, 0
	je endfunc
	push rdi
	mov rdi, rsi
	call ft_create_elem
	pop rdi
	cmp rax, 0
	je endfunc
	mov r10, QWORD [rdi]		; r10 = *begin_list
	mov QWORD [rax + 8], r10	; ret->next = r10
	mov QWORD [rdi], rax		; *begin_list = ret
	jmp endfunc

; t_list *ft_create_elem(void *data);
ft_create_elem:
	mov r10, rdi			; r10 = data
	mov rdi, 16				; sizeof(t_list) = 16
	call malloc wrt ..plt
	cmp rax, 0
	je endfunc
	mov QWORD [rax], r10	; ret->data = r10
	mov QWORD [rax + 8], 0	; ret->next = 0

endfunc:
	ret
