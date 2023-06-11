NAME		=	libasm.a
AR			=	ar rsc
ASM			=	nasm
ASMFLAGS	=	-g -f
SRCDIR		=	./srcs/
OBJDIR		=	./objs/
BONUSDIR	=	./bonus/

ifeq ($(shell uname), Linux)
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

B_SRCS		=	ft_atoi_base_bonus.s		\
				ft_list_push_front_bonus.s	\
				ft_list_size_bonus.s		\
				ft_list_sort_bonus.s		\
				ft_list_remove_if_bonus.s	\

OBJS		=	${addprefix $(OBJDIR), $(SRCS:%.s=%.o)}
B_OBJS		=	${addprefix $(OBJDIR), $(B_SRCS:%.s=%.o)}


# ===== #


all:			$(NAME)

$(NAME):		$(OBJDIR) $(OBJS)
				$(AR) $(NAME) $(OBJS)

bonus:			$(OBJDIR) $(OBJS) $(B_OBJS)
				$(AR) $(NAME) $(OBJS) $(B_OBJS)

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
