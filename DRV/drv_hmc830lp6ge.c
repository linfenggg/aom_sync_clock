


#include "drv_hmc830lp6ge.h"
#include "string.h"
#include "stdio.h"


uint32_t VCO_Reg02;
uint32_t N_int = 0;
uint32_t N_frac = 0;

// GPIO 初始化
void HMC830_GPIO_Init(void)
{
    rcu_periph_clock_enable(HMC830_RCU_GPIOA);
    rcu_periph_clock_enable(HMC830_RCU_GPIOB);

    // SCK(PA8)
    gpio_init(HMC830_GPIOA, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SCK_PIN);
	
    // SEN(PB15)
    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SEN_PIN);

		    // SDI(PB14)
    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SDI_PIN);
	
	  // SEN(PB1)
    gpio_init(HMC830_GPIOB, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, HMC830_SDO_PIN);
	
		HMC830_SCK(0);
		HMC830_SEN(0);
		HMC830_SDI(0);
}


// Delay
void HMC830_Delay(void)
{
  uint16_t delay=50;
	for(;delay>0;delay--)
	{
		__NOP();
	}
}

// Initial (Mode Select)
void HMC830_Init(void)
{

    
    delay_1ms(100);
	
	
    HMC830_SEN(1);
	  delay_1ms(10);
		HMC830_SCK(1);
  	delay_1ms(10);
	  HMC830_SEN(0);
	  delay_1ms(10);
		HMC830_SCK(0);

    
		 delay_1ms(100);

}




