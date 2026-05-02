//#include "drv_hmc830lp6ge.h"
//#include "string.h"


//// 短延时
//static void delay(void)
//{
//    volatile uint16_t i;
//    for(i=0;i<100;i++)__NOP();
//}

//// SDIO 输出模式
//static void SDIO_OUT(void)
//{
//    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SDIO_PIN);
//}

//// SDIO 输入模式
//static void SDIO_IN(void)
//{
//    gpio_init(HMC830_GPIOB, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, HMC830_SDIO_PIN);
//}

//// GPIO 初始化
//void HMC830_GPIO_Init(void)
//{
//    rcu_periph_clock_enable(HMC830_RCU_GPIOA);
//    rcu_periph_clock_enable(HMC830_RCU_GPIOB);

//    // SCK(PA8)
//    gpio_init(HMC830_GPIOA, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SCK_PIN);
//    // SEN(PB14)
//    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SEN_PIN);

//    SDIO_OUT();
//    SEN_H();
//    SCK_L();
//    delay();
//}

///**
//  * @brief  SPI 传输一个完整的 32 位帧 (符合 HMC830 Open Mode 时序)
//  * @param  data_out: 要发送的 32 位数据 (包含 R/W 位, 地址, 数据)
//  * @param  is_read: 是否为读操作 (true: 读, false: 写)
//  * @retval 接收到的数据 (仅读操作时有效)
//  */
//static uint32_t SPI_Transfer(uint32_t data_out, bool is_read)
//{
//    uint32_t data_in = 0;

//    // 1. 确保在第一个 SCK 上升沿前，SDIO 数据已稳定 (t_setup)
//    //    SDIO 在 SCK 上升沿被采样，
//    //    写操作 data_out bit31=1, 读操作 bit31=0
//    for (int8_t i = 31; i >= 0; i--) {
//        // 在 SCK 下降沿改变数据
//        SCK_L();
//        delay(); // 等待电平稳定

//        // 2. 准备数据 (如果是读操作，忽略 data_out 的数据位)
//        if (!is_read) {
//            if (data_out & (1UL << i))
//                SDIO_H();
//            else
//                SDIO_L();
//        } else {
//            // 读操作时，发送完命令后的数据线需由芯片控制，建议设为输入
//            // 但为简化时序，发送命令期间仍可输出，之后转为输入
//            if (i == 31) {
//                // 第一个 bit 为 R/W 位，我们必须在上升沿前输出高电平来表明是读操作
//                SDIO_H(); // R/W=1 表示读
//            } else if (i >= 25) {
//                // 发送地址 (6 bits)
//                if (data_out & (1UL << i))
//                    SDIO_H();
//                else
//                    SDIO_L();
//            } else {
//                // 读数据阶段，将 SDIO 设为输入，由芯片驱动
//                if (i == 24) SDIO_IN(); // 在数据位开始前切换为输入
//                // 从第 2 个时钟开始读取数据
//                // 数据在 SCK 的下降沿由芯片输出，在下一个 SCK 上升沿被锁存
//                // 我们已在 SCK 低电平时准备好读取
//            }
//        }
//        delay();

//        // 拉高 SCK，从机在此上升沿采样数据 (地址/命令)
//        SCK_H();
//        delay();

//        // 如果处于读数据阶段，读取总线值
//        if (is_read && i < 24) {
//            data_in <<= 1;
//            if (SDIO_READ())
//                data_in |= 1;
//        }
//    }

//    // 3. 一次传输结束，拉低 SCK
//    SCK_L();

//    // 4. 确保在 SEN 拉高前数据已被锁存 (t_hold)
//    delay();

//    // 5. 如果之前切换为输入模式，传输完后切回输出模式以备下次使用
//    if (is_read) {
//        SDIO_OUT();
//    }

//    return data_in;
//}

//// ==================== 【正确】写寄存器 ====================
//void HMC830_WriteReg(uint8_t addr, uint32_t data)
//{
//    // 官方格式：Bit31=1(写) + 4bit地址 + 27bit数据
//    uint32_t frame = (1UL<<31) | ((addr&0x0F)<<27) | (data&0x07FFFFFF);

//#if HMC830_DEBUG
//    printf("[HMC830] Write 0x%02X = 0x%06lX\r\n", addr, data);
//#endif

//    SDIO_OUT();
//    SEN_L();
//    SPI_Transfer(frame, 0);
//    SEN_H();
//    delay();
//}

//// ==================== 【正确】读寄存器 ====================
//uint32_t HMC830_ReadReg(uint8_t addr)
//{
//    uint32_t cmd = (0UL<<31) | ((addr&0x0F)<<27); // 读命令
//    uint32_t rx_data;

//#if HMC830_DEBUG
//    printf("[HMC830] Read 0x%02X...\r\n", addr);
//#endif

//    // 1. 发读命令
//    SDIO_OUT();
//    SEN_L();
//    SPI_Transfer(cmd, 0);
//    SEN_H();
//    delay();

