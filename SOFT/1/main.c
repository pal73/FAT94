#include "stm8s.h"
#include <iostm8s103.h>
#include "main.h"
#include <stdio.h>

//#pragma section @eeprom [aaa]

@near bool b1000Hz=0,b100Hz=0,b10Hz=0,b5Hz=0,b2Hz=0,b1Hz=0;
@near char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;

//-----------------------------------------------
//Индикация
char ind_cnt;
char ind_out[7]={0b11111111,0b11111111,0b11111111,0b11111111,0b11111111,0b11111111,0b11111111};

bool bFL5, bFL2, bFL1;

//-----------------------------------------------
void but_an(void) {

}

//-----------------------------------------------
void ind_hndl(void) {
	

}

//-----------------------------------------------
void gpio_init(void){
	//Стробы индикации
	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
	
	//Сегменты индикации
	GPIOC->CR1&=~0xfe;
	GPIOC->CR2&=~0xfe;
	GPIOC->DDR|=0xfe;
	GPIOD->CR1&=~0x01;
	GPIOD->CR2&=~0x01;
	GPIOD->DDR|=0x01;	

#ifdef FORGSM
//вход от гашетки на новом месте 
	GPIOB->DDR&=~(1<<5);	
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);
	
/*	для UARTa GPIOD->DDR&=~(1<<5);	
	GPIOD->CR1|=(1<<5);
	GPIOD->CR2&=~(1<<5);*/
#endif
#ifndef FORGSM
//вход от гашетки
	GPIOD->DDR&=~(1<<5);	
	GPIOD->CR1|=(1<<5);
	GPIOD->CR2&=~(1<<5);
#endif

	GPIOB->DDR&=~(1<<5);	
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);
	
	GPIOB->ODR|=0x0f;
}

//-----------------------------------------------
void t4_init(void){
	TIM4->PSCR = 7;
	TIM4->ARR= 123;
	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
	
	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
}	

//***********************************************
//***********************************************
//***********************************************
//***********************************************
@far @interrupt void TIM4_UPD_Interrupt (void) 
{

ind_cnt++;

if(ind_cnt>=4)ind_cnt=0;
	
GPIOC->ODR|=0xf0;

GPIOA->ODR|=0x06;
GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
GPIOD->ODR|=0x7c;
GPIOD->ODR&=(ind_out[ind_cnt])|0x83;

GPIOC->ODR&=~(0x80>>ind_cnt);

b1000Hz=1;
	
if(++t0_cnt0>=10)
	{
	t0_cnt0=0;
    	b100Hz=1;
	if(++t0_cnt1>=10)
		{
		t0_cnt1=0;
		b10Hz=1;
		}
		
	if(++t0_cnt2>=20)
		{
		t0_cnt2=0;
		b5Hz=1;
		bFL5=!bFL5;
		}

	if(++t0_cnt3>=50)
		{
		t0_cnt3=0;
		b2Hz=1;
		bFL2=!bFL2;		
		}

	if(++t0_cnt4>=100)
		{
		t0_cnt4=0;
		b1Hz=1;
		bFL1=!bFL1;
		}
	}


	
TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
return;
}

//===============================================
//===============================================
//===============================================
//===============================================
main()
{
CLK->CKDIVR=0;
	
gpio_init();
	//_init();
	//t2_init();
	
FLASH_DUKR=0xae;
FLASH_DUKR=0x56;	

	//rx_plazma=aaa;
	
/*	GPIOC->CR1|=(1<<1);
	GPIOC->DDR|=(1<<1);
	GPIOC->ODR|=(1<<1);
		//GPIOC->CR2&=~(1<<5);
	GPIOC->CR1|=(1<<2);
	GPIOC->DDR|=(1<<2);
	GPIOC->ODR|=(1<<2);
	//GPIOC->CR2&=~(1<<2);
	GPIOC->CR1|=(1<<3);
	GPIOC->DDR|=(1<<3);
	GPIOC->ODR|=(1<<3);
	//GPIOC->CR2&=~(1<<3);
	GPIOC->CR1|=(1<<4);
	GPIOC->DDR|=(1<<4);
	GPIOC->ODR|=(1<<4);

	GPIOB->DDR|=(1<<0);
	GPIOB->CR1|=(1<<0);
	GPIOB->CR2&=~(1<<0);
	
	GPIOB->DDR|=(1<<1);
	GPIOB->CR1|=(1<<1);
	GPIOB->CR2&=~(1<<1);

	GPIOB->DDR|=(1<<2);
	GPIOB->CR1|=(1<<2);
	GPIOB->CR2&=~(1<<2);


	GPIOD->DDR|=(1<<3);
	GPIOD->CR1|=(1<<3);
	GPIOD->CR2&=~(1<<3);

	GPIOD->DDR|=(1<<4);
	GPIOD->CR1|=(1<<4);
	GPIOD->CR2&=~(1<<4);

GPIOF->CR1&=~(1<<4);
GPIOF->CR2&=~(1<<4);
GPIOF->DDR|=(1<<4);*/

	//ind=iWait2;
	//ind=iMn;
	//ind=iDeb;
	
t4_init();
enableInterrupts();	



while (1)
	{

	if(b1000Hz)
		{
		b1000Hz=0;

}  	
		
	if(b100Hz)
		{
		b100Hz=0;
			
		but_an();
		}  
      	
	if(b10Hz)
		{
		b10Hz=0;
			
			
		ind_hndl();
			
		}
      	 
	if(b5Hz)
		{
		b5Hz=0;
		//GPIOF->ODR^=(1<<4);	
		}
		
	if(b2Hz)
		{
		b2Hz=0;
			
		}      

	if(b1Hz)
		{
		b1Hz=0;
		
		
		}      	     	      
	}
}