// HMC Mode Write
void HMC830_HMC_Write(uint8_t address,uint32_t data)
{
    // Begin
    HMC830_SCK(0);
    HMC830_SDI(0);
    HMC830_SEN(0);
    HMC830_Delay();
    
    HMC830_SEN(1);
    // CLK1(Pos):/WR
    HMC830_SDI(0);  // /WR
    HMC830_Delay();
    HMC830_SCK(1);  // CLK1 Posedge
    HMC830_Delay();
    
    // CLK2-CLK7(Pos):A5-A0(with CLK1 Negedge)
    for(int i=0;i<6;i++)
    {
        HMC830_SCK(0);
        HMC830_SDI(address & (1<<(5-i)));   // a5-a0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK8-CLK31(Pos):D23-D0(with CLK7 Negedge)
    for(int i=0;i<24;i++)
    {
        HMC830_SCK(0);
        HMC830_SDI(data & (1<<(23-i)));   // d23-d0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK32(Pos)(with CLK31 Negedge)
    HMC830_SCK(0);
    for(uint8_t i=0;i<5;i++)
        HMC830_Delay();
    HMC830_SCK(1);
    HMC830_Delay();
    HMC830_SCK(0);
    HMC830_Delay();
    
    HMC830_SEN(0);
    HMC830_Delay();
}



void WriteToHMC830(uint8_t Reg_temp,uint32_t Data_temp)//送入地址a5 a4 a3 a2 a1 a0 ，以及24位数据
{
	uint8_t i;
	uint8_t Reg_Add;//地址
	uint32_t Reg_Data;//写入的数据:32位
	
	Reg_Add  = Reg_temp;
	Reg_Data = Data_temp;
	
	Reg_Add=Reg_Add&0xDF;//插入一位/WR=0  后面是a5 a4 a3 a2 a1 a0  
 HMC830_SEN(0);
 HMC830_Delay();
 HMC830_SEN(1);
 HMC830_Delay();
 HMC830_SCK(0);
 HMC830_Delay();
	
	for (i = 0; i < 7; i++)		//送入地址第一位固定是RD=1，后面6位是地址，一共7位
	{
	 HMC830_SCK(0);
   HMC830_Delay();
		if((Reg_Add&0x40) == 0x40)//判断时((Reg_Add&0x40)==0x40)正确  (Reg_Add&0x40==0x40)  错误
		{
		 HMC830_SDI(1);
		}
		else 
		{
		HMC830_SDI(0);
		}
		Reg_Add = Reg_Add<<1;
	 HMC830_Delay();
	 HMC830_SCK(1);
	 HMC830_Delay();		
	}
		
	 HMC830_SCK(0);
	 HMC830_Delay();
	for (i = 0; i < 24; i++)		//读取数据
	{
		 HMC830_SCK(0);
	 HMC830_Delay();
		if((Reg_Data&0x00800000) == 0x00800000)
		{
			 HMC830_SDI(1);
		}
		else 
		{
		 HMC830_SDI(0);
		}
		Reg_Data = Reg_Data<<1;
		 HMC830_Delay();
		 HMC830_SCK(1);	
		 HMC830_Delay();	
	}
	
	HMC830_SCK(0);//最后要多给一个时钟信号（一个读数据总共是7+24+1=32个时钟）
	 HMC830_Delay();
	HMC830_SCK(1);
 HMC830_Delay();
HMC830_SCK(0);
	 HMC830_Delay();
 HMC830_SEN(0);
	 HMC830_Delay();
 
}

// HMC Mode Read
uint32_t HMC830_HMC_Read(uint8_t address)
{
    uint32_t data = 0x00000000;
    
    // Begin
    HMC830_SCK(0);
    HMC830_SDI(1);
    HMC830_SEN(0);
    HMC830_Delay();
    
    HMC830_SEN(1);
    // CLK1(Pos):RD
    HMC830_SDI(1);
    HMC830_Delay();
    HMC830_SCK(1);  // CLK1 Posedge
    HMC830_Delay();
    
    // CLK2-CLK7(Pos):A5-A0(with CLK1 Negedge)
    for(int i=0;i<6;i++)
    {
        HMC830_SCK(0);
        HMC830_SDI(address & (1<<(5-i)));   // a5-a0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK8(Pos)(with CLK7 Negedge)
    HMC830_SCK(0);
  //  for(uint8_t i=0;i<5;i++)
     HMC830_Delay();
    HMC830_SCK(1);
    HMC830_Delay();
    
    // CLK8-CLK31(Neg):D23-D0(with CLK32 Posedge)
    for(int i=0;i<24;i++)
    {
        HMC830_SCK(0);
        data |= (HMC830_SDO << (23-i));   // d23-d0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK32(Neg)
    HMC830_SCK(0);
    HMC830_Delay();
    
    HMC830_SEN(0);
    HMC830_Delay();
    
    return data;
}

// HMC Mode VCO SubSystem Write
void HMC830_HMC_VCO_Write(uint8_t vco_address,uint32_t vco_data)
{
    uint32_t data = 0x000000;
    data |= HMC830_REG05H_VCO_SUBSYSTEM_ID_MASK & (HMC830_REG05H_VCO_SUBSYSTEM_ID_WB << HMC830_REG05H_VCO_SUBSYSTEM_ID_OFFSET);
    data |= HMC830_REG05H_VCO_SUBSYSTEM_REG_ADDRESS_MASK & (vco_address << HMC830_REG05H_VCO_SUBSYSTEM_REG_ADDRESS_OFFSET);
    data |= HMC830_REG05H_VCO_SUBSYSTEM_DATA_MASK & (vco_data << HMC830_REG05H_VCO_SUBSYSTEM_DATA_OFFSET);
    
    HMC830_HMC_Write(HMC830_REG05H_VCO_SPI, data);
}

void HMC830_HMC_Write_REFDIV(uint16_t refdiv)
{
    uint32_t data = 0x000000;
    
    if(refdiv > HMC830_REG02H_RDIV_MAX)
        refdiv = HMC830_REG02H_RDIV_MAX;
    if(refdiv < HMC830_REG02H_RDIV_MIN)
        refdiv = HMC830_REG02H_RDIV_MIN;
    
    data = HMC830_REG02H_RDIV_MASK & (refdiv << HMC830_REG02H_RDIV_OFFSET);
    
    HMC830_HMC_Write(HMC830_REG02H_REFDIV, data);
}

void HMC830_HMC_Write_NDIV(double ndiv)
{   
    uint32_t data_intg = 0x000000;
    uint32_t data_frac = 0x000000;
    
    uint32_t ndiv_integer = (uint32_t)ndiv;
    uint32_t ndiv_fractional = (uint32_t)((double)(ndiv - (double)ndiv_integer) * 16777216 + 0.5);    // N * 2^-24
    
    if(ndiv == (double)ndiv_integer)
    {
        // integer
        if(ndiv_integer > HMC830_REG03H_INTG_INTEGER_MAX)
            ndiv_integer = HMC830_REG03H_INTG_INTEGER_MAX;
        if(ndiv_integer < HMC830_REG03H_INTG_INTEGER_MIN)
            ndiv_integer = HMC830_REG03H_INTG_INTEGER_MIN;
    }
    else
    {
        // fractional
        if(ndiv_integer > HMC830_REG03H_INTG_FACTIONAL_MAX)
            ndiv_integer = HMC830_REG03H_INTG_FACTIONAL_MAX;
        if(ndiv_integer < HMC830_REG03H_INTG_FACTIONAL_MIN)
            ndiv_integer = HMC830_REG03H_INTG_FACTIONAL_MIN;
        
        if(ndiv_fractional > HMC830_REG04H_FRAC_MAX)
            ndiv_fractional = HMC830_REG04H_FRAC_MAX;
        if(ndiv_fractional < HMC830_REG04H_FRAC_MIN)
            ndiv_fractional = HMC830_REG04H_FRAC_MIN;
    }
    
    data_intg = HMC830_REG03H_INTG_MASK & (ndiv_integer << HMC830_REG03H_INTG_OFFSET);
    data_frac = HMC830_REG04H_FRAC_MASK & (ndiv_fractional << HMC830_REG04H_FRAC_OFFSET);
    
    HMC830_HMC_Write(HMC830_REG03H_INTEGER_PART, data_intg);
    HMC830_HMC_Write(HMC830_REG04H_FRACTIONAL_PART, data_frac);
}

void HMC830_HMC_Write_VCO_General_Setting(uint8_t kdiv, uint8_t GAIN)
{
    uint32_t data = 0x000;
    
    if(kdiv > HMC830_VCO_REG02H_KDIV_MAX)
        kdiv = HMC830_VCO_REG02H_KDIV_MAX;
    if(kdiv < HMC830_VCO_REG02H_KDIV_MIN)
        kdiv = HMC830_VCO_REG02H_KDIV_MIN;
    
    if((kdiv != 1) && (kdiv % 2))
        kdiv--;
    
    if(GAIN > HMC830_VCO_REG02H_GAIN_3)
        GAIN = HMC830_VCO_REG02H_GAIN_3;
    if(GAIN < HMC830_VCO_REG02H_GAIN_0)
        GAIN = HMC830_VCO_REG02H_GAIN_0;
    
    data |= HMC830_VCO_REG02H_RF_DIVIDE_RATIO_MASK & (kdiv << HMC830_VCO_REG02H_RF_DIVIDE_RATIO_OFFSET);
    data |= HMC830_VCO_REG02H_RF_OUTPUT_BUF_GAIN_CTL_MASK & (GAIN << HMC830_VCO_REG02H_RF_OUTPUT_BUF_GAIN_CTL_OFFSET);
    data |= HMC830_VCO_REG02H_DIV_OUTPUT_STAGE_GAIN_CTL_MASK & ((kdiv < 4 ? 1 : 0) << HMC830_VCO_REG02H_DIV_OUTPUT_STAGE_GAIN_CTL_OFFSET);
    
    // Write Recommand Value
    HMC830_HMC_Write(HMC830_REG05H_VCO_SPI, HMC830_VCO_REG05H_RECOMMAND);
    HMC830_HMC_Write(HMC830_REG05H_VCO_SPI, HMC830_VCO_REG04H_RECOMMAND);
    
    // VCO_REG02H
    HMC830_HMC_VCO_Write(HMC830_VCO_REG02H_BIASES, data);
    
    // VCO AutoCal
    HMC830_HMC_Write(HMC830_REG05H_VCO_SPI, 0x0);
}
void HMC830_HMC_Write_PFD_General_Setting(uint8_t PFD_MODE)
{
    // fPFD = 50MHz
    if(PFD_MODE == HMC830_INTEGER_MODE)
    {
        HMC830_HMC_Write(HMC830_REG06H_SD_CFG, 0x2003CA);
        HMC830_HMC_Write(HMC830_REG07H_LOCK_DETECT, 0xCCD);
        HMC830_HMC_Write(HMC830_REG0AH_VCO_AUTOCAL_CFG, 0x2046);
        HMC830_HMC_Write(HMC830_REG0BH_PD, 0x7C061);
        HMC830_HMC_Write(HMC830_REG0FH_GPO_SPI_RDIV, 0x81);
    }
    if(PFD_MODE == HMC830_FRACTIONAL_MODE)
    {
        HMC830_HMC_Write(HMC830_REG06H_SD_CFG, 0x200B4A);
        HMC830_HMC_Write(HMC830_REG07H_LOCK_DETECT, 0xCCD);
        HMC830_HMC_Write(HMC830_REG0AH_VCO_AUTOCAL_CFG, 0x2046);
        HMC830_HMC_Write(HMC830_REG0BH_PD, 0x7C021);
        HMC830_HMC_Write(HMC830_REG0FH_GPO_SPI_RDIV, 0x81);
    }
}

void HMC830_HMC_Write_Charge_Pump_Current(float Icp, uint8_t PFD_MODE, uint16_t fVCO, uint16_t fPFD)
{
    uint32_t data = 0x000000;
    
    float Icp_offset = (2.5 + 4.0 * (1000.0/(float)fVCO)) * (float)fPFD * Icp;  // uA
    
    if(Icp > HMC830_REG09H_CP_GAIN_MAX)
        Icp = HMC830_REG09H_CP_GAIN_MAX;
    if(Icp < HMC830_REG09H_CP_GAIN_MIN)
        Icp = HMC830_REG09H_CP_GAIN_MIN;
    
    if(Icp_offset > HMC830_REG09H_OFFSET_MAGNITUDE_MAX)
        Icp_offset = HMC830_REG09H_OFFSET_MAGNITUDE_MAX;
    if(Icp_offset < HMC830_REG09H_OFFSET_MAGNITUDE_MIN)
        Icp_offset = HMC830_REG09H_OFFSET_MAGNITUDE_MIN;
    
    data |= HMC830_REG09H_CP_DN_GAIN_MASK & ((uint8_t)(Icp * 1000.0 / 20.0 + 0.5) << HMC830_REG09H_CP_DN_GAIN_OFFSET);
    data |= HMC830_REG09H_CP_UP_GAIN_MASK & ((uint8_t)(Icp * 1000.0 / 20.0 + 0.5) << HMC830_REG09H_CP_UP_GAIN_OFFSET);
    data |= HMC830_REG09H_OFFSET_MAGNITUDE_MASK & ((uint8_t)(Icp_offset / 5.0 + 0.5) << HMC830_REG09H_OFFSET_MAGNITUDE_OFFSET);
    data |= HMC830_REG09H_OFFSET_UP_ENABLE_MASK & (0 << HMC830_REG09H_OFFSET_UP_ENABLE_OFFSET);
    data |= HMC830_REG09H_OFFSET_DN_ENABLE_MASK & ((PFD_MODE == HMC830_FRACTIONAL_MODE ? 1 : 0) << HMC830_REG09H_OFFSET_DN_ENABLE_OFFSET);
    data |= HMC830_REG09H_HIKCP_MASK & (0 << HMC830_REG09H_HIKCP_OFFSET);
    
    HMC830_HMC_Write(HMC830_REG09H_CHARGE_PUMP, data);
}

void HMC830_HMC_Write_Output_Mode(uint8_t OUTPUT_MODE)
{
    uint32_t data = HMC830_VCO_REG03H_CONFIG_DEFAULT;
    
    data = (data & ~HMC830_VCO_REG03H_RF_BUFFER_SE_ENABLE_MASK)
           |(HMC830_VCO_REG03H_RF_BUFFER_SE_ENABLE_MASK & (OUTPUT_MODE << HMC830_VCO_REG03H_RF_BUFFER_SE_ENABLE_OFFSET));
    
    HMC830_HMC_VCO_Write(HMC830_VCO_REG03H_CONFIG, data);
    
    // VCO AutoCal
    HMC830_HMC_Write(HMC830_REG0AH_VCO_AUTOCAL_CFG, 0x3046);
    HMC830_HMC_Write(HMC830_REG05H_VCO_SPI, 0x0);
    HMC830_HMC_Write(HMC830_REG0AH_VCO_AUTOCAL_CFG, 0x2046);
}

uint32_t HMC830_HMC_Read_Chip_ID(void)
{
    return (HMC830_REG00H_CHIP_ID_MASK & HMC830_HMC_Read(HMC830_REG00H_ID)) >> HMC830_REG00H_CHIP_ID_OFFSET;
}

uint8_t HMC830_HMC_Read_Lock_Detect(void)
{
    uint32_t data = HMC830_HMC_Read(HMC830_REG12H_GPO2);
    return (HMC830_REG12H_LOCK_DETECT_MASK & data) >> HMC830_REG12H_LOCK_DETECT_OFFSET;
}

uint16_t HMC830_HMC_Read_REFDIV(void)
{
    return (HMC830_REG02H_RDIV_MASK & HMC830_HMC_Read(HMC830_REG02H_REFDIV)) >> HMC830_REG02H_RDIV_OFFSET;
}

double HMC830_HMC_Read_NDIV(void)
{
    uint32_t data_intg = (HMC830_REG03H_INTG_MASK & HMC830_HMC_Read(HMC830_REG03H_INTEGER_PART)) >> HMC830_REG03H_INTG_OFFSET;
    uint32_t data_frac = (HMC830_REG04H_FRAC_MASK & HMC830_HMC_Read(HMC830_REG04H_FRACTIONAL_PART)) >> HMC830_REG04H_FRAC_OFFSET;
    return (double)data_intg + (double)data_frac / 16777216.0;
}

void HMC830_HMC_Write_Freq(double fREF, uint16_t REFDIV, double fOUT, float Icp)
{
    // fREF = fREF
    // fOUT = fOUT
    // fPFD = fREF / REFDIV
    // fVCO = fREF / REFDIV * NDIV
    // fOUT = fVCO / KDIV
    
    uint8_t KDIV = 0;
    double fVCO = 0;
    double NDIV = 0;
    uint8_t PFD_MODE = 0;
    
    // kdiv = fVCO / fOUT (Estimate)
    uint16_t fvco_div_fout = 0;
    if(fOUT >= 1500 && fOUT <= 3000)
        fvco_div_fout = 1;
    else    // kdiv = fVCO(max) / fOUT
        fvco_div_fout = ((uint16_t)(3000.0 / fOUT) % 2) ? (uint16_t)(3000.0 / fOUT) - 1 : (uint16_t)(3000.0 / fOUT);
    
    KDIV = (fvco_div_fout > 62) ? 62 : fvco_div_fout;
    fVCO = fOUT * (double)KDIV;
    NDIV = fVCO / fREF * (double)REFDIV;
    
    uint32_t ndiv_integer = (uint32_t)NDIV;
    if(NDIV == (double)ndiv_integer)
        PFD_MODE = HMC830_INTEGER_MODE;
    else
        PFD_MODE = HMC830_FRACTIONAL_MODE;
    
    HMC830_HMC_Write_REFDIV(REFDIV);
    HMC830_HMC_Write_PFD_General_Setting(PFD_MODE);
    HMC830_HMC_Write_Charge_Pump_Current(Icp, PFD_MODE, fVCO, fREF / (double)REFDIV);
    HMC830_HMC_Write_VCO_General_Setting(KDIV, HMC830_VCO_REG02H_GAIN_3);
    HMC830_HMC_Write_NDIV(NDIV);
}

void HMC830_HMC_Test_Dump_Register(uint32_t * dump_memory)
{
    for(uint8_t reg = 0x00; reg <= 0x13; reg++)
       dump_memory[reg] = (reg << 24) | (HMC830_HMC_Read(reg) << 0);
}

void HMC830_HMC_Test_REF50M_35M(void)
{
    HMC830_HMC_Write_REFDIV(1);
    HMC830_HMC_Write_PFD_General_Setting(HMC830_FRACTIONAL_MODE);
    HMC830_HMC_Write_Charge_Pump_Current(2.54, HMC830_FRACTIONAL_MODE, 2170, 50);
    HMC830_HMC_Write_VCO_General_Setting(62, HMC830_VCO_REG02H_GAIN_3);
    HMC830_HMC_Write_NDIV(43.4);
}

void HMC830_HMC_Test_REF50M_100M(void)
{
    HMC830_HMC_Write_REFDIV(1);
    HMC830_HMC_Write_PFD_General_Setting(HMC830_INTEGER_MODE);
    HMC830_HMC_Write_Charge_Pump_Current(2.54, HMC830_INTEGER_MODE, 3000, 50);
    HMC830_HMC_Write_VCO_General_Setting(30, HMC830_VCO_REG02H_GAIN_3);
    HMC830_HMC_Write_NDIV(60.0);
}

void HMC830_HMC_Test_REF50M_425M(void)
{
    HMC830_HMC_Write_REFDIV(1);
    HMC830_HMC_Write_PFD_General_Setting(HMC830_INTEGER_MODE);
    HMC830_HMC_Write_Charge_Pump_Current(2.54, HMC830_INTEGER_MODE, 2550, 50);
    HMC830_HMC_Write_VCO_General_Setting(6, HMC830_VCO_REG02H_GAIN_3);
    HMC830_HMC_Write_NDIV(51.0);
}

void HMC830_HMC_Test_REF50M_650M(void)
{
    HMC830_HMC_Write_REFDIV(1);
    HMC830_HMC_Write_PFD_General_Setting(HMC830_INTEGER_MODE);
    HMC830_HMC_Write_Charge_Pump_Current(2.54, HMC830_INTEGER_MODE, 2600, 50);
    HMC830_HMC_Write_VCO_General_Setting(4, HMC830_VCO_REG02H_GAIN_3);
    HMC830_HMC_Write_NDIV(52.0);
}

void HMC830_HMC_Test_READ(void)
{
//	  for(uint8_t reg = 0x00; reg <= 0x13; reg++)
//	{
//     HMC830_HMC_Write(reg,0x01);
//		printf("addr=%d,val=%d\r\n",reg, HMC830_HMC_Read(reg));
//		
//	}
	

//	 HMC830_HMC_Write(0x01,0x03);
	delay_1ms(10);
//	 HMC830_HMC_Write(0x01,0x20);
		delay_1ms(10);
	
		  for(uint8_t reg = 0x00; reg <= 0x13; reg++)
	{
 
		printf("addr=%d,val=%x\r\n",reg, HMC830_HMC_Read(reg));
		
	}
	
	HMC830_HMC_Write(0x01, 0x03);
delay_1ms(5);

// 2. 参考分频 R=1
HMC830_HMC_Write(0x02, 0x000001);

// 3. 整数模式 N=100
HMC830_HMC_Write(0x05, 0x000064);   // 整数N=100
HMC830_HMC_Write(0x06, 0x000000);   // 小数=0

// 4. 输出分频 K=10
HMC830_HMC_Write(0x0A, 0x00000A);

// 5. 开启VCO + 输出
HMC830_HMC_Write(0x04, 0x0001DF);
HMC830_HMC_Write(0x03, 0x000433);

		  for(uint8_t reg = 0x00; reg <= 0x13; reg++)
	{
 
		printf("addr=%d,val=%x\r\n",reg, HMC830_HMC_Read(reg));
		
	}

}



/*
*********************************************************************************************************
*	函 数 名: Calc_K
*	功能说明: 计算k值，即RF Divide ratio（VCO_Reg 02h）
*	形    参: Fout 
*	返 回 值: vco_fre，返回VCO的工作频率
*	作	  者: 
*	时	  间:
*	备    注: 计算需要的输出分频系数，并将其倍频（范围1~62），从而实现任意点频输出。
*********************************************************************************************************
*/
uint32_t Calc_K(uint32_t Fout)
{
	uint32_t vco_fre;
	
	uint32_t rfdivid = 1;	
	uint8_t noise_con = 0;	//见VCO_Reg 02h[8]位
	
	if(Fout > 3000000)
		Fout = 3000000;
	if(Fout < 25000)
		Fout = 25000;
	if(Fout > 1500000) 
	{
		rfdivid = 1;
	}
	
	rfdivid = 3000000/Fout;
	if(rfdivid < 2)
	{
		rfdivid = 1;
		noise_con = 1;
	}
	else if(rfdivid < 3)
	{
		rfdivid = 2;
		noise_con = 1;
	}
	else if(rfdivid > 62)
	{
		rfdivid = 62;
	}
	else
	{
		rfdivid = ((rfdivid%2)==0)?(rfdivid):(rfdivid-1);
	}
	if(rfdivid < 3)
	{
		noise_con = 1;
	}
	else
	{
		noise_con = 0;
	}
	                                                 
	VCO_Reg02 |= 0x000010;		//VCO_Reg02[2:0]=000,VCO_Reg02[6:3]=010,VCO_Reg02[15:7]=0,0000,0000
	                          //VCO_Reg02[15]分频控制，分频器为1和2分频时，该位设置成1，其他分频设置成0
	                          //VCO_Reg02[14：13] 输出增益控制分辨是最大，最大-3DBM，最大-6DBM，最大-9DBM
	                          //VCO_Reg02[12：17]  分频器值，最大62分频
	if(noise_con) VCO_Reg02 |= (1<<15);//根据noise_con值设置VCO_Reg02[15]位
	else VCO_Reg02 &= ~(1<<15);
	VCO_Reg02 |= (rfdivid<<7);	//这里求出了VCO_Reg 02h值
	vco_fre = Fout*rfdivid;		//这里求出了VCO的工作频率
	
	return vco_fre;
}

/*
*********************************************************************************************************
*	函 数 名: Calc_N
*	功能说明: 计算N值，包括整数部分和小数部分
*	形    参: Fout 
*	返 回 值:
*	作	  者: 
*	时	  间:
*	备    注: 计算需要的倍频分频系数。
*********************************************************************************************************
*/
void Calc_N(uint32_t  vco_fre)
{	
	uint32_t Fpd = 20000;	//鉴相频率50M,参考频率50M
	double   F_frac = 0;
	
	N_int = (vco_fre)/Fpd;//得到reg03h值

	F_frac = vco_fre;
	F_frac = F_frac/Fpd;
	F_frac = (F_frac-N_int)*16777216;
	N_frac = (uint32_t)F_frac;
}

/*
*********************************************************************************************************
*	函 数 名: Change_HMC830_Fre
*	功能说明: 设置输出频率
*	形    参: Fout，输出频率值，单位：MHz 
*	返 回 值: 无
*	作	  者: 
*	时	  间:
*	备    注: 计算需要的输出分频系数，并将其倍频（范围1~62），从而实现任意点频输出。
*********************************************************************************************************
*/
void Change_HMC830_Fre(uint32_t Fout,uint8_t PowerTemp)
{	
	uint32_t vco_fre;
	
	VCO_Reg02=0; 
	vco_fre= Calc_K(Fout);
	Calc_N(vco_fre);
	VCO_Reg02 |= (PowerTemp<<13);	//这里求出了VCO_Reg 02h的幅度控制值
	HMC830_HMC_Write(0x05,VCO_Reg02);
	HMC830_HMC_Write(0x05,0);//用于打开VCO子系统中所有VCO的可用频段。只要REG05H做任何修改，这个指令必须增加在reg05命令后
	HMC830_HMC_Write(0x03,N_int);//整数分频
	HMC830_HMC_Write(0x04,N_frac);//小数分频	
}
