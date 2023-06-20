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
	cmp rdx, 0
	je .endfunc
	cmp rcx, 0
	je .endfunc

	push rbp
	mov rbp, rsp
	sub rsp, 24
	mov QWORD [rsp], rsi
	mov QWORD [rsp + 8], rdx
	mov QWORD [rsp + 16], rcx

	mov r10, QWORD [rdi]

.loop:
	cmp r10, 0
	je .restore_stack
	mov rdi, QWORD [r10 + 8]
	mov rsi, QWORD [rsp]
	call QWORD [rdx]
	cmp rax, 0
	je .freeit

.freeit:
	call QWORD [rsp + 16]	; free_fct(r10->data)
	mov rdi, 

.restore_stack:
	add rsp, 24
	pop rbp

.endfunc:
	ret
