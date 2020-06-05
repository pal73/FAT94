#include "stm8s.h"
#include <iostm8s103.h>
#include "main.h"
#include <stdio.h>

//#pragma section @eeprom [aaa]

@near bool b1000Hz=0,b100Hz=0,b10Hz=0,b5Hz=0,b2Hz=0,b1Hz=0;
@near char t0_cnt0=0,t0_cnt1=0,t0_cnt2=0,t0_cnt3=0,t0_cnt4=0;

//-----------------------------------------------
//���������
char ind_cnt;
char ind_out[7]={0b00011000,0b11111011,0b11110111,0b11101111,0b11111111,0b11111111,0b11111111};
const char DIGISYM[30]={	0b10000100,0b10011111,0b00100001,0b00001001,0b00011010,0b01001000,0b01000000,0b10011101,0b00000000,0b00001000,
					0b00010001,0b00000111,0b10001101,0b01000011,0b00000111,0b00001111,0b11111111,0b11111111,0b11111111,0b11111111,
					0b11111111,0b11111101,0b11111011,0b11110111,0b11101111,0b11011111,0b10111111,0b01111111};
char dig[10];
char ind_out_[5];
bool bFL5, bFL2, bFL1;
bool zero_on;
char led_stat;

//-----------------------------------------------
//��������� ������
char but_new;
char but_n, but_s, but;
char l_but, n_but;
short but0_cnt, but1_cnt;
char speed;
short but_onL_temp;
char but_stat;
#define BUT_ON	5
#define BUT_ONL	9000


//***********************************************
//������ ������
typedef enum {mKONST,mTIMER,mLOOP} mode_enum;
mode_enum mode;

#define butK	254
#define butK_	126
#define butT	253
#define butT_	124
#define butL	251
#define butL_	123
//-----------------------------------------------
void but_an(void) 
{
if(n_but)
	{
	if(but==butK)
		{
		mode=mKONST;
		}
	if(but==butT)
		{
		mode=mTIMER;
		}
	if(but==butL)
		{
		mode=mLOOP;
		}
	}
n_but=0;
}

//-----------------------------------------------
void but_drv(void)
{

but_n=(but_stat)|0xf8; 	
if((but_n==0xff)||(but_n!=but_s))
 	{
 	speed=0;
 
	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
		{
   	n_but=1;
    but=(char)but_s;
    }
 	if (but1_cnt>=but_onL_temp)
 		{
    n_but=1;
		but=((char)but_s)&0x7f;
    }
	l_but=0;
	but_onL_temp=BUT_ONL;
	but0_cnt=0;
	but1_cnt=0;          
	goto but_drv_out;
  }
if(but_n==but_s)
 	{
  but0_cnt++;
	if(but0_cnt>=BUT_ON)
		{
		but0_cnt=0;
		but1_cnt++;
		if(but1_cnt>=but_onL_temp)
			{              
			but=(char)(but_s&0x7f);
			but1_cnt=0;
			n_but=1;
			l_but=1;
			if(speed)
				{
				but_onL_temp=but_onL_temp>>1;
				if(but_onL_temp<=2) but_onL_temp=2;
				}    
			}
		}
 	}
but_drv_out: 
but_s=but_n;

}
//-----------------------------------------------
void bin2bcd_int(unsigned short in) 
{
char i=5;

for(i=0;i<5;i++)
	{
	dig[i]=in%10;
	in/=10;
	}
}

//-----------------------------------------------
void bcd2ind(void) 
{
char i;

for (i=4;i>0;i--)
	{
	ind_out_[i-1]=DIGISYM[dig[i-1]];
	}
} 

//-----------------------------------------------
void bcd2ind_zero(void) 
{
char i;
zero_on=1;
for (i=4;i>0;i--)
	{
	if(zero_on&&(!dig[i-1])&&(i-1))
		{
		ind_out_[i-1]=0b11111111;
		}
	else
		{
		ind_out_[i-1]=DIGISYM[dig[i-1]];
		zero_on=0;
		}
	}
}

//-----------------------------------------------
void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
{
char i;

/*for(i=0;i<4;i++) 
	{
	ind_out[i]=0xff;
	}*/
	
bin2bcd_int(in);
if(unzero)bcd2ind_zero();
else bcd2ind();
if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
	{
	for(i=0;i<len;i++) 
		{
		ind_out_[i]=DIGISYM[17];
		}
	}

for(i=0;i<len;i++) 
	{
	ind_out[start+i]=ind_out_[i];
	}
}

