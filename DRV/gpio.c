/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    gpio.c
  * @brief   This file provides code for the configuration
  *          of all used GPIO pins.
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
#include "gpio.h"
#include "gd32f10x.h"
#include "usart.h"


void MX_GPIO_Init(void)
{

	 /* GPIO Ports Clock Enable */
	rcu_periph_clock_enable(RCU_GPIOA);
	rcu_periph_clock_enable(RCU_GPIOB);
	rcu_periph_clock_enable(RCU_GPIOC);
	rcu_periph_clock_enable(RCU_GPIOD);
	 rcu_periph_clock_enable(RCU_AF);
		
	//禁用jtag
	gpio_pin_remap_config(GPIO_SWJ_SWDPENABLE_REMAP, ENABLE);
  gpio_pin_remap_config(GPIO_PD01_REMAP,ENABLE);
	
		//#####LED PID 
	  /*Configure GPIO pin Output Level */

	 gpio_init(GPIOA, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ,GPIO_PIN_1);
	
//GPIO_BOP(GPIOA)=GPIO_PIN_1;
	
	GPIO_BC(GPIOA)=GPIO_PIN_1;
	//debug led  PB7
//	 gpio_init(LED_RUN_GPIO_PORT, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ,LED_RUN_PIN);
// LED_RUN_OFF;	
		
		//485REN/TEN
//		gpio_init(GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ,GPIO_PIN_4);  
//		gpio_init(GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ,GPIO_PIN_5);  

		//默认为接收模式
	//	RS485_RX;	
		


	//gpio_init(I2C0_SCL_PORT, GPIO_MODE_OUT_OD, GPIO_OSPEED_50MHZ,I2C0_SCL_PIN);  
	//gpio_init(I2C0_SDA_PORT, GPIO_MODE_OUT_OD, GPIO_OSPEED_50MHZ,I2C0_SDA_PIN);
	

}










