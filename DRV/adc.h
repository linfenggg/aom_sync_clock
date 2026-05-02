/* USER CODE BEGIN Header */
/**
 ******************************************************************************
 * @file    adc.h
 * @brief   This file contains all the function prototypes for
 *          the adc.c file
 ******************************************************************************
 * @attention
 *
 * Copyright (c) 2022 STMicroelectronics.
 * All rights reserved.
 *
 * This software is licensed under terms that can be found in the LICENSE file
 * in the root directory of this software component.
 * If no LICENSE file comes with this software, it is provided AS-IS.
 *
 ******************************************************************************
 */
/* USER CODE END Header */
/* Define to prevent recursive inclusion -------------------------------------*/
#ifndef __ADC_H__
#define __ADC_H__

#ifdef __cplusplus
extern "C"
{
#endif

/* Includes ------------------------------------------------------------------*/
#include "main.h"

// DMA采集通道数
#define ADC_NUM 4
#define ADC_REF 3.30f
#define ADC_RANGE 4096

// 电流比例
#define LD_CUR_FACTOR 2.9f //(24K:1K)  2.9v-->1000ma

// 采样电阻330欧姆,放大比例1:10K
#define TCM_CUR_FACTOR 0.2754f // 1/(0.33x11)

  extern uint32_t adc_dma_value[4];

  void MX_ADC_Init(void);

  void adc_capture(void);
  uint16_t ADC_get_ld_current(void);
  uint16_t ADC_get_ld_vol(void);
  uint16_t ADC_get_tcm_value(void);
  uint16_t ADC_get_tcm_cur(void);
  float ADC_get_board_temp_vol(void);
#ifdef __cplusplus
}
#endif

#endif /* __ADC_H__ */
