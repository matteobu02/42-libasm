; int read(int fd, void *buf, size_t count);

global _ft_read
extern ___error

section .text

_ft_read:
	mov rax, 0x2000003
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

