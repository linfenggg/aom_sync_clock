#ifndef _ADS7883_H_
#define _ADS7883_H_


#include "stdint.h"

#define ADS_REF  3.0f

#define ADS_SELECT(n)  (n==0?gpio_bit_set(GPIOB,GPIO_PIN_6):gpio_bit_reset(GPIOB,GPIO_PIN_6))




void ads7883_init(void);

uint16_t ads7883_capture(void);

#endif



