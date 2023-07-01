#include <stdio.h>
#include <string.h>
#include <fcntl.h>
#include <stdlib.h>

typedef struct	s_list
{
	void *data;
	struct s_list *next;
}	t_list;

extern size_t	ft_strlen(char *str);
extern char		*ft_strcpy(char *dst, char *src);
extern int		ft_strcmp(const char *dst, const char *src);
extern int		ft_write(int fd, const void *buff, size_t bsize);
extern int		ft_read(int fd, void *buff, size_t bsize);
extern char		*ft_strdup(const char *str);

extern int		ft_atoi_base(const char *str, const char *base);
extern void		ft_list_push_front(t_list **begin_list, void *data);
extern int		ft_list_size(t_list *begin_list);
extern int		ft_list_sort(t_list **begin, int (*cmp)());
extern int		ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

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
	char *s = ft_strdup("VIVE L'ASM <3");
	printf("%s\n", s);
	printf("Mystrlen[%zu]\nRealstrlen[%zu]\n", ft_strlen(s), strlen(s));
	printf("Mystrcmp[%d]\nRealstrcmp[%d]\n", ft_strcmp(s, "OUI"), strcmp(s, "OUI"));
	char buff[16] = {0};
	printf("Write a string of max 16 char I'll read it and write it back to you\n");
	ft_read(0, buff, 16);
	printf("Reading..\n");
	ft_write(1, buff, 16);
	printf("Time to test bonuses !\n");
	printf("SHOULD BE '-15':[%d]\n", ft_atoi_base("+-++f", "0123456789abcedf"));		//HEX
	printf("SHOULD BE '255':[%d]\n", ft_atoi_base("+-++-ff", "0123456789abcedf"));	//HEX
	printf("SHOULD BE '-15':[%d]\n", ft_atoi_base("        +-f", "0123456789abcedf"));//HEX
	printf("SHOULD BE '29':[%d]\n", ft_atoi_base("       ---+-++11101", "01"));		//BINARY
	printf("SHOULD BE '0':[%d]\n", ft_atoi_base("",""));
	char *a = ft_strdup("a");
	char *b = ft_strdup("b");
	char *c = ft_strdup("c");
	char *d = ft_strdup("d");
	char *e = ft_strdup("e");
	t_list *lst = malloc(sizeof(t_list));
	t_list **blst = &lst;
	lst->data = a;
	printf("SHOULD BE '1':[%d]\n", ft_list_size(*blst));
	ft_list_push_front(blst, e);
	ft_list_push_front(blst, c);
	ft_list_push_front(blst, e);
	ft_list_push_front(blst, b);
	ft_list_push_front(blst, d);
	t_list *tlst = lst;
	printf("New size of the list = [%d]\n", ft_list_size(lst));
	printf("Here's a display of the element's data in order\n");
	printf("SHOULD BE [d][b][e][c][e][a]\n");
	while (tlst)
	{
		printf("[%s]", (char *)tlst->data);
		tlst = tlst->next;
	}
	printf("\n");
	printf("SORTING LIST\n");
	ft_list_sort(blst, &ccmp);
	tlst = lst;
	while (tlst)
	{
		printf("[%s]", (char *)tlst->data);
		tlst = tlst->next;
	}
	printf("\n");
	printf("LIST SORTED\n");
	printf("SHOULD BE [a][b][c][d][e][e]\n");
	printf("Removing elements with data 'c'\n");
	ft_list_remove_if(blst, c, &ccmp, &free);
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
