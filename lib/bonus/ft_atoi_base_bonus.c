#include <ctype.h>
#include <string.h>

int	ft_atoi_base(const char *s, const char *base)
{
	int base_len = strlen(base);
	if (base_len < 2)
		return 0;
	while (*base)
	{
		if (isspace(*base) || (*base == '+') || (*base == '-') || strchr(base + 1, *base))
			return 0;
		++base;
	}
	base -= base_len;
	while (isspace(*s))
		++s;
	int sign = 1;
	while (*s == '-' || *s == '+')
	{
		if (*s == '-')
			sign *= -1;
		++s;
	}
	int ret = 0;
	char *found;
	while (*s && (found = strchr(base, *s)))
	{
		ret = ret * base_len + (found - base);
		++s;
	}
	return (ret * sign);
}
