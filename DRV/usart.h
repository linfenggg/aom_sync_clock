#ifndef __USART_H__
#define __USART_H__



/* Includes ------------------------------------------------------------------*/
#include "main.h"

/* USER CODE BEGIN Includes */
#include "stdio.h"
	

/* USER CODE BEGIN Private defines */


/* USER CODE END Private defines */




void MX_USART1_UART_Init(void);

#define UART_BUF_LEN  256

typedef void (*Uart_Send)(uint8_t *,uint16_t);


typedef struct
{
	uint8_t rev_flag; /*接收到的数据*/
	uint16_t rec_len; /*需要处理数据的长度*/
	uint8_t rev_fram[UART_BUF_LEN]; /*接收到的有效数据帧*/
	                      //数据发送函数
	Uart_Send send;
} Uart_Manage_t;


/* USER CODE BEGIN Prototypes */



void uart1_send(uint8_t * data,uint16_t len);

/* USER CODE END Prototypes */



#endif /* __USART_H__ */

