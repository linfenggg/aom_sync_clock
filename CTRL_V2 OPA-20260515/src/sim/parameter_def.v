parameter


	ID_FPGA_VER_0				= 96,	//FPGA版本号0(只读)
	ID_FPGA_VER_1				= 97,	//FPGA版本号1(只读)
	ID_FPGA_VER_2				= 98,	//FPGA版本号2(只读)
	ID_FPGA_VER_3				= 99,	//FPGA版本号3(只读)
	ID_FPGA_VER_4				= 100,	//FPGA版本号4(只读)

	ID_AD_START					= 101,	//ADC芯片开始配置,只能写1
	ID_WORK_MODE				= 102,	//工作模式(MCU设定)
	ID_CHECK					= 110,	//校验寄存器，固定值0x5AA5，23205	
	ID_INT_ENABLE				= 105,	//内控声光使能，内控gate
	ID_DAC_MAX					= 109,	//APM DAC最大值	
	ID_AOM_MAX					= 111,	//AOM DAC最大值	
	ID_ONLINE_PRG1				= 113,	//FPGA1在线升级标志,1升级0正常工作
	ID_ONLINE_PRG2				= 114,	//FPGA2在线升级标志,1升级0正常工作
	
	ID_PD1_freq					= 216,	//PD1测量频率,单位kHz（只读）
	ID_PD2_freq					= 217,	//PD2测量频率,单位kHz（只读）
	ID_PD3_freq					= 218,	//PD3测量频率,单位kHz（只读）
	ID_WATER_FREQ 				= 219,	//水流量测频，测出的是周期，(x+1)*20ns
	
	ID_alarm_en					= 220,	//告警使能，1开启0关闭，32bit
	ID_clear					= 221,	//清除所有告警，1清除
	ID_alarm_now				= 222,	//当前告警，32bit, [0]-断纤，[1]-interlock1,[2]-interlock2,[3]-24V,[4]-烧纤1,[5]-烧纤2,[6]-测频1低,[7]-测频2低,[8]-测频3低,
										//				  [9]-空,  [10]-测频1高,[11]-测频2高,[12]-测频3高,[13]-MCU急停,[14]-MCU_ERR
	ID_alarm_lat				= 223,	//历史告警，
	ID_alarm_out				= 240,	//总告警，高级加低级，暂时不用，读历史告警寄存器
	ID_fiber_break_delay		= 224,	//断纤告警延时，u32
	
	ID_FREQ1_THR_H				= 225,	//频率1告警高阈值u16，单位kHz
	ID_FREQ1_THR_L				= 226,  //频率1告警低阈值u8，周期大于(x+1)*6.25ns时告警
	ID_FREQ2_THR_H				= 227,	//频率2告警高阈值u16，单位kHz
	ID_FREQ2_THR_L				= 228,  //频率2告警低阈值u8，周期大于(x+1)*6.25ns时告警
	ID_FREQ3_THR_H				= 229,	//频率3告警高阈值u16，单位kHz
	ID_FREQ3_THR_L				= 230,  //频率3告告警低阈值u8，周期大于(x+1)*6.25ns时告警
	
	ID_FREQ_ALARM_DLY			= 307,	//测频告警延时，等于X乘以20ns，X为输入的参数
	ID_EXTER_IO					= 308,	//外部IO状态:BIT[0]-GATE,BIT[1]-PWM,BIT[2]-TRIG,BIT[3]-PRR,BIT[4]-LATCH,BIT[5]-EXT_TEST,BIT[6]-EXT_SYNC,BIT[7]-EXT_STATE,
										//BIT[8]-水流量IO,BIT[9]-RESERVE1,BIT[10]-RESERVE2
	ID_EXTER_8BIT				= 309,	//8bit数据
	//ID_AOM2_DLY					= 310,	//2级声光延时的地址在421
	ID_ANALOG_8BIT				= 311,	//外部模拟量8bit
	ID_INT_8BIT					= 312,	//内控8bit数据
	ID_ONLINE_DATA1				= 313,	//16bit,在位信号
	ID_ONLINE_DATA2				= 314,	//16bit,在位信号


	ID_POWER_CTRL_SEL			= 320,	//4bit，激光功率控制选择，0-内部设置，1-外部8bit，2-外部模拟量
	ID_AOM_CTRL_SEL				= 321,	//4bit，声光控制选择,0-内部设置，1-外部gare，2-外部trigger
	//
	ID_AOM1_DATA				= 400,	//
	ID_AOM2_DATA				= 401,	//暂时不用，由校准后确定输出,回读为AOM2最终输出
	ID_AOM3_DATA				= 402,	//
	ID_AOM4_DATA				= 403,	//
	ID_AOM1_TTL					= 404,	//暂时不用
	ID_AOM2_TTL					= 405,	//暂时不用
	ID_AOM3_TTL					= 406,	//暂时不用
	ID_AOM4_TTL					= 407,	//暂时不用

	ID_AOM1_DLY					= 420,	//1级声光延时
	ID_AOM2_DLY					= 421,	//2级声光延时
	ID_AOM3_DLY					= 422,	//3级声光延时
	ID_AOM4_DLY					= 423,	//4级声光延时	

	ID_PUMP_SW1					= 450,	//1bit,PUMP1开关设定，回读是时候返归是最终输出状态
	ID_PUMP_SW2					= 451,	//1bit,PUMP2	
	ID_PUMP_SW3					= 452,	//1bit,PUMP3	
	ID_PUMP_SW4					= 453,	//1bit,PUMP4	
	ID_PUMP_SW5					= 454,	//1bit,PUMP5	
	ID_PUMP_SW6					= 455,	//1bit,PUMP6	
	ID_PUMP_SW7					= 456,	//1bit,PUMP7	
	ID_PUMP_SW8					= 457,	//1bit,PUMP8	
	ID_PUMP_SW9					= 458,	//1bit,PUMP9	
	ID_PUMP_SW10				= 459,	//1bit,PUMP10
	ID_PUMP_SW11				= 460,	//1bit,PUMP11
	ID_PUMP_SW12				= 461,	//1bit,PUMP12
	ID_PUMP_SW13				= 462,	//1bit,PUMP13
	ID_PUMP_SW14				= 463,	//1bit,PUMP14
	ID_PUMP_SW15				= 464,	//1bit,PUMP15

	ID_PUMP_SW_SYNC				= 465,	//开关同步，暂时不用
	ID_PUMP_RAMP_SPEED			= 466,	//u16,泵浦缓冲1个da量的时间，(x+1)*20ns


	ID_PUMP1_DATA				= 470,	//pump数据
	ID_PUMP2_DATA  				= 471,	//pump数据
	ID_PUMP3_DATA  				= 472,	//pump数据
	ID_PUMP4_DATA  				= 473,	//pump数据
	ID_PUMP5_DATA  				= 474,	//pump数据
	ID_PUMP6_DATA  				= 475,	//pump数据
	ID_PUMP7_DATA  				= 476,	//pump数据
	ID_PUMP8_DATA  				= 477,	//pump数据
	ID_PUMP9_DATA  				= 478,	//pump数据
	ID_PUMP10_DATA 				= 479,	//pump数据
	ID_PUMP11_DATA 				= 480,	//pump数据
	ID_PUMP12_DATA 				= 481,	//pump数据
	ID_PUMP13_DATA 				= 482,	//pump数据
	ID_PUMP14_DATA 				= 483,	//pump数据
	ID_PUMP15_DATA				= 484,	//pump数据

	ID_PUMP1_ON_DLY 			= 501,	//pump1开启延时再开下一级，(x+1)*20ns
	ID_PUMP2_ON_DLY 			= 502,	//pump2开启延时再开下一级，(x+1)*20ns
	ID_PUMP3_ON_DLY 			= 503,	//pump3开启延时再开下一级，(x+1)*20ns
	ID_PUMP4_ON_DLY 			= 504,	//pump4开启延时再开下一级，(x+1)*20ns
	ID_PUMP5_ON_DLY 			= 505,	//pump5开启延时再开下一级，(x+1)*20ns
	ID_PUMP6_ON_DLY 			= 506,	//pump6开启延时再开下一级，(x+1)*20ns
	ID_PUMP7_ON_DLY 			= 507,	//pump7开启延时再开下一级，(x+1)*20ns
	ID_PUMP8_ON_DLY 			= 508,	//pump8开启延时再开下一级，(x+1)*20ns
	ID_PUMP9_ON_DLY 			= 509,	//pump9开启延时再开下一级，(x+1)*20ns
	ID_PUMP10_ON_DLY 			= 510,	//pump10开启延时再开下一级，(x+1)*20ns
	ID_PUMP11_ON_DLY 			= 511,	//pump11开启延时再开下一级，(x+1)*20ns
	ID_PUMP12_ON_DLY 			= 512,	//pump12开启延时再开下一级，(x+1)*20ns
	ID_PUMP13_ON_DLY 			= 513,	//pump13开启延时再开下一级，(x+1)*20ns
	ID_PUMP14_ON_DLY 			= 514,	//pump14开启延时再开下一级，(x+1)*20ns
	ID_PUMP15_ON_DLY 			= 515,	//pump15开启延时再开下一级，(x+1)*20ns

	ID_PUMP1_OFF_DLY 			= 521,	//pump1关闭延时再关下一级，(x+1)*20ns
	ID_PUMP2_OFF_DLY 			= 522,	//pump2关闭延时再关下一级，(x+1)*20ns
	ID_PUMP3_OFF_DLY 			= 523,	//pump3关闭延时再关下一级，(x+1)*20ns
	ID_PUMP4_OFF_DLY 			= 524,	//pump4关闭延时再关下一级，(x+1)*20ns
	ID_PUMP5_OFF_DLY 			= 525,	//pump5关闭延时再关下一级，(x+1)*20ns
	ID_PUMP6_OFF_DLY 			= 526,	//pump6关闭延时再关下一级，(x+1)*20ns
	ID_PUMP7_OFF_DLY 			= 527,	//pump7关闭延时再关下一级，(x+1)*20ns
	ID_PUMP8_OFF_DLY 			= 528,	//pump8关闭延时再关下一级，(x+1)*20ns
	ID_PUMP9_OFF_DLY 			= 529,	//pump9关闭延时再关下一级，(x+1)*20ns
	ID_PUMP10_OFF_DLY 			= 530,	//pump10关闭延时再关下一级，(x+1)*20ns
	ID_PUMP11_OFF_DLY 			= 531,	//pump11关闭延时再关下一级，(x+1)*20ns
	ID_PUMP12_OFF_DLY 			= 532,	//pump12关闭延时再关下一级，(x+1)*20ns
	ID_PUMP13_OFF_DLY 			= 533,	//pump13关闭延时再关下一级，(x+1)*20ns
	ID_PUMP14_OFF_DLY 			= 534,	//pump14关闭延时再关下一级，(x+1)*20ns
	ID_PUMP15_OFF_DLY 			= 535,	//pump15关闭延时再关下一级，(x+1)*20ns

	ID_PUMP1_NUM	 			= 541,	//pump1的开启顺序。写1是第一个开，写2是第二个开，若n个泵需要同时开，则这n个泵的参数相同
	ID_PUMP2_NUM	 			= 542,	//pump2的开启顺序。
	ID_PUMP3_NUM	 			= 543,	//pump3的开启顺序。
	ID_PUMP4_NUM	 			= 544,	//pump4的开启顺序。
	ID_PUMP5_NUM	 			= 545,	//pump5的开启顺序。
	ID_PUMP6_NUM	 			= 546,	//pump6的开启顺序。
	ID_PUMP7_NUM	 			= 547,	//pump7的开启顺序。
	ID_PUMP8_NUM	 			= 548,	//pump8的开启顺序。
	ID_PUMP9_NUM	 			= 549,	//pump9的开启顺序。
	ID_PUMP10_NUM	 			= 550,	//pump10的开启顺序。
	ID_PUMP11_NUM	 			= 551,	//pump11的开启顺序。
	ID_PUMP12_NUM	 			= 552,	//pump12的开启顺序。
	ID_PUMP13_NUM	 			= 553,	//pump13的开启顺序。
	ID_PUMP14_NUM	 			= 554,	//pump14的开启顺序。
	ID_PUMP15_NUM	 			= 555,	//pump15的开启顺序。

	//马达
	ID_MOTOR1_reset				= 600,	//	
	ID_MOTOR1_period			= 601,	//设置的是周期，(x+1)*2*20ns	
	ID_MOTOR1_step_num			= 602,	//目标值
	ID_MOTOR1_step_sta			= 603,	//当前值
	ID_MOTOR2_reset				= 604,	//	
	ID_MOTOR2_period			= 605,	//	
	ID_MOTOR2_step_num			= 606,	//
	ID_MOTOR2_step_sta			= 607,	//
	ID_MOTOR3_reset				= 608,	//	
	ID_MOTOR3_period			= 609,	//	
	ID_MOTOR3_step_num			= 610,	//
	ID_MOTOR3_step_sta			= 611,	//
	ID_MOTOR4_reset				= 612,	//	
	ID_MOTOR4_period			= 613,	//	
	ID_MOTOR4_step_num			= 614,	//
	ID_MOTOR4_step_sta			= 615,	//

	ID_MOTOR_overflow			= 620,	//电机调试溢出，4BIT，对应4个电机
	
	//
	ID_BST_NUM						= 700,	//burst （选单）数量设置，(x+1)个
	ID_BST_PERIOD					= 701,  //burst （选单）周期（频率）设置，(x+1)*种子源周期
	//ID_AOM1_DLY						= 702,  //1级声光延时的地址在420
	ID_BST_SEL						= 710,	//选单展宽（0）或缩短（1）
	ID_BST_PUL_NUM					= 711,	//选单脉宽调节参数 4bit

	ID_PROT_FREQ					= 719,	//trigger模式下保护频率，设定的是周期，(x+1)*2*种子周期
	ID_TRIG_PRE						= 720,	//trigger模式下预电流
	ID_BURST_DATA1					= 721,	//burst数据1
	ID_BURST_DATA2					= 722,	//burst数据2
	ID_BURST_DATA3					= 723,	//burst数据3
	ID_BURST_DATA4					= 724,	//burst数据4
	ID_BURST_DATA5					= 725,	//burst数据5
	ID_BURST_DATA6					= 726,	//burst数据6
	ID_BURST_DATA7					= 727,	//burst数据7
	ID_BURST_DATA8					= 728,	//burst数据8
	ID_BURST_DATA9					= 729,	//burst数据9
	ID_BURST_DATA10					= 730,	//burst数据10
	ID_BURST_DATA11					= 731,	//burst数据11
	ID_BURST_DATA12					= 732,	//burst数据12
	ID_BURST_DATA13					= 733,	//burst数据13
	ID_BURST_DATA14					= 734,	//burst数据14
	ID_BURST_DATA15					= 735,	//burst数据15
	ID_BURST_DATA16					= 736,	//burst数据16
	ID_BURST_DATA17					= 737,	//burst数据17
	ID_BURST_DATA18					= 738,	//burst数据18
	ID_BURST_DATA19					= 739,	//burst数据19
	ID_BURST_DATA20					= 740,	//burst数据20


	//
	ID_FREQ_DIV_NUM					= 800,	//分频因子,（x+1）分频。 0是不分频，1是二分频，2是三分频
	ID_AOM1_PULSE_NUM				= 801,	//一级声实际光脉冲计数
	ID_AOM1_PULSE_CLR				= 802,	//一级声光脉冲计数清零，写1清零,要写回0才正常计数
	ID_TRIG_CNT						= 803,  //gate或者trig上升沿计数
	ID_TRIG_CLR						= 804,	//gate或者trig上升沿计数清零，写1清零,要写回0才正常计数
	ID_POD_DELAY					= 805,	//POD功能延时调节，匹配光从发送指令到光实际出来的延时，暂时不做
	ID_AOM2_HEAD_DLY				= 806,	//AOM2头展宽，(x+1)*种子源周期,u4
	ID_AOM2_TAIL_DLY				= 807,  //AOM2尾展宽，(x+1)*种子源周期,u4
	ID_SEED_SYNC_AOM1				= 808,	//种子源同步信号(1有效)，种子源开启稳定后，写1，然后再写0，每次种子源重启都要这样操作
	ID_FREQ_TRIG					= 820,	//trigger信号频率

	//校准参数
	ID_THR1							= 900,	//校准段值
	ID_THR2							= 901,	//校准段值
	ID_THR3							= 902,	//校准段值
	ID_THR4							= 903,	//校准段值
	ID_THR5							= 904,	//校准段值
	ID_THR6							= 905,	//校准段值
	ID_THR7							= 906,	//校准段值
	ID_THR8							= 907,	//校准段值
	ID_THR9							= 908,	//校准段值
	ID_THR10						= 909,	//校准段值

	ID_K1							= 910,	//校准k值
	ID_K2							= 911,	//校准k值
	ID_K3							= 912,	//校准k值
	ID_K4							= 913,	//校准k值
	ID_K5							= 914,	//校准k值
	ID_K6							= 915,	//校准k值
	ID_K7							= 916,	//校准k值
	ID_K8							= 917,	//校准k值
	ID_K9							= 918,	//校准k值
	ID_K10							= 919,	//校准k值



	
	
	
	//	
	OFF			= 0,	//OFF模式
	EXTERNAL 	= 1,	//外控模式，声光外控，APM内控
	INTERNAL 	= 2,	//内控模式,所有都内控
	DEBUG 		= 3,	//DEBUG,所有都内控

	GATE_MODE 	= 5,	//APM内控，声光外控
	APM_MODE 	= 6,	//APM外控，声光内控
	MODE_TRIG	= 7		//TRIGGER模式

;

