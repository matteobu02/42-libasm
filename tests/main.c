#include <stdio.h>

extern char ft_atoi_base(const char *s, const char *base);

int main(void)
{
	return printf("%d\n", ft_atoi_base("1234", "0123456789"));
}
