#include <stdlib.h>

typedef struct s_list
{
	void			*data;
	struct s_list	*next;
}	t_list;

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*))
{
	t_list	*list;
	t_list	*tmp;

	list = *begin_list;
	while (list && list->next)
	{
		if (!(*cmp)(list->next->data, data_ref))
		{
			tmp = list->next;
			list->next = list->next->next;
			(*free_fct)(tmp->data);
			free(tmp);
		}
		list = list->next;
	}
	list = *begin_list;
	if (list && !(*cmp)(list->data, data_ref))
	{
		*begin_list = list->next;
		(*free_fct)(list->data);
		free(list);
	}
}
