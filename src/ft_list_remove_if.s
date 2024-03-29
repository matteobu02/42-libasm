; void ft_list_remove_if(	t_list **begin_list,
; 							void *data_ref,
; 							int (*cmp)(),
; 							void (*free_fct)(void*)
; );

global _ft_list_remove_if
extern free

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
	sub rsp, 32
	mov QWORD [rsp], rdi
	mov QWORD [rsp + 8], rsi
	mov QWORD [rsp + 16], rdx
	mov QWORD [rsp + 24], rcx

	mov r10, QWORD [rdi]		; r10 = *begin_list

.rm_loop:
	cmp r10, 0					; r10 == 0
	je .rm_begin
	mov r11, QWORD [r10 + 8]	; r11 = r10->next
	cmp r11, 0					; r11 == 0
	je .rm_begin

	mov rdx, QWORD [rsp + 16]	; rdx = cmp
	mov rsi, QWORD [rsp + 8]	; rsi = data_ref
	mov rdi, QWORD [r11]		; rdi = r11->data
	push r10
	push r11
	call rdx
	pop r11
	pop r10
	cmp eax, 0
	jne .increment_ptr

	mov rax, QWORD [r11 + 8]	; rax = r11->next
	mov QWORD [r10 + 8], rax	; r10->next = rax

	; remove
	mov rcx, QWORD [rsp + 24]	; rcx = free_fct
	mov rdi, QWORD [r11]		; rdi = r11->data
	push r10
	push r11
	call rcx

	pop rdi
	call free wrt ..plt
	pop r10
	jmp .rm_loop

.increment_ptr:
	mov r10, QWORD [r10 + 8]	; r10 = r10->next
	jmp .rm_loop

.rm_begin:
	mov r11, QWORD [rsp]		; r11 = begin_list
	mov r10, QWORD [r11]		; r10 = *r11

	mov rdx, QWORD [rsp + 16]	; rdx = cmp
	mov rsi, QWORD [rsp + 8]	; rsi = data_ref
	mov rdi, QWORD [r10]		; rdi = r10->data
	push r10
	push r11
	call rdx
	pop r11
	pop r10
	cmp eax, 0
	jne .restore_stack

	mov rax, QWORD [r10 + 8]	; rax = r10->next
	mov QWORD [r11], rax		; *begin_list = rax

	; remove
	mov rcx, QWORD [rsp + 24]	; rcx = free_fct
	mov rdi, QWORD [r10]		; rdi = r10->data
	push r10
	call rcx

	pop rdi
	call free wrt ..plt

.restore_stack:
	add rsp, 32
	pop rbp

.endfunc:
	ret
