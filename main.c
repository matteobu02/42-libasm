#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>
#include <unistd.h>
#include <errno.h>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}	t_list;

extern size_t	_ft_strlen(char *str);
extern char		*_ft_strcpy(char *dst, char *src);
extern int		_ft_strcmp(const char *dst, const char *src);
extern ssize_t	_ft_write(int fd, const void *buff, size_t bsize);
extern ssize_t	_ft_read(int fd, void *buff, size_t bsize);
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
	char buff[200] = {0};
	printf("===== READ: =====\n");
	printf("my bad read:  %ld\n", _ft_read(-1, buff, 0));
	printf("errno: %d\n", errno);
	printf("sys bad read: %ld\n", read(-1, buff, 0));
	printf("errno: %d\n", errno);

	char s1[200] = {0};
	write(1, "type a big string (max 200): ", 29);
	printf("my read: %ld\n", _ft_read(0, s1, 200));


	printf("\n===== WRITE: =====\n");
	printf("my bad write:  %ld\n", _ft_write(-1, s1, 10));
	printf("errno: %d\n", errno);
	printf("sys bad write: %ld\n", write(-1, s1, 10));
	printf("errno: %d\n", errno);

	printf("\nthe string you typed earlier:\n");
	ssize_t my_write = _ft_write(1, s1, strlen(s1));
	ssize_t original = write(1, s1, strlen(s1));
	printf("my write:  %ld\n", my_write);
	printf("sys write: %ld\n", original);


	char s2[] = "";
	printf("\n===== STRLEN: =====\n");
	printf("my strlen:  %ld\n", _ft_strlen(s2));
	printf("sys strlen: %ld\n", strlen(s2));
	printf("my strlen:  %ld\n", _ft_strlen(s1));
	printf("sys strlen: %ld\n", strlen(s1));


	printf("\n===== STRCPY: =====\n");
	printf("my strcpy:  %s\n", _ft_strcpy(buff, s2));
	printf("sys strcpy: %s\n", strcpy(buff, s2));
	printf("my strcpy:  %s", _ft_strcpy(buff, s1));
	printf("sys strcpy: %s", strcpy(buff, s1));


	printf("\n===== STRDUP: =====\n");
	printf("my strdup:  %s\n", _ft_strdup(s2));
	printf("sys strdup: %s\n", strdup(s2));
	printf("my strdup:  %s", _ft_strdup(s1));
	printf("sys strdup: %s", strdup(s1));

	/* BONUS */

	printf("\n\n***** BONUSES: *****\n\n");
	printf("\n===== ATOI_BASE: =====\n");
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("+-++f", "0123456789abcedf"));
	printf("SHOULD BE '255':[%d]\n", _ft_atoi_base("+-++-ff", "0123456789abcedf"));
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("        +-f", "0123456789abcedf"));
	printf("SHOULD BE '29':[%d]\n", _ft_atoi_base("       ---+-++11101", "01"));
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
