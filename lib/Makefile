NAME		=	libasm.a
AR			=	ar rsc
ASM			=	nasm
ASMFLAGS	=	-g -f
SRCDIR		=	./src/
OBJDIR		=	./obj/
BONUSDIR	=	./bonus/

ifeq ($(shell uname), Linux)
	ASMFLAGS += elf64
else
	ASMFLAGS += macho64
endif

SRC		=	ft_strlen.s	\
				ft_strcpy.s	\
				ft_strcmp.s	\
				ft_write.s	\
				ft_read.s	\
				ft_strdup.s	\

B_SRC		=	ft_atoi_base_bonus.s		\
				ft_list_push_front_bonus.s	\
				ft_list_size_bonus.s		\
				ft_list_sort_bonus.s		\
				ft_list_remove_if_bonus.s	\

OBJ		=	${addprefix $(OBJDIR), $(SRC:%.s=%.o)}
B_OBJ		=	${addprefix $(OBJDIR), $(B_SRC:%.s=%.o)}


# ===== #


all:			$(NAME)

$(NAME):		$(OBJDIR) $(OBJ)
				$(AR) $(NAME) $(OBJ)

bonus:			$(OBJDIR) $(OBJ) $(B_OBJ)
				$(AR) $(NAME) $(OBJ) $(B_OBJ)

clean:
				@rm -rf $(OBJDIR)

fclean:			
				@rm -rf $(NAME) $(OBJDIR)

re:				fclean all

$(OBJDIR)%.o:	$(SRCDIR)%.s
				$(ASM) $(ASMFLAGS) $< -o $@

$(OBJDIR)%.o:	$(BONUSDIR)%.s
				$(ASM) $(ASMFLAGS) $< -o $@

$(OBJDIR):
				@mkdir -p $(OBJDIR)

.PHONY:			re clean fclean objs all
