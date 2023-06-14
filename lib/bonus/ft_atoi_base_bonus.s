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

	sub rsp, 20
	mov QWORD [rsp], rsi		; s
	mov QWORD [rsp + 8], rdi	; base
	mov DWORD [rsp + 16], eax	; base_len
	xor rcx, rcx

.base_check_loop:
	cmp BYTE [rsp + 8 + rcx], 0
	je .setup_parsing
	mov dil, BYTE [rsp + 8 + rcx]
	call ft_isspace
	cmp rax, 0
	jne .base_invalid
	cmp BYTE [rsp + 8 + rcx], 43	; c == '+'
	je .base_invalid
	cmp BYTE [rsp + 8 + rcx], 45	; c == '-'
	je .base_invalid
	mov sil, BYTE [rsp + 8 + rcx]
	lea rdi, [rsp + 8 + rcx + 1]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	jne .base_invalid
	inc rcx
	jmp .base_check_loop

.setup_parsing:
	mov rcx, -1
	sub rsp, 8
	xor r10, r10
	mov r11, 1
	mov DWORD [rsp + 20], r11d 	; sign = 1
	mov DWORD [rsp + 24], r10d	; ret = 0

.skip_spaces:
	inc rcx
	mov dil, BYTE [rsp + rcx]
	call ft_isspace
	cmp rax, 0
	jne .skip_spaces
	dec rcx

.read_signs:
	inc rcx
	cmp BYTE [rsp + rcx], 43
	je .read_signs
	cmp BYTE [rsp + rcx], 45
	je .set_sign

.atoi_calculate:
	cmp BYTE [rsp + rcx], 0
	je .atoi_base_endfunc
	mov sil, BYTE [rsp + rcx]
	lea rdi, [rsp + 8]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	je .atoi_base_endfunc

	; actual op
	sub rax, rdi
	mov r10d, DWORD [rsp + 20]
	mov r11d, DWORD [rsp + 16]
	imul r10, r11
	add r10, rax
	mov DWORD [rsp + 20], r10d

	inc rcx
	jmp .atoi_calculate

.set_sign:
	mov r11d, DWORD [rsp + 16]
	imul r11, -1
	mov DWORD [rsp + 16], r11d
	jmp .read_signs

.base_invalid:
	xor rax, rax
	add rsp, 20
	pop rbp
	ret

.base_len_err:
	xor rax, rax
	pop rbp
	ret

.atoi_base_endfunc:
	mov eax, DWORD [rsp + 20]
	mov r10d, DWORD [rsp + 16]
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
