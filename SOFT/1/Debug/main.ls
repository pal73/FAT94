   1                     ; C Compiler for STM8 (COSMIC Software)
   2                     ; Parser V4.8.32.1 - 30 Mar 2010
   3                     ; Generator V4.3.4 - 23 Mar 2010
2172                     	switch	.data
2173  0000               _b1000Hz:
2174  0000 00            	dc.b	0
2175  0001               _b100Hz:
2176  0001 00            	dc.b	0
2177  0002               _b10Hz:
2178  0002 00            	dc.b	0
2179  0003               _b5Hz:
2180  0003 00            	dc.b	0
2181  0004               _b2Hz:
2182  0004 00            	dc.b	0
2183  0005               _b1Hz:
2184  0005 00            	dc.b	0
2185  0006               _t0_cnt0:
2186  0006 00            	dc.b	0
2187  0007               _t0_cnt1:
2188  0007 00            	dc.b	0
2189  0008               _t0_cnt2:
2190  0008 00            	dc.b	0
2191  0009               _t0_cnt3:
2192  0009 00            	dc.b	0
2193  000a               _t0_cnt4:
2194  000a 00            	dc.b	0
2195                     	bsct
2196  0000               _ind_out:
2197  0000 ff            	dc.b	255
2198  0001 ff            	dc.b	255
2199  0002 ff            	dc.b	255
2200  0003 ff            	dc.b	255
2201  0004 ff            	dc.b	255
2202  0005 ff            	dc.b	255
2203  0006 ff            	dc.b	255
2232                     ; 19 void but_an(void) {
2234                     	switch	.text
2235  0000               _but_an:
2239                     ; 21 }
2242  0000 81            	ret
2265                     ; 24 void ind_hndl(void) {
2266                     	switch	.text
2267  0001               _ind_hndl:
2271                     ; 27 }
2274  0001 81            	ret
2297                     ; 30 void gpio_init(void){
2298                     	switch	.text
2299  0002               _gpio_init:
2303                     ; 32 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
2305  0002 c65008        	ld	a,20488
2306  0005 a4f0          	and	a,#240
2307  0007 c75008        	ld	20488,a
2308                     ; 33 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
2310  000a c65009        	ld	a,20489
2311  000d a4f0          	and	a,#240
2312  000f c75009        	ld	20489,a
2313                     ; 34 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
2315  0012 c65007        	ld	a,20487
2316  0015 aa0f          	or	a,#15
2317  0017 c75007        	ld	20487,a
2318                     ; 37 	GPIOC->CR1&=~0xfe;
2320  001a c6500d        	ld	a,20493
2321  001d a401          	and	a,#1
2322  001f c7500d        	ld	20493,a
2323                     ; 38 	GPIOC->CR2&=~0xfe;
2325  0022 c6500e        	ld	a,20494
2326  0025 a401          	and	a,#1
2327  0027 c7500e        	ld	20494,a
2328                     ; 39 	GPIOC->DDR|=0xfe;
2330  002a c6500c        	ld	a,20492
2331  002d aafe          	or	a,#254
2332  002f c7500c        	ld	20492,a
2333                     ; 40 	GPIOD->CR1&=~0x01;
2335  0032 72115012      	bres	20498,#0
2336                     ; 41 	GPIOD->CR2&=~0x01;
2338  0036 72115013      	bres	20499,#0
2339                     ; 42 	GPIOD->DDR|=0x01;	
2341  003a 72105011      	bset	20497,#0
2342                     ; 56 	GPIOD->DDR&=~(1<<5);	
2344  003e 721b5011      	bres	20497,#5
2345                     ; 57 	GPIOD->CR1|=(1<<5);
2347  0042 721a5012      	bset	20498,#5
2348                     ; 58 	GPIOD->CR2&=~(1<<5);
2350  0046 721b5013      	bres	20499,#5
2351                     ; 61 	GPIOB->DDR&=~(1<<5);	
2353  004a 721b5007      	bres	20487,#5
2354                     ; 62 	GPIOB->CR1|=(1<<5);
2356  004e 721a5008      	bset	20488,#5
2357                     ; 63 	GPIOB->CR2&=~(1<<5);
2359  0052 721b5009      	bres	20489,#5
2360                     ; 65 	GPIOB->ODR|=0x0f;
2362  0056 c65005        	ld	a,20485
2363  0059 aa0f          	or	a,#15
2364  005b c75005        	ld	20485,a
2365                     ; 66 }
2368  005e 81            	ret
2391                     ; 69 void t4_init(void){
2392                     	switch	.text
2393  005f               _t4_init:
2397                     ; 70 	TIM4->PSCR = 7;
2399  005f 35075347      	mov	21319,#7
2400                     ; 71 	TIM4->ARR= 123;
2402  0063 357b5348      	mov	21320,#123
2403                     ; 72 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
2405  0067 72105343      	bset	21315,#0
2406                     ; 74 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
2408  006b 35855340      	mov	21312,#133
2409                     ; 75 }	
2412  006f 81            	ret
2451                     ; 81 @far @interrupt void TIM4_UPD_Interrupt (void) 
2451                     ; 82 {
2453                     	switch	.text
2454  0070               f_TIM4_UPD_Interrupt:
2458                     ; 84 ind_cnt++;
2460  0070 3c03          	inc	_ind_cnt
2461                     ; 86 if(ind_cnt>=4)ind_cnt=0;
2463  0072 b603          	ld	a,_ind_cnt
2464  0074 a104          	cp	a,#4
2465  0076 2502          	jrult	L1051
2468  0078 3f03          	clr	_ind_cnt
2469  007a               L1051:
2470                     ; 88 GPIOC->ODR|=0xf0;
2472  007a c6500a        	ld	a,20490
2473  007d aaf0          	or	a,#240
2474  007f c7500a        	ld	20490,a
2475                     ; 90 GPIOA->ODR|=0x06;
2477  0082 c65000        	ld	a,20480
2478  0085 aa06          	or	a,#6
2479  0087 c75000        	ld	20480,a
2480                     ; 91 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
2482  008a b603          	ld	a,_ind_cnt
2483  008c 5f            	clrw	x
2484  008d 97            	ld	xl,a
2485  008e e600          	ld	a,(_ind_out,x)
2486  0090 48            	sll	a
2487  0091 aaf9          	or	a,#249
2488  0093 c45000        	and	a,20480
2489  0096 c75000        	ld	20480,a
2490                     ; 92 GPIOD->ODR|=0x7c;
2492  0099 c6500f        	ld	a,20495
2493  009c aa7c          	or	a,#124
2494  009e c7500f        	ld	20495,a
2495                     ; 93 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
2497  00a1 b603          	ld	a,_ind_cnt
2498  00a3 5f            	clrw	x
2499  00a4 97            	ld	xl,a
2500  00a5 e600          	ld	a,(_ind_out,x)
2501  00a7 aa83          	or	a,#131
2502  00a9 c4500f        	and	a,20495
2503  00ac c7500f        	ld	20495,a
2504                     ; 95 GPIOC->ODR&=~(0x80>>ind_cnt);
2506  00af b603          	ld	a,_ind_cnt
2507  00b1 5f            	clrw	x
2508  00b2 97            	ld	xl,a
2509  00b3 a680          	ld	a,#128
2510  00b5 5d            	tnzw	x
2511  00b6 2704          	jreq	L61
2512  00b8               L02:
2513  00b8 44            	srl	a
2514  00b9 5a            	decw	x
2515  00ba 26fc          	jrne	L02
2516  00bc               L61:
2517  00bc 43            	cpl	a
2518  00bd c4500a        	and	a,20490
2519  00c0 c7500a        	ld	20490,a
2520                     ; 97 b1000Hz=1;
2522  00c3 35010000      	mov	_b1000Hz,#1
2523                     ; 99 if(++t0_cnt0>=10)
2525  00c7 725c0006      	inc	_t0_cnt0
2526  00cb c60006        	ld	a,_t0_cnt0
2527  00ce a10a          	cp	a,#10
2528  00d0 2575          	jrult	L3051
2529                     ; 101 	t0_cnt0=0;
2531  00d2 725f0006      	clr	_t0_cnt0
2532                     ; 102     	b100Hz=1;
2534  00d6 35010001      	mov	_b100Hz,#1
2535                     ; 103 	if(++t0_cnt1>=10)
2537  00da 725c0007      	inc	_t0_cnt1
2538  00de c60007        	ld	a,_t0_cnt1
2539  00e1 a10a          	cp	a,#10
2540  00e3 2508          	jrult	L5051
2541                     ; 105 		t0_cnt1=0;
2543  00e5 725f0007      	clr	_t0_cnt1
2544                     ; 106 		b10Hz=1;
2546  00e9 35010002      	mov	_b10Hz,#1
2547  00ed               L5051:
2548                     ; 109 	if(++t0_cnt2>=20)
2550  00ed 725c0008      	inc	_t0_cnt2
2551  00f1 c60008        	ld	a,_t0_cnt2
2552  00f4 a114          	cp	a,#20
2553  00f6 2513          	jrult	L7051
2554                     ; 111 		t0_cnt2=0;
2556  00f8 725f0008      	clr	_t0_cnt2
2557                     ; 112 		b5Hz=1;
2559  00fc 35010003      	mov	_b5Hz,#1
2560                     ; 113 		bFL5=!bFL5;
2562  0100 3d02          	tnz	_bFL5
2563  0102 2604          	jrne	L22
2564  0104 a601          	ld	a,#1
2565  0106 2001          	jra	L42
2566  0108               L22:
2567  0108 4f            	clr	a
2568  0109               L42:
2569  0109 b702          	ld	_bFL5,a
2570  010b               L7051:
2571                     ; 116 	if(++t0_cnt3>=50)
2573  010b 725c0009      	inc	_t0_cnt3
2574  010f c60009        	ld	a,_t0_cnt3
2575  0112 a132          	cp	a,#50
2576  0114 2513          	jrult	L1151
2577                     ; 118 		t0_cnt3=0;
2579  0116 725f0009      	clr	_t0_cnt3
2580                     ; 119 		b2Hz=1;
2582  011a 35010004      	mov	_b2Hz,#1
2583                     ; 120 		bFL2=!bFL2;		
2585  011e 3d01          	tnz	_bFL2
2586  0120 2604          	jrne	L62
2587  0122 a601          	ld	a,#1
2588  0124 2001          	jra	L03
2589  0126               L62:
2590  0126 4f            	clr	a
2591  0127               L03:
2592  0127 b701          	ld	_bFL2,a
2593  0129               L1151:
2594                     ; 123 	if(++t0_cnt4>=100)
2596  0129 725c000a      	inc	_t0_cnt4
2597  012d c6000a        	ld	a,_t0_cnt4
2598  0130 a164          	cp	a,#100
2599  0132 2513          	jrult	L3051
2600                     ; 125 		t0_cnt4=0;
2602  0134 725f000a      	clr	_t0_cnt4
2603                     ; 126 		b1Hz=1;
2605  0138 35010005      	mov	_b1Hz,#1
2606                     ; 127 		bFL1=!bFL1;
2608  013c 3d00          	tnz	_bFL1
2609  013e 2604          	jrne	L23
2610  0140 a601          	ld	a,#1
2611  0142 2001          	jra	L43
2612  0144               L23:
2613  0144 4f            	clr	a
2614  0145               L43:
2615  0145 b700          	ld	_bFL1,a
2616  0147               L3051:
2617                     ; 133 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
2619  0147 72115344      	bres	21316,#0
2620                     ; 134 return;
2623  014b 80            	iret
2657                     ; 141 main()
2657                     ; 142 {
2659                     	switch	.text
2660  014c               _main:
2664                     ; 143 CLK->CKDIVR=0;
2666  014c 725f50c6      	clr	20678
2667                     ; 145 gpio_init();
2669  0150 cd0002        	call	_gpio_init
2671                     ; 149 FLASH_DUKR=0xae;
2673  0153 35ae5064      	mov	_FLASH_DUKR,#174
2674                     ; 150 FLASH_DUKR=0x56;	
2676  0157 35565064      	mov	_FLASH_DUKR,#86
2677                     ; 199 t4_init();
2679  015b cd005f        	call	_t4_init
2681                     ; 200 enableInterrupts();	
2684  015e 9a            rim
2686  015f               L5251:
2687                     ; 207 	if(b1000Hz)
2689  015f 725d0000      	tnz	_b1000Hz
2690  0163 2704          	jreq	L1351
2691                     ; 209 		b1000Hz=0;
2693  0165 725f0000      	clr	_b1000Hz
2694  0169               L1351:
2695                     ; 213 	if(b100Hz)
2697  0169 725d0001      	tnz	_b100Hz
2698  016d 2707          	jreq	L3351
2699                     ; 215 		b100Hz=0;
2701  016f 725f0001      	clr	_b100Hz
2702                     ; 217 		but_an();
2704  0173 cd0000        	call	_but_an
2706  0176               L3351:
2707                     ; 220 	if(b10Hz)
2709  0176 725d0002      	tnz	_b10Hz
2710  017a 2707          	jreq	L5351
2711                     ; 222 		b10Hz=0;
2713  017c 725f0002      	clr	_b10Hz
2714                     ; 225 		ind_hndl();
2716  0180 cd0001        	call	_ind_hndl
2718  0183               L5351:
2719                     ; 229 	if(b5Hz)
2721  0183 725d0003      	tnz	_b5Hz
2722  0187 2704          	jreq	L7351
2723                     ; 231 		b5Hz=0;
2725  0189 725f0003      	clr	_b5Hz
2726  018d               L7351:
2727                     ; 235 	if(b2Hz)
2729  018d 725d0004      	tnz	_b2Hz
2730  0191 2704          	jreq	L1451
2731                     ; 237 		b2Hz=0;
2733  0193 725f0004      	clr	_b2Hz
2734  0197               L1451:
2735                     ; 241 	if(b1Hz)
2737  0197 725d0005      	tnz	_b1Hz
2738  019b 27c2          	jreq	L5251
2739                     ; 243 		b1Hz=0;
2741  019d 725f0005      	clr	_b1Hz
2742  01a1 20bc          	jra	L5251
2931                     	xdef	_main
2932                     	xdef	f_TIM4_UPD_Interrupt
2933                     	xdef	_t4_init
2934                     	xdef	_gpio_init
2935                     	xdef	_ind_hndl
2936                     	xdef	_but_an
2937                     	switch	.ubsct
2938  0000               _bFL1:
2939  0000 00            	ds.b	1
2940                     	xdef	_bFL1
2941  0001               _bFL2:
2942  0001 00            	ds.b	1
2943                     	xdef	_bFL2
2944  0002               _bFL5:
2945  0002 00            	ds.b	1
2946                     	xdef	_bFL5
2947                     	xdef	_ind_out
2948  0003               _ind_cnt:
2949  0003 00            	ds.b	1
2950                     	xdef	_ind_cnt
2951                     	xdef	_t0_cnt4
2952                     	xdef	_t0_cnt3
2953                     	xdef	_t0_cnt2
2954                     	xdef	_t0_cnt1
2955                     	xdef	_t0_cnt0
2956                     	xdef	_b1Hz
2957                     	xdef	_b2Hz
2958                     	xdef	_b5Hz
2959                     	xdef	_b10Hz
2960                     	xdef	_b100Hz
2961                     	xdef	_b1000Hz
2981                     	end
