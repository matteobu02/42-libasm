section .text
	global _ft_atoi_base
	extern _ft_strlen

; int ft_atoi_base(const char *str, const char *base);
_ft_atoi_base:
	push rbp
	mov rbp, rsp

	xchg rdi, rsi
	call _ft_strlen
	cmp rax, 2
	jl .base_len_err

	sub rsp, 28
	mov QWORD [rsp], rsi		; str
	mov QWORD [rsp + 8], rdi	; base
	mov DWORD [rsp + 16], eax	; base_len
	mov DWORD [rsp + 20], 1		; sign
	mov DWORD [rsp + 24], 0		; ret

	xor rcx, rcx
	mov rdx, rdi

.base_check_loop:
	mov al, BYTE [rdx + rcx]
	cmp al, 0
	je .setup_parsing
	cmp al, '+'
	je .base_invalid
	cmp al, '-'
	je .base_invalid

	mov dil, al
	call ft_isspace
	cmp rax, 0
	jne .base_invalid

	mov sil, dil
	lea rdi, [rdx + rcx + 1]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	jne .base_invalid

	inc rcx
	jmp .base_check_loop

.setup_parsing:
	mov rcx, -1
	mov rdx, QWORD [rsp]

.skip_spaces:
	inc rcx
	mov dil, BYTE [rdx + rcx]
	call ft_isspace
	cmp rax, 0
	jne .skip_spaces
	dec rcx

.read_signs:
	inc rcx
	cmp BYTE [rdx + rcx], '+'
	je .read_signs
	cmp BYTE [rdx + rcx], '-'
	je .set_sign

.atoi_calculate:
	cmp BYTE [rdx + rcx], 0
	je .atoi_base_endfunc
	mov sil, BYTE [rdx + rcx]
	mov rdi, QWORD [rsp + 8]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	je .atoi_base_endfunc

	; actual op
	sub rax, rdi
	mov r10d, DWORD [rsp + 24]
	mov r11d, DWORD [rsp + 16]
	imul r10, r11
	add r10, rax
	mov DWORD [rsp + 24], r10d

	inc rcx
	jmp .atoi_calculate

.set_sign:
	mov r11d, DWORD [rsp + 16]
	imul r11, -1
	mov DWORD [rsp + 16], r11d
	jmp .read_signs

.base_invalid:
	xor rax, rax
	add rsp, 28
	pop rbp
	ret

.base_len_err:
	xor rax, rax
	pop rbp
	ret

.atoi_base_endfunc:
	mov eax, DWORD [rsp + 20]
	mov r10d, DWORD [rsp + 24]
	mul r10
	add rsp, 28
	pop rbp
	ret

;===================;
; int isspace(int c);
;===================;
ft_isspace:
	cmp dil, 32
	je .isspace_true
	cmp dil, 9
	jl .isspace_false
	cmp dil, 13
	jg .isspace_false

.isspace_true:
	mov eax, 1
	ret

.isspace_false:
	xor eax, eax
	ret

;======================================;
; char *ft_strchr(const char *s, int c);
;======================================;
ft_strchr:
	mov rcx, -1

.strchr_loop:
	inc rcx
	cmp BYTE [rdi + rcx], sil
	je .strchr_found
	cmp BYTE [rdi + rcx], 0
	jne .strchr_loop
	xor rax, rax
	ret

.strchr_found:
	lea rax, [rdi + rcx]
	ret
