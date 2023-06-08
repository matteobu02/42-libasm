NAME		=	libasm.a
AR			=	ar -rsc
ASM			=	nasm
ASMFLAGS	=	-g -f
SRCDIR		=	./srcs/
OBJDIR		=	./objs/
OS			=	$(shell uname)

ifeq ($(OS), Linux)
	ASMFLAGS += elf64
else
	ASMFLAGS += macho64
endif

SRCS		=	ft_strlen.s	\
				ft_strcpy.s	\
				ft_strcmp.s	\
				ft_write.s	\
				ft_read.s	\
				ft_strdup.s	\
				
OBJS		=	${addprefix $(OBJDIR), $(SRCS:%.s=%.o)}


# ===== #


all:			$(NAME)

$(NAME):		$(OBJDIR) $(OBJS)
				$(AR) $(NAME) $(OBJS)

bonus:			$(OBJDIR) $(OBJS)
				# TODO

clean:
				@rm -rf $(OBJDIR)

fclean:			
				@rm -rf $(NAME) $(OBJDIR)
				@echo "Library cleaned"

re:				fclean all

$(OBJDIR)%.o:	$(SRCDIR)%.s
				$(ASM) $(ASMFLAGS) $< -o $@

$(OBJDIR):
				@mkdir -p $(OBJDIR)

.PHONY:			re clean fclean all
