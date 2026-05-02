#ifndef _MODBUS_COMM_H_
#define _MODBUS_COMM_H_

#include "stdint.h"

#include "usart.h"

// 通讯结构体

typedef struct
{
	uint16_t pd1;	 
	uint16_t pd2; 
	uint16_t pd3;
	uint16_t pd4;	 


} sig_board_input_reg; // 输入寄存器


#define MB_SLAVE_ADDR_INDEX 0
#define MB_FUNC_CODE_INDEX 1
#define MB_REG_ADDR_H_INDEX 2
#define MB_REG_ADDR_L_INDEX 3
#define MB_REG_03H_10H_NUM_H_INDEX 4
#define MB_REG_03H_10H_NUM_L_INDEX 5
#define MB_06H_REG_DATA_H 4
#define MB_06H_REG_DATA_L 5
#define MB_10H_BYTE_NUM 6
#define MB_10H_REG_START_ADDR 7 // 10数据码起始地址

#define MB_SLAVE_ADDR_OFFSET 0xA0

#define MB_SLAVE_ADDR (0xc0)

#define FUN_CODE_03H 0x03 // 功能码03H
#define FUN_CODE_04H 0x04 // 功能码04H
#define FUN_CODE_06H 0x06 // 功能码06H
#define FUN_CODE_10H 0x10 // 功能码10H

#define EX_CODE_NONE 0
#define EX_CODE_ADDR_OVER 1

typedef struct
{
	__IO uint8_t SlaveAddr; // 从机地址
	__IO uint8_t byteNums;	// 字节数
	__IO uint8_t RegNums;	// 寄存器数量
	__IO uint8_t Code;		// 功能
	__IO uint16_t RegAddr;	// 操作内存的起始地址
	__IO uint16_t ValueReg; // 10H功能码的数据

} PDUData_TypeDef;

#define MOD_ADDR_INPUT_END sizeof(sig_board_input_reg) / 2
#define MOD_ADDR_HOLDINGD_END 10

extern uint16_t Laser_Mon[MOD_ADDR_INPUT_END];
extern uint16_t Laser_Para[MOD_ADDR_HOLDINGD_END];

extern PDUData_TypeDef PduData;

uint8_t MB_RSP(Uart_Manage_t *uart_rev);

uint16_t MB_CRC16(uint8_t *pushMsg, uint8_t usDataLen);

extern Uart_Manage_t uart1_rev;

extern sig_board_input_reg sig_mon;

void rs485_task(void);

#endif
