#ifndef _DAC_H_
#define _DAC_H_


#include "stdint.h"


#define DAC_REF 3.30f

#define DAC_RANGE 4095



void DAC_Init(void);


float ADN8831_Temp_Calcu(float mon_vol,float Tr);
float ADN8831_Set_Vol_Calcu(float temp,float Tr);

void dac_voltage_output(uint8_t ch,float vol);

#endif