//    // 2. 读回数据
//    SDIO_IN();
//    SEN_L();
//    rx_data = SPI_Transfer(0, 1);
//    SEN_H();
//    delay();

//    return rx_data & 0x07FFFFFF;
//}

//// ==================== 300MHz 官方标准配置 ====================
//void HMC830_SetFreq_300MHz(void)
//{
//    printf("\r\n[HMC830] Set 300MHz...\r\n");

//    HMC830_WriteReg(0x00, 0x000001); // 软复位
//    delay();

//    HMC830_WriteReg(0x02, 0x000001); // R=1
//    HMC830_WriteReg(0x03, 0x000078); // N=120
//    HMC830_WriteReg(0x04, 0x0160000); // 输出 8 分频

//    HMC830_WriteReg(0x05, 0x0800000); // 启动 VCO 校准
//    for(uint16_t i=0;i<1000;i++)delay();

//    HMC830_WriteReg(0x05, 0x001628); // 输出使能
//    HMC830_WriteReg(0x07, 0x00014D);
//    HMC830_WriteReg(0x09, 0x4032AD);

//    printf("[HMC830] 300MHz Config Done\r\n");
//}

//// ==================== 测试读写 ====================
//void HMC830_Test(void)
//{
//    uint32_t val;

//    printf("\r\n=== HMC830 TEST ===\r\n");

//    HMC830_WriteReg(0x02, 0x01);
//    val = HMC830_ReadReg(0x02);
//    printf("R 0x02 = 0x%06lX\r\n", val);

//    HMC830_WriteReg(0x03, 0x78);
//    val = HMC830_ReadReg(0x03);
//    printf("R 0x03 = 0x%06lX\r\n", val);
//}



/**
  ******************************************************************************
  * File Name          : HMC830.c
  * Version            : v1.0
  * Date               : 2020.04.25
  * Description        : This file provides code for the configuration
  *                      of HMC830.
  *
  * Library            : HMC830_LIB
  * Version            : v1.0
  * Dependency         : ---
  * Description        : HMC830 Communication Library.
  *
  *                      COPYRIGHT(c) 2020 yummycarrot
  *                      https://www.github.com/crthu
  *
  ******************************************************************************
  */


#include "drv_hmc830lp6ge.h"
#include "string.h"



// GPIO 初始化
void HMC830_GPIO_Init(void)
{
    rcu_periph_clock_enable(HMC830_RCU_GPIOA);
    rcu_periph_clock_enable(HMC830_RCU_GPIOB);

    // SCK(PA8)
    gpio_init(HMC830_GPIOA, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SCK_PIN);
	
    // SEN(PB14)
    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SEN_PIN);

		    // SDI(PB14)
    gpio_init(HMC830_GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, HMC830_SDI_PIN);
	
	  // SEN(PB14)
    gpio_init(HMC830_GPIOB, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, HMC830_SDO_PIN);
	
		HMC830_SCK(0)  ;
		HMC830_SEN(0)  ;
		HMC830_SDI(0)  ;
}


// Delay
void HMC830_Delay(void)
{
    __nop();
	__nop();
	__nop();
	__nop();
	__nop();
	__nop();
}

// Initial (Mode Select)
void HMC830_Init(uint8_t MODE)
{
    HMC830_SCK(0);
    HMC830_SEN(0);
    HMC830_SDI(0);
    
    delay_1ms(5);
	
    if(MODE == HMC830_OPEN_MODE)
    {
        HMC830_Delay();
        HMC830_SCK(1);
    }
    else
    {
        // Single HMC830 should use HMC mode. AUTO mode maps here.
        HMC830_SEN(1);
        HMC830_Delay();
        HMC830_SCK(1);
    }
    
    HMC830_Delay();
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
        HMC830_SDI((address >> (5 - i)) & 0x01);   // a5-a0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK8-CLK31(Pos):D23-D0(with CLK7 Negedge)
    for(int i=0;i<24;i++)
    {
        HMC830_SCK(0);
        HMC830_SDI((data >> (23 - i)) & 0x01);   // d23-d0
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

// HMC Mode Read
uint32_t HMC830_HMC_Read(uint8_t address)
{
    uint32_t data = 0x00000000;
    
    // Begin
    HMC830_SCK(0);
    HMC830_SDI(0);
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
        HMC830_SDI((address >> (5 - i)) & 0x01);   // a5-a0
        HMC830_Delay();
        HMC830_SCK(1);
        HMC830_Delay();
    }
    
    // CLK8(Pos)(with CLK7 Negedge)
    HMC830_SCK(0);
    for(uint8_t i=0;i<5;i++)
        HMC830_Delay();
    HMC830_SCK(1);
    HMC830_Delay();
    
    // CLK8-CLK31(Neg):D23-D0(with CLK32 Posedge)
    for(int i=0;i<24;i++)
    {
        HMC830_SCK(0);
        HMC830_Delay();
        data |= (HMC830_SDO << (23-i));   // d23-d0
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
