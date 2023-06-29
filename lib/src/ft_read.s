; int read(int fd, void *buf, size_t count);

section .text
	global _ft_read

_ft_read:
	xor rax, rax
	syscall

	; TODO: handle errno

