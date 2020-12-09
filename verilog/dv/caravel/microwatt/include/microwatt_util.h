#ifndef __MICROWATT_UTIL_H
#define __MICROWATT_UTIL_H

#include "io.h"

#define LA_REG			0xc8020000

#define LA_MICROWATT_START	0xbadc0ffe
#define LA_MICROWATT_SUCCESS	0x0ddf00d5
#define LA_MICROWATT_FAILURE 	0x71077345

#ifdef __powerpc64__
static inline void microwatt_alive(void)
{
	writel(LA_MICROWATT_START, LA_REG);
}

static inline void microwatt_success(void)
{
	writel(LA_MICROWATT_SUCCESS, LA_REG);
}

static inline void microwatt_failure(void)
{
	writel(LA_MICROWATT_FAILURE, LA_REG);
}
#endif

#endif
