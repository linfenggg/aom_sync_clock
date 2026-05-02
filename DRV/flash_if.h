
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __FLASH_IF_H
#define __FLASH_IF_H

/* Includes ------------------------------------------------------------------*/
#include "gd32f10x.h"

/* Exported types ------------------------------------------------------------*/
/* Exported constants --------------------------------------------------------*/
/* Exported macro ------------------------------------------------------------*/
  #define USER_FLASH_END_ADDRESS        0x0801FFFF /* 128 KBytes */
#define FMC_PAGE_SIZE           ((uint16_t)0x800U)      /* 2 Kbytes */

/* define the address from where user application will be loaded,
   the application address should be a start sector address */
#define APPLICATION_ADDRESS     (uint32_t)0x08003000





uint8_t 	flash_write_timeout(uint8_t *para,uint32_t addr,uint16_t len);

uint8_t		flash_read_timeout(uint8_t *para,uint32_t addr,uint16_t len);

#endif  /* __FLASH_IF_H */

/*******************(C)COPYRIGHT 2011 STMicroelectronics *****END OF FILE******/
