/*!
    \file    main.c
    \brief   DAC concurrent mode output voltage demo

    \version 2017-02-10, V1.0.0, firmware for GD32F30x
    \version 2018-10-10, V1.1.0, firmware for GD32F30x
    \version 2018-12-25, V2.0.0, firmware for GD32F30x
    \version 2020-09-30, V2.1.0, firmware for GD32F30x
*/

/*
    Copyright (c) 2020, GigaDevice Semiconductor Inc.


*/

#include "gd32f10x.h"
#include "stdio.h"
#include "dac.h"
#include "math.h"
#include "usart.h"





void DAC_Init(void)
{
		

}


float ADN8831_Temp_Calcu(float mon_vol,float Tr)
{
	float temp;
	float Rr=10,Br=3575;
	float Rfb=10.0f;
	float R=17.8f;
	float Rx=7.68f;
	//float Rx=0;
	float Vref=2.50f;
	float Vout=mon_vol;
	//step1:根据分压电阻网络换算出ntc电阻值
	float Rth= Rfb/(Vout*2/Vref-1+(Rfb/R))-Rx;
	temp=	1/((log(Rth/Rr)/Br)+1/(Tr+273.15f))-273.15f;
	
	return temp;
}


float ADN8831_Set_Vol_Calcu(float temp,float Tr)
{
	float vol;
	float Rr=10,Br=3575;
	float Rfb=10.0f;
	float R=18.0f;
	float Rx=7.68f;
	//float Rx=0;
	float Vref=2.50f;
	
	float Rth= exp((1/(temp+273.15f)-1/(Tr+273.15f))*Br)*Rr;
	vol= (Rfb/(Rth+Rx)+1-(Rfb/R))*Vref/2;
	return vol;
}




   

void dac_voltage_output(uint8_t ch,float vol)
{
	
	
	if(vol>DAC_REF)
	{
		vol=DAC_REF;
	}
	uint16_t  DAC_OUT_VAL= DAC_RANGE/DAC_REF*vol;
//	dac_data_set(ch, DAC_ALIGN_12B_R, DAC_OUT_VAL);
}




