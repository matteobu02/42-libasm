; void ft_list_sort( t_list **begin_list, int (*cmp)() );

global _ft_list_sort

section .text

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
	mov r11, QWORD [r10 + 8]	; r11 = r10->next

.second_loop:
	cmp r11, 0
	je .incr_first

	mov rdi, QWORD [r10]		; rdi = r10->data
	mov rsi, QWORD [r11]		; rsi = r11->data
	push rdx
	call rdx
	pop rdx
	cmp eax, 0
	jg .swap_ptr

.incr_second:
	mov r11, QWORD [r11 + 8]
	jmp .second_loop

.incr_first:
	mov r10, QWORD [r10 + 8]
	jmp .first_loop

.swap_ptr:
	mov rax, rdi
	mov QWORD [r10], rsi
	mov QWORD [r11], rax
	jmp .incr_second

.endfunc:
	ret
