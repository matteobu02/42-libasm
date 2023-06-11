#include <string.h>

int ft_isspace(int c)
{
	return (c == 32 || (c > 8 && c < 14));
}

char *ft_strchr(const char *s, int c)
{
	int i = -1;
	while (s[++i])
		if (s[i] == c)
			return (char *)(s + 1);
	if (!c)
		return (char *)(s + 1);
	return 0;
}

int check_base(const char *b)
{
	if (strlen(b) < 2)
		return 1;
	while (*b)
	{
		if (ft_isspace(*b) || (*b == '+') || (*b == '-') )
			return 1;
		if (ft_strchr(b + 1, *b))
			return 1;
		++b;
	}
	return 0;
}

int	ft_atoi_base(const char *s, const char *base)
{
	if (!s || !base || check_base(base))
		return 0;
	while (ft_isspace(*s))
		++s;
	int sign = 1;
	while (*s == '-' || *s == '+')
	{
		if (*s == '-')
			sign *= -1;
		++s;
	}
	int ret = 0;
	int base_len = strlen(base);
	char *found;
	while (*s && (found = ft_strchr(base, *s)))
	{
		ret = ret * base_len + (found - base);
		++s;
	}
	return (ret * sign);
}
