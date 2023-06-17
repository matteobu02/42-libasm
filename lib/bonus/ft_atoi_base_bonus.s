section .text
	global _ft_atoi_base
	extern _ft_strlen

; int ft_atoi_base(const char *str, const char *base);
_ft_atoi_base:
	push rbp
	mov rbp, rsp

	sub rsp, 28
	mov QWORD [rsp], rdi		; str
	mov QWORD [rsp + 8], rsi	; base
	mov DWORD [rsp + 16], eax	; base_len
	mov DWORD [rsp + 20], 1		; sign
	mov DWORD [rsp + 24], 0		; ret

	xchg rdi, rsi
	call _ft_strlen
	cmp rax, 2
	jl .base_invalid

	xor rcx, rcx
	mov rdx, rdi

.check_base:
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
	jmp .check_base

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

.calculate:
	cmp BYTE [rdx + rcx], 0
	je .endfunc
	mov sil, BYTE [rdx + rcx]
	mov rdi, QWORD [rsp + 8]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	je .endfunc

	; actual op
	sub rax, rdi
	mov r10d, DWORD [rsp + 24]
	mov r11d, DWORD [rsp + 16]
	imul r10, r11
	add r10, rax
	mov DWORD [rsp + 24], r10d

	inc rcx
	jmp .calculate

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

.endfunc:
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
	je .true
	cmp dil, 9
	jl .false
	cmp dil, 13
	jg .false

.true:
	mov eax, 1
	ret

.false:
	xor eax, eax
	ret

;======================================;
; char *ft_strchr(const char *s, int c);
;======================================;
ft_strchr:
	mov rcx, -1

.loop:
	inc rcx
	cmp BYTE [rdi + rcx], sil
	je .found
	cmp BYTE [rdi + rcx], 0
	jne .loop
	xor rax, rax
	ret

.found:
	lea rax, [rdi + rcx]
	ret
