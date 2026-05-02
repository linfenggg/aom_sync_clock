/* USER CODE BEGIN Header */
/**
  ******************************************************************************
  * @file    usart.c
  * @brief   This file provides code for the configuration
  *          of the USART instances.
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
#include "usart.h"

/* USER CODE BEGIN 0 */

#include "string.h"
#include "stdio.h"
#include "stdlib.h"
#include "stdarg.h"
#include "sys_control.h"
#include "gd32f10x_usart.h"
#include "gpio.h"



Uart_Manage_t  uart1_rev=
{
	.send=uart1_send,


};


unsigned char rx1_buf[64];
unsigned char TCM_Rx_cnt=0;




void usart_delay(void)
{
	uint16_t cnt=2000;
	while(cnt--)
	{
	__nop();__nop();__nop();
	
	}


}



void MX_USART1_UART_Init(void)
{
	
    /* enable GPIO clock */
    rcu_periph_clock_enable(RCU_GPIOA);
		rcu_periph_clock_enable(RCU_AF);
    /* enable USART clock */
    rcu_periph_clock_enable(RCU_USART1);
		//gpio_pin_remap_config(GPIO_USART1_REMAP,ENABLE);
	
    /* connect port to USARTx_Tx */
    gpio_init(GPIOA, GPIO_MODE_AF_PP, GPIO_OSPEED_50MHZ, GPIO_PIN_2);

    /* connect port to USARTx_Rx */
    gpio_init(GPIOA, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, GPIO_PIN_3);

    /* USART configure */
    usart_deinit(USART1);
    usart_baudrate_set(USART1, 115200U);
    usart_receive_config(USART1, USART_RECEIVE_ENABLE);
    usart_transmit_config(USART1, USART_TRANSMIT_ENABLE);
		usart_word_length_set(USART1,USART_WL_8BIT);
		usart_parity_config(USART1,USART_PM_NONE);
		usart_stop_bit_set(USART1,USART_STB_1BIT);

    usart_enable(USART1);


		//接收中断和空闲中断
		nvic_irq_enable(USART1_IRQn, 0, 0);
		usart_interrupt_enable(USART1, USART_INT_RBNE);
	  usart_interrupt_enable(USART1, USART_INT_IDLE);
}




void USART1_IRQHandler(void)
{


	  if(RESET != usart_interrupt_flag_get(USART1, USART_INT_FLAG_RBNE)){
			
			usart_interrupt_flag_clear(USART1, USART_INT_FLAG_RBNE);
			//告警清除
        /* read one byte from the receive data register */
			
        rx1_buf[TCM_Rx_cnt] = (uint8_t)usart_data_receive(USART1);
				TCM_Rx_cnt++;
					//数据溢出	
				if(TCM_Rx_cnt>=64)TCM_Rx_cnt=0;
    } 
	
		
		if(RESET != usart_interrupt_flag_get(USART0, USART_INT_FLAG_IDLE)){
		
			usart_interrupt_flag_clear(USART1, USART_INT_FLAG_IDLE);

			(GET_BITS(USART_STAT(USART1), 0U, 8U));  //先读取SR
			(GET_BITS(USART_DATA(USART1), 0U, 8U));   //再读取DR
			
		//if('\r'==TCM_Rx_Buf[TCM_Rx_cnt-1])


		
			//拷贝接收数据帧
		
			if(uart1_rev.rev_flag==0)
			{
			uart1_rev.rec_len=TCM_Rx_cnt;
			memcpy(uart1_rev.rev_fram,rx1_buf,TCM_Rx_cnt);
			uart1_rev.rev_flag=1;
			memset(rx1_buf,0,sizeof(rx1_buf));
			}
			//	LED_ERR_FLASH;
    
		TCM_Rx_cnt=0;

	}
	
}





void uart1_send(uint8_t * data,uint16_t len)
{
	
	while(len--)
	{
		usart_data_transmit(USART1, *data++);
    while(RESET == usart_flag_get(USART1, USART_FLAG_TBE));
	}
	
	usart_delay();

	
}





/* retarget the C library printf function to the USART */
int fputc(int ch, FILE *f)
{
	
    usart_data_transmit(USART1, (uint8_t)ch);
    while(RESET == usart_flag_get(USART1, USART_FLAG_TBE));
    return ch;
}


/* USER CODE END 1 */
