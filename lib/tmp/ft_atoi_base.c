int ft_strlen(const char *s)
{
	int i = 0;
	while (s[i])
		++i;
	return i;
}

int ft_isspace(int c)
{
	return (c == 32 || (c > 8 && c < 14));
}

char *ft_strchr(const char *s, int c)
{
	while (*s)
	{
		if (*s == c)
			return (char *)s;
		++s;
	}
	if (!c)
		return (char *)s;
	return 0;
}

int ft_atoi_base(const char *str, const char *base)
{
	int base_len = ft_strlen(base);
	if (base_len < 2)
		return 0;
	int i = -1;
	while (base[++i])
	{
		if (ft_isspace(base[i]) || base[i] == '+'
			|| base[i] == '-' || ft_strchr(base + i + 1, base[i]))
			return 0;
	}
	i = 0;
	while (str[i] && ft_isspace(str[i]))
		++i;
	int sign = 1;
	while (str[i] && (str[i] == '+' || str[i] == '-'))
	{
		if (str[i++] == '-')
			sign *= -1;
	}
	int ret = 0;
	char *found;
	while (str[i] && (found = ft_strchr(base, str[i++])))
		ret = ret * base_len + (found - base);
	return (ret * sign);
}
