
#include "stdio.h"
#include "drv_ads1115.h"
#include "usart.h"
#include  "i2c.h"

ADS1115_InitTypeDefine ADS1115_InitType;




uint16_t ADS1115_RawDataTemp[ADS1115_MAX_CHANNEL][ADS1115_FILTER_MAX] = {0};
uint32_t ADS1115_RawDataSum [ADS1115_MAX_CHANNEL]={0};
uint16_t ADS1115_RawData[ADS1115_MAX_CHANNEL] = {0};




/** * @brief Configuration of ADS1115, single-shot */
void ADS1115_UserConfig1()
{ 

ADS1115_InitType.COMP_LAT = ADS1115_COMP_LAT_0;
ADS1115_InitType.COMP_MODE = ADS1115_COMP_MODE_0;
ADS1115_InitType.COMP_POL = ADS1115_COMP_POL_0;
ADS1115_InitType.DataRate = ADS1115_DataRate_475;
ADS1115_InitType.MODE = ADS1115_MODE_SingleConver;
ADS1115_InitType.MUX = ADS1115_MUX_Channel_0;
ADS1115_InitType.OS = ADS1115_OS_SingleConverStart;
ADS1115_InitType.PGA = ADS1115_PGA_4096;
ADS1115_Config(&ADS1115_InitType);
}
/** * @brief Configuration of ADS1115, continuous conversion */


void ADS1115_UserConfig2()
{ 

ADS1115_InitType.COMP_LAT = ADS1115_COMP_LAT_0;
ADS1115_InitType.COMP_MODE = ADS1115_COMP_MODE_0;
ADS1115_InitType.COMP_POL = ADS1115_COMP_POL_0;
ADS1115_InitType.DataRate = ADS1115_DataRate_860;
ADS1115_InitType.MODE = ADS1115_MODE_ContinuConver;
ADS1115_InitType.MUX = ADS1115_MUX_Channel_0;
ADS1115_InitType.OS = ADS1115_OS_OperationalStatus;
ADS1115_InitType.PGA = ADS1115_PGA_2048;
ADS1115_Config(&ADS1115_InitType);
}

/** * @brief 配置ADS1115 * @param ADS1115_InitStruct: 用来配置ADS1115的结构体变量指针 * @return 配置结果 * @arg: fail * @arg: success */
uint8_t ADS1115_Config(ADS1115_InitTypeDefine *ADS1115_InitStruct)
{ 

uint16_t Config;
uint8_t Writebuff[2];
Config = ADS1115_InitStruct->OS + ADS1115_InitStruct->MUX + ADS1115_InitStruct->PGA + ADS1115_InitStruct->MODE
+ ADS1115_InitStruct->DataRate + ADS1115_InitStruct->COMP_MODE + ADS1115_InitStruct->COMP_POL
+ ADS1115_InitStruct->COMP_LAT + ADS1115_InitStruct->COMP_QUE;
Writebuff[0] = (uint8_t) ((Config >> 8) & 0xFF);
Writebuff[1] = (uint8_t) (Config & 0xFF);
	

uint8_t err=0;	
	
IIC_Start();					//启动总线
err |=IIC_Send_Byte(ADS1115_ADDRESS_W);		//发送器件地址（写）
err |=IIC_Send_Byte(ADS1115_Pointer_ConfigReg );
err |=IIC_Send_Byte(Writebuff[0]);
err |=IIC_Send_Byte(Writebuff[1]);
IIC_Stop();
	
return err;
	
}



void ADS1115_Init(void)
{ 
	
	uint8_t i=0;
			ADS1115_UserConfig2();
	
		for(i=0;i<ADS1115_MAX_CHANNEL;i++)
	{
		ADS1115_RawDataSum[i]=0;
		
	}
		
	
}





