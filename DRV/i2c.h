/*!
    \file    i2c.h
    \brief   the header file of I2C

    \version 2022-05-30, V1.0.0, firmware for GD32F30x
*/

/*
    Copyright (c) 2022, GigaDevice Semiconductor Inc.

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

#ifndef I2C_H
#define I2C_H

#include "gd32f10x.h"
#include  "gpio.h"

#define SDA_IN()   IIC_SDA_H//gpio_init(I2C0_SDA_PORT, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ,I2C0_SDA_PIN);
#define SDA_OUT() 	IIC_SDA_H// gpio_init(I2C0_SDA_PORT, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ,I2C0_SDA_PIN);

//#define SDA_IN()  	GPIO_CTL1(GPIOB)&=~GPIO_MODE_MASK(1);GPIO_CTL1(GPIOB)|=GPIO_MODE_SET(1,0x08)
//#define SDA_OUT()   GPIO_CTL1(GPIOB)&=~GPIO_MODE_MASK(1);GPIO_CTL1(GPIOB)|=GPIO_MODE_SET(1,0x03)


//IO操作函数	 
#define IIC_SCL_H    GPIO_BOP(I2C0_SCL_PORT)=I2C0_SCL_PIN
#define IIC_SCL_L    GPIO_BC(I2C0_SCL_PORT)=I2C0_SCL_PIN
#define IIC_SDA_H    GPIO_BOP(I2C0_SDA_PORT)=I2C0_SDA_PIN
#define IIC_SDA_L    GPIO_BC(I2C0_SDA_PORT)=I2C0_SDA_PIN
#define READ_SDA  	 gpio_input_bit_get(I2C0_SDA_PORT,I2C0_SDA_PIN)


//IIC所有操作函数
void I2C_delay(uint32_t cnt);
void drv_i2c_init(void);        //初始化IIC的IO口				 
void IIC_Start(void);				//发送IIC开始信号
void IIC_Stop(void);	  		//发送IIC停止信号

uint8_t IIC_Send_Byte(uint8_t txd);			//IIC发送一个字节
uint8_t IIC_Read_Byte(uint8_t ack);//IIC读取一个字节
uint8_t IIC_Wait_Ack(void); 				//IIC等待ACK信号

void IIC_Ack(void);					//IIC发送ACK信号
void IIC_NAck(void);				//IIC不发送ACK信号

void IIC_Write_One_Byte(uint8_t daddr,uint8_t addr,uint8_t data);
uint8_t IIC_Read_One_Byte(uint8_t daddr,uint8_t addr);	





#endif  /* I2C_H */
