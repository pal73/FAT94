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
2201                     	bsct
2202  0000               _ind_out:
2203  0000 18            	dc.b	24
2204  0001 fb            	dc.b	251
2205  0002 f7            	dc.b	247
2206  0003 ef            	dc.b	239
2207  0004 ff            	dc.b	255
2208  0005 ff            	dc.b	255
2209  0006 ff            	dc.b	255
2210                     .const:	section	.text
2211  0000               _DIGISYM:
2212  0000 84            	dc.b	132
2213  0001 9f            	dc.b	159
2214  0002 21            	dc.b	33
2215  0003 09            	dc.b	9
2216  0004 1a            	dc.b	26
2217  0005 48            	dc.b	72
2218  0006 40            	dc.b	64
2219  0007 9d            	dc.b	157
2220  0008 00            	dc.b	0
2221  0009 08            	dc.b	8
2222  000a 11            	dc.b	17
2223  000b 07            	dc.b	7
2224  000c 8d            	dc.b	141
2225  000d 43            	dc.b	67
2226  000e 07            	dc.b	7
2227  000f 0f            	dc.b	15
2228  0010 ff            	dc.b	255
2229  0011 ff            	dc.b	255
2230  0012 ff            	dc.b	255
2231  0013 ff            	dc.b	255
2232  0014 ff            	dc.b	255
2233  0015 fd            	dc.b	253
2234  0016 fb            	dc.b	251
2235  0017 f7            	dc.b	247
2236  0018 ef            	dc.b	239
2237  0019 df            	dc.b	223
2238  001a bf            	dc.b	191
2239  001b 7f            	dc.b	127
2240  001c 0000          	ds.b	2
2279                     ; 83 void time_hndl(void) 
2279                     ; 84 {
2281                     	switch	.text
2282  0000               _time_hndl:
2286                     ; 85 if(out_state==osON)
2288  0000 b60a          	ld	a,_out_state
2289  0002 a101          	cp	a,#1
2290  0004 2623          	jrne	L1441
2291                     ; 87 	second_cnt++;
2293  0006 be08          	ldw	x,_second_cnt
2294  0008 1c0001        	addw	x,#1
2295  000b bf08          	ldw	_second_cnt,x
2296                     ; 88 	if(second_cnt>=SEC_IN_HOUR)
2298  000d 9c            	rvf
2299  000e be08          	ldw	x,_second_cnt
2300  0010 a30e10        	cpw	x,#3600
2301  0013 2f14          	jrslt	L1441
2302                     ; 90 		second_cnt=0;
2304  0015 5f            	clrw	x
2305  0016 bf08          	ldw	_second_cnt,x
2306                     ; 91 		if(main_cnt_ee)
2308  0018 ce4002        	ldw	x,_main_cnt_ee
2309  001b 270c          	jreq	L1441
2310                     ; 93 			main_cnt_ee--;
2312  001d ce4002        	ldw	x,_main_cnt_ee
2313  0020 1d0001        	subw	x,#1
2314  0023 cf4002        	ldw	_main_cnt_ee,x
2315                     ; 94 			if(!main_cnt_ee)
2317  0026 ce4002        	ldw	x,_main_cnt_ee
2318  0029               L1441:
2319                     ; 101 if(timer_pause_cnt)
2321  0029 be04          	ldw	x,_timer_pause_cnt
2322  002b 2720          	jreq	L1541
2323                     ; 103 	timer_pause_cnt--;
2325  002d be04          	ldw	x,_timer_pause_cnt
2326  002f 1d0001        	subw	x,#1
2327  0032 bf04          	ldw	_timer_pause_cnt,x
2328                     ; 104 	if((timer_pause_cnt==0)&&(main_cnt_ee))
2330  0034 be04          	ldw	x,_timer_pause_cnt
2331  0036 2615          	jrne	L1541
2333  0038 ce4002        	ldw	x,_main_cnt_ee
2334  003b 2710          	jreq	L1541
2335                     ; 106 		mode_phase=mpON;
2337  003d 3501000b      	mov	_mode_phase,#1
2338                     ; 107 		timer_second_cnt=SEC_IN_MIN*timer_period_ee;
2340  0041 ce4008        	ldw	x,_timer_period_ee
2341  0044 90ae003c      	ldw	y,#60
2342  0048 cd0000        	call	c_imul
2344  004b bf06          	ldw	_timer_second_cnt,x
2345  004d               L1541:
2346                     ; 110 if(timer_second_cnt)
2348  004d be06          	ldw	x,_timer_second_cnt
2349  004f 270d          	jreq	L5541
2350                     ; 112 	timer_second_cnt--;
2352  0051 be06          	ldw	x,_timer_second_cnt
2353  0053 1d0001        	subw	x,#1
2354  0056 bf06          	ldw	_timer_second_cnt,x
2355                     ; 113 	if(timer_second_cnt==0)
2357  0058 be06          	ldw	x,_timer_second_cnt
2358  005a 2602          	jrne	L5541
2359                     ; 115 		mode_phase=mpOFF;
2361  005c 3f0b          	clr	_mode_phase
2362  005e               L5541:
2363                     ; 119 if(mode==mLOOP)
2365  005e b60c          	ld	a,_mode
2366  0060 a102          	cp	a,#2
2367  0062 2636          	jrne	L1641
2368                     ; 121 	if(loop_wrk_cnt)
2370  0064 be02          	ldw	x,_loop_wrk_cnt
2371  0066 2717          	jreq	L3641
2372                     ; 123 		loop_wrk_cnt--;
2374  0068 be02          	ldw	x,_loop_wrk_cnt
2375  006a 1d0001        	subw	x,#1
2376  006d bf02          	ldw	_loop_wrk_cnt,x
2377                     ; 124 		mode_phase=mpON;
2379  006f 3501000b      	mov	_mode_phase,#1
2380                     ; 125 		if(loop_wrk_cnt<=0)
2382  0073 9c            	rvf
2383  0074 be02          	ldw	x,_loop_wrk_cnt
2384  0076 2c28          	jrsgt	L5741
2385                     ; 127 			loop_pause_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2387  0078 ae0e10        	ldw	x,#3600
2388  007b bf00          	ldw	_loop_pause_cnt,x
2389  007d 2021          	jra	L5741
2390  007f               L3641:
2391                     ; 130 	else if(loop_pause_cnt)
2393  007f be00          	ldw	x,_loop_pause_cnt
2394  0081 271d          	jreq	L5741
2395                     ; 132 		loop_pause_cnt--;
2397  0083 be00          	ldw	x,_loop_pause_cnt
2398  0085 1d0001        	subw	x,#1
2399  0088 bf00          	ldw	_loop_pause_cnt,x
2400                     ; 133 		mode_phase=mpPAUSE;
2402  008a 3502000b      	mov	_mode_phase,#2
2403                     ; 134 		if(loop_pause_cnt<=0)
2405  008e 9c            	rvf
2406  008f be00          	ldw	x,_loop_pause_cnt
2407  0091 2c0d          	jrsgt	L5741
2408                     ; 136 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2410  0093 ae0e10        	ldw	x,#3600
2411  0096 bf02          	ldw	_loop_wrk_cnt,x
2412  0098 2006          	jra	L5741
2413  009a               L1641:
2414                     ; 142 	loop_wrk_cnt=0;
2416  009a 5f            	clrw	x
2417  009b bf02          	ldw	_loop_wrk_cnt,x
2418                     ; 143 	loop_pause_cnt=0;
2420  009d 5f            	clrw	x
2421  009e bf00          	ldw	_loop_pause_cnt,x
2422  00a0               L5741:
2423                     ; 145 }
2426  00a0 81            	ret
2452                     ; 148 void out_hndl(void) 
2452                     ; 149 {
2453                     	switch	.text
2454  00a1               _out_hndl:
2458                     ; 150 if( 	((mode==mKONST)&&(mode_phase==mpON)) ||
2458                     ; 151 	((mode==mTIMER)&&(mode_phase==mpON)) ||
2458                     ; 152 	((mode==mLOOP)&&(mode_phase==mpON))
2458                     ; 153 	)out_state=osON;
2460  00a1 3d0c          	tnz	_mode
2461  00a3 2606          	jrne	L3151
2463  00a5 b60b          	ld	a,_mode_phase
2464  00a7 a101          	cp	a,#1
2465  00a9 2718          	jreq	L1151
2466  00ab               L3151:
2468  00ab b60c          	ld	a,_mode
2469  00ad a101          	cp	a,#1
2470  00af 2606          	jrne	L7151
2472  00b1 b60b          	ld	a,_mode_phase
2473  00b3 a101          	cp	a,#1
2474  00b5 270c          	jreq	L1151
2475  00b7               L7151:
2477  00b7 b60c          	ld	a,_mode
2478  00b9 a102          	cp	a,#2
2479  00bb 260c          	jrne	L7051
2481  00bd b60b          	ld	a,_mode_phase
2482  00bf a101          	cp	a,#1
2483  00c1 2606          	jrne	L7051
2484  00c3               L1151:
2487  00c3 3501000a      	mov	_out_state,#1
2489  00c7 2002          	jra	L1251
2490  00c9               L7051:
2491                     ; 154 else out_state=osOFF; 
2493  00c9 3f0a          	clr	_out_state
2494  00cb               L1251:
2495                     ; 156 }
2498  00cb 81            	ret
2522                     ; 159 void out_drv(void) 
2522                     ; 160 {
2523                     	switch	.text
2524  00cc               _out_drv:
2528                     ; 161 if(out_state==osON)
2530  00cc b60a          	ld	a,_out_state
2531  00ce a101          	cp	a,#1
2532  00d0 2606          	jrne	L3351
2533                     ; 163 	GPIOA->ODR|=(1<<3);	
2535  00d2 72165000      	bset	20480,#3
2537  00d6 2004          	jra	L5351
2538  00d8               L3351:
2539                     ; 165 else GPIOA->ODR&=~(1<<3);
2541  00d8 72175000      	bres	20480,#3
2542  00dc               L5351:
2543                     ; 166 }
2546  00dc 81            	ret
2581                     ; 169 void but_an(void) 
2581                     ; 170 {
2582                     	switch	.text
2583  00dd               _but_an:
2587                     ; 171 if(n_but)
2589  00dd 3d16          	tnz	_n_but
2590  00df 2603          	jrne	L41
2591  00e1 cc01f6        	jp	L7451
2592  00e4               L41:
2593                     ; 173 	if(but==butK)
2595  00e4 b618          	ld	a,_but
2596  00e6 a1fe          	cp	a,#254
2597  00e8 2620          	jrne	L1551
2598                     ; 175 		if((mode!=mKONST)&&(main_cnt_ee))
2600  00ea 3d0c          	tnz	_mode
2601  00ec 270d          	jreq	L3551
2603  00ee ce4002        	ldw	x,_main_cnt_ee
2604  00f1 2708          	jreq	L3551
2605                     ; 177 			mode=mKONST;
2607  00f3 3f0c          	clr	_mode
2608                     ; 178 			mode_phase=mpON;
2610  00f5 3501000b      	mov	_mode_phase,#1
2612  00f9 200f          	jra	L1551
2613  00fb               L3551:
2614                     ; 182 			if((mode_phase!=mpON)&&(main_cnt_ee))mode_phase=mpON;
2616  00fb b60b          	ld	a,_mode_phase
2617  00fd a101          	cp	a,#1
2618  00ff 2709          	jreq	L1551
2620  0101 ce4002        	ldw	x,_main_cnt_ee
2621  0104 2704          	jreq	L1551
2624  0106 3501000b      	mov	_mode_phase,#1
2625  010a               L1551:
2626                     ; 186 	if(but==butK_)
2628  010a b618          	ld	a,_but
2629  010c a17e          	cp	a,#126
2630  010e 2611          	jrne	L1651
2631                     ; 188 		dark_on_cnt=100;
2633  0110 ae0064        	ldw	x,#100
2634  0113 bf1c          	ldw	_dark_on_cnt,x
2635                     ; 189 		if((mode==mKONST)&&(mode_phase==mpON))
2637  0115 3d0c          	tnz	_mode
2638  0117 2608          	jrne	L1651
2640  0119 b60b          	ld	a,_mode_phase
2641  011b a101          	cp	a,#1
2642  011d 2602          	jrne	L1651
2643                     ; 191 			mode_phase=mpOFF;
2645  011f 3f0b          	clr	_mode_phase
2646  0121               L1651:
2647                     ; 194 	if(but==butT)
2649  0121 b618          	ld	a,_but
2650  0123 a1fd          	cp	a,#253
2651  0125 265f          	jrne	L5651
2652                     ; 196 		if(mode!=mTIMER)
2654  0127 b60c          	ld	a,_mode
2655  0129 a101          	cp	a,#1
2656  012b 270d          	jreq	L7651
2657                     ; 198 			mode=mTIMER;
2659  012d 3501000c      	mov	_mode,#1
2660                     ; 199 			mode_phase=mpOFF;
2662  0131 3f0b          	clr	_mode_phase
2663                     ; 200 			timer_pause_cnt=4;
2665  0133 ae0004        	ldw	x,#4
2666  0136 bf04          	ldw	_timer_pause_cnt,x
2668  0138 204c          	jra	L5651
2669  013a               L7651:
2670                     ; 202 		else	if(mode==mTIMER)
2672  013a b60c          	ld	a,_mode
2673  013c a101          	cp	a,#1
2674  013e 2646          	jrne	L5651
2675                     ; 204 			if(timer_pause_cnt)	
2677  0140 be04          	ldw	x,_timer_pause_cnt
2678  0142 2737          	jreq	L5751
2679                     ; 206 				timer_period_ee=((timer_period_ee/20)+1)*20;
2681  0144 ce4008        	ldw	x,_timer_period_ee
2682  0147 a614          	ld	a,#20
2683  0149 cd0000        	call	c_sdivx
2685  014c 90ae0014      	ldw	y,#20
2686  0150 cd0000        	call	c_imul
2688  0153 1c0014        	addw	x,#20
2689  0156 89            	pushw	x
2690  0157 ae4008        	ldw	x,#_timer_period_ee
2691  015a cd0000        	call	c_eewrw
2693  015d 85            	popw	x
2694                     ; 207 				if(timer_period_ee>180)timer_period_ee=20;
2696  015e 9c            	rvf
2697  015f ce4008        	ldw	x,_timer_period_ee
2698  0162 a300b5        	cpw	x,#181
2699  0165 2f0b          	jrslt	L7751
2702  0167 ae0014        	ldw	x,#20
2703  016a 89            	pushw	x
2704  016b ae4008        	ldw	x,#_timer_period_ee
2705  016e cd0000        	call	c_eewrw
2707  0171 85            	popw	x
2708  0172               L7751:
2709                     ; 208 				timer_pause_cnt=4;
2711  0172 ae0004        	ldw	x,#4
2712  0175 bf04          	ldw	_timer_pause_cnt,x
2713                     ; 209 				mode_phase=mpOFF;
2715  0177 3f0b          	clr	_mode_phase
2717  0179 200b          	jra	L5651
2718  017b               L5751:
2719                     ; 212 			else if(mode_phase!=mpON)
2721  017b b60b          	ld	a,_mode_phase
2722  017d a101          	cp	a,#1
2723  017f 2705          	jreq	L5651
2724                     ; 216 				timer_pause_cnt=4;
2726  0181 ae0004        	ldw	x,#4
2727  0184 bf04          	ldw	_timer_pause_cnt,x
2728  0186               L5651:
2729                     ; 221 	if(but==butT_)
2731  0186 b618          	ld	a,_but
2732  0188 a17d          	cp	a,#125
2733  018a 2613          	jrne	L5061
2734                     ; 223 		dark_on_cnt=100;
2736  018c ae0064        	ldw	x,#100
2737  018f bf1c          	ldw	_dark_on_cnt,x
2738                     ; 224 		if((mode==mTIMER)&&(mode_phase==mpON))
2740  0191 b60c          	ld	a,_mode
2741  0193 a101          	cp	a,#1
2742  0195 2608          	jrne	L5061
2744  0197 b60b          	ld	a,_mode_phase
2745  0199 a101          	cp	a,#1
2746  019b 2602          	jrne	L5061
2747                     ; 226 			mode_phase=mpOFF;
2749  019d 3f0b          	clr	_mode_phase
2750  019f               L5061:
2751                     ; 230 	if(but==butL)
2753  019f b618          	ld	a,_but
2754  01a1 a1fb          	cp	a,#251
2755  01a3 2618          	jrne	L1161
2756                     ; 232 		if(((mode!=mLOOP)||(mode_phase==mpOFF))&&(main_cnt_ee))
2758  01a5 b60c          	ld	a,_mode
2759  01a7 a102          	cp	a,#2
2760  01a9 2604          	jrne	L5161
2762  01ab 3d0b          	tnz	_mode_phase
2763  01ad 260e          	jrne	L1161
2764  01af               L5161:
2766  01af ce4002        	ldw	x,_main_cnt_ee
2767  01b2 2709          	jreq	L1161
2768                     ; 234 			mode=mLOOP;
2770  01b4 3502000c      	mov	_mode,#2
2771                     ; 235 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2773  01b8 ae0e10        	ldw	x,#3600
2774  01bb bf02          	ldw	_loop_wrk_cnt,x
2775  01bd               L1161:
2776                     ; 238 	if(but==butL_)
2778  01bd b618          	ld	a,_but
2779  01bf a17b          	cp	a,#123
2780  01c1 2613          	jrne	L7161
2781                     ; 240 		dark_on_cnt=100;	
2783  01c3 ae0064        	ldw	x,#100
2784  01c6 bf1c          	ldw	_dark_on_cnt,x
2785                     ; 241 		if((mode==mLOOP))
2787  01c8 b60c          	ld	a,_mode
2788  01ca a102          	cp	a,#2
2789  01cc 2608          	jrne	L7161
2790                     ; 243 			mode_phase=mpOFF;
2792  01ce 3f0b          	clr	_mode_phase
2793                     ; 244 			loop_wrk_cnt=0;
2795  01d0 5f            	clrw	x
2796  01d1 bf02          	ldw	_loop_wrk_cnt,x
2797                     ; 245 			loop_pause_cnt=0;
2799  01d3 5f            	clrw	x
2800  01d4 bf00          	ldw	_loop_pause_cnt,x
2801  01d6               L7161:
2802                     ; 248 	if(but==butKTL_)
2804  01d6 b618          	ld	a,_but
2805  01d8 a178          	cp	a,#120
2806  01da 2618          	jrne	L3261
2807                     ; 250 		main_cnt_reset++;
2809  01dc 3c0d          	inc	_main_cnt_reset
2810                     ; 251 			if(main_cnt_reset>=3)
2812  01de b60d          	ld	a,_main_cnt_reset
2813  01e0 a103          	cp	a,#3
2814  01e2 2512          	jrult	L7451
2815                     ; 253 				main_cnt_ee=MAX_RESURS;
2817  01e4 ae1f40        	ldw	x,#8000
2818  01e7 89            	pushw	x
2819  01e8 ae4002        	ldw	x,#_main_cnt_ee
2820  01eb cd0000        	call	c_eewrw
2822  01ee 85            	popw	x
2823                     ; 254 				second_cnt=0;
2825  01ef 5f            	clrw	x
2826  01f0 bf08          	ldw	_second_cnt,x
2827  01f2 2002          	jra	L7451
2828  01f4               L3261:
2829                     ; 257 	else main_cnt_reset=0;
2831  01f4 3f0d          	clr	_main_cnt_reset
2832  01f6               L7451:
2833                     ; 259 n_but=0;
2835  01f6 3f16          	clr	_n_but
2836                     ; 260 }
2839  01f8 81            	ret
2874                     ; 263 void but_drv(void)
2874                     ; 264 {
2875                     	switch	.text
2876  01f9               _but_drv:
2880                     ; 266 but_n=(but_stat)|0xf8; 	
2882  01f9 b60e          	ld	a,_but_stat
2883  01fb aaf8          	or	a,#248
2884  01fd b71a          	ld	_but_n,a
2885                     ; 267 if((but_n==0xff)||(but_n!=but_s))
2887  01ff b61a          	ld	a,_but_n
2888  0201 a1ff          	cp	a,#255
2889  0203 2706          	jreq	L7461
2891  0205 b61a          	ld	a,_but_n
2892  0207 b119          	cp	a,_but_s
2893  0209 273b          	jreq	L5461
2894  020b               L7461:
2895                     ; 269  	speed=0;
2897  020b 3f11          	clr	_speed
2898                     ; 271 	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
2900  020d 9c            	rvf
2901  020e be14          	ldw	x,_but0_cnt
2902  0210 a30005        	cpw	x,#5
2903  0213 2e04          	jrsge	L3561
2905  0215 be12          	ldw	x,_but1_cnt
2906  0217 270b          	jreq	L1561
2907  0219               L3561:
2909  0219 3d17          	tnz	_l_but
2910  021b 2607          	jrne	L1561
2911                     ; 273    	n_but=1;
2913  021d 35010016      	mov	_n_but,#1
2914                     ; 274     but=(char)but_s;
2916  0221 451918        	mov	_but,_but_s
2917  0224               L1561:
2918                     ; 276  	if (but1_cnt>=but_onL_temp)
2920  0224 9c            	rvf
2921  0225 be12          	ldw	x,_but1_cnt
2922  0227 b30f          	cpw	x,_but_onL_temp
2923  0229 2f0a          	jrslt	L5561
2924                     ; 278     n_but=1;
2926  022b 35010016      	mov	_n_but,#1
2927                     ; 279 		but=((char)but_s)&0x7f;
2929  022f b619          	ld	a,_but_s
2930  0231 a47f          	and	a,#127
2931  0233 b718          	ld	_but,a
2932  0235               L5561:
2933                     ; 281 	l_but=0;
2935  0235 3f17          	clr	_l_but
2936                     ; 282 	but_onL_temp=BUT_ONL;
2938  0237 ae03e8        	ldw	x,#1000
2939  023a bf0f          	ldw	_but_onL_temp,x
2940                     ; 283 	but0_cnt=0;
2942  023c 5f            	clrw	x
2943  023d bf14          	ldw	_but0_cnt,x
2944                     ; 284 	but1_cnt=0;          
2946  023f 5f            	clrw	x
2947  0240 bf12          	ldw	_but1_cnt,x
2948                     ; 285 	goto but_drv_out;
2949  0242               L1361:
2950                     ; 308 but_drv_out: 
2950                     ; 309 but_s=but_n;
2952  0242 451a19        	mov	_but_s,_but_n
2953                     ; 311 }
2956  0245 81            	ret
2957  0246               L5461:
2958                     ; 287 if(but_n==but_s)
2960  0246 b61a          	ld	a,_but_n
2961  0248 b119          	cp	a,_but_s
2962  024a 26f6          	jrne	L1361
2963                     ; 289   but0_cnt++;
2965  024c be14          	ldw	x,_but0_cnt
2966  024e 1c0001        	addw	x,#1
2967  0251 bf14          	ldw	_but0_cnt,x
2968                     ; 290 	if(but0_cnt>=BUT_ON)
2970  0253 9c            	rvf
2971  0254 be14          	ldw	x,_but0_cnt
2972  0256 a30005        	cpw	x,#5
2973  0259 2fe7          	jrslt	L1361
2974                     ; 292 		but0_cnt=0;
2976  025b 5f            	clrw	x
2977  025c bf14          	ldw	_but0_cnt,x
2978                     ; 293 		but1_cnt++;
2980  025e be12          	ldw	x,_but1_cnt
2981  0260 1c0001        	addw	x,#1
2982  0263 bf12          	ldw	_but1_cnt,x
2983                     ; 294 		if(but1_cnt>=but_onL_temp)
2985  0265 9c            	rvf
2986  0266 be12          	ldw	x,_but1_cnt
2987  0268 b30f          	cpw	x,_but_onL_temp
2988  026a 2fd6          	jrslt	L1361
2989                     ; 296 			but=(char)(but_s&0x7f);
2991  026c b619          	ld	a,_but_s
2992  026e a47f          	and	a,#127
2993  0270 b718          	ld	_but,a
2994                     ; 297 			but1_cnt=0;
2996  0272 5f            	clrw	x
2997  0273 bf12          	ldw	_but1_cnt,x
2998                     ; 298 			n_but=1;
3000  0275 35010016      	mov	_n_but,#1
3001                     ; 299 			l_but=1;
3003  0279 35010017      	mov	_l_but,#1
3004                     ; 300 			if(speed)
3006  027d 3d11          	tnz	_speed
3007  027f 27c1          	jreq	L1361
3008                     ; 302 				but_onL_temp=but_onL_temp>>1;
3010  0281 370f          	sra	_but_onL_temp
3011  0283 3610          	rrc	_but_onL_temp+1
3012                     ; 303 				if(but_onL_temp<=2) but_onL_temp=2;
3014  0285 9c            	rvf
3015  0286 be0f          	ldw	x,_but_onL_temp
3016  0288 a30003        	cpw	x,#3
3017  028b 2eb5          	jrsge	L1361
3020  028d ae0002        	ldw	x,#2
3021  0290 bf0f          	ldw	_but_onL_temp,x
3022  0292 20ae          	jra	L1361
3066                     ; 313 void bin2bcd_int(unsigned short in) 
3066                     ; 314 {
3067                     	switch	.text
3068  0294               _bin2bcd_int:
3070  0294 89            	pushw	x
3071  0295 88            	push	a
3072       00000001      OFST:	set	1
3075                     ; 315 char i=5;
3077                     ; 317 for(i=0;i<5;i++)
3079  0296 0f01          	clr	(OFST+0,sp)
3080  0298               L3171:
3081                     ; 319 	dig[i]=in%10;
3083  0298 1e02          	ldw	x,(OFST+1,sp)
3084  029a 90ae000a      	ldw	y,#10
3085  029e 65            	divw	x,y
3086  029f 51            	exgw	x,y
3087  02a0 7b01          	ld	a,(OFST+0,sp)
3088  02a2 905f          	clrw	y
3089  02a4 9097          	ld	yl,a
3090  02a6 01            	rrwa	x,a
3091  02a7 90e728        	ld	(_dig,y),a
3092  02aa 02            	rlwa	x,a
3093                     ; 320 	in/=10;
3095  02ab 1e02          	ldw	x,(OFST+1,sp)
3096  02ad 90ae000a      	ldw	y,#10
3097  02b1 65            	divw	x,y
3098  02b2 1f02          	ldw	(OFST+1,sp),x
3099                     ; 317 for(i=0;i<5;i++)
3101  02b4 0c01          	inc	(OFST+0,sp)
3104  02b6 7b01          	ld	a,(OFST+0,sp)
3105  02b8 a105          	cp	a,#5
3106  02ba 25dc          	jrult	L3171
3107                     ; 322 }
3110  02bc 5b03          	addw	sp,#3
3111  02be 81            	ret
3148                     ; 325 void bcd2ind(void) 
3148                     ; 326 {
3149                     	switch	.text
3150  02bf               _bcd2ind:
3152  02bf 88            	push	a
3153       00000001      OFST:	set	1
3156                     ; 329 for (i=4;i>0;i--)
3158  02c0 a604          	ld	a,#4
3159  02c2 6b01          	ld	(OFST+0,sp),a
3160  02c4               L7371:
3161                     ; 331 	ind_out_[i-1]=DIGISYM[dig[i-1]];
3163  02c4 7b01          	ld	a,(OFST+0,sp)
3164  02c6 5f            	clrw	x
3165  02c7 97            	ld	xl,a
3166  02c8 5a            	decw	x
3167  02c9 7b01          	ld	a,(OFST+0,sp)
3168  02cb 905f          	clrw	y
3169  02cd 9097          	ld	yl,a
3170  02cf 905a          	decw	y
3171  02d1 90e628        	ld	a,(_dig,y)
3172  02d4 905f          	clrw	y
3173  02d6 9097          	ld	yl,a
3174  02d8 90d60000      	ld	a,(_DIGISYM,y)
3175  02dc e723          	ld	(_ind_out_,x),a
3176                     ; 329 for (i=4;i>0;i--)
3178  02de 0a01          	dec	(OFST+0,sp)
3181  02e0 0d01          	tnz	(OFST+0,sp)
3182  02e2 26e0          	jrne	L7371
3183                     ; 333 } 
3186  02e4 84            	pop	a
3187  02e5 81            	ret
3225                     ; 336 void bcd2ind_zero(void) 
3225                     ; 337 {
3226                     	switch	.text
3227  02e6               _bcd2ind_zero:
3229  02e6 88            	push	a
3230       00000001      OFST:	set	1
3233                     ; 339 zero_on=1;
3235  02e7 3501001f      	mov	_zero_on,#1
3236                     ; 340 for (i=4;i>0;i--)
3238  02eb a604          	ld	a,#4
3239  02ed 6b01          	ld	(OFST+0,sp),a
3240  02ef               L3671:
3241                     ; 342 	if(zero_on&&(!dig[i-1])&&(i-1))
3243  02ef 3d1f          	tnz	_zero_on
3244  02f1 271e          	jreq	L1771
3246  02f3 7b01          	ld	a,(OFST+0,sp)
3247  02f5 5f            	clrw	x
3248  02f6 97            	ld	xl,a
3249  02f7 5a            	decw	x
3250  02f8 6d28          	tnz	(_dig,x)
3251  02fa 2615          	jrne	L1771
3253  02fc 7b01          	ld	a,(OFST+0,sp)
3254  02fe 5f            	clrw	x
3255  02ff 97            	ld	xl,a
3256  0300 5a            	decw	x
3257  0301 a30000        	cpw	x,#0
3258  0304 270b          	jreq	L1771
3259                     ; 344 		ind_out_[i-1]=0b11111111;
3261  0306 7b01          	ld	a,(OFST+0,sp)
3262  0308 5f            	clrw	x
3263  0309 97            	ld	xl,a
3264  030a 5a            	decw	x
3265  030b a6ff          	ld	a,#255
3266  030d e723          	ld	(_ind_out_,x),a
3268  030f 201c          	jra	L3771
3269  0311               L1771:
3270                     ; 348 		ind_out_[i-1]=DIGISYM[dig[i-1]];
3272  0311 7b01          	ld	a,(OFST+0,sp)
3273  0313 5f            	clrw	x
3274  0314 97            	ld	xl,a
3275  0315 5a            	decw	x
3276  0316 7b01          	ld	a,(OFST+0,sp)
3277  0318 905f          	clrw	y
3278  031a 9097          	ld	yl,a
3279  031c 905a          	decw	y
3280  031e 90e628        	ld	a,(_dig,y)
3281  0321 905f          	clrw	y
3282  0323 9097          	ld	yl,a
3283  0325 90d60000      	ld	a,(_DIGISYM,y)
3284  0329 e723          	ld	(_ind_out_,x),a
3285                     ; 349 		zero_on=0;
3287  032b 3f1f          	clr	_zero_on
3288  032d               L3771:
3289                     ; 340 for (i=4;i>0;i--)
3291  032d 0a01          	dec	(OFST+0,sp)
3294  032f 0d01          	tnz	(OFST+0,sp)
3295  0331 26bc          	jrne	L3671
3296                     ; 352 }
3299  0333 84            	pop	a
3300  0334 81            	ret
3387                     ; 355 void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
3387                     ; 356 {
3388                     	switch	.text
3389  0335               _int2indI_slkuf:
3391  0335 89            	pushw	x
3392  0336 88            	push	a
3393       00000001      OFST:	set	1
3396                     ; 364 bin2bcd_int(in);
3398  0337 cd0294        	call	_bin2bcd_int
3400                     ; 365 if(unzero)bcd2ind_zero();
3402  033a 0d08          	tnz	(OFST+7,sp)
3403  033c 2704          	jreq	L7302
3406  033e ada6          	call	_bcd2ind_zero
3409  0340 2003          	jra	L1402
3410  0342               L7302:
3411                     ; 366 else bcd2ind();
3413  0342 cd02bf        	call	_bcd2ind
3415  0345               L1402:
3416                     ; 367 if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
3418  0345 7b09          	ld	a,(OFST+8,sp)
3419  0347 a101          	cp	a,#1
3420  0349 2604          	jrne	L7402
3422  034b 3d21          	tnz	_bFL2
3423  034d 2614          	jrne	L5402
3424  034f               L7402:
3426  034f 7b09          	ld	a,(OFST+8,sp)
3427  0351 a102          	cp	a,#2
3428  0353 2604          	jrne	L3502
3430  0355 3d21          	tnz	_bFL2
3431  0357 260a          	jrne	L5402
3432  0359               L3502:
3434  0359 7b09          	ld	a,(OFST+8,sp)
3435  035b a105          	cp	a,#5
3436  035d 2618          	jrne	L3402
3438  035f 3d22          	tnz	_bFL5
3439  0361 2714          	jreq	L3402
3440  0363               L5402:
3441                     ; 369 	for(i=0;i<len;i++) 
3443  0363 0f01          	clr	(OFST+0,sp)
3445  0365 200a          	jra	L1602
3446  0367               L5502:
3447                     ; 371 		ind_out_[i]=DIGISYM[17];
3449  0367 7b01          	ld	a,(OFST+0,sp)
3450  0369 5f            	clrw	x
3451  036a 97            	ld	xl,a
3452  036b a6ff          	ld	a,#255
3453  036d e723          	ld	(_ind_out_,x),a
3454                     ; 369 	for(i=0;i<len;i++) 
3456  036f 0c01          	inc	(OFST+0,sp)
3457  0371               L1602:
3460  0371 7b01          	ld	a,(OFST+0,sp)
3461  0373 1107          	cp	a,(OFST+6,sp)
3462  0375 25f0          	jrult	L5502
3463  0377               L3402:
3464                     ; 375 for(i=0;i<len;i++) 
3466  0377 0f01          	clr	(OFST+0,sp)
3468  0379 2016          	jra	L1702
3469  037b               L5602:
3470                     ; 377 	ind_out[start+i]=ind_out_[i];
3472  037b 7b06          	ld	a,(OFST+5,sp)
3473  037d 5f            	clrw	x
3474  037e 1b01          	add	a,(OFST+0,sp)
3475  0380 2401          	jrnc	L03
3476  0382 5c            	incw	x
3477  0383               L03:
3478  0383 02            	rlwa	x,a
3479  0384 7b01          	ld	a,(OFST+0,sp)
3480  0386 905f          	clrw	y
3481  0388 9097          	ld	yl,a
3482  038a 90e623        	ld	a,(_ind_out_,y)
3483  038d e700          	ld	(_ind_out,x),a
3484                     ; 375 for(i=0;i<len;i++) 
3486  038f 0c01          	inc	(OFST+0,sp)
3487  0391               L1702:
3490  0391 7b01          	ld	a,(OFST+0,sp)
3491  0393 1107          	cp	a,(OFST+6,sp)
3492  0395 25e4          	jrult	L5602
3493                     ; 379 }
3496  0397 5b03          	addw	sp,#3
3497  0399 81            	ret
3524                     ; 382 void led_hndl(void)
3524                     ; 383 {
3525                     	switch	.text
3526  039a               _led_hndl:
3530                     ; 384 if(mode==mKONST)
3532  039a 3d0c          	tnz	_mode
3533  039c 2618          	jrne	L5012
3534                     ; 386 	if(mode_phase==mpOFF)led_stat=0x00;
3536  039e 3d0b          	tnz	_mode_phase
3537  03a0 2604          	jrne	L7012
3540  03a2 3f1e          	clr	_led_stat
3542  03a4 204a          	jra	L7112
3543  03a6               L7012:
3544                     ; 389 		if(bFL1)led_stat=0x01;
3546  03a6 3d20          	tnz	_bFL1
3547  03a8 2706          	jreq	L3112
3550  03aa 3501001e      	mov	_led_stat,#1
3552  03ae 2040          	jra	L7112
3553  03b0               L3112:
3554                     ; 390 		else led_stat=0x01;
3556  03b0 3501001e      	mov	_led_stat,#1
3557  03b4 203a          	jra	L7112
3558  03b6               L5012:
3559                     ; 393 else if(mode==mTIMER)
3561  03b6 b60c          	ld	a,_mode
3562  03b8 a101          	cp	a,#1
3563  03ba 2618          	jrne	L1212
3564                     ; 395 	if(mode_phase==mpOFF)led_stat=0x00;
3566  03bc 3d0b          	tnz	_mode_phase
3567  03be 2604          	jrne	L3212
3570  03c0 3f1e          	clr	_led_stat
3572  03c2 202c          	jra	L7112
3573  03c4               L3212:
3574                     ; 398 		if(bFL1)led_stat=0x02;
3576  03c4 3d20          	tnz	_bFL1
3577  03c6 2706          	jreq	L7212
3580  03c8 3502001e      	mov	_led_stat,#2
3582  03cc 2022          	jra	L7112
3583  03ce               L7212:
3584                     ; 399 		else led_stat=0x02;
3586  03ce 3502001e      	mov	_led_stat,#2
3587  03d2 201c          	jra	L7112
3588  03d4               L1212:
3589                     ; 402 else if(mode==mLOOP)
3591  03d4 b60c          	ld	a,_mode
3592  03d6 a102          	cp	a,#2
3593  03d8 2616          	jrne	L7112
3594                     ; 404 	if(mode_phase==mpOFF)led_stat=0x00;
3596  03da 3d0b          	tnz	_mode_phase
3597  03dc 2604          	jrne	L7312
3600  03de 3f1e          	clr	_led_stat
3602  03e0 200e          	jra	L7112
3603  03e2               L7312:
3604                     ; 407 		if(bFL1)led_stat=0x04;
3606  03e2 3d20          	tnz	_bFL1
3607  03e4 2706          	jreq	L3412
3610  03e6 3504001e      	mov	_led_stat,#4
3612  03ea 2004          	jra	L7112
3613  03ec               L3412:
3614                     ; 408 		else led_stat=0x04;
3616  03ec 3504001e      	mov	_led_stat,#4
3617  03f0               L7112:
3618                     ; 411 }
3621  03f0 81            	ret
3653                     ; 440 void ind_hndl(void) 
3653                     ; 441 {
3654                     	switch	.text
3655  03f1               _ind_hndl:
3659                     ; 442 if((main_cnt_ee==0)&&(mode_phase==mpOFF))
3661  03f1 ce4002        	ldw	x,_main_cnt_ee
3662  03f4 2618          	jrne	L7512
3664  03f6 3d0b          	tnz	_mode_phase
3665  03f8 2614          	jrne	L7512
3666                     ; 444 	int2indI_slkuf(main_cnt_ee, 0, 4, 0, 1);	
3668  03fa 4b01          	push	#1
3669  03fc 4b00          	push	#0
3670  03fe 4b04          	push	#4
3671  0400 4b00          	push	#0
3672  0402 ce4002        	ldw	x,_main_cnt_ee
3673  0405 cd0335        	call	_int2indI_slkuf
3675  0408 5b04          	addw	sp,#4
3677  040a acdf04df      	jpf	L1612
3678  040e               L7512:
3679                     ; 446 else if(mode==mKONST)
3681  040e 3d0c          	tnz	_mode
3682  0410 262e          	jrne	L3612
3683                     ; 448 	if(mode_phase==mpON)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3685  0412 b60b          	ld	a,_mode_phase
3686  0414 a101          	cp	a,#1
3687  0416 2614          	jrne	L5612
3690  0418 4b00          	push	#0
3691  041a 4b00          	push	#0
3692  041c 4b04          	push	#4
3693  041e 4b00          	push	#0
3694  0420 ce4002        	ldw	x,_main_cnt_ee
3695  0423 cd0335        	call	_int2indI_slkuf
3697  0426 5b04          	addw	sp,#4
3699  0428 acdf04df      	jpf	L1612
3700  042c               L5612:
3701                     ; 449 	else int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3703  042c 4b00          	push	#0
3704  042e 4b00          	push	#0
3705  0430 4b04          	push	#4
3706  0432 4b00          	push	#0
3707  0434 ce4002        	ldw	x,_main_cnt_ee
3708  0437 cd0335        	call	_int2indI_slkuf
3710  043a 5b04          	addw	sp,#4
3711  043c acdf04df      	jpf	L1612
3712  0440               L3612:
3713                     ; 451 else if(mode==mTIMER)
3715  0440 b60c          	ld	a,_mode
3716  0442 a101          	cp	a,#1
3717  0444 264a          	jrne	L3712
3718                     ; 453 	if(timer_pause_cnt)int2indI_slkuf(timer_period_ee, 0, 4, 0, 0);
3720  0446 be04          	ldw	x,_timer_pause_cnt
3721  0448 2713          	jreq	L5712
3724  044a 4b00          	push	#0
3725  044c 4b00          	push	#0
3726  044e 4b04          	push	#4
3727  0450 4b00          	push	#0
3728  0452 ce4008        	ldw	x,_timer_period_ee
3729  0455 cd0335        	call	_int2indI_slkuf
3731  0458 5b04          	addw	sp,#4
3733  045a cc04df        	jra	L1612
3734  045d               L5712:
3735                     ; 454 	else if(mode_phase==mpON)int2indI_slkuf((timer_second_cnt/SEC_IN_MIN)+1, 0, 3, 0, 0);
3737  045d b60b          	ld	a,_mode_phase
3738  045f a101          	cp	a,#1
3739  0461 2617          	jrne	L1022
3742  0463 4b00          	push	#0
3743  0465 4b00          	push	#0
3744  0467 4b03          	push	#3
3745  0469 4b00          	push	#0
3746  046b be06          	ldw	x,_timer_second_cnt
3747  046d a63c          	ld	a,#60
3748  046f cd0000        	call	c_sdivx
3750  0472 5c            	incw	x
3751  0473 cd0335        	call	_int2indI_slkuf
3753  0476 5b04          	addw	sp,#4
3755  0478 2065          	jra	L1612
3756  047a               L1022:
3757                     ; 455 	else if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3759  047a 3d0b          	tnz	_mode_phase
3760  047c 2661          	jrne	L1612
3763  047e 4b00          	push	#0
3764  0480 4b00          	push	#0
3765  0482 4b04          	push	#4
3766  0484 4b00          	push	#0
3767  0486 ce4002        	ldw	x,_main_cnt_ee
3768  0489 cd0335        	call	_int2indI_slkuf
3770  048c 5b04          	addw	sp,#4
3771  048e 204f          	jra	L1612
3772  0490               L3712:
3773                     ; 462 else if(mode==mLOOP)
3775  0490 b60c          	ld	a,_mode
3776  0492 a102          	cp	a,#2
3777  0494 2649          	jrne	L1612
3778                     ; 464 	if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3780  0496 3d0b          	tnz	_mode_phase
3781  0498 2612          	jrne	L3122
3784  049a 4b00          	push	#0
3785  049c 4b00          	push	#0
3786  049e 4b04          	push	#4
3787  04a0 4b00          	push	#0
3788  04a2 ce4002        	ldw	x,_main_cnt_ee
3789  04a5 cd0335        	call	_int2indI_slkuf
3791  04a8 5b04          	addw	sp,#4
3793  04aa 2033          	jra	L1612
3794  04ac               L3122:
3795                     ; 465 	else if(mode_phase==mpON)
3797  04ac b60b          	ld	a,_mode_phase
3798  04ae a101          	cp	a,#1
3799  04b0 2617          	jrne	L7122
3800                     ; 467 		int2indI_slkuf((loop_wrk_cnt/SEC_IN_MIN)+1, 0, 4, 0, 0);	
3802  04b2 4b00          	push	#0
3803  04b4 4b00          	push	#0
3804  04b6 4b04          	push	#4
3805  04b8 4b00          	push	#0
3806  04ba be02          	ldw	x,_loop_wrk_cnt
3807  04bc a63c          	ld	a,#60
3808  04be cd0000        	call	c_sdivx
3810  04c1 5c            	incw	x
3811  04c2 cd0335        	call	_int2indI_slkuf
3813  04c5 5b04          	addw	sp,#4
3815  04c7 2016          	jra	L1612
3816  04c9               L7122:
3817                     ; 470 	else if(mode_phase==mpPAUSE)	
3819  04c9 b60b          	ld	a,_mode_phase
3820  04cb a102          	cp	a,#2
3821  04cd 2610          	jrne	L1612
3822                     ; 472 		ind_out[0]=0b00001001;
3824  04cf 35090000      	mov	_ind_out,#9
3825                     ; 473 		ind_out[1]=0b00001010;
3827  04d3 350a0001      	mov	_ind_out+1,#10
3828                     ; 474 		ind_out[2]=0b00010000;
3830  04d7 35100002      	mov	_ind_out+2,#16
3831                     ; 475 		ind_out[3]=0b10010100;
3833  04db 35940003      	mov	_ind_out+3,#148
3834  04df               L1612:
3835                     ; 481 }
3838  04df 81            	ret
3861                     ; 484 void gpio_init(void){
3862                     	switch	.text
3863  04e0               _gpio_init:
3867                     ; 485 	GPIOA->DDR|=((1<<1)|(1<<2));
3869  04e0 c65002        	ld	a,20482
3870  04e3 aa06          	or	a,#6
3871  04e5 c75002        	ld	20482,a
3872                     ; 486 	GPIOA->CR1|=((1<<1)|(1<<2));
3874  04e8 c65003        	ld	a,20483
3875  04eb aa06          	or	a,#6
3876  04ed c75003        	ld	20483,a
3877                     ; 487 	GPIOA->CR2&=~((1<<1)|(1<<2));
3879  04f0 c65004        	ld	a,20484
3880  04f3 a4f9          	and	a,#249
3881  04f5 c75004        	ld	20484,a
3882                     ; 488 	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3884  04f8 c65011        	ld	a,20497
3885  04fb aa7c          	or	a,#124
3886  04fd c75011        	ld	20497,a
3887                     ; 489 	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3889  0500 c65012        	ld	a,20498
3890  0503 a483          	and	a,#131
3891  0505 c75012        	ld	20498,a
3892                     ; 490 	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3894  0508 c65013        	ld	a,20499
3895  050b a483          	and	a,#131
3896  050d c75013        	ld	20499,a
3897                     ; 494 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3899  0510 c65008        	ld	a,20488
3900  0513 a4f0          	and	a,#240
3901  0515 c75008        	ld	20488,a
3902                     ; 495 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3904  0518 c65009        	ld	a,20489
3905  051b a4f0          	and	a,#240
3906  051d c75009        	ld	20489,a
3907                     ; 496 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
3909  0520 c65007        	ld	a,20487
3910  0523 aa0f          	or	a,#15
3911  0525 c75007        	ld	20487,a
3912                     ; 499 	GPIOC->CR1|=((1<<3));
3914  0528 7216500d      	bset	20493,#3
3915                     ; 500 	GPIOC->CR2&=~((1<<3));
3917  052c 7217500e      	bres	20494,#3
3918                     ; 501 	GPIOB->CR1|=((1<<4)|(1<<5));
3920  0530 c65008        	ld	a,20488
3921  0533 aa30          	or	a,#48
3922  0535 c75008        	ld	20488,a
3923                     ; 502 	GPIOB->CR2&=~((1<<4)|(1<<5));
3925  0538 c65009        	ld	a,20489
3926  053b a4cf          	and	a,#207
3927  053d c75009        	ld	20489,a
3928                     ; 505 	GPIOC->CR1&=~0xfe;
3930  0540 c6500d        	ld	a,20493
3931  0543 a401          	and	a,#1
3932  0545 c7500d        	ld	20493,a
3933                     ; 506 	GPIOC->CR2&=~0xfe;
3935  0548 c6500e        	ld	a,20494
3936  054b a401          	and	a,#1
3937  054d c7500e        	ld	20494,a
3938                     ; 507 	GPIOC->DDR|=0xfe;
3940  0550 c6500c        	ld	a,20492
3941  0553 aafe          	or	a,#254
3942  0555 c7500c        	ld	20492,a
3943                     ; 512 	GPIOA->DDR|=(1<<3);
3945  0558 72165002      	bset	20482,#3
3946                     ; 513 	GPIOA->CR1|=(1<<3);
3948  055c 72165003      	bset	20483,#3
3949                     ; 514 	GPIOA->CR2&=~(1<<3);
3951  0560 72175004      	bres	20484,#3
3952                     ; 517 	GPIOB->DDR&=~(1<<5);	
3954  0564 721b5007      	bres	20487,#5
3955                     ; 518 	GPIOB->CR1|=(1<<5);
3957  0568 721a5008      	bset	20488,#5
3958                     ; 519 	GPIOB->CR2&=~(1<<5);
3960  056c 721b5009      	bres	20489,#5
3961                     ; 521 	GPIOB->ODR|=0x0f;
3963  0570 c65005        	ld	a,20485
3964  0573 aa0f          	or	a,#15
3965  0575 c75005        	ld	20485,a
3966                     ; 522 }
3969  0578 81            	ret
3992                     ; 525 void t4_init(void){
3993                     	switch	.text
3994  0579               _t4_init:
3998                     ; 526 	TIM4->PSCR = 7;
4000  0579 35075347      	mov	21319,#7
4001                     ; 527 	TIM4->ARR= 123;
4003  057d 357b5348      	mov	21320,#123
4004                     ; 528 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
4006  0581 72105343      	bset	21315,#0
4007                     ; 530 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
4009  0585 35855340      	mov	21312,#133
4010                     ; 531 }	
4013  0589 81            	ret
4055                     ; 537 @far @interrupt void TIM4_UPD_Interrupt (void) 
4055                     ; 538 {
4057                     	switch	.text
4058  058a               f_TIM4_UPD_Interrupt:
4062                     ; 540 ind_cnt++;
4064  058a 3c32          	inc	_ind_cnt
4065                     ; 542 if(ind_cnt>=5)ind_cnt=0;
4067  058c b632          	ld	a,_ind_cnt
4068  058e a105          	cp	a,#5
4069  0590 2502          	jrult	L5522
4072  0592 3f32          	clr	_ind_cnt
4073  0594               L5522:
4074                     ; 544 GPIOC->ODR|=0xf0;
4076  0594 c6500a        	ld	a,20490
4077  0597 aaf0          	or	a,#240
4078  0599 c7500a        	ld	20490,a
4079                     ; 547 GPIOA->ODR|=0x06;
4081  059c c65000        	ld	a,20480
4082  059f aa06          	or	a,#6
4083  05a1 c75000        	ld	20480,a
4084                     ; 548 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
4086  05a4 b632          	ld	a,_ind_cnt
4087  05a6 5f            	clrw	x
4088  05a7 97            	ld	xl,a
4089  05a8 e600          	ld	a,(_ind_out,x)
4090  05aa 48            	sll	a
4091  05ab aaf9          	or	a,#249
4092  05ad c45000        	and	a,20480
4093  05b0 c75000        	ld	20480,a
4094                     ; 549 GPIOD->ODR|=0x7c;
4096  05b3 c6500f        	ld	a,20495
4097  05b6 aa7c          	or	a,#124
4098  05b8 c7500f        	ld	20495,a
4099                     ; 550 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
4101  05bb b632          	ld	a,_ind_cnt
4102  05bd 5f            	clrw	x
4103  05be 97            	ld	xl,a
4104  05bf e600          	ld	a,(_ind_out,x)
4105  05c1 aa83          	or	a,#131
4106  05c3 c4500f        	and	a,20495
4107  05c6 c7500f        	ld	20495,a
4108                     ; 552 if(dark_on_cnt)dark_on_cnt--;
4110  05c9 be1c          	ldw	x,_dark_on_cnt
4111  05cb 2709          	jreq	L7522
4114  05cd be1c          	ldw	x,_dark_on_cnt
4115  05cf 1d0001        	subw	x,#1
4116  05d2 bf1c          	ldw	_dark_on_cnt,x
4118  05d4 2014          	jra	L1622
4119  05d6               L7522:
4120                     ; 553 else GPIOC->ODR&=~(0x10<<ind_cnt);
4122  05d6 b632          	ld	a,_ind_cnt
4123  05d8 5f            	clrw	x
4124  05d9 97            	ld	xl,a
4125  05da a610          	ld	a,#16
4126  05dc 5d            	tnzw	x
4127  05dd 2704          	jreq	L44
4128  05df               L64:
4129  05df 48            	sll	a
4130  05e0 5a            	decw	x
4131  05e1 26fc          	jrne	L64
4132  05e3               L44:
4133  05e3 43            	cpl	a
4134  05e4 c4500a        	and	a,20490
4135  05e7 c7500a        	ld	20490,a
4136  05ea               L1622:
4137                     ; 555 if(ind_cnt==4)
4139  05ea b632          	ld	a,_ind_cnt
4140  05ec a104          	cp	a,#4
4141  05ee 2604          	jrne	L3622
4142                     ; 557 	GPIOC->ODR&=~(0x10);
4144  05f0 7219500a      	bres	20490,#4
4145  05f4               L3622:
4146                     ; 560 GPIOC->CR1|=((1<<3));
4148  05f4 7216500d      	bset	20493,#3
4149                     ; 561 GPIOC->CR2&=~((1<<3));
4151  05f8 7217500e      	bres	20494,#3
4152                     ; 562 GPIOB->CR1|=((1<<4)|(1<<5));
4154  05fc c65008        	ld	a,20488
4155  05ff aa30          	or	a,#48
4156  0601 c75008        	ld	20488,a
4157                     ; 563 GPIOB->CR2&=~((1<<4)|(1<<5));
4159  0604 c65009        	ld	a,20489
4160  0607 a4cf          	and	a,#207
4161  0609 c75009        	ld	20489,a
4162                     ; 565 if(ind_cnt==4)	
4164  060c b632          	ld	a,_ind_cnt
4165  060e a104          	cp	a,#4
4166  0610 260e          	jrne	L5622
4167                     ; 567 	GPIOC->DDR&=~(1<<3);
4169  0612 7217500c      	bres	20492,#3
4170                     ; 568 	GPIOB->DDR&=~((1<<4)|(1<<5));
4172  0616 c65007        	ld	a,20487
4173  0619 a4cf          	and	a,#207
4174  061b c75007        	ld	20487,a
4176  061e 2010          	jra	L7622
4177  0620               L5622:
4178                     ; 570 else if(ind_cnt==0)	
4180  0620 3d32          	tnz	_ind_cnt
4181  0622 260c          	jrne	L7622
4182                     ; 572 	GPIOC->DDR|=((1<<3));
4184  0624 7216500c      	bset	20492,#3
4185                     ; 573 	GPIOB->DDR|=((1<<4)|(1<<5));
4187  0628 c65007        	ld	a,20487
4188  062b aa30          	or	a,#48
4189  062d c75007        	ld	20487,a
4190  0630               L7622:
4191                     ; 582 if(ind_cnt==0)	
4193  0630 3d32          	tnz	_ind_cnt
4194  0632 2632          	jrne	L3722
4195                     ; 584 	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
4197  0634 b61e          	ld	a,_led_stat
4198  0636 a501          	bcp	a,#1
4199  0638 2706          	jreq	L5722
4202  063a 7217500a      	bres	20490,#3
4204  063e 2004          	jra	L7722
4205  0640               L5722:
4206                     ; 585 	else 			GPIOC->ODR|=(1<<3);
4208  0640 7216500a      	bset	20490,#3
4209  0644               L7722:
4210                     ; 586 	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
4212  0644 b61e          	ld	a,_led_stat
4213  0646 a502          	bcp	a,#2
4214  0648 2706          	jreq	L1032
4217  064a 72195005      	bres	20485,#4
4219  064e 2004          	jra	L3032
4220  0650               L1032:
4221                     ; 587 	else 			GPIOB->ODR|=(1<<4);
4223  0650 72185005      	bset	20485,#4
4224  0654               L3032:
4225                     ; 588 	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
4227  0654 b61e          	ld	a,_led_stat
4228  0656 a504          	bcp	a,#4
4229  0658 2706          	jreq	L5032
4232  065a 721b5005      	bres	20485,#5
4234  065e 203f          	jra	L1132
4235  0660               L5032:
4236                     ; 589 	else 			GPIOB->ODR|=(1<<5);
4238  0660 721a5005      	bset	20485,#5
4239  0664 2039          	jra	L1132
4240  0666               L3722:
4241                     ; 591 else if(ind_cnt==4)	
4243  0666 b632          	ld	a,_ind_cnt
4244  0668 a104          	cp	a,#4
4245  066a 2633          	jrne	L1132
4246                     ; 593 	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
4248  066c c6500b        	ld	a,20491
4249  066f a508          	bcp	a,#8
4250  0671 2606          	jrne	L5132
4253  0673 7211000e      	bres	_but_stat,#0
4255  0677 2004          	jra	L7132
4256  0679               L5132:
4257                     ; 594 	else but_stat|=0x01;
4259  0679 7210000e      	bset	_but_stat,#0
4260  067d               L7132:
4261                     ; 595 	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
4263  067d c65006        	ld	a,20486
4264  0680 a510          	bcp	a,#16
4265  0682 2606          	jrne	L1232
4268  0684 7213000e      	bres	_but_stat,#1
4270  0688 2004          	jra	L3232
4271  068a               L1232:
4272                     ; 596 	else but_stat|=0x02;
4274  068a 7212000e      	bset	_but_stat,#1
4275  068e               L3232:
4276                     ; 597 	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
4278  068e c65006        	ld	a,20486
4279  0691 a520          	bcp	a,#32
4280  0693 2606          	jrne	L5232
4283  0695 7215000e      	bres	_but_stat,#2
4285  0699 2004          	jra	L1132
4286  069b               L5232:
4287                     ; 598 	else but_stat|=0x04;	
4289  069b 7214000e      	bset	_but_stat,#2
4290  069f               L1132:
4291                     ; 601 b1000Hz=1;
4293  069f 35010000      	mov	_b1000Hz,#1
4294                     ; 603 if(++t0_cnt0>=10)
4296  06a3 725c0006      	inc	_t0_cnt0
4297  06a7 c60006        	ld	a,_t0_cnt0
4298  06aa a10a          	cp	a,#10
4299  06ac 2575          	jrult	L1332
4300                     ; 605 	t0_cnt0=0;
4302  06ae 725f0006      	clr	_t0_cnt0
4303                     ; 606     	b100Hz=1;
4305  06b2 35010001      	mov	_b100Hz,#1
4306                     ; 607 	if(++t0_cnt1>=10)
4308  06b6 725c0007      	inc	_t0_cnt1
4309  06ba c60007        	ld	a,_t0_cnt1
4310  06bd a10a          	cp	a,#10
4311  06bf 2508          	jrult	L3332
4312                     ; 609 		t0_cnt1=0;
4314  06c1 725f0007      	clr	_t0_cnt1
4315                     ; 610 		b10Hz=1;
4317  06c5 35010002      	mov	_b10Hz,#1
4318  06c9               L3332:
4319                     ; 613 	if(++t0_cnt2>=20)
4321  06c9 725c0008      	inc	_t0_cnt2
4322  06cd c60008        	ld	a,_t0_cnt2
4323  06d0 a114          	cp	a,#20
4324  06d2 2513          	jrult	L5332
4325                     ; 615 		t0_cnt2=0;
4327  06d4 725f0008      	clr	_t0_cnt2
4328                     ; 616 		b5Hz=1;
4330  06d8 35010003      	mov	_b5Hz,#1
4331                     ; 617 		bFL5=!bFL5;
4333  06dc 3d22          	tnz	_bFL5
4334  06de 2604          	jrne	L05
4335  06e0 a601          	ld	a,#1
4336  06e2 2001          	jra	L25
4337  06e4               L05:
4338  06e4 4f            	clr	a
4339  06e5               L25:
4340  06e5 b722          	ld	_bFL5,a
4341  06e7               L5332:
4342                     ; 620 	if(++t0_cnt3>=50)
4344  06e7 725c0009      	inc	_t0_cnt3
4345  06eb c60009        	ld	a,_t0_cnt3
4346  06ee a132          	cp	a,#50
4347  06f0 2513          	jrult	L7332
4348                     ; 622 		t0_cnt3=0;
4350  06f2 725f0009      	clr	_t0_cnt3
4351                     ; 623 		b2Hz=1;
4353  06f6 35010004      	mov	_b2Hz,#1
4354                     ; 624 		bFL2=!bFL2;		
4356  06fa 3d21          	tnz	_bFL2
4357  06fc 2604          	jrne	L45
4358  06fe a601          	ld	a,#1
4359  0700 2001          	jra	L65
4360  0702               L45:
4361  0702 4f            	clr	a
4362  0703               L65:
4363  0703 b721          	ld	_bFL2,a
4364  0705               L7332:
4365                     ; 627 	if(++t0_cnt4>=100)
4367  0705 725c000a      	inc	_t0_cnt4
4368  0709 c6000a        	ld	a,_t0_cnt4
4369  070c a164          	cp	a,#100
4370  070e 2513          	jrult	L1332
4371                     ; 629 		t0_cnt4=0;
4373  0710 725f000a      	clr	_t0_cnt4
4374                     ; 630 		b1Hz=1;
4376  0714 35010005      	mov	_b1Hz,#1
4377                     ; 631 		bFL1=!bFL1;
4379  0718 3d20          	tnz	_bFL1
4380  071a 2604          	jrne	L06
4381  071c a601          	ld	a,#1
4382  071e 2001          	jra	L26
4383  0720               L06:
4384  0720 4f            	clr	a
4385  0721               L26:
4386  0721 b720          	ld	_bFL1,a
4387  0723               L1332:
4388                     ; 637 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
4390  0723 72115344      	bres	21316,#0
4391                     ; 638 return;
4394  0727 80            	iret
4436                     ; 645 main()
4436                     ; 646 {
4438                     	switch	.text
4439  0728               _main:
4443                     ; 647 CLK->CKDIVR=0;
4445  0728 725f50c6      	clr	20678
4446                     ; 649 gpio_init();
4448  072c cd04e0        	call	_gpio_init
4450                     ; 653 FLASH_DUKR=0xae;
4452  072f 35ae5064      	mov	_FLASH_DUKR,#174
4453                     ; 654 FLASH_DUKR=0x56;	
4455  0733 35565064      	mov	_FLASH_DUKR,#86
4456                     ; 703 t4_init();
4458  0737 cd0579        	call	_t4_init
4460                     ; 704 enableInterrupts();	
4463  073a 9a            rim
4465                     ; 706 mode=mKONST;
4468  073b 3f0c          	clr	_mode
4469                     ; 707 mode_phase=mpOFF;
4471  073d 3f0b          	clr	_mode_phase
4472  073f               L3532:
4473                     ; 713 	if(b1000Hz)
4475  073f 725d0000      	tnz	_b1000Hz
4476  0743 270a          	jreq	L7532
4477                     ; 715 		b1000Hz=0;
4479  0745 725f0000      	clr	_b1000Hz
4480                     ; 716 		but_drv();
4482  0749 cd01f9        	call	_but_drv
4484                     ; 717 		but_an();
4486  074c cd00dd        	call	_but_an
4488  074f               L7532:
4489                     ; 720 	if(b100Hz)
4491  074f 725d0001      	tnz	_b100Hz
4492  0753 2707          	jreq	L1632
4493                     ; 722 		b100Hz=0;
4495  0755 725f0001      	clr	_b100Hz
4496                     ; 723 		led_hndl();	
4498  0759 cd039a        	call	_led_hndl
4500  075c               L1632:
4501                     ; 727 	if(b10Hz)
4503  075c 725d0002      	tnz	_b10Hz
4504  0760 270d          	jreq	L3632
4505                     ; 729 		b10Hz=0;
4507  0762 725f0002      	clr	_b10Hz
4508                     ; 730 		ind_hndl();	
4510  0766 cd03f1        	call	_ind_hndl
4512                     ; 731 		out_hndl();	
4514  0769 cd00a1        	call	_out_hndl
4516                     ; 732 		out_drv();
4518  076c cd00cc        	call	_out_drv
4520  076f               L3632:
4521                     ; 736 	if(b5Hz)
4523  076f 725d0003      	tnz	_b5Hz
4524  0773 2704          	jreq	L5632
4525                     ; 738 		b5Hz=0;
4527  0775 725f0003      	clr	_b5Hz
4528  0779               L5632:
4529                     ; 742 	if(b2Hz)
4531  0779 725d0004      	tnz	_b2Hz
4532  077d 2704          	jreq	L7632
4533                     ; 744 		b2Hz=0;
4535  077f 725f0004      	clr	_b2Hz
4536  0783               L7632:
4537                     ; 748 	if(b1Hz)
4539  0783 725d0005      	tnz	_b1Hz
4540  0787 27b6          	jreq	L3532
4541                     ; 750 		b1Hz=0;
4543  0789 725f0005      	clr	_b1Hz
4544                     ; 751 		led_stat=0;
4546  078d 3f1e          	clr	_led_stat
4547                     ; 752 		time_hndl();
4549  078f cd0000        	call	_time_hndl
4551  0792 20ab          	jra	L3532
5073                     	xdef	_main
5074                     	xdef	f_TIM4_UPD_Interrupt
5075                     	xdef	_t4_init
5076                     	xdef	_gpio_init
5077                     	xdef	_ind_hndl
5078                     	xdef	_led_hndl
5079                     	xdef	_int2indI_slkuf
5080                     	xdef	_bcd2ind_zero
5081                     	xdef	_bcd2ind
5082                     	xdef	_bin2bcd_int
5083                     	xdef	_but_drv
5084                     	xdef	_but_an
5085                     	xdef	_out_drv
5086                     	xdef	_out_hndl
5087                     	xdef	_time_hndl
5088                     	switch	.ubsct
5089  0000               _loop_pause_cnt:
5090  0000 0000          	ds.b	2
5091                     	xdef	_loop_pause_cnt
5092  0002               _loop_wrk_cnt:
5093  0002 0000          	ds.b	2
5094                     	xdef	_loop_wrk_cnt
5095  0004               _timer_pause_cnt:
5096  0004 0000          	ds.b	2
5097                     	xdef	_timer_pause_cnt
5098  0006               _timer_second_cnt:
5099  0006 0000          	ds.b	2
5100                     	xdef	_timer_second_cnt
5101  0008               _second_cnt:
5102  0008 0000          	ds.b	2
5103                     	xdef	_second_cnt
5104  000a               _out_state:
5105  000a 00            	ds.b	1
5106                     	xdef	_out_state
5107  000b               _mode_phase:
5108  000b 00            	ds.b	1
5109                     	xdef	_mode_phase
5110  000c               _mode:
5111  000c 00            	ds.b	1
5112                     	xdef	_mode
5113  000d               _main_cnt_reset:
5114  000d 00            	ds.b	1
5115                     	xdef	_main_cnt_reset
5116  000e               _but_stat:
5117  000e 00            	ds.b	1
5118                     	xdef	_but_stat
5119  000f               _but_onL_temp:
5120  000f 0000          	ds.b	2
5121                     	xdef	_but_onL_temp
5122  0011               _speed:
5123  0011 00            	ds.b	1
5124                     	xdef	_speed
5125  0012               _but1_cnt:
5126  0012 0000          	ds.b	2
5127                     	xdef	_but1_cnt
5128  0014               _but0_cnt:
5129  0014 0000          	ds.b	2
5130                     	xdef	_but0_cnt
5131  0016               _n_but:
5132  0016 00            	ds.b	1
5133                     	xdef	_n_but
5134  0017               _l_but:
5135  0017 00            	ds.b	1
5136                     	xdef	_l_but
5137  0018               _but:
5138  0018 00            	ds.b	1
5139                     	xdef	_but
5140  0019               _but_s:
5141  0019 00            	ds.b	1
5142                     	xdef	_but_s
5143  001a               _but_n:
5144  001a 00            	ds.b	1
5145                     	xdef	_but_n
5146  001b               _but_new:
5147  001b 00            	ds.b	1
5148                     	xdef	_but_new
5149  001c               _dark_on_cnt:
5150  001c 0000          	ds.b	2
5151                     	xdef	_dark_on_cnt
5152  001e               _led_stat:
5153  001e 00            	ds.b	1
5154                     	xdef	_led_stat
5155  001f               _zero_on:
5156  001f 00            	ds.b	1
5157                     	xdef	_zero_on
5158  0020               _bFL1:
5159  0020 00            	ds.b	1
5160                     	xdef	_bFL1
5161  0021               _bFL2:
5162  0021 00            	ds.b	1
5163                     	xdef	_bFL2
5164  0022               _bFL5:
5165  0022 00            	ds.b	1
5166                     	xdef	_bFL5
5167  0023               _ind_out_:
5168  0023 0000000000    	ds.b	5
5169                     	xdef	_ind_out_
5170  0028               _dig:
5171  0028 000000000000  	ds.b	10
5172                     	xdef	_dig
5173                     	xdef	_DIGISYM
5174                     	xdef	_ind_out
5175  0032               _ind_cnt:
5176  0032 00            	ds.b	1
5177                     	xdef	_ind_cnt
5178                     	xdef	_t0_cnt4
5179                     	xdef	_t0_cnt3
5180                     	xdef	_t0_cnt2
5181                     	xdef	_t0_cnt1
5182                     	xdef	_t0_cnt0
5183                     	xdef	_b1Hz
5184                     	xdef	_b2Hz
5185                     	xdef	_b5Hz
5186                     	xdef	_b10Hz
5187                     	xdef	_b100Hz
5188                     	xdef	_b1000Hz
5189                     	xref.b	c_x
5209                     	xref	c_eewrw
5210                     	xref	c_sdivx
5211                     	xref	c_imul
5212                     	end
