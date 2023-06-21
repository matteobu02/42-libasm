section .text
	global _ft_list_remove_if
	extern free

; void ft_list_remove_if(	t_list **begin_list,
; 							void *data_ref,
; 							int (*cmp)(),
; 							void (*free_fct)(void*)
; );
_ft_list_remove_if:
	cmp rdi, 0
	je .endfunc
	cmp rsi, 0
	je .endfunc
	cmp rdx, 0
	je .endfunc
	cmp rcx, 0
	je .endfunc

	push rbp
	mov rbp, rsp
	sub rsp, 24
	mov QWORD [rsp], rdi
	mov QWORD [rsp + 8], rdx
	mov QWORD [rsp + 16], rcx

.remove_begin:
	mov r10, QWORD [rsp]		; r10 = *begin_list
	mov r10, QWORD [r10]
	cmp r10, 0
	je .restore_stack
	mov rdi, QWORD [r10 + 8]	; rdi = r10->data
	mov rdx, QWORD [rsp + 8]
	call QWORD [rdx]
	cmp rax, 0
	jne .check_done

	mov r11, QWORD [r10]		; r11 = r10->next
	mov QWORD [rsp], r11		; *begin_list = (*begin_list)->next

	mov rcx, QWORD [rsp + 16]
	call QWORD [rcx]
	mov rdi, r10
	call free wrt ..plt
	jmp .remove_begin


.check_done:
	

.restore_stack:
	add rsp, 24
	pop rbp

.endfunc:
	ret
