#ifndef DRV_MAX5395_H_
#define DRV_MAX5395_H_





#include "gpio.h"


#define MAX5395_ADDR 0x50


//读取地址
#define ADDR_GET_WIPER  0x00
#define ADDR_GET_CONFIG 0x80


//写寄存器地址
#define  ADDR_WIPER 0x00
#define  ADDR_SD_CLR 0x80 
#define  ADDR_SD_H_WREG  0x90
#define  ADDR_SD_H_ZERO 0x91
#define  ADDR_SD_H_MID 0x92
#define  ADDR_SD_H_FULL 0x93
#define  ADDR_SD_L_WRGE  0x88
#define  ADDR_SD_L_ZERO 0x89
#define  ADDR_SD_L_MID  0x8A
#define  ADDR_SD_L_FULL 0x8B
#define  ADDR_SD_W   0x84
#define  ADDR_QP_OFF 0xA0
#define  ADDR_QP_ON   0xA1
#define  ADDR_RST 0xC0





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



void drv_max5395_init(void);

uint8_t  drv_max5395_set_wiper_value(uint8_t value);
uint8_t  drv_max5395_get_wiper_value(uint8_t *value);

#endif