//-----------------------------------------------
void led_hndl(void)
{
if(mode==mKONST)
	{
	led_stat=0x01;
	}
else if(mode==mTIMER)
	{
	led_stat=0x02;
	}
else if(mode==mLOOP)
	{
	led_stat=0x04;
	}	
}

/*
//-----------------------------------------------
void int2indII_slkuf(unsigned short in, char start, char len, char komma, char unzero, char fl) 
{
char i;

bin2bcd_int(in);
if(unzero)bcd2ind_zero();
else bcd2ind();
if(komma)ind_out_[komma]&=0b01111111; 
if(((fl==1)&&(bFL2)) || ((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
	{
	for(i=0;i<len;i++) 
		{
		ind_out_[i]=DIGISYM[17];
		}
	}

for(i=0;i<len;i++) 
	{
	ind_outC[start+i]=(ind_out_[i]<<1);
	ind_outG[start+i]=0xff;
	if(!(ind_out_[i]&0x80)) ind_outG[start+i]&=0xfe;
	}
}*/

//-----------------------------------------------
void ind_hndl(void) 
{
int2indI_slkuf(but, 0, 4, 0, 0);
//int2indI_slkuf(9, 3, 1, 1, 1);
}

//-----------------------------------------------
void gpio_init(void){
	GPIOA->DDR|=((1<<1)|(1<<2));
	GPIOA->CR1|=((1<<1)|(1<<2));
	GPIOA->CR2&=~((1<<1)|(1<<2));
	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
	
	
	//������ ���������
	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));

	//����������-������
	GPIOC->CR1|=((1<<3));
	GPIOC->CR2&=~((1<<3));
	GPIOB->CR1|=((1<<4)|(1<<5));
	GPIOB->CR2&=~((1<<4)|(1<<5));

	//�������� ���������
	GPIOC->CR1&=~0xfe;
	GPIOC->CR2&=~0xfe;
	GPIOC->DDR|=0xfe;
//	GPIOD->CR1&=~0x01;
//	GPIOD->CR2&=~0x01;
//	GPIOD->DDR|=0x01;	

#ifdef FORGSM
//���� �� ������� �� ����� ����� 
	GPIOB->DDR&=~(1<<5);	
	GPIOB->CR1|=(1<<5);
	GPIOB->CR2&=~(1<<5);
	
/*	��� UARTa GPIOD->DDR&=~(1<<5);	
	GPIOD->CR1|=(1<<5);
	GPIOD->CR2&=~(1<<5);*/
#endif
#ifndef FORGSM
//���� �� �������

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

if(ind_cnt>=5)ind_cnt=0;
	
GPIOC->ODR|=0xf0;


GPIOA->ODR|=0x06;
GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
GPIOD->ODR|=0x7c;
GPIOD->ODR&=(ind_out[ind_cnt])|0x83;



GPIOC->ODR&=~(0x10<<ind_cnt);
if(ind_cnt==4)
	{
	GPIOC->ODR&=~(0x10);
	}

GPIOC->CR1|=((1<<3));
GPIOC->CR2&=~((1<<3));
GPIOB->CR1|=((1<<4)|(1<<5));
GPIOB->CR2&=~((1<<4)|(1<<5));

if(ind_cnt==4)	
	{
	GPIOC->DDR&=~(1<<3);
	GPIOB->DDR&=~((1<<4)|(1<<5));
	}
else if(ind_cnt==0)	
	{
	GPIOC->DDR|=((1<<3));
	GPIOB->DDR|=((1<<4)|(1<<5));
	}


	

//GPIOC->DDR&=~(1<<3);
//GPIOB->DDR&=~((1<<4)|(1<<5));

if(ind_cnt==0)	
	{
	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
	else 			GPIOC->ODR|=(1<<3);
	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
	else 			GPIOB->ODR|=(1<<4);
	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
	else 			GPIOB->ODR|=(1<<5);
	}
else if(ind_cnt==4)	
	{
	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
	else but_stat|=0x01;
	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
	else but_stat|=0x02;
	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
	else but_stat|=0x04;	
	}

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
		but_drv();
		but_an();
		}  	
		
	if(b100Hz)
		{
		b100Hz=0;
		led_hndl();	
		//but_an();
		}  
      	
	if(b10Hz)
		{
		b10Hz=0;
		ind_hndl();	
		out_hndl();	
		out_drv();
			
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
		led_stat=0;
		
		}      	     	      
	}
}