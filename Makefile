NAME		=	test
ASM			=	nasm
ASMFLAGS	=	-g -f
SRCDIR		=	./tests/
OBJDIR		=	./tests/objs/

ifeq ($(shell uname), Linux)
	ASMFLAGS += elf64
else
	ASMFLAGS += macho64
endif

SRCS		=	main.s	\
				
OBJS		=	${addprefix $(OBJDIR), $(SRCS:%.s=%.o)}


# ===== #


all:			$(NAME)

$(NAME):		$(OBJDIR) $(OBJS)
				@make -C lib/
				ld $(OBJDIR)main.o -Llib/ -lasm -lc -o $(NAME)

bonus:			$(OBJDIR) $(OBJS)
				# TODO

clean:
				@rm -rf $(OBJDIR)
				@make -C lib/ clean

fclean:			
				@rm -rf $(NAME) $(OBJDIR)
				@make -C lib/ fclean

re:				fclean all

$(OBJDIR)%.o:	$(SRCDIR)%.s
				$(ASM) $(ASMFLAGS) $< -o $@

$(OBJDIR):
				@mkdir -p $(OBJDIR)

.PHONY:			re clean fclean all
