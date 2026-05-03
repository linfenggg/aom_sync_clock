/*!
    \file    main.c
    \brief   led spark with systick, USART print and key example

    \version 2017-02-10, V1.0.0, firmware for GD32F30x
    \version 2018-10-10, V1.1.0, firmware for GD32F30x
    \version 2018-12-25, V2.0.0, firmware for GD32F30x
    \version 2020-09-30, V2.1.0, firmware for GD32F30x
*/

/*
    Copyright (c) 2020, GigaDevice Semiconductor Inc.

    Redistribution and use in source and binary forms, with or without modification,
are permitted provided that the following conditions are met:

    1. Redistributions of source code must retain the above copyright notice, this
       list of conditions and the following disclaimer.
    2. Redistributions in binary form must reproduce the above copyright notice,
       this list of conditions and the following disclaimer in the documentation
       and/or other materials provided with the distribution.
    3. Neither the name of the copyright holder nor the names of its contributors
       may be used to endorse or promote products derived from this software without
       specific prior written permission.

    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY
OF SUCH DAMAGE.
*/

#include "gd32f10x.h"
#include "systick.h"
#include <stdio.h>
#include "stdint.h"
#include "string.h"
#include "main.h"
#include "adc.h"
#include "tim.h"
#include "usart.h"
#include "gpio.h"
#include "sys_control.h"

#include "dac.h"
#include "ads7883.h"
#include "flash_if.h"
#include "modbus_comm.h"
#include "drv_hmc830lp6ge.h"

int main(void)
{
  //	float pwm=-100;
  systick_config();
	nvic_priority_group_set(NVIC_PRIGROUP_PRE2_SUB2);
  /* Initialize all configured peripherals */
//  MX_GPIO_Init();
  MX_USART1_UART_Init();
	
	
	HMC830_GPIO_Init();
	HMC830_Init();
	
    printf("System Start\r\n");

 
	HMC830_HMC_Test_READ();
  //para_init();

  while (1)
  {
		
		 HMC830_HMC_Write_Freq(20, 5, 1500, 2.54);
    
	
      
    uint32_t id = HMC830_HMC_Read_Chip_ID();
  uint32_t lock = HMC830_HMC_Read_Lock_Detect();
 
		
   // memset(UserTxBuffer, 0, sizeof(UserTxBuffer));
    printf("HMC830 ID:0x%X\r\nLD:%s\r\n", id, lock == HMC830_LOCKED ? "LOCKED" : "UNLOCKED");
   // CDC_Transmit_FS((uint8_t*)UserTxBuffer,sizeof(UserTxBuffer));
  
 //   rs485_task(); // 通讯处理
	//  HMC830_Test();     
//sys_status_update();

	//printf("aa");
	delay_1ms(2000);
	
  }
}
