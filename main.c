#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}	t_list;

extern size_t	_ft_strlen(char *str);
extern char		*_ft_strcpy(char *dst, char *src);
extern int		_ft_strcmp(const char *dst, const char *src);
extern int		_ft_write(int fd, const void *buff, size_t bsize);
extern int		_ft_read(int fd, void *buff, size_t bsize);
extern char		*_ft_strdup(const char *str);

extern int		_ft_atoi_base(const char *str, const char *base);
extern void		_ft_list_push_front(t_list **begin_list, void *data);
extern int		_ft_list_size(t_list *begin_list);
extern int		_ft_list_sort(t_list **begin, int (*cmp)());
extern void		_ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

/*
** THIS IS A TESTER
*/

void print_lst(t_list *head)
{
	while (head)
	{
		_ft_write(1, "[", 1);
		_ft_write(1, head->data, _ft_strlen(head->data));
		_ft_write(1, "]", 1);
		head = head->next;
	}
	_ft_write(1, "\n", 1);
}

int main()
{
	char *s = _ft_strdup("VIVE L'ASM <3");
	printf("%s\n\n", s);
	printf("Mystrlen[%zu]\nRealstrlen[%zu]\n", _ft_strlen(s), strlen(s));
	printf("Mystrcmp[%d]\nRealstrcmp[%d]\n", _ft_strcmp(s, "OUI"), strcmp(s, "OUI"));

	char buff[16] = {0};
	printf("\nWrite a string of max 16 char I'll read it and write it back to you\n");
	_ft_read(0, buff, 16);
	printf("Reading..\n");
	_ft_write(1, buff, 16);

	printf("\nTime to test bonuses !\n");
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("+-++f", "0123456789abcedf"));		//HEX
	printf("SHOULD BE '255':[%d]\n", _ft_atoi_base("+-++-ff", "0123456789abcedf"));	//HEX
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("        +-f", "0123456789abcedf"));//HEX
	printf("SHOULD BE '29':[%d]\n", _ft_atoi_base("       ---+-++11101", "01"));		//BINARY
	printf("SHOULD BE '0':[%d]\n", _ft_atoi_base("",""));

	t_list *lst = NULL;
	_ft_list_push_front(&lst, _ft_strdup("a"));
	printf("SHOULD BE '1':[%d]\n", _ft_list_size(lst));

	_ft_list_push_front(&lst, _ft_strdup("e"));
	_ft_list_push_front(&lst, _ft_strdup("c"));
	_ft_list_push_front(&lst, _ft_strdup("e"));
	_ft_list_push_front(&lst, _ft_strdup("b"));
	_ft_list_push_front(&lst, _ft_strdup("d"));

	printf("\nNew size of the list = [%d]\n", _ft_list_size(lst));
	_ft_write(1, "CURRENTLY: ", 11);
	print_lst(lst);
	printf("SHOULD BE [d][b][e][c][e][a]\n");

	printf("\nSORTING LIST\n");
	_ft_list_sort(&lst, &_ft_strcmp);
	_ft_write(1, "LIST SORTED: ", 13);
	print_lst(lst);
	printf("SHOULD BE [a][b][c][d][e][e]\n");

	printf("\nRemoving elements with data 'c'\n");
	_ft_list_remove_if(&lst, "c", &_ft_strcmp, &free);
	print_lst(lst);
	printf("SHOULD BE [a][b][d][e][e]\n");

	printf("\nBy now you should understand that my lib works :D !\n");
}
