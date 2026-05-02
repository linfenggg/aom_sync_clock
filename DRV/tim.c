/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    tim.c
  * @brief   This file provides code for the configuration
  *          of the TIM instances.
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
#include "tim.h"

/* USER CODE BEGIN 0 */
#include "gd32f10x.h"
#include "stdio.h"
#include "sys_control.h"
#include "gpio.h"
#include "usart.h"
#include "drv_ads1115.h"

/* USER CODE END 0 */


/* TIM1 init function */


void TIM1_Init(void)
{
      /* TIMER0CLK = SystemCoreClock / 120 = 1MHz */
	
    timer_parameter_struct timer_initpara;
	

    rcu_periph_clock_enable(RCU_TIMER1);
    timer_deinit(TIMER1);
	
	 // timer_struct_para_init(&timer_initpara);
		
    /* TIMER1 configuration */
    timer_initpara.prescaler         = 1079;
    timer_initpara.alignedmode       = TIMER_COUNTER_EDGE;
    timer_initpara.counterdirection  = TIMER_COUNTER_UP;
    timer_initpara.period            = 4999;
    timer_initpara.clockdivision     = TIMER_CKDIV_DIV1;
    timer_initpara.repetitioncounter = 0;
    timer_init(TIMER1,&timer_initpara);


//		timer_flag_clear(TIMER1, TIMER_FLAG_UP);       // 清除更新标志位
//    timer_auto_reload_shadow_enable(TIMER1);  
//		
//		timer_interrupt_enable(TIMER1,TIMER_INT_UP);
//		nvic_irq_enable(TIMER1_IRQn, 0,0); 
//    timer_enable(TIMER1);

    timer_auto_reload_shadow_enable(TIMER1);
		nvic_irq_enable(TIMER1_IRQn, 1,1);
		timer_interrupt_flag_clear(TIMER1,TIMER_INT_FLAG_UP);
		timer_interrupt_enable(TIMER1,TIMER_INT_UP);
    timer_enable(TIMER1);
		
		
	
}



void TIMER1_IRQHandler()
{


timer_interrupt_flag_clear(TIMER1,TIMER_INT_FLAG_UP);
 //ADS1115_RefreshAllChannel();
	

}



