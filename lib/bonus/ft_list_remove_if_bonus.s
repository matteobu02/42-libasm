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
	mov r10, QWORD [rsp]		; r10 = begin_list
	mov r10, QWORD [r10]		; r10 = *begin_list
	cmp r10, 0
	je .restore_stack
	mov rdi, QWORD [r10]		; rdi = r10->data
	mov rdx, QWORD [rsp + 8]	; rdx = cmp
	call rdx
	cmp eax, 0
	jne .main_remove

	mov r11, QWORD [r10 + 8]	; r11 = r10->next
	lea QWORD [rsp], r11		; *begin_list = r11

	mov rcx, QWORD [rsp + 16]	; rcx = free_fct
	call rcx
	mov rdi, r10
	call free wrt ..plt
	jmp .remove_begin

.main_remove:
	mov r11, QWORD [r10 + 8]	; r11 = r10->next
	cmp r11, 0
	je .restore_stack

	mov rdi, QWORD [r11]		; rdi = r11->data
	mov rdx, QWORD [rsp + 8]	; rdx = cmp
	call rdx
	cmp eax, 0
	jne .increment_ptr
	
	mov rcx, QWORD [r11 + 8]	;
	mov QWORD [r10 + 8], rcx	; r10->next = r11->next

	mov rcx, QWORD [rsp + 16]	; rcx = free_fct
	call rcx
	mov rdi, r11
	call free wrt ..plt

.increment_ptr:
	mov r10, QWORD [r10 + 8]
	jmp .main_remove

.restore_stack:
	add rsp, 24
	pop rbp

.endfunc:
	ret
