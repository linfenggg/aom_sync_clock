/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    adc.c
  * @brief   This file provides code for the configuration
  *          of the ADC instances.
  ******************************************************************************
  * @attention
  *
  * Copyright (c) 2022 STMicroelectronics.
  * All rights reserved.
  *
  * This software is licensed under terms that can be found in the LICENSE file
  * in the root directory of this software component.
  * If no LICENSE file comes with this software, it is provided AS-IS.
  *
  ******************************************************************************
  */
/* USER CODE END Header */
/* Includes ------------------------------------------------------------------*/
#include "adc.h"
#include "gd32f10x.h"
#include "systick.h"
#include "stdio.h"
#include "usart.h"

//adc dma 数据缓存
//高位是adc1,低位是adc0
uint32_t adc_dma_value[4];



//
void MX_ADC_Init(void)
{
	


//* ADC1 init function */
	
	
//adc 通道绑定
	
	
    /* ADC_DMA_channel configuration */
    dma_parameter_struct dma_data_parameter;
		
		

		rcu_periph_clock_enable(RCU_AF);
	  /* config the GPIO as analog mode */  
	
	

    /* enable GPIOB clock */
    rcu_periph_clock_enable(RCU_GPIOA);
		rcu_periph_clock_enable(RCU_GPIOB);
    /* enable DMA clock */
    rcu_periph_clock_enable(RCU_DMA0);
    /* enable ADC0 clock */
    rcu_periph_clock_enable(RCU_ADC0);
    /* enable ADC1 clock */
    rcu_periph_clock_enable(RCU_ADC1);
    /* config ADC clock */
		
		
		/*模拟通道分配
		PA0-CH0: LD1电压采集
		PA1-CH1: LD2电压采集
		PA2-CH2: TEC温度
		
		PA3-CH3: TEC电流
		PA6-CH6: LD1电流
		PA7-CH7: LD2电流
		
			
		*/
		
	
		gpio_init(GPIOA, GPIO_MODE_AIN, GPIO_OSPEED_10MHZ, GPIO_PIN_0|GPIO_PIN_1|GPIO_PIN_2|GPIO_PIN_3| GPIO_PIN_6|GPIO_PIN_7);
		gpio_init(GPIOB, GPIO_MODE_AIN, GPIO_OSPEED_10MHZ, GPIO_PIN_0);
    
    /* ADC_DMA_channel deinit */
    dma_deinit(DMA0, DMA_CH0);
    
    /* initialize DMA single data mode */
    dma_data_parameter.periph_addr = (uint32_t)(&ADC_RDATA(ADC0));
    dma_data_parameter.periph_inc = DMA_PERIPH_INCREASE_DISABLE;
    dma_data_parameter.memory_addr = (uint32_t)(&adc_dma_value);
    dma_data_parameter.memory_inc = DMA_MEMORY_INCREASE_ENABLE;
    dma_data_parameter.periph_width = DMA_PERIPHERAL_WIDTH_32BIT;
    dma_data_parameter.memory_width = DMA_MEMORY_WIDTH_32BIT;
    dma_data_parameter.direction = DMA_PERIPHERAL_TO_MEMORY;
    dma_data_parameter.number = ADC_NUM;
    dma_data_parameter.priority = DMA_PRIORITY_HIGH;  
    dma_init(DMA0, DMA_CH0, &dma_data_parameter);
  
    dma_circulation_enable(DMA0, DMA_CH0);
  
    /* enable DMA channel */
    dma_channel_enable(DMA0, DMA_CH0);  

		
    /* configure the ADC sync mode */
    adc_mode_config(ADC_DAUL_REGULAL_PARALLEL);
    /* ADC data alignment config */
    adc_data_alignment_config(ADC0, ADC_DATAALIGN_RIGHT);
    adc_data_alignment_config(ADC1, ADC_DATAALIGN_RIGHT);
    /* ADC scan mode function enable */
    adc_special_function_config(ADC0, ADC_SCAN_MODE, ENABLE);
		adc_special_function_config(ADC0, ADC_CONTINUOUS_MODE, ENABLE); 
    adc_special_function_config(ADC1, ADC_SCAN_MODE, ENABLE);
	  adc_special_function_config(ADC1, ADC_CONTINUOUS_MODE, ENABLE); 

    /* ADC channel length config */
    adc_channel_length_config(ADC0, ADC_REGULAR_CHANNEL,ADC_NUM);
    adc_channel_length_config(ADC1, ADC_REGULAR_CHANNEL,ADC_NUM);
    /* ADC regular channel config */
    adc_regular_channel_config(ADC0, 0, ADC_CHANNEL_0, ADC_SAMPLETIME_55POINT5);
    adc_regular_channel_config(ADC0, 1, ADC_CHANNEL_1, ADC_SAMPLETIME_55POINT5);
		adc_regular_channel_config(ADC0, 2, ADC_CHANNEL_2, ADC_SAMPLETIME_55POINT5);
		adc_regular_channel_config(ADC0, 3, ADC_CHANNEL_8, ADC_SAMPLETIME_55POINT5);
	
		
    adc_regular_channel_config(ADC1, 0, ADC_CHANNEL_3, ADC_SAMPLETIME_55POINT5);
    adc_regular_channel_config(ADC1, 1, ADC_CHANNEL_6, ADC_SAMPLETIME_55POINT5);
		adc_regular_channel_config(ADC1, 2, ADC_CHANNEL_7, ADC_SAMPLETIME_55POINT5);
		adc_regular_channel_config(ADC1, 3, ADC_CHANNEL_9, ADC_SAMPLETIME_55POINT5);
  
    /* ADC trigger config */
    adc_external_trigger_source_config(ADC0, ADC_REGULAR_CHANNEL, ADC0_1_EXTTRIG_REGULAR_T1_CH1);
    adc_external_trigger_source_config(ADC1, ADC_REGULAR_CHANNEL, ADC0_1_2_EXTTRIG_REGULAR_NONE);
    /* ADC external trigger enable */
    adc_external_trigger_config(ADC0, ADC_REGULAR_CHANNEL, ENABLE);
    adc_external_trigger_config(ADC1, ADC_REGULAR_CHANNEL, ENABLE);
   
    /* enable ADC interface */
    adc_enable(ADC0);
    delay_1ms(1);    
    /* ADC calibration and reset calibration */
    adc_calibration_enable(ADC0);
    /* enable ADC interface */
    adc_enable(ADC1);    
    delay_1ms(1);
    /* ADC calibration and reset calibration */
    adc_calibration_enable(ADC1);
    
    /* ADC DMA function enable */
    adc_dma_mode_enable(ADC0);
		
		//adc_software_trigger_enable(ADC0, ADC_REGULAR_CHANNEL);
}


