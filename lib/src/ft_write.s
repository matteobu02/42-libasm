; int write(int fd, const void *buf, size_t count);

section .text
	global _ft_write

_ft_write:
	mov rax, 1
	syscall

	; TODO: handle errno
