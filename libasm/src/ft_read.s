; int read(int fd, void *buf, size_t count);

global _ft_read
extern __errno_location

section .text

_ft_read:
	xor rax, rax
	syscall
	cmp rax, 0
	jnl .endfunc

	; ERROR
	imul rax, -1
	mov rdx, rax
	call __errno_location wrt ..plt
	mov [rax], rdx
	mov rax, -1

.endfunc:
	ret
