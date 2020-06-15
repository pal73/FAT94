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
2279                     ; 76 void time_hndl(void) 
2279                     ; 77 {
2281                     	switch	.text
2282  0000               _time_hndl:
2286                     ; 78 if(out_state==osON)
2288  0000 b60a          	ld	a,_out_state
2289  0002 a101          	cp	a,#1
2290  0004 2623          	jrne	L1441
2291                     ; 80 	second_cnt++;
2293  0006 be08          	ldw	x,_second_cnt
2294  0008 1c0001        	addw	x,#1
2295  000b bf08          	ldw	_second_cnt,x
2296                     ; 81 	if(second_cnt>=SEC_IN_HOUR)
2298  000d 9c            	rvf
2299  000e be08          	ldw	x,_second_cnt
2300  0010 a30014        	cpw	x,#20
2301  0013 2f14          	jrslt	L1441
2302                     ; 83 		second_cnt=0;
2304  0015 5f            	clrw	x
2305  0016 bf08          	ldw	_second_cnt,x
2306                     ; 84 		if(main_cnt_ee)
2308  0018 ce4002        	ldw	x,_main_cnt_ee
2309  001b 270c          	jreq	L1441
2310                     ; 86 			main_cnt_ee--;
2312  001d ce4002        	ldw	x,_main_cnt_ee
2313  0020 1d0001        	subw	x,#1
2314  0023 cf4002        	ldw	_main_cnt_ee,x
2315                     ; 87 			if(!main_cnt_ee)
2317  0026 ce4002        	ldw	x,_main_cnt_ee
2318  0029               L1441:
2319                     ; 94 if(timer_pause_cnt)
2321  0029 be04          	ldw	x,_timer_pause_cnt
2322  002b 2720          	jreq	L1541
2323                     ; 96 	timer_pause_cnt--;
2325  002d be04          	ldw	x,_timer_pause_cnt
2326  002f 1d0001        	subw	x,#1
2327  0032 bf04          	ldw	_timer_pause_cnt,x
2328                     ; 97 	if((timer_pause_cnt==0)&&(main_cnt_ee))
2330  0034 be04          	ldw	x,_timer_pause_cnt
2331  0036 2615          	jrne	L1541
2333  0038 ce4002        	ldw	x,_main_cnt_ee
2334  003b 2710          	jreq	L1541
2335                     ; 99 		mode_phase=mpON;
2337  003d 3501000b      	mov	_mode_phase,#1
2338                     ; 100 		timer_second_cnt=SEC_IN_MIN*timer_period_ee;
2340  0041 ce4008        	ldw	x,_timer_period_ee
2341  0044 90ae0014      	ldw	y,#20
2342  0048 cd0000        	call	c_imul
2344  004b bf06          	ldw	_timer_second_cnt,x
2345  004d               L1541:
2346                     ; 103 if(timer_second_cnt)
2348  004d be06          	ldw	x,_timer_second_cnt
2349  004f 270d          	jreq	L5541
2350                     ; 105 	timer_second_cnt--;
2352  0051 be06          	ldw	x,_timer_second_cnt
2353  0053 1d0001        	subw	x,#1
2354  0056 bf06          	ldw	_timer_second_cnt,x
2355                     ; 106 	if(timer_second_cnt==0)
2357  0058 be06          	ldw	x,_timer_second_cnt
2358  005a 2602          	jrne	L5541
2359                     ; 108 		mode_phase=mpOFF;
2361  005c 3f0b          	clr	_mode_phase
2362  005e               L5541:
2363                     ; 112 if(mode==mLOOP)
2365  005e b60c          	ld	a,_mode
2366  0060 a102          	cp	a,#2
2367  0062 2636          	jrne	L1641
2368                     ; 114 	if(loop_wrk_cnt)
2370  0064 be02          	ldw	x,_loop_wrk_cnt
2371  0066 2717          	jreq	L3641
2372                     ; 116 		loop_wrk_cnt--;
2374  0068 be02          	ldw	x,_loop_wrk_cnt
2375  006a 1d0001        	subw	x,#1
2376  006d bf02          	ldw	_loop_wrk_cnt,x
2377                     ; 117 		mode_phase=mpON;
2379  006f 3501000b      	mov	_mode_phase,#1
2380                     ; 118 		if(loop_wrk_cnt<=0)
2382  0073 9c            	rvf
2383  0074 be02          	ldw	x,_loop_wrk_cnt
2384  0076 2c28          	jrsgt	L5741
2385                     ; 120 			loop_pause_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2387  0078 ae00c8        	ldw	x,#200
2388  007b bf00          	ldw	_loop_pause_cnt,x
2389  007d 2021          	jra	L5741
2390  007f               L3641:
2391                     ; 123 	else if(loop_pause_cnt)
2393  007f be00          	ldw	x,_loop_pause_cnt
2394  0081 271d          	jreq	L5741
2395                     ; 125 		loop_pause_cnt--;
2397  0083 be00          	ldw	x,_loop_pause_cnt
2398  0085 1d0001        	subw	x,#1
2399  0088 bf00          	ldw	_loop_pause_cnt,x
2400                     ; 126 		mode_phase=mpPAUSE;
2402  008a 3502000b      	mov	_mode_phase,#2
2403                     ; 127 		if(loop_pause_cnt<=0)
2405  008e 9c            	rvf
2406  008f be00          	ldw	x,_loop_pause_cnt
2407  0091 2c0d          	jrsgt	L5741
2408                     ; 129 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2410  0093 ae00c8        	ldw	x,#200
2411  0096 bf02          	ldw	_loop_wrk_cnt,x
2412  0098 2006          	jra	L5741
2413  009a               L1641:
2414                     ; 135 	loop_wrk_cnt=0;
2416  009a 5f            	clrw	x
2417  009b bf02          	ldw	_loop_wrk_cnt,x
2418                     ; 136 	loop_pause_cnt=0;
2420  009d 5f            	clrw	x
2421  009e bf00          	ldw	_loop_pause_cnt,x
2422  00a0               L5741:
2423                     ; 138 }
2426  00a0 81            	ret
2452                     ; 141 void out_hndl(void) 
2452                     ; 142 {
2453                     	switch	.text
2454  00a1               _out_hndl:
2458                     ; 143 if( 	((mode==mKONST)&&(mode_phase==mpON)) ||
2458                     ; 144 	((mode==mTIMER)&&(mode_phase==mpON)) ||
2458                     ; 145 	((mode==mLOOP)&&(mode_phase==mpON))
2458                     ; 146 	)out_state=osON;
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
2491                     ; 147 else out_state=osOFF; 
2493  00c9 3f0a          	clr	_out_state
2494  00cb               L1251:
2495                     ; 149 }
2498  00cb 81            	ret
2522                     ; 152 void out_drv(void) 
2522                     ; 153 {
2523                     	switch	.text
2524  00cc               _out_drv:
2528                     ; 154 if(out_state==osON)
2530  00cc b60a          	ld	a,_out_state
2531  00ce a101          	cp	a,#1
2532  00d0 2606          	jrne	L3351
2533                     ; 156 	GPIOA->ODR|=(1<<3);	
2535  00d2 72165000      	bset	20480,#3
2537  00d6 2004          	jra	L5351
2538  00d8               L3351:
2539                     ; 158 else GPIOA->ODR&=~(1<<3);
2541  00d8 72175000      	bres	20480,#3
2542  00dc               L5351:
2543                     ; 159 }
2546  00dc 81            	ret
2580                     ; 162 void but_an(void) 
2580                     ; 163 {
2581                     	switch	.text
2582  00dd               _but_an:
2586                     ; 164 if(n_but)
2588  00dd 3d15          	tnz	_n_but
2589  00df 2603          	jrne	L41
2590  00e1 cc01db        	jp	L7451
2591  00e4               L41:
2592                     ; 166 	dark_on_cnt=100;
2594  00e4 ae0064        	ldw	x,#100
2595  00e7 bf1b          	ldw	_dark_on_cnt,x
2596                     ; 167 	if(but==butK)
2598  00e9 b617          	ld	a,_but
2599  00eb a1fe          	cp	a,#254
2600  00ed 2620          	jrne	L1551
2601                     ; 169 		if((mode!=mKONST)&&(main_cnt_ee))
2603  00ef 3d0c          	tnz	_mode
2604  00f1 270d          	jreq	L3551
2606  00f3 ce4002        	ldw	x,_main_cnt_ee
2607  00f6 2708          	jreq	L3551
2608                     ; 171 			mode=mKONST;
2610  00f8 3f0c          	clr	_mode
2611                     ; 172 			mode_phase=mpON;
2613  00fa 3501000b      	mov	_mode_phase,#1
2615  00fe 200f          	jra	L1551
2616  0100               L3551:
2617                     ; 176 			if((mode_phase!=mpON)&&(main_cnt_ee))mode_phase=mpON;
2619  0100 b60b          	ld	a,_mode_phase
2620  0102 a101          	cp	a,#1
2621  0104 2709          	jreq	L1551
2623  0106 ce4002        	ldw	x,_main_cnt_ee
2624  0109 2704          	jreq	L1551
2627  010b 3501000b      	mov	_mode_phase,#1
2628  010f               L1551:
2629                     ; 180 	if(but==butK_)
2631  010f b617          	ld	a,_but
2632  0111 a17e          	cp	a,#126
2633  0113 260c          	jrne	L1651
2634                     ; 182 		if((mode==mKONST)&&(mode_phase==mpON))
2636  0115 3d0c          	tnz	_mode
2637  0117 2608          	jrne	L1651
2639  0119 b60b          	ld	a,_mode_phase
2640  011b a101          	cp	a,#1
2641  011d 2602          	jrne	L1651
2642                     ; 184 			mode_phase=mpOFF;
2644  011f 3f0b          	clr	_mode_phase
2645  0121               L1651:
2646                     ; 187 	if(but==butT)
2648  0121 b617          	ld	a,_but
2649  0123 a1fd          	cp	a,#253
2650  0125 265f          	jrne	L5651
2651                     ; 189 		if(mode!=mTIMER)
2653  0127 b60c          	ld	a,_mode
2654  0129 a101          	cp	a,#1
2655  012b 270d          	jreq	L7651
2656                     ; 191 			mode=mTIMER;
2658  012d 3501000c      	mov	_mode,#1
2659                     ; 192 			mode_phase=mpOFF;
2661  0131 3f0b          	clr	_mode_phase
2662                     ; 193 			timer_pause_cnt=4;
2664  0133 ae0004        	ldw	x,#4
2665  0136 bf04          	ldw	_timer_pause_cnt,x
2667  0138 204c          	jra	L5651
2668  013a               L7651:
2669                     ; 195 		else	if(mode==mTIMER)
2671  013a b60c          	ld	a,_mode
2672  013c a101          	cp	a,#1
2673  013e 2646          	jrne	L5651
2674                     ; 197 			if(timer_pause_cnt)	
2676  0140 be04          	ldw	x,_timer_pause_cnt
2677  0142 2737          	jreq	L5751
2678                     ; 199 				timer_period_ee=((timer_period_ee/20)+1)*20;
2680  0144 ce4008        	ldw	x,_timer_period_ee
2681  0147 a614          	ld	a,#20
2682  0149 cd0000        	call	c_sdivx
2684  014c 90ae0014      	ldw	y,#20
2685  0150 cd0000        	call	c_imul
2687  0153 1c0014        	addw	x,#20
2688  0156 89            	pushw	x
2689  0157 ae4008        	ldw	x,#_timer_period_ee
2690  015a cd0000        	call	c_eewrw
2692  015d 85            	popw	x
2693                     ; 200 				if(timer_period_ee>180)timer_period_ee=20;
2695  015e 9c            	rvf
2696  015f ce4008        	ldw	x,_timer_period_ee
2697  0162 a300b5        	cpw	x,#181
2698  0165 2f0b          	jrslt	L7751
2701  0167 ae0014        	ldw	x,#20
2702  016a 89            	pushw	x
2703  016b ae4008        	ldw	x,#_timer_period_ee
2704  016e cd0000        	call	c_eewrw
2706  0171 85            	popw	x
2707  0172               L7751:
2708                     ; 201 				timer_pause_cnt=4;
2710  0172 ae0004        	ldw	x,#4
2711  0175 bf04          	ldw	_timer_pause_cnt,x
2712                     ; 202 				mode_phase=mpOFF;
2714  0177 3f0b          	clr	_mode_phase
2716  0179 200b          	jra	L5651
2717  017b               L5751:
2718                     ; 205 			else if(mode_phase!=mpON)
2720  017b b60b          	ld	a,_mode_phase
2721  017d a101          	cp	a,#1
2722  017f 2705          	jreq	L5651
2723                     ; 209 				timer_pause_cnt=4;
2725  0181 ae0004        	ldw	x,#4
2726  0184 bf04          	ldw	_timer_pause_cnt,x
2727  0186               L5651:
2728                     ; 214 	if(but==butT_)
2730  0186 b617          	ld	a,_but
2731  0188 a17d          	cp	a,#125
2732  018a 260e          	jrne	L5061
2733                     ; 216 		if((mode==mTIMER)&&(mode_phase==mpON))
2735  018c b60c          	ld	a,_mode
2736  018e a101          	cp	a,#1
2737  0190 2608          	jrne	L5061
2739  0192 b60b          	ld	a,_mode_phase
2740  0194 a101          	cp	a,#1
2741  0196 2602          	jrne	L5061
2742                     ; 218 			mode_phase=mpOFF;
2744  0198 3f0b          	clr	_mode_phase
2745  019a               L5061:
2746                     ; 222 	if(but==butL)
2748  019a b617          	ld	a,_but
2749  019c a1fb          	cp	a,#251
2750  019e 2613          	jrne	L1161
2751                     ; 224 		if((mode!=mLOOP)||(mode_phase==mpOFF))
2753  01a0 b60c          	ld	a,_mode
2754  01a2 a102          	cp	a,#2
2755  01a4 2604          	jrne	L5161
2757  01a6 3d0b          	tnz	_mode_phase
2758  01a8 2609          	jrne	L1161
2759  01aa               L5161:
2760                     ; 226 			mode=mLOOP;
2762  01aa 3502000c      	mov	_mode,#2
2763                     ; 227 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2765  01ae ae00c8        	ldw	x,#200
2766  01b1 bf02          	ldw	_loop_wrk_cnt,x
2767  01b3               L1161:
2768                     ; 230 	if(but==butL_)
2770  01b3 b617          	ld	a,_but
2771  01b5 a17b          	cp	a,#123
2772  01b7 260e          	jrne	L7161
2773                     ; 232 		if((mode==mLOOP))
2775  01b9 b60c          	ld	a,_mode
2776  01bb a102          	cp	a,#2
2777  01bd 2608          	jrne	L7161
2778                     ; 234 			mode_phase=mpOFF;
2780  01bf 3f0b          	clr	_mode_phase
2781                     ; 235 			loop_wrk_cnt=0;
2783  01c1 5f            	clrw	x
2784  01c2 bf02          	ldw	_loop_wrk_cnt,x
2785                     ; 236 			loop_pause_cnt=0;
2787  01c4 5f            	clrw	x
2788  01c5 bf00          	ldw	_loop_pause_cnt,x
2789  01c7               L7161:
2790                     ; 239 	if(but==butKTL_)
2792  01c7 b617          	ld	a,_but
2793  01c9 a178          	cp	a,#120
2794  01cb 260e          	jrne	L7451
2795                     ; 241 		main_cnt_ee=MAX_RESURS;
2797  01cd ae003c        	ldw	x,#60
2798  01d0 89            	pushw	x
2799  01d1 ae4002        	ldw	x,#_main_cnt_ee
2800  01d4 cd0000        	call	c_eewrw
2802  01d7 85            	popw	x
2803                     ; 242 		second_cnt=0;
2805  01d8 5f            	clrw	x
2806  01d9 bf08          	ldw	_second_cnt,x
2807  01db               L7451:
2808                     ; 245 n_but=0;
2810  01db 3f15          	clr	_n_but
2811                     ; 246 }
2814  01dd 81            	ret
2849                     ; 249 void but_drv(void)
2849                     ; 250 {
2850                     	switch	.text
2851  01de               _but_drv:
2855                     ; 252 but_n=(but_stat)|0xf8; 	
2857  01de b60d          	ld	a,_but_stat
2858  01e0 aaf8          	or	a,#248
2859  01e2 b719          	ld	_but_n,a
2860                     ; 253 if((but_n==0xff)||(but_n!=but_s))
2862  01e4 b619          	ld	a,_but_n
2863  01e6 a1ff          	cp	a,#255
2864  01e8 2706          	jreq	L3461
2866  01ea b619          	ld	a,_but_n
2867  01ec b118          	cp	a,_but_s
2868  01ee 273b          	jreq	L1461
2869  01f0               L3461:
2870                     ; 255  	speed=0;
2872  01f0 3f10          	clr	_speed
2873                     ; 257 	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
2875  01f2 9c            	rvf
2876  01f3 be13          	ldw	x,_but0_cnt
2877  01f5 a30005        	cpw	x,#5
2878  01f8 2e04          	jrsge	L7461
2880  01fa be11          	ldw	x,_but1_cnt
2881  01fc 270b          	jreq	L5461
2882  01fe               L7461:
2884  01fe 3d16          	tnz	_l_but
2885  0200 2607          	jrne	L5461
2886                     ; 259    	n_but=1;
2888  0202 35010015      	mov	_n_but,#1
2889                     ; 260     but=(char)but_s;
2891  0206 451817        	mov	_but,_but_s
2892  0209               L5461:
2893                     ; 262  	if (but1_cnt>=but_onL_temp)
2895  0209 9c            	rvf
2896  020a be11          	ldw	x,_but1_cnt
2897  020c b30e          	cpw	x,_but_onL_temp
2898  020e 2f0a          	jrslt	L1561
2899                     ; 264     n_but=1;
2901  0210 35010015      	mov	_n_but,#1
2902                     ; 265 		but=((char)but_s)&0x7f;
2904  0214 b618          	ld	a,_but_s
2905  0216 a47f          	and	a,#127
2906  0218 b717          	ld	_but,a
2907  021a               L1561:
2908                     ; 267 	l_but=0;
2910  021a 3f16          	clr	_l_but
2911                     ; 268 	but_onL_temp=BUT_ONL;
2913  021c ae03e8        	ldw	x,#1000
2914  021f bf0e          	ldw	_but_onL_temp,x
2915                     ; 269 	but0_cnt=0;
2917  0221 5f            	clrw	x
2918  0222 bf13          	ldw	_but0_cnt,x
2919                     ; 270 	but1_cnt=0;          
2921  0224 5f            	clrw	x
2922  0225 bf11          	ldw	_but1_cnt,x
2923                     ; 271 	goto but_drv_out;
2924  0227               L5261:
2925                     ; 294 but_drv_out: 
2925                     ; 295 but_s=but_n;
2927  0227 451918        	mov	_but_s,_but_n
2928                     ; 297 }
2931  022a 81            	ret
2932  022b               L1461:
2933                     ; 273 if(but_n==but_s)
2935  022b b619          	ld	a,_but_n
2936  022d b118          	cp	a,_but_s
2937  022f 26f6          	jrne	L5261
2938                     ; 275   but0_cnt++;
2940  0231 be13          	ldw	x,_but0_cnt
2941  0233 1c0001        	addw	x,#1
2942  0236 bf13          	ldw	_but0_cnt,x
2943                     ; 276 	if(but0_cnt>=BUT_ON)
2945  0238 9c            	rvf
2946  0239 be13          	ldw	x,_but0_cnt
2947  023b a30005        	cpw	x,#5
2948  023e 2fe7          	jrslt	L5261
2949                     ; 278 		but0_cnt=0;
2951  0240 5f            	clrw	x
2952  0241 bf13          	ldw	_but0_cnt,x
2953                     ; 279 		but1_cnt++;
2955  0243 be11          	ldw	x,_but1_cnt
2956  0245 1c0001        	addw	x,#1
2957  0248 bf11          	ldw	_but1_cnt,x
2958                     ; 280 		if(but1_cnt>=but_onL_temp)
2960  024a 9c            	rvf
2961  024b be11          	ldw	x,_but1_cnt
2962  024d b30e          	cpw	x,_but_onL_temp
2963  024f 2fd6          	jrslt	L5261
2964                     ; 282 			but=(char)(but_s&0x7f);
2966  0251 b618          	ld	a,_but_s
2967  0253 a47f          	and	a,#127
2968  0255 b717          	ld	_but,a
2969                     ; 283 			but1_cnt=0;
2971  0257 5f            	clrw	x
2972  0258 bf11          	ldw	_but1_cnt,x
2973                     ; 284 			n_but=1;
2975  025a 35010015      	mov	_n_but,#1
2976                     ; 285 			l_but=1;
2978  025e 35010016      	mov	_l_but,#1
2979                     ; 286 			if(speed)
2981  0262 3d10          	tnz	_speed
2982  0264 27c1          	jreq	L5261
2983                     ; 288 				but_onL_temp=but_onL_temp>>1;
2985  0266 370e          	sra	_but_onL_temp
2986  0268 360f          	rrc	_but_onL_temp+1
2987                     ; 289 				if(but_onL_temp<=2) but_onL_temp=2;
2989  026a 9c            	rvf
2990  026b be0e          	ldw	x,_but_onL_temp
2991  026d a30003        	cpw	x,#3
2992  0270 2eb5          	jrsge	L5261
2995  0272 ae0002        	ldw	x,#2
2996  0275 bf0e          	ldw	_but_onL_temp,x
2997  0277 20ae          	jra	L5261
3041                     ; 299 void bin2bcd_int(unsigned short in) 
3041                     ; 300 {
3042                     	switch	.text
3043  0279               _bin2bcd_int:
3045  0279 89            	pushw	x
3046  027a 88            	push	a
3047       00000001      OFST:	set	1
3050                     ; 301 char i=5;
3052                     ; 303 for(i=0;i<5;i++)
3054  027b 0f01          	clr	(OFST+0,sp)
3055  027d               L7071:
3056                     ; 305 	dig[i]=in%10;
3058  027d 1e02          	ldw	x,(OFST+1,sp)
3059  027f 90ae000a      	ldw	y,#10
3060  0283 65            	divw	x,y
3061  0284 51            	exgw	x,y
3062  0285 7b01          	ld	a,(OFST+0,sp)
3063  0287 905f          	clrw	y
3064  0289 9097          	ld	yl,a
3065  028b 01            	rrwa	x,a
3066  028c 90e727        	ld	(_dig,y),a
3067  028f 02            	rlwa	x,a
3068                     ; 306 	in/=10;
3070  0290 1e02          	ldw	x,(OFST+1,sp)
3071  0292 90ae000a      	ldw	y,#10
3072  0296 65            	divw	x,y
3073  0297 1f02          	ldw	(OFST+1,sp),x
3074                     ; 303 for(i=0;i<5;i++)
3076  0299 0c01          	inc	(OFST+0,sp)
3079  029b 7b01          	ld	a,(OFST+0,sp)
3080  029d a105          	cp	a,#5
3081  029f 25dc          	jrult	L7071
3082                     ; 308 }
3085  02a1 5b03          	addw	sp,#3
3086  02a3 81            	ret
3123                     ; 311 void bcd2ind(void) 
3123                     ; 312 {
3124                     	switch	.text
3125  02a4               _bcd2ind:
3127  02a4 88            	push	a
3128       00000001      OFST:	set	1
3131                     ; 315 for (i=4;i>0;i--)
3133  02a5 a604          	ld	a,#4
3134  02a7 6b01          	ld	(OFST+0,sp),a
3135  02a9               L3371:
3136                     ; 317 	ind_out_[i-1]=DIGISYM[dig[i-1]];
3138  02a9 7b01          	ld	a,(OFST+0,sp)
3139  02ab 5f            	clrw	x
3140  02ac 97            	ld	xl,a
3141  02ad 5a            	decw	x
3142  02ae 7b01          	ld	a,(OFST+0,sp)
3143  02b0 905f          	clrw	y
3144  02b2 9097          	ld	yl,a
3145  02b4 905a          	decw	y
3146  02b6 90e627        	ld	a,(_dig,y)
3147  02b9 905f          	clrw	y
3148  02bb 9097          	ld	yl,a
3149  02bd 90d60000      	ld	a,(_DIGISYM,y)
3150  02c1 e722          	ld	(_ind_out_,x),a
3151                     ; 315 for (i=4;i>0;i--)
3153  02c3 0a01          	dec	(OFST+0,sp)
3156  02c5 0d01          	tnz	(OFST+0,sp)
3157  02c7 26e0          	jrne	L3371
3158                     ; 319 } 
3161  02c9 84            	pop	a
3162  02ca 81            	ret
3200                     ; 322 void bcd2ind_zero(void) 
3200                     ; 323 {
3201                     	switch	.text
3202  02cb               _bcd2ind_zero:
3204  02cb 88            	push	a
3205       00000001      OFST:	set	1
3208                     ; 325 zero_on=1;
3210  02cc 3501001e      	mov	_zero_on,#1
3211                     ; 326 for (i=4;i>0;i--)
3213  02d0 a604          	ld	a,#4
3214  02d2 6b01          	ld	(OFST+0,sp),a
3215  02d4               L7571:
3216                     ; 328 	if(zero_on&&(!dig[i-1])&&(i-1))
3218  02d4 3d1e          	tnz	_zero_on
3219  02d6 271e          	jreq	L5671
3221  02d8 7b01          	ld	a,(OFST+0,sp)
3222  02da 5f            	clrw	x
3223  02db 97            	ld	xl,a
3224  02dc 5a            	decw	x
3225  02dd 6d27          	tnz	(_dig,x)
3226  02df 2615          	jrne	L5671
3228  02e1 7b01          	ld	a,(OFST+0,sp)
3229  02e3 5f            	clrw	x
3230  02e4 97            	ld	xl,a
3231  02e5 5a            	decw	x
3232  02e6 a30000        	cpw	x,#0
3233  02e9 270b          	jreq	L5671
3234                     ; 330 		ind_out_[i-1]=0b11111111;
3236  02eb 7b01          	ld	a,(OFST+0,sp)
3237  02ed 5f            	clrw	x
3238  02ee 97            	ld	xl,a
3239  02ef 5a            	decw	x
3240  02f0 a6ff          	ld	a,#255
3241  02f2 e722          	ld	(_ind_out_,x),a
3243  02f4 201c          	jra	L7671
3244  02f6               L5671:
3245                     ; 334 		ind_out_[i-1]=DIGISYM[dig[i-1]];
3247  02f6 7b01          	ld	a,(OFST+0,sp)
3248  02f8 5f            	clrw	x
3249  02f9 97            	ld	xl,a
3250  02fa 5a            	decw	x
3251  02fb 7b01          	ld	a,(OFST+0,sp)
3252  02fd 905f          	clrw	y
3253  02ff 9097          	ld	yl,a
3254  0301 905a          	decw	y
3255  0303 90e627        	ld	a,(_dig,y)
3256  0306 905f          	clrw	y
3257  0308 9097          	ld	yl,a
3258  030a 90d60000      	ld	a,(_DIGISYM,y)
3259  030e e722          	ld	(_ind_out_,x),a
3260                     ; 335 		zero_on=0;
3262  0310 3f1e          	clr	_zero_on
3263  0312               L7671:
3264                     ; 326 for (i=4;i>0;i--)
3266  0312 0a01          	dec	(OFST+0,sp)
3269  0314 0d01          	tnz	(OFST+0,sp)
3270  0316 26bc          	jrne	L7571
3271                     ; 338 }
3274  0318 84            	pop	a
3275  0319 81            	ret
3362                     ; 341 void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
3362                     ; 342 {
3363                     	switch	.text
3364  031a               _int2indI_slkuf:
3366  031a 89            	pushw	x
3367  031b 88            	push	a
3368       00000001      OFST:	set	1
3371                     ; 350 bin2bcd_int(in);
3373  031c cd0279        	call	_bin2bcd_int
3375                     ; 351 if(unzero)bcd2ind_zero();
3377  031f 0d08          	tnz	(OFST+7,sp)
3378  0321 2704          	jreq	L3302
3381  0323 ada6          	call	_bcd2ind_zero
3384  0325 2003          	jra	L5302
3385  0327               L3302:
3386                     ; 352 else bcd2ind();
3388  0327 cd02a4        	call	_bcd2ind
3390  032a               L5302:
3391                     ; 353 if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
3393  032a 7b09          	ld	a,(OFST+8,sp)
3394  032c a101          	cp	a,#1
3395  032e 2604          	jrne	L3402
3397  0330 3d20          	tnz	_bFL2
3398  0332 2614          	jrne	L1402
3399  0334               L3402:
3401  0334 7b09          	ld	a,(OFST+8,sp)
3402  0336 a102          	cp	a,#2
3403  0338 2604          	jrne	L7402
3405  033a 3d20          	tnz	_bFL2
3406  033c 260a          	jrne	L1402
3407  033e               L7402:
3409  033e 7b09          	ld	a,(OFST+8,sp)
3410  0340 a105          	cp	a,#5
3411  0342 2618          	jrne	L7302
3413  0344 3d21          	tnz	_bFL5
3414  0346 2714          	jreq	L7302
3415  0348               L1402:
3416                     ; 355 	for(i=0;i<len;i++) 
3418  0348 0f01          	clr	(OFST+0,sp)
3420  034a 200a          	jra	L5502
3421  034c               L1502:
3422                     ; 357 		ind_out_[i]=DIGISYM[17];
3424  034c 7b01          	ld	a,(OFST+0,sp)
3425  034e 5f            	clrw	x
3426  034f 97            	ld	xl,a
3427  0350 a6ff          	ld	a,#255
3428  0352 e722          	ld	(_ind_out_,x),a
3429                     ; 355 	for(i=0;i<len;i++) 
3431  0354 0c01          	inc	(OFST+0,sp)
3432  0356               L5502:
3435  0356 7b01          	ld	a,(OFST+0,sp)
3436  0358 1107          	cp	a,(OFST+6,sp)
3437  035a 25f0          	jrult	L1502
3438  035c               L7302:
3439                     ; 361 for(i=0;i<len;i++) 
3441  035c 0f01          	clr	(OFST+0,sp)
3443  035e 2016          	jra	L5602
3444  0360               L1602:
3445                     ; 363 	ind_out[start+i]=ind_out_[i];
3447  0360 7b06          	ld	a,(OFST+5,sp)
3448  0362 5f            	clrw	x
3449  0363 1b01          	add	a,(OFST+0,sp)
3450  0365 2401          	jrnc	L03
3451  0367 5c            	incw	x
3452  0368               L03:
3453  0368 02            	rlwa	x,a
3454  0369 7b01          	ld	a,(OFST+0,sp)
3455  036b 905f          	clrw	y
3456  036d 9097          	ld	yl,a
3457  036f 90e622        	ld	a,(_ind_out_,y)
3458  0372 e700          	ld	(_ind_out,x),a
3459                     ; 361 for(i=0;i<len;i++) 
3461  0374 0c01          	inc	(OFST+0,sp)
3462  0376               L5602:
3465  0376 7b01          	ld	a,(OFST+0,sp)
3466  0378 1107          	cp	a,(OFST+6,sp)
3467  037a 25e4          	jrult	L1602
3468                     ; 365 }
3471  037c 5b03          	addw	sp,#3
3472  037e 81            	ret
3499                     ; 368 void led_hndl(void)
3499                     ; 369 {
3500                     	switch	.text
3501  037f               _led_hndl:
3505                     ; 370 if(mode==mKONST)
3507  037f 3d0c          	tnz	_mode
3508  0381 2618          	jrne	L1012
3509                     ; 372 	if(mode_phase==mpOFF)led_stat=0x00;
3511  0383 3d0b          	tnz	_mode_phase
3512  0385 2604          	jrne	L3012
3515  0387 3f1d          	clr	_led_stat
3517  0389 204a          	jra	L3112
3518  038b               L3012:
3519                     ; 375 		if(bFL1)led_stat=0x01;
3521  038b 3d1f          	tnz	_bFL1
3522  038d 2706          	jreq	L7012
3525  038f 3501001d      	mov	_led_stat,#1
3527  0393 2040          	jra	L3112
3528  0395               L7012:
3529                     ; 376 		else led_stat=0x01;
3531  0395 3501001d      	mov	_led_stat,#1
3532  0399 203a          	jra	L3112
3533  039b               L1012:
3534                     ; 379 else if(mode==mTIMER)
3536  039b b60c          	ld	a,_mode
3537  039d a101          	cp	a,#1
3538  039f 2618          	jrne	L5112
3539                     ; 381 	if(mode_phase==mpOFF)led_stat=0x00;
3541  03a1 3d0b          	tnz	_mode_phase
3542  03a3 2604          	jrne	L7112
3545  03a5 3f1d          	clr	_led_stat
3547  03a7 202c          	jra	L3112
3548  03a9               L7112:
3549                     ; 384 		if(bFL1)led_stat=0x02;
3551  03a9 3d1f          	tnz	_bFL1
3552  03ab 2706          	jreq	L3212
3555  03ad 3502001d      	mov	_led_stat,#2
3557  03b1 2022          	jra	L3112
3558  03b3               L3212:
3559                     ; 385 		else led_stat=0x02;
3561  03b3 3502001d      	mov	_led_stat,#2
3562  03b7 201c          	jra	L3112
3563  03b9               L5112:
3564                     ; 388 else if(mode==mLOOP)
3566  03b9 b60c          	ld	a,_mode
3567  03bb a102          	cp	a,#2
3568  03bd 2616          	jrne	L3112
3569                     ; 390 	if(mode_phase==mpOFF)led_stat=0x00;
3571  03bf 3d0b          	tnz	_mode_phase
3572  03c1 2604          	jrne	L3312
3575  03c3 3f1d          	clr	_led_stat
3577  03c5 200e          	jra	L3112
3578  03c7               L3312:
3579                     ; 393 		if(bFL1)led_stat=0x04;
3581  03c7 3d1f          	tnz	_bFL1
3582  03c9 2706          	jreq	L7312
3585  03cb 3504001d      	mov	_led_stat,#4
3587  03cf 2004          	jra	L3112
3588  03d1               L7312:
3589                     ; 394 		else led_stat=0x04;
3591  03d1 3504001d      	mov	_led_stat,#4
3592  03d5               L3112:
3593                     ; 397 }
3596  03d5 81            	ret
3628                     ; 426 void ind_hndl(void) 
3628                     ; 427 {
3629                     	switch	.text
3630  03d6               _ind_hndl:
3634                     ; 428 if((main_cnt_ee==0)&&(mode_phase==mpOFF))
3636  03d6 ce4002        	ldw	x,_main_cnt_ee
3637  03d9 2618          	jrne	L3512
3639  03db 3d0b          	tnz	_mode_phase
3640  03dd 2614          	jrne	L3512
3641                     ; 430 	int2indI_slkuf(main_cnt_ee, 0, 4, 0, 1);	
3643  03df 4b01          	push	#1
3644  03e1 4b00          	push	#0
3645  03e3 4b04          	push	#4
3646  03e5 4b00          	push	#0
3647  03e7 ce4002        	ldw	x,_main_cnt_ee
3648  03ea cd031a        	call	_int2indI_slkuf
3650  03ed 5b04          	addw	sp,#4
3652  03ef acc404c4      	jpf	L5512
3653  03f3               L3512:
3654                     ; 432 else if(mode==mKONST)
3656  03f3 3d0c          	tnz	_mode
3657  03f5 262e          	jrne	L7512
3658                     ; 434 	if(mode_phase==mpON)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3660  03f7 b60b          	ld	a,_mode_phase
3661  03f9 a101          	cp	a,#1
3662  03fb 2614          	jrne	L1612
3665  03fd 4b00          	push	#0
3666  03ff 4b00          	push	#0
3667  0401 4b04          	push	#4
3668  0403 4b00          	push	#0
3669  0405 ce4002        	ldw	x,_main_cnt_ee
3670  0408 cd031a        	call	_int2indI_slkuf
3672  040b 5b04          	addw	sp,#4
3674  040d acc404c4      	jpf	L5512
3675  0411               L1612:
3676                     ; 435 	else int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3678  0411 4b00          	push	#0
3679  0413 4b00          	push	#0
3680  0415 4b04          	push	#4
3681  0417 4b00          	push	#0
3682  0419 ce4002        	ldw	x,_main_cnt_ee
3683  041c cd031a        	call	_int2indI_slkuf
3685  041f 5b04          	addw	sp,#4
3686  0421 acc404c4      	jpf	L5512
3687  0425               L7512:
3688                     ; 437 else if(mode==mTIMER)
3690  0425 b60c          	ld	a,_mode
3691  0427 a101          	cp	a,#1
3692  0429 264a          	jrne	L7612
3693                     ; 439 	if(timer_pause_cnt)int2indI_slkuf(timer_period_ee, 0, 4, 0, 0);
3695  042b be04          	ldw	x,_timer_pause_cnt
3696  042d 2713          	jreq	L1712
3699  042f 4b00          	push	#0
3700  0431 4b00          	push	#0
3701  0433 4b04          	push	#4
3702  0435 4b00          	push	#0
3703  0437 ce4008        	ldw	x,_timer_period_ee
3704  043a cd031a        	call	_int2indI_slkuf
3706  043d 5b04          	addw	sp,#4
3708  043f cc04c4        	jra	L5512
3709  0442               L1712:
3710                     ; 440 	else if(mode_phase==mpON)int2indI_slkuf((timer_second_cnt/SEC_IN_MIN)+1, 0, 3, 0, 0);
3712  0442 b60b          	ld	a,_mode_phase
3713  0444 a101          	cp	a,#1
3714  0446 2617          	jrne	L5712
3717  0448 4b00          	push	#0
3718  044a 4b00          	push	#0
3719  044c 4b03          	push	#3
3720  044e 4b00          	push	#0
3721  0450 be06          	ldw	x,_timer_second_cnt
3722  0452 a614          	ld	a,#20
3723  0454 cd0000        	call	c_sdivx
3725  0457 5c            	incw	x
3726  0458 cd031a        	call	_int2indI_slkuf
3728  045b 5b04          	addw	sp,#4
3730  045d 2065          	jra	L5512
3731  045f               L5712:
3732                     ; 441 	else if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3734  045f 3d0b          	tnz	_mode_phase
3735  0461 2661          	jrne	L5512
3738  0463 4b00          	push	#0
3739  0465 4b00          	push	#0
3740  0467 4b04          	push	#4
3741  0469 4b00          	push	#0
3742  046b ce4002        	ldw	x,_main_cnt_ee
3743  046e cd031a        	call	_int2indI_slkuf
3745  0471 5b04          	addw	sp,#4
3746  0473 204f          	jra	L5512
3747  0475               L7612:
3748                     ; 448 else if(mode==mLOOP)
3750  0475 b60c          	ld	a,_mode
3751  0477 a102          	cp	a,#2
3752  0479 2649          	jrne	L5512
3753                     ; 450 	if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3755  047b 3d0b          	tnz	_mode_phase
3756  047d 2612          	jrne	L7022
3759  047f 4b00          	push	#0
3760  0481 4b00          	push	#0
3761  0483 4b04          	push	#4
3762  0485 4b00          	push	#0
3763  0487 ce4002        	ldw	x,_main_cnt_ee
3764  048a cd031a        	call	_int2indI_slkuf
3766  048d 5b04          	addw	sp,#4
3768  048f 2033          	jra	L5512
3769  0491               L7022:
3770                     ; 451 	else if(mode_phase==mpON)
3772  0491 b60b          	ld	a,_mode_phase
3773  0493 a101          	cp	a,#1
3774  0495 2617          	jrne	L3122
3775                     ; 453 		int2indI_slkuf((loop_wrk_cnt/SEC_IN_MIN)+1, 0, 4, 0, 0);	
3777  0497 4b00          	push	#0
3778  0499 4b00          	push	#0
3779  049b 4b04          	push	#4
3780  049d 4b00          	push	#0
3781  049f be02          	ldw	x,_loop_wrk_cnt
3782  04a1 a614          	ld	a,#20
3783  04a3 cd0000        	call	c_sdivx
3785  04a6 5c            	incw	x
3786  04a7 cd031a        	call	_int2indI_slkuf
3788  04aa 5b04          	addw	sp,#4
3790  04ac 2016          	jra	L5512
3791  04ae               L3122:
3792                     ; 456 	else if(mode_phase==mpPAUSE)	
3794  04ae b60b          	ld	a,_mode_phase
3795  04b0 a102          	cp	a,#2
3796  04b2 2610          	jrne	L5512
3797                     ; 458 		ind_out[0]=0b00001001;
3799  04b4 35090000      	mov	_ind_out,#9
3800                     ; 459 		ind_out[1]=0b00001010;
3802  04b8 350a0001      	mov	_ind_out+1,#10
3803                     ; 460 		ind_out[2]=0b00010000;
3805  04bc 35100002      	mov	_ind_out+2,#16
3806                     ; 461 		ind_out[3]=0b10010100;
3808  04c0 35940003      	mov	_ind_out+3,#148
3809  04c4               L5512:
3810                     ; 467 }
3813  04c4 81            	ret
3836                     ; 470 void gpio_init(void){
3837                     	switch	.text
3838  04c5               _gpio_init:
3842                     ; 471 	GPIOA->DDR|=((1<<1)|(1<<2));
3844  04c5 c65002        	ld	a,20482
3845  04c8 aa06          	or	a,#6
3846  04ca c75002        	ld	20482,a
3847                     ; 472 	GPIOA->CR1|=((1<<1)|(1<<2));
3849  04cd c65003        	ld	a,20483
3850  04d0 aa06          	or	a,#6
3851  04d2 c75003        	ld	20483,a
3852                     ; 473 	GPIOA->CR2&=~((1<<1)|(1<<2));
3854  04d5 c65004        	ld	a,20484
3855  04d8 a4f9          	and	a,#249
3856  04da c75004        	ld	20484,a
3857                     ; 474 	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3859  04dd c65011        	ld	a,20497
3860  04e0 aa7c          	or	a,#124
3861  04e2 c75011        	ld	20497,a
3862                     ; 475 	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3864  04e5 c65012        	ld	a,20498
3865  04e8 a483          	and	a,#131
3866  04ea c75012        	ld	20498,a
3867                     ; 476 	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3869  04ed c65013        	ld	a,20499
3870  04f0 a483          	and	a,#131
3871  04f2 c75013        	ld	20499,a
3872                     ; 480 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3874  04f5 c65008        	ld	a,20488
3875  04f8 a4f0          	and	a,#240
3876  04fa c75008        	ld	20488,a
3877                     ; 481 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3879  04fd c65009        	ld	a,20489
3880  0500 a4f0          	and	a,#240
3881  0502 c75009        	ld	20489,a
3882                     ; 482 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
3884  0505 c65007        	ld	a,20487
3885  0508 aa0f          	or	a,#15
3886  050a c75007        	ld	20487,a
3887                     ; 485 	GPIOC->CR1|=((1<<3));
3889  050d 7216500d      	bset	20493,#3
3890                     ; 486 	GPIOC->CR2&=~((1<<3));
3892  0511 7217500e      	bres	20494,#3
3893                     ; 487 	GPIOB->CR1|=((1<<4)|(1<<5));
3895  0515 c65008        	ld	a,20488
3896  0518 aa30          	or	a,#48
3897  051a c75008        	ld	20488,a
3898                     ; 488 	GPIOB->CR2&=~((1<<4)|(1<<5));
3900  051d c65009        	ld	a,20489
3901  0520 a4cf          	and	a,#207
3902  0522 c75009        	ld	20489,a
3903                     ; 491 	GPIOC->CR1&=~0xfe;
3905  0525 c6500d        	ld	a,20493
3906  0528 a401          	and	a,#1
3907  052a c7500d        	ld	20493,a
3908                     ; 492 	GPIOC->CR2&=~0xfe;
3910  052d c6500e        	ld	a,20494
3911  0530 a401          	and	a,#1
3912  0532 c7500e        	ld	20494,a
3913                     ; 493 	GPIOC->DDR|=0xfe;
3915  0535 c6500c        	ld	a,20492
3916  0538 aafe          	or	a,#254
3917  053a c7500c        	ld	20492,a
3918                     ; 498 	GPIOA->DDR|=(1<<3);
3920  053d 72165002      	bset	20482,#3
3921                     ; 499 	GPIOA->CR1|=(1<<3);
3923  0541 72165003      	bset	20483,#3
3924                     ; 500 	GPIOA->CR2&=~(1<<3);
3926  0545 72175004      	bres	20484,#3
3927                     ; 503 	GPIOB->DDR&=~(1<<5);	
3929  0549 721b5007      	bres	20487,#5
3930                     ; 504 	GPIOB->CR1|=(1<<5);
3932  054d 721a5008      	bset	20488,#5
3933                     ; 505 	GPIOB->CR2&=~(1<<5);
3935  0551 721b5009      	bres	20489,#5
3936                     ; 507 	GPIOB->ODR|=0x0f;
3938  0555 c65005        	ld	a,20485
3939  0558 aa0f          	or	a,#15
3940  055a c75005        	ld	20485,a
3941                     ; 508 }
3944  055d 81            	ret
3967                     ; 511 void t4_init(void){
3968                     	switch	.text
3969  055e               _t4_init:
3973                     ; 512 	TIM4->PSCR = 7;
3975  055e 35075347      	mov	21319,#7
3976                     ; 513 	TIM4->ARR= 123;
3978  0562 357b5348      	mov	21320,#123
3979                     ; 514 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3981  0566 72105343      	bset	21315,#0
3982                     ; 516 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3984  056a 35855340      	mov	21312,#133
3985                     ; 517 }	
3988  056e 81            	ret
4030                     ; 523 @far @interrupt void TIM4_UPD_Interrupt (void) 
4030                     ; 524 {
4032                     	switch	.text
4033  056f               f_TIM4_UPD_Interrupt:
4037                     ; 526 ind_cnt++;
4039  056f 3c31          	inc	_ind_cnt
4040                     ; 528 if(ind_cnt>=5)ind_cnt=0;
4042  0571 b631          	ld	a,_ind_cnt
4043  0573 a105          	cp	a,#5
4044  0575 2502          	jrult	L1522
4047  0577 3f31          	clr	_ind_cnt
4048  0579               L1522:
4049                     ; 530 GPIOC->ODR|=0xf0;
4051  0579 c6500a        	ld	a,20490
4052  057c aaf0          	or	a,#240
4053  057e c7500a        	ld	20490,a
4054                     ; 533 GPIOA->ODR|=0x06;
4056  0581 c65000        	ld	a,20480
4057  0584 aa06          	or	a,#6
4058  0586 c75000        	ld	20480,a
4059                     ; 534 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
4061  0589 b631          	ld	a,_ind_cnt
4062  058b 5f            	clrw	x
4063  058c 97            	ld	xl,a
4064  058d e600          	ld	a,(_ind_out,x)
4065  058f 48            	sll	a
4066  0590 aaf9          	or	a,#249
4067  0592 c45000        	and	a,20480
4068  0595 c75000        	ld	20480,a
4069                     ; 535 GPIOD->ODR|=0x7c;
4071  0598 c6500f        	ld	a,20495
4072  059b aa7c          	or	a,#124
4073  059d c7500f        	ld	20495,a
4074                     ; 536 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
4076  05a0 b631          	ld	a,_ind_cnt
4077  05a2 5f            	clrw	x
4078  05a3 97            	ld	xl,a
4079  05a4 e600          	ld	a,(_ind_out,x)
4080  05a6 aa83          	or	a,#131
4081  05a8 c4500f        	and	a,20495
4082  05ab c7500f        	ld	20495,a
4083                     ; 538 if(dark_on_cnt)dark_on_cnt--;
4085  05ae be1b          	ldw	x,_dark_on_cnt
4086  05b0 2709          	jreq	L3522
4089  05b2 be1b          	ldw	x,_dark_on_cnt
4090  05b4 1d0001        	subw	x,#1
4091  05b7 bf1b          	ldw	_dark_on_cnt,x
4093  05b9 2014          	jra	L5522
4094  05bb               L3522:
4095                     ; 539 else GPIOC->ODR&=~(0x10<<ind_cnt);
4097  05bb b631          	ld	a,_ind_cnt
4098  05bd 5f            	clrw	x
4099  05be 97            	ld	xl,a
4100  05bf a610          	ld	a,#16
4101  05c1 5d            	tnzw	x
4102  05c2 2704          	jreq	L44
4103  05c4               L64:
4104  05c4 48            	sll	a
4105  05c5 5a            	decw	x
4106  05c6 26fc          	jrne	L64
4107  05c8               L44:
4108  05c8 43            	cpl	a
4109  05c9 c4500a        	and	a,20490
4110  05cc c7500a        	ld	20490,a
4111  05cf               L5522:
4112                     ; 541 if(ind_cnt==4)
4114  05cf b631          	ld	a,_ind_cnt
4115  05d1 a104          	cp	a,#4
4116  05d3 2604          	jrne	L7522
4117                     ; 543 	GPIOC->ODR&=~(0x10);
4119  05d5 7219500a      	bres	20490,#4
4120  05d9               L7522:
4121                     ; 546 GPIOC->CR1|=((1<<3));
4123  05d9 7216500d      	bset	20493,#3
4124                     ; 547 GPIOC->CR2&=~((1<<3));
4126  05dd 7217500e      	bres	20494,#3
4127                     ; 548 GPIOB->CR1|=((1<<4)|(1<<5));
4129  05e1 c65008        	ld	a,20488
4130  05e4 aa30          	or	a,#48
4131  05e6 c75008        	ld	20488,a
4132                     ; 549 GPIOB->CR2&=~((1<<4)|(1<<5));
4134  05e9 c65009        	ld	a,20489
4135  05ec a4cf          	and	a,#207
4136  05ee c75009        	ld	20489,a
4137                     ; 551 if(ind_cnt==4)	
4139  05f1 b631          	ld	a,_ind_cnt
4140  05f3 a104          	cp	a,#4
4141  05f5 260e          	jrne	L1622
4142                     ; 553 	GPIOC->DDR&=~(1<<3);
4144  05f7 7217500c      	bres	20492,#3
4145                     ; 554 	GPIOB->DDR&=~((1<<4)|(1<<5));
4147  05fb c65007        	ld	a,20487
4148  05fe a4cf          	and	a,#207
4149  0600 c75007        	ld	20487,a
4151  0603 2010          	jra	L3622
4152  0605               L1622:
4153                     ; 556 else if(ind_cnt==0)	
4155  0605 3d31          	tnz	_ind_cnt
4156  0607 260c          	jrne	L3622
4157                     ; 558 	GPIOC->DDR|=((1<<3));
4159  0609 7216500c      	bset	20492,#3
4160                     ; 559 	GPIOB->DDR|=((1<<4)|(1<<5));
4162  060d c65007        	ld	a,20487
4163  0610 aa30          	or	a,#48
4164  0612 c75007        	ld	20487,a
4165  0615               L3622:
4166                     ; 568 if(ind_cnt==0)	
4168  0615 3d31          	tnz	_ind_cnt
4169  0617 2632          	jrne	L7622
4170                     ; 570 	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
4172  0619 b61d          	ld	a,_led_stat
4173  061b a501          	bcp	a,#1
4174  061d 2706          	jreq	L1722
4177  061f 7217500a      	bres	20490,#3
4179  0623 2004          	jra	L3722
4180  0625               L1722:
4181                     ; 571 	else 			GPIOC->ODR|=(1<<3);
4183  0625 7216500a      	bset	20490,#3
4184  0629               L3722:
4185                     ; 572 	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
4187  0629 b61d          	ld	a,_led_stat
4188  062b a502          	bcp	a,#2
4189  062d 2706          	jreq	L5722
4192  062f 72195005      	bres	20485,#4
4194  0633 2004          	jra	L7722
4195  0635               L5722:
4196                     ; 573 	else 			GPIOB->ODR|=(1<<4);
4198  0635 72185005      	bset	20485,#4
4199  0639               L7722:
4200                     ; 574 	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
4202  0639 b61d          	ld	a,_led_stat
4203  063b a504          	bcp	a,#4
4204  063d 2706          	jreq	L1032
4207  063f 721b5005      	bres	20485,#5
4209  0643 203f          	jra	L5032
4210  0645               L1032:
4211                     ; 575 	else 			GPIOB->ODR|=(1<<5);
4213  0645 721a5005      	bset	20485,#5
4214  0649 2039          	jra	L5032
4215  064b               L7622:
4216                     ; 577 else if(ind_cnt==4)	
4218  064b b631          	ld	a,_ind_cnt
4219  064d a104          	cp	a,#4
4220  064f 2633          	jrne	L5032
4221                     ; 579 	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
4223  0651 c6500b        	ld	a,20491
4224  0654 a508          	bcp	a,#8
4225  0656 2606          	jrne	L1132
4228  0658 7211000d      	bres	_but_stat,#0
4230  065c 2004          	jra	L3132
4231  065e               L1132:
4232                     ; 580 	else but_stat|=0x01;
4234  065e 7210000d      	bset	_but_stat,#0
4235  0662               L3132:
4236                     ; 581 	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
4238  0662 c65006        	ld	a,20486
4239  0665 a510          	bcp	a,#16
4240  0667 2606          	jrne	L5132
4243  0669 7213000d      	bres	_but_stat,#1
4245  066d 2004          	jra	L7132
4246  066f               L5132:
4247                     ; 582 	else but_stat|=0x02;
4249  066f 7212000d      	bset	_but_stat,#1
4250  0673               L7132:
4251                     ; 583 	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
4253  0673 c65006        	ld	a,20486
4254  0676 a520          	bcp	a,#32
4255  0678 2606          	jrne	L1232
4258  067a 7215000d      	bres	_but_stat,#2
4260  067e 2004          	jra	L5032
4261  0680               L1232:
4262                     ; 584 	else but_stat|=0x04;	
4264  0680 7214000d      	bset	_but_stat,#2
4265  0684               L5032:
4266                     ; 587 b1000Hz=1;
4268  0684 35010000      	mov	_b1000Hz,#1
4269                     ; 589 if(++t0_cnt0>=10)
4271  0688 725c0006      	inc	_t0_cnt0
4272  068c c60006        	ld	a,_t0_cnt0
4273  068f a10a          	cp	a,#10
4274  0691 2575          	jrult	L5232
4275                     ; 591 	t0_cnt0=0;
4277  0693 725f0006      	clr	_t0_cnt0
4278                     ; 592     	b100Hz=1;
4280  0697 35010001      	mov	_b100Hz,#1
4281                     ; 593 	if(++t0_cnt1>=10)
4283  069b 725c0007      	inc	_t0_cnt1
4284  069f c60007        	ld	a,_t0_cnt1
4285  06a2 a10a          	cp	a,#10
4286  06a4 2508          	jrult	L7232
4287                     ; 595 		t0_cnt1=0;
4289  06a6 725f0007      	clr	_t0_cnt1
4290                     ; 596 		b10Hz=1;
4292  06aa 35010002      	mov	_b10Hz,#1
4293  06ae               L7232:
4294                     ; 599 	if(++t0_cnt2>=20)
4296  06ae 725c0008      	inc	_t0_cnt2
4297  06b2 c60008        	ld	a,_t0_cnt2
4298  06b5 a114          	cp	a,#20
4299  06b7 2513          	jrult	L1332
4300                     ; 601 		t0_cnt2=0;
4302  06b9 725f0008      	clr	_t0_cnt2
4303                     ; 602 		b5Hz=1;
4305  06bd 35010003      	mov	_b5Hz,#1
4306                     ; 603 		bFL5=!bFL5;
4308  06c1 3d21          	tnz	_bFL5
4309  06c3 2604          	jrne	L05
4310  06c5 a601          	ld	a,#1
4311  06c7 2001          	jra	L25
4312  06c9               L05:
4313  06c9 4f            	clr	a
4314  06ca               L25:
4315  06ca b721          	ld	_bFL5,a
4316  06cc               L1332:
4317                     ; 606 	if(++t0_cnt3>=50)
4319  06cc 725c0009      	inc	_t0_cnt3
4320  06d0 c60009        	ld	a,_t0_cnt3
4321  06d3 a132          	cp	a,#50
4322  06d5 2513          	jrult	L3332
4323                     ; 608 		t0_cnt3=0;
4325  06d7 725f0009      	clr	_t0_cnt3
4326                     ; 609 		b2Hz=1;
4328  06db 35010004      	mov	_b2Hz,#1
4329                     ; 610 		bFL2=!bFL2;		
4331  06df 3d20          	tnz	_bFL2
4332  06e1 2604          	jrne	L45
4333  06e3 a601          	ld	a,#1
4334  06e5 2001          	jra	L65
4335  06e7               L45:
4336  06e7 4f            	clr	a
4337  06e8               L65:
4338  06e8 b720          	ld	_bFL2,a
4339  06ea               L3332:
4340                     ; 613 	if(++t0_cnt4>=100)
4342  06ea 725c000a      	inc	_t0_cnt4
4343  06ee c6000a        	ld	a,_t0_cnt4
4344  06f1 a164          	cp	a,#100
4345  06f3 2513          	jrult	L5232
4346                     ; 615 		t0_cnt4=0;
4348  06f5 725f000a      	clr	_t0_cnt4
4349                     ; 616 		b1Hz=1;
4351  06f9 35010005      	mov	_b1Hz,#1
4352                     ; 617 		bFL1=!bFL1;
4354  06fd 3d1f          	tnz	_bFL1
4355  06ff 2604          	jrne	L06
4356  0701 a601          	ld	a,#1
4357  0703 2001          	jra	L26
4358  0705               L06:
4359  0705 4f            	clr	a
4360  0706               L26:
4361  0706 b71f          	ld	_bFL1,a
4362  0708               L5232:
4363                     ; 623 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
4365  0708 72115344      	bres	21316,#0
4366                     ; 624 return;
4369  070c 80            	iret
4411                     ; 631 main()
4411                     ; 632 {
4413                     	switch	.text
4414  070d               _main:
4418                     ; 633 CLK->CKDIVR=0;
4420  070d 725f50c6      	clr	20678
4421                     ; 635 gpio_init();
4423  0711 cd04c5        	call	_gpio_init
4425                     ; 639 FLASH_DUKR=0xae;
4427  0714 35ae5064      	mov	_FLASH_DUKR,#174
4428                     ; 640 FLASH_DUKR=0x56;	
4430  0718 35565064      	mov	_FLASH_DUKR,#86
4431                     ; 689 t4_init();
4433  071c cd055e        	call	_t4_init
4435                     ; 690 enableInterrupts();	
4438  071f 9a            rim
4440                     ; 692 mode=mKONST;
4443  0720 3f0c          	clr	_mode
4444                     ; 693 mode_phase=mpOFF;
4446  0722 3f0b          	clr	_mode_phase
4447  0724               L7432:
4448                     ; 699 	if(b1000Hz)
4450  0724 725d0000      	tnz	_b1000Hz
4451  0728 270a          	jreq	L3532
4452                     ; 701 		b1000Hz=0;
4454  072a 725f0000      	clr	_b1000Hz
4455                     ; 702 		but_drv();
4457  072e cd01de        	call	_but_drv
4459                     ; 703 		but_an();
4461  0731 cd00dd        	call	_but_an
4463  0734               L3532:
4464                     ; 706 	if(b100Hz)
4466  0734 725d0001      	tnz	_b100Hz
4467  0738 2707          	jreq	L5532
4468                     ; 708 		b100Hz=0;
4470  073a 725f0001      	clr	_b100Hz
4471                     ; 709 		led_hndl();	
4473  073e cd037f        	call	_led_hndl
4475  0741               L5532:
4476                     ; 713 	if(b10Hz)
4478  0741 725d0002      	tnz	_b10Hz
4479  0745 270d          	jreq	L7532
4480                     ; 715 		b10Hz=0;
4482  0747 725f0002      	clr	_b10Hz
4483                     ; 716 		ind_hndl();	
4485  074b cd03d6        	call	_ind_hndl
4487                     ; 717 		out_hndl();	
4489  074e cd00a1        	call	_out_hndl
4491                     ; 718 		out_drv();
4493  0751 cd00cc        	call	_out_drv
4495  0754               L7532:
4496                     ; 722 	if(b5Hz)
4498  0754 725d0003      	tnz	_b5Hz
4499  0758 2704          	jreq	L1632
4500                     ; 724 		b5Hz=0;
4502  075a 725f0003      	clr	_b5Hz
4503  075e               L1632:
4504                     ; 728 	if(b2Hz)
4506  075e 725d0004      	tnz	_b2Hz
4507  0762 2704          	jreq	L3632
4508                     ; 730 		b2Hz=0;
4510  0764 725f0004      	clr	_b2Hz
4511  0768               L3632:
4512                     ; 734 	if(b1Hz)
4514  0768 725d0005      	tnz	_b1Hz
4515  076c 27b6          	jreq	L7432
4516                     ; 736 		b1Hz=0;
4518  076e 725f0005      	clr	_b1Hz
4519                     ; 737 		led_stat=0;
4521  0772 3f1d          	clr	_led_stat
4522                     ; 738 		time_hndl();
4524  0774 cd0000        	call	_time_hndl
4526  0777 20ab          	jra	L7432
5039                     	xdef	_main
5040                     	xdef	f_TIM4_UPD_Interrupt
5041                     	xdef	_t4_init
5042                     	xdef	_gpio_init
5043                     	xdef	_ind_hndl
5044                     	xdef	_led_hndl
5045                     	xdef	_int2indI_slkuf
5046                     	xdef	_bcd2ind_zero
5047                     	xdef	_bcd2ind
5048                     	xdef	_bin2bcd_int
5049                     	xdef	_but_drv
5050                     	xdef	_but_an
5051                     	xdef	_out_drv
5052                     	xdef	_out_hndl
5053                     	xdef	_time_hndl
5054                     	switch	.ubsct
5055  0000               _loop_pause_cnt:
5056  0000 0000          	ds.b	2
5057                     	xdef	_loop_pause_cnt
5058  0002               _loop_wrk_cnt:
5059  0002 0000          	ds.b	2
5060                     	xdef	_loop_wrk_cnt
5061  0004               _timer_pause_cnt:
5062  0004 0000          	ds.b	2
5063                     	xdef	_timer_pause_cnt
5064  0006               _timer_second_cnt:
5065  0006 0000          	ds.b	2
5066                     	xdef	_timer_second_cnt
5067  0008               _second_cnt:
5068  0008 0000          	ds.b	2
5069                     	xdef	_second_cnt
5070  000a               _out_state:
5071  000a 00            	ds.b	1
5072                     	xdef	_out_state
5073  000b               _mode_phase:
5074  000b 00            	ds.b	1
5075                     	xdef	_mode_phase
5076  000c               _mode:
5077  000c 00            	ds.b	1
5078                     	xdef	_mode
5079  000d               _but_stat:
5080  000d 00            	ds.b	1
5081                     	xdef	_but_stat
5082  000e               _but_onL_temp:
5083  000e 0000          	ds.b	2
5084                     	xdef	_but_onL_temp
5085  0010               _speed:
5086  0010 00            	ds.b	1
5087                     	xdef	_speed
5088  0011               _but1_cnt:
5089  0011 0000          	ds.b	2
5090                     	xdef	_but1_cnt
5091  0013               _but0_cnt:
5092  0013 0000          	ds.b	2
5093                     	xdef	_but0_cnt
5094  0015               _n_but:
5095  0015 00            	ds.b	1
5096                     	xdef	_n_but
5097  0016               _l_but:
5098  0016 00            	ds.b	1
5099                     	xdef	_l_but
5100  0017               _but:
5101  0017 00            	ds.b	1
5102                     	xdef	_but
5103  0018               _but_s:
5104  0018 00            	ds.b	1
5105                     	xdef	_but_s
5106  0019               _but_n:
5107  0019 00            	ds.b	1
5108                     	xdef	_but_n
5109  001a               _but_new:
5110  001a 00            	ds.b	1
5111                     	xdef	_but_new
5112  001b               _dark_on_cnt:
5113  001b 0000          	ds.b	2
5114                     	xdef	_dark_on_cnt
5115  001d               _led_stat:
5116  001d 00            	ds.b	1
5117                     	xdef	_led_stat
5118  001e               _zero_on:
5119  001e 00            	ds.b	1
5120                     	xdef	_zero_on
5121  001f               _bFL1:
5122  001f 00            	ds.b	1
5123                     	xdef	_bFL1
5124  0020               _bFL2:
5125  0020 00            	ds.b	1
5126                     	xdef	_bFL2
5127  0021               _bFL5:
5128  0021 00            	ds.b	1
5129                     	xdef	_bFL5
5130  0022               _ind_out_:
5131  0022 0000000000    	ds.b	5
5132                     	xdef	_ind_out_
5133  0027               _dig:
5134  0027 000000000000  	ds.b	10
5135                     	xdef	_dig
5136                     	xdef	_DIGISYM
5137                     	xdef	_ind_out
5138  0031               _ind_cnt:
5139  0031 00            	ds.b	1
5140                     	xdef	_ind_cnt
5141                     	xdef	_t0_cnt4
5142                     	xdef	_t0_cnt3
5143                     	xdef	_t0_cnt2
5144                     	xdef	_t0_cnt1
5145                     	xdef	_t0_cnt0
5146                     	xdef	_b1Hz
5147                     	xdef	_b2Hz
5148                     	xdef	_b5Hz
5149                     	xdef	_b10Hz
5150                     	xdef	_b100Hz
5151                     	xdef	_b1000Hz
5152                     	xref.b	c_x
5172                     	xref	c_eewrw
5173                     	xref	c_sdivx
5174                     	xref	c_imul
5175                     	end
