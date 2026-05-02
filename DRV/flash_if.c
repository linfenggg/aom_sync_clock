
#include "flash_if.h"
#include "usart.h"
#define FMC_WRITE_START_ADDR    ((uint32_t)0x08018000U)
#define FMC_WRITE_END_ADDR      ((uint32_t)0x08020000U)

uint32_t * ptrd ;


/* calculate the number of page to be programmed/erased */
uint32_t PageNum = (FMC_WRITE_END_ADDR - FMC_WRITE_START_ADDR) / FMC_PAGE_SIZE;
/* calculate the number of page to be programmed/erased */
uint32_t WordNum = ((FMC_WRITE_END_ADDR - FMC_WRITE_START_ADDR) >> 2);

/*!
    \brief      erase fmc pages from FMC_WRITE_START_ADDR to FMC_WRITE_END_ADDR
    \param[in]  none
    \param[out] none
    \retval     none
*/
void fmc_erase_pages(void)
{
    uint32_t EraseCounter;

    /* unlock the flash program/erase controller */
    fmc_unlock();

    /* clear all pending flags */
    fmc_flag_clear(FMC_FLAG_BANK0_END);
    fmc_flag_clear(FMC_FLAG_BANK0_WPERR);
    fmc_flag_clear(FMC_FLAG_BANK0_PGERR);

    /* erase the flash pages */
    for(EraseCounter = 0; EraseCounter < PageNum; EraseCounter++){
        fmc_page_erase(FMC_WRITE_START_ADDR + (FMC_PAGE_SIZE * EraseCounter));
        fmc_flag_clear(FMC_FLAG_BANK0_END);
        fmc_flag_clear(FMC_FLAG_BANK0_WPERR);
        fmc_flag_clear(FMC_FLAG_BANK0_PGERR);
    }

    /* lock the main FMC after the erase operation */
    fmc_lock();
}

/*!
    \brief      program fmc word by word from FMC_WRITE_START_ADDR to FMC_WRITE_END_ADDR
    \param[in]  none
    \param[out] none
    \retval     none
*/
void fmc_program(void)
{

}

/*!
    \brief      check fmc erase result
    \param[in]  none
    \param[out] none
    \retval     none
*/
void fmc_erase_pages_check(void)
{
    uint32_t i;

    uint32_t * ptrd = (uint32_t *)FMC_WRITE_START_ADDR;

    /* check flash whether has been erased */
    for(i = 0; i < WordNum; i++){
        if(0xFFFFFFFF != (*ptrd)){
					TCM_Print("flash_erase_err");
            break;
        }else{
            ptrd++;
				//TCM_Print("flash_erase_ok");
        }
    }
}




uint8_t 	flash_write_timeout(uint8_t *para,uint32_t addr,uint16_t len)
{
		fmc_erase_pages();
    fmc_erase_pages_check();

	    /* unlock the flash program/erase controller */
    fmc_unlock();

     uint32_t address = 0;
		
    /* program flash */
    while(address < len){
			
        fmc_word_program(FMC_WRITE_START_ADDR+address+addr, *((uint32_t*)para));
        address += 4;
				para+=4;
        fmc_flag_clear(FMC_FLAG_BANK0_END);
        fmc_flag_clear(FMC_FLAG_BANK0_WPERR);
        fmc_flag_clear(FMC_FLAG_BANK0_PGERR);
				
    }

    /* lock the main FMC after the program operation */
    fmc_lock();
		
		return 0;
}

uint8_t		flash_read_timeout(uint8_t *para,uint32_t addr,uint16_t len)
{

    uint32_t i;

    ptrd = (uint32_t *)(FMC_WRITE_START_ADDR+addr);

    /* check flash whether has been programmed */
    for(i = 0; i < len/4; i++){

         *(uint32_t*)para=(*ptrd);
            ptrd++;
						para+=4;
        }
    

			return 0;
}


