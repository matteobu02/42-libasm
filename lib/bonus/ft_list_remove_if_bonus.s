; void ft_list_remove_if(	t_list **begin_list,
; 							void *data_ref,
; 							int (*cmp)(),
; 							void (*free_fct)(void*)
; );

global _ft_list_remove_if
extern _free

section .text

_ft_list_remove_if:
	cmp rdi, 0
	je .endfunc
	cmp QWORD [rdi], 0
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

	mov r10, QWORD [rdi]		; r10 = *begin_list

.rm_loop:
	cmp r10, 0
	je .rm_begin
	mov r11, QWORD [r10 + 8]	; r11 = r10->next
	cmp r11, 0
	je .rm_begin

	mov rdi, QWORD [r11]		; rdi = r11->data
	mov rdx, QWORD [rsp + 8]	; rdx = cmp
	call rdx
	cmp eax, 0
	jne .increment_ptr

	mov rdx, QWORD [r11 + 8]
	mov QWORD [r10 + 8], rdx	; r10->next = r11->next
	; remove
	mov rcx, QWORD [rsp + 16]	; rcx = free_fct
	push r11
	call rcx
	pop rdi
	call _free

.increment_ptr:
	mov r10, QWORD [r10 + 8]	; r10 = r10->next
	jmp .rm_loop

.rm_begin:
	mov r11, QWORD [rsp]		;
	mov r10, QWORD [r11]		; r10 = *begin_list
	mov rdx, QWORD [rsp + 8]	; rdx = cmp
	mov rdi, QWORD [r10]
	call rdx
	cmp eax, 0
	jne .restore_stack

	mov rax, QWORD [r10 + 8]	;
	mov QWORD [r11], rax		; *begin_list = (*begin_list)->next

	mov rcx, QWORD [rsp + 16]	; rdx = free_fct
	push r10
	call rcx
	pop rdi
	call _free

.restore_stack:
	add rsp, 24
	pop rbp

.endfunc:
	ret

