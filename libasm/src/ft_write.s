; int write(int fd, const void *buf, size_t count);

global _ft_write
extern __errno_location

section .text

_ft_write:
	mov rax, 1
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