//float  ADC_get_5v_vol(void)
//{
//	//分压电阻10/15
//	
//	
//	float vol;
//	unsigned short reg=(adc_dma_value[0]&0xffff);
//	
//	vol= reg*ADC_REF/ADC_RANGE*((15.0f+10.0f)/15.0f);
//	return vol;
//	
//}


//float  ADC_get_24V_vol(void)
//{
//	//分压电阻3/15
//	float vol;
//	unsigned short reg=(adc_dma_value[3]);
//	vol= reg*ADC_REF/ADC_RANGE*((20.0f+3.0f)/3.0f);
//	return vol;


//}
//float  ADC_get_tcm_vol_p(void)
//{
//		//分压电阻10/1
//	float vol;
//	unsigned short reg=(adc_dma_value[1]);
//	vol= reg*ADC_REF/ADC_RANGE*((10.0f+1.0f)/1.0f);
//	return vol;

//}

//float  ADC_get_tcm_vol_n(void)
//{
//		//分压电阻10/1
//	float vol;
//	unsigned short reg=(adc_dma_value[0]>>16);
//	vol= reg*ADC_REF/ADC_RANGE*((10.0f+1.0f)/1.0f);
//	return vol;

//}
uint16_t  ADC_get_tcm_cur(void)
{
	return (adc_dma_value[0]>>16)*3.3f/4096/TCM_CUR_FACTOR*1000;
}

uint16_t ADC_get_tcm_value( void)
{
		
	return (adc_dma_value[2]&0xffff);


}


uint16_t ADC_get_ld_current(void)
{

	return (float)(adc_dma_value[1]>>16)*3.3f/4096/LD_CUR_FACTOR*1000;

}

uint16_t ADC_get_ld_vol(void)
{

	return (float)(adc_dma_value[0]&0xffff)*3.3f/4096*1000;

}

float ADC_get_board_temp_vol(void)
{

	return (adc_dma_value[3]&0xffff)*3.3f/4096;

}


void adc_capture(void)
{

	//测试
	uint8_t i=0;
	for(i=0;i<ADC_NUM;i++)
{
	//TCM_Print("adc[%d]=%.2f\r\n",i*2,(float)(adc_dma_value[i]&0xffff)*3.3f/4096);
	//TCM_Print("adc[%d]=%.2f\r\n",i*2+1,(float)(adc_dma_value[i]>>16)*3.3f/4096);
}
	
}




