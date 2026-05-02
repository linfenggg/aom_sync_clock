#ifndef __STORAGE_H__
#define __STORAGE_H__



#include "stdint.h"


#define MAX_ADDR 512	//24xc04
//-------------------系统初始化参数设定值------------------------//

//包头定义

#define RECORDHEADA 0xaa
#define RECORDHEADB 0x55

//fram 关键参数保存
#define SYS_INIT_PARAM_FRAM_ADDR  0x00    //基地址为0x00





//参数读取
unsigned char load_storage_param(unsigned char *para,unsigned int addr,unsigned  short len);

//参数写入
unsigned char write_storage_param(unsigned char *para,unsigned int addr,unsigned short len);



#endif


