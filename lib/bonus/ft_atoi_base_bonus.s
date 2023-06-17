section .text
	global _ft_atoi_base
	extern _ft_strlen

; int ft_atoi_base(const char *str, const char *base);
_ft_atoi_base:
	push rbp
	mov rbp, rsp
	sub rsp, 24

	xchg rdi, rsi
	call _ft_strlen
	cmp rax, 2
	jl .base_invalid

	mov QWORD [rsp], rsi		; str
	mov QWORD [rsp + 8], rdi	; base
	mov DWORD [rsp + 16], eax	; base_len

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
	mov r10d, 1

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

	mov DWORD [rsp + 20], r10d	; save sign
	mov rdi, QWORD [rsp + 8]	; rid = base
	mov r11d, DWORD [rsp + 16]	; r11d = base_len
	xor r10, r10				; ret = 0

.calculate:
	cmp BYTE [rdx + rcx], 0
	je .get_ret
	mov sil, BYTE [rdx + rcx]
	push rcx
	call ft_strchr
	pop rcx
	cmp rax, 0
	je .get_ret

	; actual op
	sub rax, rdi
	imul r10, r11
	add r10, rax

	inc rcx
	jmp .calculate

.set_sign:
	imul r10d, -1
	jmp .read_signs

.base_invalid:
	xor rax, rax
	jmp .endfunc

.get_ret:
	mov eax, DWORD [rsp + 20]
	mul r10

.endfunc:
	mov rsi, QWORD [rsp + 8]
	mov rdi, QWORD [rsp]
	add rsp, 24
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