/** * @brief 读取ADS1115当前通道下的原始数据 * @param rawData: 传入一个int16_t整型变量的指针，ADS1115的原始数据将保存在这个变量中 * @return 读取结果 * @arg 0: fail * @arg 1: success */
uint8_t ADS1115_ReadRawData(uint16_t *rawData)
{ 

	
uint8_t err=0;
uint8_t Result[2];
IIC_Start(); 
err |=IIC_Send_Byte(ADS1115_ADDRESS_W); //发送读器件地址
err |=IIC_Send_Byte(ADS1115_Pointer_ConverReg); 	//发送寄存器地址
IIC_Start();
err |=IIC_Send_Byte(ADS1115_ADDRESS_R); //发送读器件地址
Result[0] =IIC_Read_Byte(1); 
Result[1] =IIC_Read_Byte(0); 
IIC_Stop();
*rawData =  (((uint16_t)Result[0] << 8) & 0xFF00) | (Result[1] & 0xFF);
	
return err;
	
}


/** * @brief Switch the channel of ADS1115 * @param channel */
void ADS1115_ScanChannel(uint8_t channel)
{ 

switch (channel)
{ 

case 0:
ADS1115_InitType.MUX = ADS1115_MUX_Channel_0;
break;
case 1:
ADS1115_InitType.MUX = ADS1115_MUX_Channel_1;
break;
case 2:
ADS1115_InitType.MUX = ADS1115_MUX_Channel_2;
break;
case 3:
ADS1115_InitType.MUX = ADS1115_MUX_Channel_3;
break;
default:
break;
}
ADS1115_Config(&ADS1115_InitType);
}
/** * @brief 将传感器的原始采样数据转化为电压数据， * 根据ADS1115_InitType结构体中包含的增益信息计算 * @param rawData: 待转换的原始数据 * @retval 返回经过计算的电压值 */

float ADS1115_RawDataToVoltage(uint16_t rawData)
{ 

float voltage;
switch (ADS1115_InitType.PGA)
{ 

case ADS1115_PGA_0256:
voltage = rawData * 0.0078125;
break;
case ADS1115_PGA_0512:
voltage = rawData * 0.015625;
break;
case ADS1115_PGA_1024:
voltage = rawData * 0.03125;
break;
case ADS1115_PGA_2048:
voltage = rawData * 0.0625;
break;
case ADS1115_PGA_4096:
voltage = rawData * 0.135;
break;
case ADS1115_PGA_6144:
voltage = rawData * 0.1875;
break;
default:
voltage = 0;
break;
}
return voltage;
}
/** * @brief 直接获取ADS1115当前通道的电压采样值 * @return 电压采样值 */
float ADS1115_GetVoltage()
{ 

uint16_t rawData;
ADS1115_ReadRawData(&rawData);
return ADS1115_RawDataToVoltage(rawData);
}



void ADS1115_RefreshAllChannel(void)
{ 

static uint8_t channel = 0,filter_index=0;
	
uint16_t adcDataTemp = 0;

	

	
//读取数据返回正确，则将读到的数据写入ADS1115_RawData数组中
if( ADS1115_ReadRawData(&adcDataTemp) ==0 )
{ 


	
	//TCM_Print("CH=%d,value=%d\r\n",channel,adcDataTemp);
	ADS1115_RawDataSum[channel]+=adcDataTemp;
	ADS1115_RawDataSum[channel]-=ADS1115_RawDataTemp[channel][filter_index];
	ADS1115_RawDataTemp[channel][filter_index]=adcDataTemp;
	
	ADS1115_RawData[channel] = ADS1115_RawDataSum[channel]/ADS1115_FILTER_MAX;

//ch change
channel++;
if(channel>=ADS1115_MAX_CHANNEL)
{
		channel=0;
		LED_RUN_FLASH;
		filter_index++;

	if(filter_index>=ADS1115_FILTER_MAX)
	{
		filter_index=0;
			
	}
	
}
}


ADS1115_ScanChannel(channel);
}



void  ADS1115_test(void)
{
	static uint16_t i=0;
	i++;
	i%=4;
	
	//TCM_Print("ch=%d,vol==%.3f\r\n",i,ADS1115_RawDataToVoltage(ADS1115_RawData[i]));
	

}
