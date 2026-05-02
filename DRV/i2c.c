
#include "i2c.h"

void I2C_delay(unsigned int cnt)
{ 
	static unsigned  short delay=0;
	while(cnt--)
	{
		delay=100;
		while(delay--)
		{
			__nop();
			__nop();
			__nop();
		}
	
	}

}


void drv_max5395_i2c_init(void)
{					     
	SDA_OUT();
	I2C_delay(5);
	IIC_SCL_H;
	I2C_delay(5);
	IIC_SDA_H;

}
//产生IIC起始信号
void IIC_Start(void)
{
	SDA_OUT();     //sda线输出
	IIC_SDA_H;
	I2C_delay(2);	
	IIC_SCL_H;
	I2C_delay(5);
 	IIC_SDA_L;//START:when CLK is high,DATA change form high to low 
	I2C_delay(5);
	IIC_SCL_L;//钳住I2C总线，准备发送或接收数据 
}	  
//产生IIC停止信号
void IIC_Stop(void)
{
	SDA_OUT();//sda线输出
	IIC_SCL_L;
	I2C_delay(2);	
	IIC_SDA_L;//STOP:when CLK is high DATA change form low to high
 	I2C_delay(5);
	IIC_SCL_H; 
	I2C_delay(5);		
	IIC_SDA_H;//发送I2C总线结束信号
					   	
}
//等待应答信号到来
//返回值：1，接收应答失败
//        0，接收应答成功
unsigned char IIC_Wait_Ack(void)
{
	
	unsigned short ucErrTime=0;
	SDA_IN();      //SDA设置为输入  
	IIC_SDA_H;I2C_delay(2);	   
	IIC_SCL_H;I2C_delay(2);	 
	while(READ_SDA)
	{
		ucErrTime++;
		if(ucErrTime>500)
		{
			IIC_Stop();
			return 1;
		}
	}
	IIC_SCL_L;//时钟输出0 	   
	return 0;  
} 
//产生ACK应答
void IIC_Ack(void)
{
	IIC_SCL_L;
	I2C_delay(2);
	SDA_OUT();
	IIC_SDA_L;
	I2C_delay(2);
	IIC_SCL_H;
	I2C_delay(2);
	IIC_SCL_L;
}
//不产生ACK应答		    
void IIC_NAck(void)
{
	IIC_SCL_L;
	I2C_delay(2);
	SDA_OUT();
	IIC_SDA_H;
	I2C_delay(2);
	IIC_SCL_H;
	I2C_delay(2);
	IIC_SCL_L;
}					 				     
//IIC发送一个字节
//返回从机有无应答
//0，有应答
//1，无应答			  
unsigned char IIC_Send_Byte(uint8_t txd)
{
	unsigned char t; 
	unsigned char res;
	SDA_OUT(); 
	I2C_delay(2);	
  IIC_SCL_L;       //拉低时钟改变数据
  for(t=0;t<8;t++)
  {    
		if((txd&0x80)>>7)
		{
			 IIC_SDA_H; //从最高位开始按位发送
		}
		else
		{
			IIC_SDA_L; //从最高位开始按位发送
		}
   
    txd<<=1; 	  
		I2C_delay(2);   //对TEA5767这三个延时都是必须的
		IIC_SCL_H;     //高电平发送
		I2C_delay(2);   
		IIC_SCL_L;	   
		I2C_delay(2);
  }	 
		res= IIC_Wait_Ack();
		return res;
} 	  


//读1个字节，ack=1时，发送ACK，ack=0，发送nACK   
uint8_t IIC_Read_Byte(uint8_t ack)
{
	unsigned char i,receive=0;
	SDA_IN();   //SDA设置为输入
  for(i=0;i<8;i++ )
	{
    IIC_SCL_L; 
    I2C_delay(2);
		IIC_SCL_H;
    receive<<=1;  
    if(READ_SDA)receive++;   
		I2C_delay(2); 
  }					 
  if (!ack)
    IIC_NAck();//发送nACK
  else
    IIC_Ack(); //发送ACK  
		
  return receive;
}
