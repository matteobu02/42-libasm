; int write(int fd, const void *buf, size_t count);

global _ft_write
extern ___error

section .text

_ft_write:
	mov rax, 0x2000004
	syscall
	jnc .endfunc

	; ERROR
	push rax
	call ___error
	mov rdx, rax
	pop rax
	mov DWORD [rdx], eax
	mov eax, -1

.endfunc:
	ret
