NAME	=	test
CC		=	gcc
CFLAGS	=	-Wall -Werror -Wextra -z noexecstack

ifeq ($(shell uname), Linux)
	ASMFLAGS += elf64
else
	ASMFLAGS += macho64
endif

MAIN	=	./main.c


# ===== #


all:			$(NAME)

$(NAME):
				@make -C libasm/ bonus
				$(CC) $(CFLAGS) $(MAIN) -Llibasm/ -lasm -o $(NAME)

clean:
				@make -C libasm/ clean

fclean:			
				@rm -rf $(NAME)
				@make -C libasm/ fclean

re:				fclean all

.PHONY:			re clean fclean all
