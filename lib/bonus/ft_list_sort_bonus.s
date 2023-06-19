section .text
	global _ft_list_sort

; void ft_list_sort( t_list **begin_list, int (*cmp)() );
_ft_list_sort:
	cmp rdi, 0
	je .endfunc
	cmp rsi, 0
	je .endfunc

	mov rdx, rsi				; rdx = cmp
	mov r10, QWORD [rdi]		; r10 = *begin_list

.first_loop:
	cmp r10, 0
	je .endfunc
	mov r11, QWORD [r10]		; r11 = r10->next

.second_loop:
	cmp r11, 0
	je .incr_first

	mov rdi, QWORD [r10 + 8]	; rdi = r10->data
	mov rsi, QWORD [r11 + 8]	; rsi = r11->data
	call QWORD [rdx]
	cmp rax, 0
	jl .swap_ptr

.incr_second:
	mov r11, QWORD [r11]
	jmp .second_loop

.incr_first:
	mov r10, QWORD [r10]
	jmp .first_loop

.swap_ptr:
	mov rax, rdi
	mov rdi, rsi
	mov rsi, rax
	mov r11, QWORD [r10]
	jmp .second_loop

.endfunc:
	ret
