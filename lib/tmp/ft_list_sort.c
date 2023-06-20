
typedef struct s_list
{
	struct s_list	*next;
	void			*data;
}	t_list;

void ft_swap(void *p1, void *p2)
{
	*p1 ^= *p2;
	*p2 ^= *p1;
	*p1 ^= *p2;
}

void ft_list_sort(t_list **begin_list, int (*cmp)())
{
	if (!begin_list || !cmp)
		return;
	t_list *curr = *begin_list;
	t_list *next;

	while (curr)
	{
		next = curr->next;
		while (next)
		{
			if ((*cmp)(curr->data, next->next) > 0)
			{
				ft_swap(curr->data, next->data);
				next = curr;
			}
			next = next->next;
		}
		curr = curr->next;
	}
}
