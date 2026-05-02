#include "ads7883.h"
#include "gd32f30x.h"
#include "usart.h"


void ads7883_init(void)
{
	
			
		spi_parameter_struct spi_init_struct;
	  rcu_periph_clock_enable(RCU_SPI0);
    rcu_periph_clock_enable(RCU_GPIOB);
	  rcu_periph_clock_enable(RCU_AF);
		
	//禁用jtag和开启spi0
		gpio_pin_remap_config(GPIO_SWJ_SWDPENABLE_REMAP, ENABLE);
		gpio_pin_remap_config(GPIO_SPI0_REMAP,ENABLE);
	
    /* SPI0_SCK(PB), SPI0_MISO(PB4) and SPI0_MOSI(PB5) GPIO pin configuration */
    gpio_init(GPIOB, GPIO_MODE_AF_PP, GPIO_OSPEED_50MHZ, GPIO_PIN_3 );
    gpio_init(GPIOB, GPIO_MODE_IN_FLOATING, GPIO_OSPEED_50MHZ, GPIO_PIN_4);
	
    /* SPI0_CS(PB1) GPIO pin configuration */
    gpio_init(GPIOB, GPIO_MODE_OUT_PP, GPIO_OSPEED_50MHZ, GPIO_PIN_6);
	
 

    /* SPI0 parameter config */
    spi_init_struct.trans_mode           = SPI_TRANSMODE_FULLDUPLEX;
    spi_init_struct.device_mode          = SPI_MASTER;
    spi_init_struct.frame_size           = SPI_FRAMESIZE_16BIT;
	

    spi_init_struct.clock_polarity_phase = SPI_CK_PL_HIGH_PH_1EDGE;

		spi_init_struct.nss                  = SPI_NSS_SOFT;
    spi_init_struct.prescale             = SPI_PSC_256;
    spi_init_struct.endian               = SPI_ENDIAN_MSB;
    spi_init(SPI0, &spi_init_struct);

    /* enable SPI0 */
    spi_enable(SPI0);
		 /* chip select invalid*/
		ADS_SELECT(1);
		
	
}






//获取采集值

uint16_t ads7883_capture(void)
{
			uint16_t rev=0;
		//片选
		ADS_SELECT(0);
	__NOP();
	__NOP();
	__NOP();
	ADS_SELECT(1);
    /* loop while data register in not emplty */
    while (RESET == spi_i2s_flag_get(SPI0,SPI_FLAG_TBE));

    /* send byte through the SPI0 peripheral */
    spi_i2s_data_transmit(SPI0,0);
		
		while(RESET==spi_i2s_flag_get(SPI0,SPI_FLAG_RBNE));
		 rev=spi_i2s_data_receive(SPI0);
	
		return	rev>>2;
		
}








