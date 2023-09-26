NAME		=	libasm.a
AR			=	ar rsc
ASM			=	nasm
ASMFLAGS	=	-f elf64
SRCDIR		=	./src/
OBJDIR		=	./obj/

SRC		=	ft_strlen.s				\
			ft_strcpy.s				\
			ft_strcmp.s				\
			ft_write.s				\
			ft_read.s				\
			ft_strdup.s				\
			ft_atoi_base.s			\
			ft_list_push_front.s	\
			ft_list_size.s			\
			ft_list_sort.s			\
			ft_list_remove_if.s		\

OBJ		=	${addprefix $(OBJDIR), $(SRC:%.s=%.o)}


# ===== #


all:			$(NAME)

$(NAME):		$(OBJDIR) $(OBJ)
				$(AR) $(NAME) $(OBJ)

clean:
				@rm -rf $(OBJDIR)

fclean:			
				@rm -rf $(NAME) $(OBJDIR)

re:				fclean all

$(OBJDIR)%.o:	$(SRCDIR)%.s
				$(ASM) $(ASMFLAGS) $< -o $@

$(OBJDIR):
				@mkdir -p $(OBJDIR)

.PHONY:			re clean fclean objs all
