#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>

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
extern int		_ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

/*
** THIS IS A TESTER
*/


//Char compare used to test list functions
int ccmp(char *a, char *b)
{
	return ((*(char *)a)-(*(char *)b));
}

int main()
{
	char *s = _ft_strdup("VIVE L'ASM <3");
	printf("%s\n", s); 
	printf("Mystrlen[%zu]\nRealstrlen[%zu]\n", _ft_strlen(s), strlen(s));
	printf("Mystrcmp[%d]\nRealstrcmp[%d]\n", _ft_strcmp(s, "OUI"), strcmp(s, "OUI"));
	char buff[16] = {0};
	printf("Write a string of max 16 char I'll read it and write it back to you\n");
	_ft_read(0, buff, 16);
	printf("Reading..\n");
	_ft_write(1, buff, 16);
	printf("Time to test bonuses !\n");
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("+-++f", "0123456789abcedf"));		//HEX
	printf("SHOULD BE '255':[%d]\n", _ft_atoi_base("+-++-ff", "0123456789abcedf"));	//HEX
	printf("SHOULD BE '-15':[%d]\n", _ft_atoi_base("        +-f", "0123456789abcedf"));//HEX
	printf("SHOULD BE '29':[%d]\n", _ft_atoi_base("       ---+-++11101", "01"));		//BINARY
	printf("SHOULD BE '0':[%d]\n", _ft_atoi_base("",""));
	char a[] = "a";
	char b[] = "b";
	char c[] = "c";
	char d[] = "d";
	char e[] = "e";
	char f[] = "f";
	t_list *lst = malloc(sizeof(t_list));
	t_list **blst = &lst;
	lst->data = a;
	printf("SHOULD BE '1':[%d]\n", _ft_list_size(*blst));
	_ft_list_push_front(blst, f);
	_ft_list_push_front(blst, c);
	_ft_list_push_front(blst, f);
	_ft_list_push_front(blst, b);
	_ft_list_push_front(blst, d);
	t_list *tlst = lst;
	printf("New size of the list = [%d]\n", _ft_list_size(lst));
	printf("Here's a display of the element's data in order\n");
	printf("SHOULD BE [d][b][f][c][f][a]\n");
	while (tlst)
	{
		printf("[%s]", (char *)tlst->data);
		tlst = tlst->next;
	}
	printf("\n");
	printf("SORTING LIST\n");
	_ft_list_sort(blst, &ccmp);
	tlst = lst;
	while (tlst)
	{
		printf("[%s]", (char *)tlst->data);
		tlst = tlst->next;
	}
	printf("\n");
	printf("LIST SORTED\n");
	printf("SHOULD BE [a][b][c][d][f][f]\n");
	printf("Removing elements with data 'c'\n");
	_ft_list_remove_if(blst, c, &ccmp, &free);
	tlst = lst;
	while (tlst)
	{
		printf("[%s]", (char *)tlst->data);
		tlst = tlst->next;
	}
	printf("\n");
	printf("SHOULD BE [a][b][d][f][f]\n");
	printf("By now you should understand that my lib works :D !\n");
}
