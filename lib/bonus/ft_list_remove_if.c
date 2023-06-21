#include <stdlib.h>

typedef struct s_list
{
	struct s_list	*next;
	void			*data;
}

void ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void*))
{
	if (!begin_list || !data_ref || !cmp || !free_fct)
		return ;
	t_list *tmp, *curr;

	while (*begin_list && !(*cmp)((*begin_list)->data, data_ref))
	{
		tmp = *begin_list;
		*begin_list = (*begin_list)->next;
		(*free_fct)(tmp->data);
		free(tmp);
	}
	tmp = *begin_list;
	if (!tmp)
		return ;
	curr = tmp->next;
	while (curr)
	{
		if (!(*cmp)(curr->data, data_ref))
		{
			tmp->next = curr->next;
			(*free_fct)(curr->data);
			free(curr);
			curr = tmp->next;
			continue ;
		}
		tmp = curr;
		curr = curr->next;
	}
}
