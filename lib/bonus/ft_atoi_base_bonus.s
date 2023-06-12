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
	.base_len_err:
		xor rax, rax
		pop rbp
		ret
	
	; allocate 1 ints + 2 char* -> 20 bits
	sub rsp, 20
	mov QWORD [rsp], rsi		; s
	mov QWORD [rsp + 8], rdi	; base
	mov [rsp + 12], rax			; base_len

	xor rcx, rcx
	; check base content
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
	call ft_strchr
	cmp rax, 0
	jne .base_invalid
	inc rcx
	jmp .base_check_loop

.setup_parsing:
	mov rcx, -1
	sub rsp, 8
	xor r10, r10
	mov r11, 1
	mov [rsp + 16], r11 ; sign = 1
	mov [rsp + 20], r10	; ret = 0

.skip_spaces:
	inc rcx
	mov dil, BYTE [rsp + rcx]
	call ft_isspace
	cmp rax, 0
	jne .skip_spaces

	; disgusting af but works
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
	call ft_strchr
	cmp rax, 0
	je .atoi_base_endfunc
	; TODO: calculate
	inc rcx
	jmp .atoi_calculate

.set_sign:
	mov r11, [rsp + 12]
	imul r11, -1
	mov [rsp + 12], r11
	jmp .read_signs

.base_invalid:
	xor rax, rax
	add rsp, 20
	pop rbp
	ret

.atoi_base_endfunc:
	mov rax, [rsp + 20]
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
