; int read(int fd, void *buf, size_t count);

global _ft_read
extern __errno_location ; ___error

section .text

_ft_read:
	xor rax, rax ; mov rax, 0x2000003
	syscall
	jnc .endfunc

	; ERROR
	push rax
	call __errno_location wrt ..plt ; ___error
	mov rdx, rax
	pop rax
	mov DWORD [rdx], eax
	mov eax, -1

.endfunc:
	ret

