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
2279                     ; 73 void time_hndl(void) 
2279                     ; 74 {
2281                     	switch	.text
2282  0000               _time_hndl:
2286                     ; 75 if(out_state==osON)
2288  0000 b60a          	ld	a,_out_state
2289  0002 a101          	cp	a,#1
2290  0004 2627          	jrne	L1441
2291                     ; 77 	second_cnt++;
2293  0006 be08          	ldw	x,_second_cnt
2294  0008 1c0001        	addw	x,#1
2295  000b bf08          	ldw	_second_cnt,x
2296                     ; 78 	if(second_cnt>=SEC_IN_HOUR)
2298  000d 9c            	rvf
2299  000e be08          	ldw	x,_second_cnt
2300  0010 a30014        	cpw	x,#20
2301  0013 2f18          	jrslt	L1441
2302                     ; 80 		second_cnt=0;
2304  0015 5f            	clrw	x
2305  0016 bf08          	ldw	_second_cnt,x
2306                     ; 81 		if(main_cnt_ee)
2308  0018 ce4002        	ldw	x,_main_cnt_ee
2309  001b 2710          	jreq	L1441
2310                     ; 83 			main_cnt_ee--;
2312  001d ce4002        	ldw	x,_main_cnt_ee
2313  0020 1d0001        	subw	x,#1
2314  0023 cf4002        	ldw	_main_cnt_ee,x
2315                     ; 84 			if(!main_cnt_ee)
2317  0026 ce4002        	ldw	x,_main_cnt_ee
2318  0029 2602          	jrne	L1441
2319                     ; 86 				mode_phase=mpOFF;
2321  002b 3f0b          	clr	_mode_phase
2322  002d               L1441:
2323                     ; 91 if(timer_pause_cnt)
2325  002d be04          	ldw	x,_timer_pause_cnt
2326  002f 2720          	jreq	L1541
2327                     ; 93 	timer_pause_cnt--;
2329  0031 be04          	ldw	x,_timer_pause_cnt
2330  0033 1d0001        	subw	x,#1
2331  0036 bf04          	ldw	_timer_pause_cnt,x
2332                     ; 94 	if((timer_pause_cnt==0)&&(main_cnt_ee))
2334  0038 be04          	ldw	x,_timer_pause_cnt
2335  003a 2615          	jrne	L1541
2337  003c ce4002        	ldw	x,_main_cnt_ee
2338  003f 2710          	jreq	L1541
2339                     ; 96 		mode_phase=mpON;
2341  0041 3501000b      	mov	_mode_phase,#1
2342                     ; 97 		timer_second_cnt=SEC_IN_MIN*timer_period_ee;
2344  0045 ce4008        	ldw	x,_timer_period_ee
2345  0048 90ae0014      	ldw	y,#20
2346  004c cd0000        	call	c_imul
2348  004f bf06          	ldw	_timer_second_cnt,x
2349  0051               L1541:
2350                     ; 100 if(timer_second_cnt)
2352  0051 be06          	ldw	x,_timer_second_cnt
2353  0053 270d          	jreq	L5541
2354                     ; 102 	timer_second_cnt--;
2356  0055 be06          	ldw	x,_timer_second_cnt
2357  0057 1d0001        	subw	x,#1
2358  005a bf06          	ldw	_timer_second_cnt,x
2359                     ; 103 	if(timer_second_cnt==0)
2361  005c be06          	ldw	x,_timer_second_cnt
2362  005e 2602          	jrne	L5541
2363                     ; 105 		mode_phase=mpOFF;
2365  0060 3f0b          	clr	_mode_phase
2366  0062               L5541:
2367                     ; 109 if(mode==mLOOP)
2369  0062 b60c          	ld	a,_mode
2370  0064 a102          	cp	a,#2
2371  0066 2620          	jrne	L1641
2372                     ; 111 	if(loop_wrk_cnt)
2374  0068 be02          	ldw	x,_loop_wrk_cnt
2375  006a 270d          	jreq	L3641
2376                     ; 113 		loop_wrk_cnt--;
2378  006c be02          	ldw	x,_loop_wrk_cnt
2379  006e 1d0001        	subw	x,#1
2380  0071 bf02          	ldw	_loop_wrk_cnt,x
2381                     ; 114 		mode_phase=mpON;
2383  0073 3501000b      	mov	_mode_phase,#1
2385  0077 2015          	jra	L1741
2386  0079               L3641:
2387                     ; 116 	else if(loop_pause_cnt)
2389  0079 be00          	ldw	x,_loop_pause_cnt
2390  007b 2711          	jreq	L1741
2391                     ; 118 		loop_pause_cnt--;
2393  007d be00          	ldw	x,_loop_pause_cnt
2394  007f 1d0001        	subw	x,#1
2395  0082 bf00          	ldw	_loop_pause_cnt,x
2396                     ; 119 		mode_phase=mpOFF;
2398  0084 3f0b          	clr	_mode_phase
2399  0086 2006          	jra	L1741
2400  0088               L1641:
2401                     ; 124 	loop_wrk_cnt=0;
2403  0088 5f            	clrw	x
2404  0089 bf02          	ldw	_loop_wrk_cnt,x
2405                     ; 125 	loop_pause_cnt=0;
2407  008b 5f            	clrw	x
2408  008c bf00          	ldw	_loop_pause_cnt,x
2409  008e               L1741:
2410                     ; 127 }
2413  008e 81            	ret
2439                     ; 130 void out_hndl(void) 
2439                     ; 131 {
2440                     	switch	.text
2441  008f               _out_hndl:
2443  008f 89            	pushw	x
2444       00000002      OFST:	set	2
2447                     ; 132 if( 	((mode==mKONST)&(mode_phase==mpON)) ||
2447                     ; 133 	((mode==mTIMER)&(mode_phase==mpON)) ||
2447                     ; 134 	((mode==mLOOP)&(mode_phase==mpON))
2447                     ; 135 	)out_state=osON;
2449  0090 b60b          	ld	a,_mode_phase
2450  0092 a101          	cp	a,#1
2451  0094 2605          	jrne	L01
2452  0096 ae0001        	ldw	x,#1
2453  0099 2001          	jra	L21
2454  009b               L01:
2455  009b 5f            	clrw	x
2456  009c               L21:
2457  009c 1f01          	ldw	(OFST-1,sp),x
2458  009e 3d0c          	tnz	_mode
2459  00a0 2605          	jrne	L41
2460  00a2 ae0001        	ldw	x,#1
2461  00a5 2001          	jra	L61
2462  00a7               L41:
2463  00a7 5f            	clrw	x
2464  00a8               L61:
2465  00a8 01            	rrwa	x,a
2466  00a9 1402          	and	a,(OFST+0,sp)
2467  00ab 01            	rrwa	x,a
2468  00ac 1401          	and	a,(OFST-1,sp)
2469  00ae 01            	rrwa	x,a
2470  00af a30000        	cpw	x,#0
2471  00b2 264c          	jrne	L5051
2473  00b4 b60b          	ld	a,_mode_phase
2474  00b6 a101          	cp	a,#1
2475  00b8 2605          	jrne	L02
2476  00ba ae0001        	ldw	x,#1
2477  00bd 2001          	jra	L22
2478  00bf               L02:
2479  00bf 5f            	clrw	x
2480  00c0               L22:
2481  00c0 1f01          	ldw	(OFST-1,sp),x
2482  00c2 b60c          	ld	a,_mode
2483  00c4 a101          	cp	a,#1
2484  00c6 2605          	jrne	L42
2485  00c8 ae0001        	ldw	x,#1
2486  00cb 2001          	jra	L62
2487  00cd               L42:
2488  00cd 5f            	clrw	x
2489  00ce               L62:
2490  00ce 01            	rrwa	x,a
2491  00cf 1402          	and	a,(OFST+0,sp)
2492  00d1 01            	rrwa	x,a
2493  00d2 1401          	and	a,(OFST-1,sp)
2494  00d4 01            	rrwa	x,a
2495  00d5 a30000        	cpw	x,#0
2496  00d8 2626          	jrne	L5051
2498  00da b60b          	ld	a,_mode_phase
2499  00dc a101          	cp	a,#1
2500  00de 2605          	jrne	L03
2501  00e0 ae0001        	ldw	x,#1
2502  00e3 2001          	jra	L23
2503  00e5               L03:
2504  00e5 5f            	clrw	x
2505  00e6               L23:
2506  00e6 1f01          	ldw	(OFST-1,sp),x
2507  00e8 b60c          	ld	a,_mode
2508  00ea a102          	cp	a,#2
2509  00ec 2605          	jrne	L43
2510  00ee ae0001        	ldw	x,#1
2511  00f1 2001          	jra	L63
2512  00f3               L43:
2513  00f3 5f            	clrw	x
2514  00f4               L63:
2515  00f4 01            	rrwa	x,a
2516  00f5 1402          	and	a,(OFST+0,sp)
2517  00f7 01            	rrwa	x,a
2518  00f8 1401          	and	a,(OFST-1,sp)
2519  00fa 01            	rrwa	x,a
2520  00fb a30000        	cpw	x,#0
2521  00fe 2706          	jreq	L3051
2522  0100               L5051:
2525  0100 3501000a      	mov	_out_state,#1
2527  0104               L1151:
2528                     ; 138 }
2531  0104 85            	popw	x
2532  0105 81            	ret
2533  0106               L3051:
2534                     ; 136 else out_state=osOFF; 
2536  0106 3f0a          	clr	_out_state
2537  0108 20fa          	jra	L1151
2560                     ; 141 void out_drv(void) 
2560                     ; 142 {
2561                     	switch	.text
2562  010a               _out_drv:
2566                     ; 144 }
2569  010a 81            	ret
2600                     ; 147 void but_an(void) 
2600                     ; 148 {
2601                     	switch	.text
2602  010b               _but_an:
2606                     ; 149 if(n_but)
2608  010b 3d15          	tnz	_n_but
2609  010d 2603          	jrne	L44
2610  010f cc01e1        	jp	L3351
2611  0112               L44:
2612                     ; 151 	if(but==butK)
2614  0112 b617          	ld	a,_but
2615  0114 a1fe          	cp	a,#254
2616  0116 2620          	jrne	L5351
2617                     ; 153 		if((mode!=mKONST)&&(main_cnt_ee))
2619  0118 3d0c          	tnz	_mode
2620  011a 270d          	jreq	L7351
2622  011c ce4002        	ldw	x,_main_cnt_ee
2623  011f 2708          	jreq	L7351
2624                     ; 155 			mode=mKONST;
2626  0121 3f0c          	clr	_mode
2627                     ; 156 			mode_phase=mpON;
2629  0123 3501000b      	mov	_mode_phase,#1
2631  0127 200f          	jra	L5351
2632  0129               L7351:
2633                     ; 160 			if((mode_phase!=mpON)&&(main_cnt_ee))mode_phase=mpON;
2635  0129 b60b          	ld	a,_mode_phase
2636  012b a101          	cp	a,#1
2637  012d 2709          	jreq	L5351
2639  012f ce4002        	ldw	x,_main_cnt_ee
2640  0132 2704          	jreq	L5351
2643  0134 3501000b      	mov	_mode_phase,#1
2644  0138               L5351:
2645                     ; 164 	if(but==butK_)
2647  0138 b617          	ld	a,_but
2648  013a a17e          	cp	a,#126
2649  013c 260c          	jrne	L5451
2650                     ; 166 		if((mode==mKONST)&&(mode_phase==mpON))
2652  013e 3d0c          	tnz	_mode
2653  0140 2608          	jrne	L5451
2655  0142 b60b          	ld	a,_mode_phase
2656  0144 a101          	cp	a,#1
2657  0146 2602          	jrne	L5451
2658                     ; 168 			mode_phase=mpOFF;
2660  0148 3f0b          	clr	_mode_phase
2661  014a               L5451:
2662                     ; 171 	if(but==butT)
2664  014a b617          	ld	a,_but
2665  014c a1fd          	cp	a,#253
2666  014e 265f          	jrne	L1551
2667                     ; 173 		if(mode!=mTIMER)
2669  0150 b60c          	ld	a,_mode
2670  0152 a101          	cp	a,#1
2671  0154 270d          	jreq	L3551
2672                     ; 175 			mode=mTIMER;
2674  0156 3501000c      	mov	_mode,#1
2675                     ; 176 			mode_phase=mpOFF;
2677  015a 3f0b          	clr	_mode_phase
2678                     ; 177 			timer_pause_cnt=4;
2680  015c ae0004        	ldw	x,#4
2681  015f bf04          	ldw	_timer_pause_cnt,x
2683  0161 204c          	jra	L1551
2684  0163               L3551:
2685                     ; 179 		else	if(mode==mTIMER)
2687  0163 b60c          	ld	a,_mode
2688  0165 a101          	cp	a,#1
2689  0167 2646          	jrne	L1551
2690                     ; 181 			if(timer_pause_cnt)	
2692  0169 be04          	ldw	x,_timer_pause_cnt
2693  016b 2737          	jreq	L1651
2694                     ; 183 				timer_period_ee=((timer_period_ee/20)+1)*20;
2696  016d ce4008        	ldw	x,_timer_period_ee
2697  0170 a614          	ld	a,#20
2698  0172 cd0000        	call	c_sdivx
2700  0175 90ae0014      	ldw	y,#20
2701  0179 cd0000        	call	c_imul
2703  017c 1c0014        	addw	x,#20
2704  017f 89            	pushw	x
2705  0180 ae4008        	ldw	x,#_timer_period_ee
2706  0183 cd0000        	call	c_eewrw
2708  0186 85            	popw	x
2709                     ; 184 				if(timer_period_ee>180)timer_period_ee=20;
2711  0187 9c            	rvf
2712  0188 ce4008        	ldw	x,_timer_period_ee
2713  018b a300b5        	cpw	x,#181
2714  018e 2f0b          	jrslt	L3651
2717  0190 ae0014        	ldw	x,#20
2718  0193 89            	pushw	x
2719  0194 ae4008        	ldw	x,#_timer_period_ee
2720  0197 cd0000        	call	c_eewrw
2722  019a 85            	popw	x
2723  019b               L3651:
2724                     ; 185 				timer_pause_cnt=4;
2726  019b ae0004        	ldw	x,#4
2727  019e bf04          	ldw	_timer_pause_cnt,x
2728                     ; 186 				mode_phase=mpOFF;
2730  01a0 3f0b          	clr	_mode_phase
2732  01a2 200b          	jra	L1551
2733  01a4               L1651:
2734                     ; 189 			else if(mode_phase!=mpON)
2736  01a4 b60b          	ld	a,_mode_phase
2737  01a6 a101          	cp	a,#1
2738  01a8 2705          	jreq	L1551
2739                     ; 193 				timer_pause_cnt=4;
2741  01aa ae0004        	ldw	x,#4
2742  01ad bf04          	ldw	_timer_pause_cnt,x
2743  01af               L1551:
2744                     ; 198 	if(but==butT_)
2746  01af b617          	ld	a,_but
2747  01b1 a17d          	cp	a,#125
2748  01b3 260e          	jrne	L1751
2749                     ; 200 		if((mode==mTIMER)&&(mode_phase==mpON))
2751  01b5 b60c          	ld	a,_mode
2752  01b7 a101          	cp	a,#1
2753  01b9 2608          	jrne	L1751
2755  01bb b60b          	ld	a,_mode_phase
2756  01bd a101          	cp	a,#1
2757  01bf 2602          	jrne	L1751
2758                     ; 202 			mode_phase=mpOFF;
2760  01c1 3f0b          	clr	_mode_phase
2761  01c3               L1751:
2762                     ; 206 	if(but==butL)
2764  01c3 b617          	ld	a,_but
2765  01c5 a1fb          	cp	a,#251
2766  01c7 2604          	jrne	L5751
2767                     ; 208 		mode=mLOOP;
2769  01c9 3502000c      	mov	_mode,#2
2770  01cd               L5751:
2771                     ; 210 	if(but==butKTL_)
2773  01cd b617          	ld	a,_but
2774  01cf a178          	cp	a,#120
2775  01d1 260e          	jrne	L3351
2776                     ; 212 		main_cnt_ee=MAX_RESURS;
2778  01d3 ae000a        	ldw	x,#10
2779  01d6 89            	pushw	x
2780  01d7 ae4002        	ldw	x,#_main_cnt_ee
2781  01da cd0000        	call	c_eewrw
2783  01dd 85            	popw	x
2784                     ; 213 		second_cnt=0;
2786  01de 5f            	clrw	x
2787  01df bf08          	ldw	_second_cnt,x
2788  01e1               L3351:
2789                     ; 216 n_but=0;
2791  01e1 3f15          	clr	_n_but
2792                     ; 217 }
2795  01e3 81            	ret
2830                     ; 220 void but_drv(void)
2830                     ; 221 {
2831                     	switch	.text
2832  01e4               _but_drv:
2836                     ; 223 but_n=(but_stat)|0xf8; 	
2838  01e4 b60d          	ld	a,_but_stat
2839  01e6 aaf8          	or	a,#248
2840  01e8 b719          	ld	_but_n,a
2841                     ; 224 if((but_n==0xff)||(but_n!=but_s))
2843  01ea b619          	ld	a,_but_n
2844  01ec a1ff          	cp	a,#255
2845  01ee 2706          	jreq	L7161
2847  01f0 b619          	ld	a,_but_n
2848  01f2 b118          	cp	a,_but_s
2849  01f4 273b          	jreq	L5161
2850  01f6               L7161:
2851                     ; 226  	speed=0;
2853  01f6 3f10          	clr	_speed
2854                     ; 228 	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
2856  01f8 9c            	rvf
2857  01f9 be13          	ldw	x,_but0_cnt
2858  01fb a30005        	cpw	x,#5
2859  01fe 2e04          	jrsge	L3261
2861  0200 be11          	ldw	x,_but1_cnt
2862  0202 270b          	jreq	L1261
2863  0204               L3261:
2865  0204 3d16          	tnz	_l_but
2866  0206 2607          	jrne	L1261
2867                     ; 230    	n_but=1;
2869  0208 35010015      	mov	_n_but,#1
2870                     ; 231     but=(char)but_s;
2872  020c 451817        	mov	_but,_but_s
2873  020f               L1261:
2874                     ; 233  	if (but1_cnt>=but_onL_temp)
2876  020f 9c            	rvf
2877  0210 be11          	ldw	x,_but1_cnt
2878  0212 b30e          	cpw	x,_but_onL_temp
2879  0214 2f0a          	jrslt	L5261
2880                     ; 235     n_but=1;
2882  0216 35010015      	mov	_n_but,#1
2883                     ; 236 		but=((char)but_s)&0x7f;
2885  021a b618          	ld	a,_but_s
2886  021c a47f          	and	a,#127
2887  021e b717          	ld	_but,a
2888  0220               L5261:
2889                     ; 238 	l_but=0;
2891  0220 3f16          	clr	_l_but
2892                     ; 239 	but_onL_temp=BUT_ONL;
2894  0222 ae03e8        	ldw	x,#1000
2895  0225 bf0e          	ldw	_but_onL_temp,x
2896                     ; 240 	but0_cnt=0;
2898  0227 5f            	clrw	x
2899  0228 bf13          	ldw	_but0_cnt,x
2900                     ; 241 	but1_cnt=0;          
2902  022a 5f            	clrw	x
2903  022b bf11          	ldw	_but1_cnt,x
2904                     ; 242 	goto but_drv_out;
2905  022d               L1061:
2906                     ; 265 but_drv_out: 
2906                     ; 266 but_s=but_n;
2908  022d 451918        	mov	_but_s,_but_n
2909                     ; 268 }
2912  0230 81            	ret
2913  0231               L5161:
2914                     ; 244 if(but_n==but_s)
2916  0231 b619          	ld	a,_but_n
2917  0233 b118          	cp	a,_but_s
2918  0235 26f6          	jrne	L1061
2919                     ; 246   but0_cnt++;
2921  0237 be13          	ldw	x,_but0_cnt
2922  0239 1c0001        	addw	x,#1
2923  023c bf13          	ldw	_but0_cnt,x
2924                     ; 247 	if(but0_cnt>=BUT_ON)
2926  023e 9c            	rvf
2927  023f be13          	ldw	x,_but0_cnt
2928  0241 a30005        	cpw	x,#5
2929  0244 2fe7          	jrslt	L1061
2930                     ; 249 		but0_cnt=0;
2932  0246 5f            	clrw	x
2933  0247 bf13          	ldw	_but0_cnt,x
2934                     ; 250 		but1_cnt++;
2936  0249 be11          	ldw	x,_but1_cnt
2937  024b 1c0001        	addw	x,#1
2938  024e bf11          	ldw	_but1_cnt,x
2939                     ; 251 		if(but1_cnt>=but_onL_temp)
2941  0250 9c            	rvf
2942  0251 be11          	ldw	x,_but1_cnt
2943  0253 b30e          	cpw	x,_but_onL_temp
2944  0255 2fd6          	jrslt	L1061
2945                     ; 253 			but=(char)(but_s&0x7f);
2947  0257 b618          	ld	a,_but_s
2948  0259 a47f          	and	a,#127
2949  025b b717          	ld	_but,a
2950                     ; 254 			but1_cnt=0;
2952  025d 5f            	clrw	x
2953  025e bf11          	ldw	_but1_cnt,x
2954                     ; 255 			n_but=1;
2956  0260 35010015      	mov	_n_but,#1
2957                     ; 256 			l_but=1;
2959  0264 35010016      	mov	_l_but,#1
2960                     ; 257 			if(speed)
2962  0268 3d10          	tnz	_speed
2963  026a 27c1          	jreq	L1061
2964                     ; 259 				but_onL_temp=but_onL_temp>>1;
2966  026c 370e          	sra	_but_onL_temp
2967  026e 360f          	rrc	_but_onL_temp+1
2968                     ; 260 				if(but_onL_temp<=2) but_onL_temp=2;
2970  0270 9c            	rvf
2971  0271 be0e          	ldw	x,_but_onL_temp
2972  0273 a30003        	cpw	x,#3
2973  0276 2eb5          	jrsge	L1061
2976  0278 ae0002        	ldw	x,#2
2977  027b bf0e          	ldw	_but_onL_temp,x
2978  027d 20ae          	jra	L1061
3022                     ; 270 void bin2bcd_int(unsigned short in) 
3022                     ; 271 {
3023                     	switch	.text
3024  027f               _bin2bcd_int:
3026  027f 89            	pushw	x
3027  0280 88            	push	a
3028       00000001      OFST:	set	1
3031                     ; 272 char i=5;
3033                     ; 274 for(i=0;i<5;i++)
3035  0281 0f01          	clr	(OFST+0,sp)
3036  0283               L3661:
3037                     ; 276 	dig[i]=in%10;
3039  0283 1e02          	ldw	x,(OFST+1,sp)
3040  0285 90ae000a      	ldw	y,#10
3041  0289 65            	divw	x,y
3042  028a 51            	exgw	x,y
3043  028b 7b01          	ld	a,(OFST+0,sp)
3044  028d 905f          	clrw	y
3045  028f 9097          	ld	yl,a
3046  0291 01            	rrwa	x,a
3047  0292 90e725        	ld	(_dig,y),a
3048  0295 02            	rlwa	x,a
3049                     ; 277 	in/=10;
3051  0296 1e02          	ldw	x,(OFST+1,sp)
3052  0298 90ae000a      	ldw	y,#10
3053  029c 65            	divw	x,y
3054  029d 1f02          	ldw	(OFST+1,sp),x
3055                     ; 274 for(i=0;i<5;i++)
3057  029f 0c01          	inc	(OFST+0,sp)
3060  02a1 7b01          	ld	a,(OFST+0,sp)
3061  02a3 a105          	cp	a,#5
3062  02a5 25dc          	jrult	L3661
3063                     ; 279 }
3066  02a7 5b03          	addw	sp,#3
3067  02a9 81            	ret
3104                     ; 282 void bcd2ind(void) 
3104                     ; 283 {
3105                     	switch	.text
3106  02aa               _bcd2ind:
3108  02aa 88            	push	a
3109       00000001      OFST:	set	1
3112                     ; 286 for (i=4;i>0;i--)
3114  02ab a604          	ld	a,#4
3115  02ad 6b01          	ld	(OFST+0,sp),a
3116  02af               L7071:
3117                     ; 288 	ind_out_[i-1]=DIGISYM[dig[i-1]];
3119  02af 7b01          	ld	a,(OFST+0,sp)
3120  02b1 5f            	clrw	x
3121  02b2 97            	ld	xl,a
3122  02b3 5a            	decw	x
3123  02b4 7b01          	ld	a,(OFST+0,sp)
3124  02b6 905f          	clrw	y
3125  02b8 9097          	ld	yl,a
3126  02ba 905a          	decw	y
3127  02bc 90e625        	ld	a,(_dig,y)
3128  02bf 905f          	clrw	y
3129  02c1 9097          	ld	yl,a
3130  02c3 90d60000      	ld	a,(_DIGISYM,y)
3131  02c7 e720          	ld	(_ind_out_,x),a
3132                     ; 286 for (i=4;i>0;i--)
3134  02c9 0a01          	dec	(OFST+0,sp)
3137  02cb 0d01          	tnz	(OFST+0,sp)
3138  02cd 26e0          	jrne	L7071
3139                     ; 290 } 
3142  02cf 84            	pop	a
3143  02d0 81            	ret
3181                     ; 293 void bcd2ind_zero(void) 
3181                     ; 294 {
3182                     	switch	.text
3183  02d1               _bcd2ind_zero:
3185  02d1 88            	push	a
3186       00000001      OFST:	set	1
3189                     ; 296 zero_on=1;
3191  02d2 3501001c      	mov	_zero_on,#1
3192                     ; 297 for (i=4;i>0;i--)
3194  02d6 a604          	ld	a,#4
3195  02d8 6b01          	ld	(OFST+0,sp),a
3196  02da               L3371:
3197                     ; 299 	if(zero_on&&(!dig[i-1])&&(i-1))
3199  02da 3d1c          	tnz	_zero_on
3200  02dc 271e          	jreq	L1471
3202  02de 7b01          	ld	a,(OFST+0,sp)
3203  02e0 5f            	clrw	x
3204  02e1 97            	ld	xl,a
3205  02e2 5a            	decw	x
3206  02e3 6d25          	tnz	(_dig,x)
3207  02e5 2615          	jrne	L1471
3209  02e7 7b01          	ld	a,(OFST+0,sp)
3210  02e9 5f            	clrw	x
3211  02ea 97            	ld	xl,a
3212  02eb 5a            	decw	x
3213  02ec a30000        	cpw	x,#0
3214  02ef 270b          	jreq	L1471
3215                     ; 301 		ind_out_[i-1]=0b11111111;
3217  02f1 7b01          	ld	a,(OFST+0,sp)
3218  02f3 5f            	clrw	x
3219  02f4 97            	ld	xl,a
3220  02f5 5a            	decw	x
3221  02f6 a6ff          	ld	a,#255
3222  02f8 e720          	ld	(_ind_out_,x),a
3224  02fa 201c          	jra	L3471
3225  02fc               L1471:
3226                     ; 305 		ind_out_[i-1]=DIGISYM[dig[i-1]];
3228  02fc 7b01          	ld	a,(OFST+0,sp)
3229  02fe 5f            	clrw	x
3230  02ff 97            	ld	xl,a
3231  0300 5a            	decw	x
3232  0301 7b01          	ld	a,(OFST+0,sp)
3233  0303 905f          	clrw	y
3234  0305 9097          	ld	yl,a
3235  0307 905a          	decw	y
3236  0309 90e625        	ld	a,(_dig,y)
3237  030c 905f          	clrw	y
3238  030e 9097          	ld	yl,a
3239  0310 90d60000      	ld	a,(_DIGISYM,y)
3240  0314 e720          	ld	(_ind_out_,x),a
3241                     ; 306 		zero_on=0;
3243  0316 3f1c          	clr	_zero_on
3244  0318               L3471:
3245                     ; 297 for (i=4;i>0;i--)
3247  0318 0a01          	dec	(OFST+0,sp)
3250  031a 0d01          	tnz	(OFST+0,sp)
3251  031c 26bc          	jrne	L3371
3252                     ; 309 }
3255  031e 84            	pop	a
3256  031f 81            	ret
3343                     ; 312 void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
3343                     ; 313 {
3344                     	switch	.text
3345  0320               _int2indI_slkuf:
3347  0320 89            	pushw	x
3348  0321 88            	push	a
3349       00000001      OFST:	set	1
3352                     ; 321 bin2bcd_int(in);
3354  0322 cd027f        	call	_bin2bcd_int
3356                     ; 322 if(unzero)bcd2ind_zero();
3358  0325 0d08          	tnz	(OFST+7,sp)
3359  0327 2704          	jreq	L7002
3362  0329 ada6          	call	_bcd2ind_zero
3365  032b 2003          	jra	L1102
3366  032d               L7002:
3367                     ; 323 else bcd2ind();
3369  032d cd02aa        	call	_bcd2ind
3371  0330               L1102:
3372                     ; 324 if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
3374  0330 7b09          	ld	a,(OFST+8,sp)
3375  0332 a101          	cp	a,#1
3376  0334 2604          	jrne	L7102
3378  0336 3d1e          	tnz	_bFL2
3379  0338 2614          	jrne	L5102
3380  033a               L7102:
3382  033a 7b09          	ld	a,(OFST+8,sp)
3383  033c a102          	cp	a,#2
3384  033e 2604          	jrne	L3202
3386  0340 3d1e          	tnz	_bFL2
3387  0342 260a          	jrne	L5102
3388  0344               L3202:
3390  0344 7b09          	ld	a,(OFST+8,sp)
3391  0346 a105          	cp	a,#5
3392  0348 2618          	jrne	L3102
3394  034a 3d1f          	tnz	_bFL5
3395  034c 2714          	jreq	L3102
3396  034e               L5102:
3397                     ; 326 	for(i=0;i<len;i++) 
3399  034e 0f01          	clr	(OFST+0,sp)
3401  0350 200a          	jra	L1302
3402  0352               L5202:
3403                     ; 328 		ind_out_[i]=DIGISYM[17];
3405  0352 7b01          	ld	a,(OFST+0,sp)
3406  0354 5f            	clrw	x
3407  0355 97            	ld	xl,a
3408  0356 a6ff          	ld	a,#255
3409  0358 e720          	ld	(_ind_out_,x),a
3410                     ; 326 	for(i=0;i<len;i++) 
3412  035a 0c01          	inc	(OFST+0,sp)
3413  035c               L1302:
3416  035c 7b01          	ld	a,(OFST+0,sp)
3417  035e 1107          	cp	a,(OFST+6,sp)
3418  0360 25f0          	jrult	L5202
3419  0362               L3102:
3420                     ; 332 for(i=0;i<len;i++) 
3422  0362 0f01          	clr	(OFST+0,sp)
3424  0364 2016          	jra	L1402
3425  0366               L5302:
3426                     ; 334 	ind_out[start+i]=ind_out_[i];
3428  0366 7b06          	ld	a,(OFST+5,sp)
3429  0368 5f            	clrw	x
3430  0369 1b01          	add	a,(OFST+0,sp)
3431  036b 2401          	jrnc	L06
3432  036d 5c            	incw	x
3433  036e               L06:
3434  036e 02            	rlwa	x,a
3435  036f 7b01          	ld	a,(OFST+0,sp)
3436  0371 905f          	clrw	y
3437  0373 9097          	ld	yl,a
3438  0375 90e620        	ld	a,(_ind_out_,y)
3439  0378 e700          	ld	(_ind_out,x),a
3440                     ; 332 for(i=0;i<len;i++) 
3442  037a 0c01          	inc	(OFST+0,sp)
3443  037c               L1402:
3446  037c 7b01          	ld	a,(OFST+0,sp)
3447  037e 1107          	cp	a,(OFST+6,sp)
3448  0380 25e4          	jrult	L5302
3449                     ; 336 }
3452  0382 5b03          	addw	sp,#3
3453  0384 81            	ret
3480                     ; 339 void led_hndl(void)
3480                     ; 340 {
3481                     	switch	.text
3482  0385               _led_hndl:
3486                     ; 341 if(mode==mKONST)
3488  0385 3d0c          	tnz	_mode
3489  0387 2618          	jrne	L5502
3490                     ; 343 	if(mode_phase==mpOFF)led_stat=0x00;
3492  0389 3d0b          	tnz	_mode_phase
3493  038b 2604          	jrne	L7502
3496  038d 3f1b          	clr	_led_stat
3498  038f 204a          	jra	L7602
3499  0391               L7502:
3500                     ; 346 		if(bFL1)led_stat=0x01;
3502  0391 3d1d          	tnz	_bFL1
3503  0393 2706          	jreq	L3602
3506  0395 3501001b      	mov	_led_stat,#1
3508  0399 2040          	jra	L7602
3509  039b               L3602:
3510                     ; 347 		else led_stat=0x01;
3512  039b 3501001b      	mov	_led_stat,#1
3513  039f 203a          	jra	L7602
3514  03a1               L5502:
3515                     ; 350 else if(mode==mTIMER)
3517  03a1 b60c          	ld	a,_mode
3518  03a3 a101          	cp	a,#1
3519  03a5 2618          	jrne	L1702
3520                     ; 352 	if(mode_phase==mpOFF)led_stat=0x00;
3522  03a7 3d0b          	tnz	_mode_phase
3523  03a9 2604          	jrne	L3702
3526  03ab 3f1b          	clr	_led_stat
3528  03ad 202c          	jra	L7602
3529  03af               L3702:
3530                     ; 355 		if(bFL1)led_stat=0x02;
3532  03af 3d1d          	tnz	_bFL1
3533  03b1 2706          	jreq	L7702
3536  03b3 3502001b      	mov	_led_stat,#2
3538  03b7 2022          	jra	L7602
3539  03b9               L7702:
3540                     ; 356 		else led_stat=0x02;
3542  03b9 3502001b      	mov	_led_stat,#2
3543  03bd 201c          	jra	L7602
3544  03bf               L1702:
3545                     ; 359 else if(mode==mLOOP)
3547  03bf b60c          	ld	a,_mode
3548  03c1 a102          	cp	a,#2
3549  03c3 2616          	jrne	L7602
3550                     ; 361 	if(mode_phase==mpOFF)led_stat=0x00;
3552  03c5 3d0b          	tnz	_mode_phase
3553  03c7 2604          	jrne	L7012
3556  03c9 3f1b          	clr	_led_stat
3558  03cb 200e          	jra	L7602
3559  03cd               L7012:
3560                     ; 364 		if(bFL1)led_stat=0x04;
3562  03cd 3d1d          	tnz	_bFL1
3563  03cf 2706          	jreq	L3112
3566  03d1 3504001b      	mov	_led_stat,#4
3568  03d5 2004          	jra	L7602
3569  03d7               L3112:
3570                     ; 365 		else led_stat=0x04;
3572  03d7 3504001b      	mov	_led_stat,#4
3573  03db               L7602:
3574                     ; 368 }
3577  03db 81            	ret
3607                     ; 397 void ind_hndl(void) 
3607                     ; 398 {
3608                     	switch	.text
3609  03dc               _ind_hndl:
3613                     ; 399 if(main_cnt_ee==0)
3615  03dc ce4002        	ldw	x,_main_cnt_ee
3616  03df 2613          	jrne	L7212
3617                     ; 401 	int2indI_slkuf(main_cnt_ee, 0, 4, 0, 1);	
3619  03e1 4b01          	push	#1
3620  03e3 4b00          	push	#0
3621  03e5 4b04          	push	#4
3622  03e7 4b00          	push	#0
3623  03e9 ce4002        	ldw	x,_main_cnt_ee
3624  03ec cd0320        	call	_int2indI_slkuf
3626  03ef 5b04          	addw	sp,#4
3628  03f1 cc0474        	jra	L1312
3629  03f4               L7212:
3630                     ; 403 else if(mode==mKONST)
3632  03f4 3d0c          	tnz	_mode
3633  03f6 262a          	jrne	L3312
3634                     ; 405 	if(mode_phase==mpON)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3636  03f8 b60b          	ld	a,_mode_phase
3637  03fa a101          	cp	a,#1
3638  03fc 2612          	jrne	L5312
3641  03fe 4b00          	push	#0
3642  0400 4b00          	push	#0
3643  0402 4b04          	push	#4
3644  0404 4b00          	push	#0
3645  0406 ce4002        	ldw	x,_main_cnt_ee
3646  0409 cd0320        	call	_int2indI_slkuf
3648  040c 5b04          	addw	sp,#4
3650  040e 2064          	jra	L1312
3651  0410               L5312:
3652                     ; 406 	else int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3654  0410 4b00          	push	#0
3655  0412 4b00          	push	#0
3656  0414 4b04          	push	#4
3657  0416 4b00          	push	#0
3658  0418 ce4002        	ldw	x,_main_cnt_ee
3659  041b cd0320        	call	_int2indI_slkuf
3661  041e 5b04          	addw	sp,#4
3662  0420 2052          	jra	L1312
3663  0422               L3312:
3664                     ; 408 else if(mode==mTIMER)
3666  0422 b60c          	ld	a,_mode
3667  0424 a101          	cp	a,#1
3668  0426 2648          	jrne	L3412
3669                     ; 410 	if(timer_pause_cnt)int2indI_slkuf(timer_period_ee, 0, 4, 0, 0);
3671  0428 be04          	ldw	x,_timer_pause_cnt
3672  042a 2712          	jreq	L5412
3675  042c 4b00          	push	#0
3676  042e 4b00          	push	#0
3677  0430 4b04          	push	#4
3678  0432 4b00          	push	#0
3679  0434 ce4008        	ldw	x,_timer_period_ee
3680  0437 cd0320        	call	_int2indI_slkuf
3682  043a 5b04          	addw	sp,#4
3684  043c 2036          	jra	L1312
3685  043e               L5412:
3686                     ; 411 	else if(mode_phase==mpON)int2indI_slkuf(timer_second_cnt/SEC_IN_MIN, 0, 3, 0, 0);
3688  043e b60b          	ld	a,_mode_phase
3689  0440 a101          	cp	a,#1
3690  0442 2616          	jrne	L1512
3693  0444 4b00          	push	#0
3694  0446 4b00          	push	#0
3695  0448 4b03          	push	#3
3696  044a 4b00          	push	#0
3697  044c be06          	ldw	x,_timer_second_cnt
3698  044e a614          	ld	a,#20
3699  0450 cd0000        	call	c_sdivx
3701  0453 cd0320        	call	_int2indI_slkuf
3703  0456 5b04          	addw	sp,#4
3705  0458 201a          	jra	L1312
3706  045a               L1512:
3707                     ; 412 	else if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3709  045a 3d0b          	tnz	_mode_phase
3710  045c 2616          	jrne	L1312
3713  045e 4b00          	push	#0
3714  0460 4b00          	push	#0
3715  0462 4b04          	push	#4
3716  0464 4b00          	push	#0
3717  0466 ce4002        	ldw	x,_main_cnt_ee
3718  0469 cd0320        	call	_int2indI_slkuf
3720  046c 5b04          	addw	sp,#4
3721  046e 2004          	jra	L1312
3722  0470               L3412:
3723                     ; 419 else if(mode==mLOOP)
3725  0470 b60c          	ld	a,_mode
3726  0472 a102          	cp	a,#2
3727  0474               L1312:
3728                     ; 422 }
3731  0474 81            	ret
3754                     ; 425 void gpio_init(void){
3755                     	switch	.text
3756  0475               _gpio_init:
3760                     ; 426 	GPIOA->DDR|=((1<<1)|(1<<2));
3762  0475 c65002        	ld	a,20482
3763  0478 aa06          	or	a,#6
3764  047a c75002        	ld	20482,a
3765                     ; 427 	GPIOA->CR1|=((1<<1)|(1<<2));
3767  047d c65003        	ld	a,20483
3768  0480 aa06          	or	a,#6
3769  0482 c75003        	ld	20483,a
3770                     ; 428 	GPIOA->CR2&=~((1<<1)|(1<<2));
3772  0485 c65004        	ld	a,20484
3773  0488 a4f9          	and	a,#249
3774  048a c75004        	ld	20484,a
3775                     ; 429 	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3777  048d c65011        	ld	a,20497
3778  0490 aa7c          	or	a,#124
3779  0492 c75011        	ld	20497,a
3780                     ; 430 	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3782  0495 c65012        	ld	a,20498
3783  0498 a483          	and	a,#131
3784  049a c75012        	ld	20498,a
3785                     ; 431 	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3787  049d c65013        	ld	a,20499
3788  04a0 a483          	and	a,#131
3789  04a2 c75013        	ld	20499,a
3790                     ; 435 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3792  04a5 c65008        	ld	a,20488
3793  04a8 a4f0          	and	a,#240
3794  04aa c75008        	ld	20488,a
3795                     ; 436 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3797  04ad c65009        	ld	a,20489
3798  04b0 a4f0          	and	a,#240
3799  04b2 c75009        	ld	20489,a
3800                     ; 437 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
3802  04b5 c65007        	ld	a,20487
3803  04b8 aa0f          	or	a,#15
3804  04ba c75007        	ld	20487,a
3805                     ; 440 	GPIOC->CR1|=((1<<3));
3807  04bd 7216500d      	bset	20493,#3
3808                     ; 441 	GPIOC->CR2&=~((1<<3));
3810  04c1 7217500e      	bres	20494,#3
3811                     ; 442 	GPIOB->CR1|=((1<<4)|(1<<5));
3813  04c5 c65008        	ld	a,20488
3814  04c8 aa30          	or	a,#48
3815  04ca c75008        	ld	20488,a
3816                     ; 443 	GPIOB->CR2&=~((1<<4)|(1<<5));
3818  04cd c65009        	ld	a,20489
3819  04d0 a4cf          	and	a,#207
3820  04d2 c75009        	ld	20489,a
3821                     ; 446 	GPIOC->CR1&=~0xfe;
3823  04d5 c6500d        	ld	a,20493
3824  04d8 a401          	and	a,#1
3825  04da c7500d        	ld	20493,a
3826                     ; 447 	GPIOC->CR2&=~0xfe;
3828  04dd c6500e        	ld	a,20494
3829  04e0 a401          	and	a,#1
3830  04e2 c7500e        	ld	20494,a
3831                     ; 448 	GPIOC->DDR|=0xfe;
3833  04e5 c6500c        	ld	a,20492
3834  04e8 aafe          	or	a,#254
3835  04ea c7500c        	ld	20492,a
3836                     ; 468 	GPIOB->DDR&=~(1<<5);	
3838  04ed 721b5007      	bres	20487,#5
3839                     ; 469 	GPIOB->CR1|=(1<<5);
3841  04f1 721a5008      	bset	20488,#5
3842                     ; 470 	GPIOB->CR2&=~(1<<5);
3844  04f5 721b5009      	bres	20489,#5
3845                     ; 472 	GPIOB->ODR|=0x0f;
3847  04f9 c65005        	ld	a,20485
3848  04fc aa0f          	or	a,#15
3849  04fe c75005        	ld	20485,a
3850                     ; 473 }
3853  0501 81            	ret
3876                     ; 476 void t4_init(void){
3877                     	switch	.text
3878  0502               _t4_init:
3882                     ; 477 	TIM4->PSCR = 7;
3884  0502 35075347      	mov	21319,#7
3885                     ; 478 	TIM4->ARR= 123;
3887  0506 357b5348      	mov	21320,#123
3888                     ; 479 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3890  050a 72105343      	bset	21315,#0
3891                     ; 481 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3893  050e 35855340      	mov	21312,#133
3894                     ; 482 }	
3897  0512 81            	ret
3938                     ; 488 @far @interrupt void TIM4_UPD_Interrupt (void) 
3938                     ; 489 {
3940                     	switch	.text
3941  0513               f_TIM4_UPD_Interrupt:
3945                     ; 491 ind_cnt++;
3947  0513 3c2f          	inc	_ind_cnt
3948                     ; 493 if(ind_cnt>=5)ind_cnt=0;
3950  0515 b62f          	ld	a,_ind_cnt
3951  0517 a105          	cp	a,#5
3952  0519 2502          	jrult	L3122
3955  051b 3f2f          	clr	_ind_cnt
3956  051d               L3122:
3957                     ; 495 GPIOC->ODR|=0xf0;
3959  051d c6500a        	ld	a,20490
3960  0520 aaf0          	or	a,#240
3961  0522 c7500a        	ld	20490,a
3962                     ; 498 GPIOA->ODR|=0x06;
3964  0525 c65000        	ld	a,20480
3965  0528 aa06          	or	a,#6
3966  052a c75000        	ld	20480,a
3967                     ; 499 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
3969  052d b62f          	ld	a,_ind_cnt
3970  052f 5f            	clrw	x
3971  0530 97            	ld	xl,a
3972  0531 e600          	ld	a,(_ind_out,x)
3973  0533 48            	sll	a
3974  0534 aaf9          	or	a,#249
3975  0536 c45000        	and	a,20480
3976  0539 c75000        	ld	20480,a
3977                     ; 500 GPIOD->ODR|=0x7c;
3979  053c c6500f        	ld	a,20495
3980  053f aa7c          	or	a,#124
3981  0541 c7500f        	ld	20495,a
3982                     ; 501 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
3984  0544 b62f          	ld	a,_ind_cnt
3985  0546 5f            	clrw	x
3986  0547 97            	ld	xl,a
3987  0548 e600          	ld	a,(_ind_out,x)
3988  054a aa83          	or	a,#131
3989  054c c4500f        	and	a,20495
3990  054f c7500f        	ld	20495,a
3991                     ; 505 GPIOC->ODR&=~(0x10<<ind_cnt);
3993  0552 b62f          	ld	a,_ind_cnt
3994  0554 5f            	clrw	x
3995  0555 97            	ld	xl,a
3996  0556 a610          	ld	a,#16
3997  0558 5d            	tnzw	x
3998  0559 2704          	jreq	L47
3999  055b               L67:
4000  055b 48            	sll	a
4001  055c 5a            	decw	x
4002  055d 26fc          	jrne	L67
4003  055f               L47:
4004  055f 43            	cpl	a
4005  0560 c4500a        	and	a,20490
4006  0563 c7500a        	ld	20490,a
4007                     ; 506 if(ind_cnt==4)
4009  0566 b62f          	ld	a,_ind_cnt
4010  0568 a104          	cp	a,#4
4011  056a 2604          	jrne	L5122
4012                     ; 508 	GPIOC->ODR&=~(0x10);
4014  056c 7219500a      	bres	20490,#4
4015  0570               L5122:
4016                     ; 511 GPIOC->CR1|=((1<<3));
4018  0570 7216500d      	bset	20493,#3
4019                     ; 512 GPIOC->CR2&=~((1<<3));
4021  0574 7217500e      	bres	20494,#3
4022                     ; 513 GPIOB->CR1|=((1<<4)|(1<<5));
4024  0578 c65008        	ld	a,20488
4025  057b aa30          	or	a,#48
4026  057d c75008        	ld	20488,a
4027                     ; 514 GPIOB->CR2&=~((1<<4)|(1<<5));
4029  0580 c65009        	ld	a,20489
4030  0583 a4cf          	and	a,#207
4031  0585 c75009        	ld	20489,a
4032                     ; 516 if(ind_cnt==4)	
4034  0588 b62f          	ld	a,_ind_cnt
4035  058a a104          	cp	a,#4
4036  058c 260e          	jrne	L7122
4037                     ; 518 	GPIOC->DDR&=~(1<<3);
4039  058e 7217500c      	bres	20492,#3
4040                     ; 519 	GPIOB->DDR&=~((1<<4)|(1<<5));
4042  0592 c65007        	ld	a,20487
4043  0595 a4cf          	and	a,#207
4044  0597 c75007        	ld	20487,a
4046  059a 2010          	jra	L1222
4047  059c               L7122:
4048                     ; 521 else if(ind_cnt==0)	
4050  059c 3d2f          	tnz	_ind_cnt
4051  059e 260c          	jrne	L1222
4052                     ; 523 	GPIOC->DDR|=((1<<3));
4054  05a0 7216500c      	bset	20492,#3
4055                     ; 524 	GPIOB->DDR|=((1<<4)|(1<<5));
4057  05a4 c65007        	ld	a,20487
4058  05a7 aa30          	or	a,#48
4059  05a9 c75007        	ld	20487,a
4060  05ac               L1222:
4061                     ; 533 if(ind_cnt==0)	
4063  05ac 3d2f          	tnz	_ind_cnt
4064  05ae 2632          	jrne	L5222
4065                     ; 535 	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
4067  05b0 b61b          	ld	a,_led_stat
4068  05b2 a501          	bcp	a,#1
4069  05b4 2706          	jreq	L7222
4072  05b6 7217500a      	bres	20490,#3
4074  05ba 2004          	jra	L1322
4075  05bc               L7222:
4076                     ; 536 	else 			GPIOC->ODR|=(1<<3);
4078  05bc 7216500a      	bset	20490,#3
4079  05c0               L1322:
4080                     ; 537 	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
4082  05c0 b61b          	ld	a,_led_stat
4083  05c2 a502          	bcp	a,#2
4084  05c4 2706          	jreq	L3322
4087  05c6 72195005      	bres	20485,#4
4089  05ca 2004          	jra	L5322
4090  05cc               L3322:
4091                     ; 538 	else 			GPIOB->ODR|=(1<<4);
4093  05cc 72185005      	bset	20485,#4
4094  05d0               L5322:
4095                     ; 539 	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
4097  05d0 b61b          	ld	a,_led_stat
4098  05d2 a504          	bcp	a,#4
4099  05d4 2706          	jreq	L7322
4102  05d6 721b5005      	bres	20485,#5
4104  05da 203f          	jra	L3422
4105  05dc               L7322:
4106                     ; 540 	else 			GPIOB->ODR|=(1<<5);
4108  05dc 721a5005      	bset	20485,#5
4109  05e0 2039          	jra	L3422
4110  05e2               L5222:
4111                     ; 542 else if(ind_cnt==4)	
4113  05e2 b62f          	ld	a,_ind_cnt
4114  05e4 a104          	cp	a,#4
4115  05e6 2633          	jrne	L3422
4116                     ; 544 	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
4118  05e8 c6500b        	ld	a,20491
4119  05eb a508          	bcp	a,#8
4120  05ed 2606          	jrne	L7422
4123  05ef 7211000d      	bres	_but_stat,#0
4125  05f3 2004          	jra	L1522
4126  05f5               L7422:
4127                     ; 545 	else but_stat|=0x01;
4129  05f5 7210000d      	bset	_but_stat,#0
4130  05f9               L1522:
4131                     ; 546 	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
4133  05f9 c65006        	ld	a,20486
4134  05fc a510          	bcp	a,#16
4135  05fe 2606          	jrne	L3522
4138  0600 7213000d      	bres	_but_stat,#1
4140  0604 2004          	jra	L5522
4141  0606               L3522:
4142                     ; 547 	else but_stat|=0x02;
4144  0606 7212000d      	bset	_but_stat,#1
4145  060a               L5522:
4146                     ; 548 	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
4148  060a c65006        	ld	a,20486
4149  060d a520          	bcp	a,#32
4150  060f 2606          	jrne	L7522
4153  0611 7215000d      	bres	_but_stat,#2
4155  0615 2004          	jra	L3422
4156  0617               L7522:
4157                     ; 549 	else but_stat|=0x04;	
4159  0617 7214000d      	bset	_but_stat,#2
4160  061b               L3422:
4161                     ; 552 b1000Hz=1;
4163  061b 35010000      	mov	_b1000Hz,#1
4164                     ; 554 if(++t0_cnt0>=10)
4166  061f 725c0006      	inc	_t0_cnt0
4167  0623 c60006        	ld	a,_t0_cnt0
4168  0626 a10a          	cp	a,#10
4169  0628 2575          	jrult	L3622
4170                     ; 556 	t0_cnt0=0;
4172  062a 725f0006      	clr	_t0_cnt0
4173                     ; 557     	b100Hz=1;
4175  062e 35010001      	mov	_b100Hz,#1
4176                     ; 558 	if(++t0_cnt1>=10)
4178  0632 725c0007      	inc	_t0_cnt1
4179  0636 c60007        	ld	a,_t0_cnt1
4180  0639 a10a          	cp	a,#10
4181  063b 2508          	jrult	L5622
4182                     ; 560 		t0_cnt1=0;
4184  063d 725f0007      	clr	_t0_cnt1
4185                     ; 561 		b10Hz=1;
4187  0641 35010002      	mov	_b10Hz,#1
4188  0645               L5622:
4189                     ; 564 	if(++t0_cnt2>=20)
4191  0645 725c0008      	inc	_t0_cnt2
4192  0649 c60008        	ld	a,_t0_cnt2
4193  064c a114          	cp	a,#20
4194  064e 2513          	jrult	L7622
4195                     ; 566 		t0_cnt2=0;
4197  0650 725f0008      	clr	_t0_cnt2
4198                     ; 567 		b5Hz=1;
4200  0654 35010003      	mov	_b5Hz,#1
4201                     ; 568 		bFL5=!bFL5;
4203  0658 3d1f          	tnz	_bFL5
4204  065a 2604          	jrne	L001
4205  065c a601          	ld	a,#1
4206  065e 2001          	jra	L201
4207  0660               L001:
4208  0660 4f            	clr	a
4209  0661               L201:
4210  0661 b71f          	ld	_bFL5,a
4211  0663               L7622:
4212                     ; 571 	if(++t0_cnt3>=50)
4214  0663 725c0009      	inc	_t0_cnt3
4215  0667 c60009        	ld	a,_t0_cnt3
4216  066a a132          	cp	a,#50
4217  066c 2513          	jrult	L1722
4218                     ; 573 		t0_cnt3=0;
4220  066e 725f0009      	clr	_t0_cnt3
4221                     ; 574 		b2Hz=1;
4223  0672 35010004      	mov	_b2Hz,#1
4224                     ; 575 		bFL2=!bFL2;		
4226  0676 3d1e          	tnz	_bFL2
4227  0678 2604          	jrne	L401
4228  067a a601          	ld	a,#1
4229  067c 2001          	jra	L601
4230  067e               L401:
4231  067e 4f            	clr	a
4232  067f               L601:
4233  067f b71e          	ld	_bFL2,a
4234  0681               L1722:
4235                     ; 578 	if(++t0_cnt4>=100)
4237  0681 725c000a      	inc	_t0_cnt4
4238  0685 c6000a        	ld	a,_t0_cnt4
4239  0688 a164          	cp	a,#100
4240  068a 2513          	jrult	L3622
4241                     ; 580 		t0_cnt4=0;
4243  068c 725f000a      	clr	_t0_cnt4
4244                     ; 581 		b1Hz=1;
4246  0690 35010005      	mov	_b1Hz,#1
4247                     ; 582 		bFL1=!bFL1;
4249  0694 3d1d          	tnz	_bFL1
4250  0696 2604          	jrne	L011
4251  0698 a601          	ld	a,#1
4252  069a 2001          	jra	L211
4253  069c               L011:
4254  069c 4f            	clr	a
4255  069d               L211:
4256  069d b71d          	ld	_bFL1,a
4257  069f               L3622:
4258                     ; 588 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
4260  069f 72115344      	bres	21316,#0
4261                     ; 589 return;
4264  06a3 80            	iret
4306                     ; 596 main()
4306                     ; 597 {
4308                     	switch	.text
4309  06a4               _main:
4313                     ; 598 CLK->CKDIVR=0;
4315  06a4 725f50c6      	clr	20678
4316                     ; 600 gpio_init();
4318  06a8 cd0475        	call	_gpio_init
4320                     ; 604 FLASH_DUKR=0xae;
4322  06ab 35ae5064      	mov	_FLASH_DUKR,#174
4323                     ; 605 FLASH_DUKR=0x56;	
4325  06af 35565064      	mov	_FLASH_DUKR,#86
4326                     ; 654 t4_init();
4328  06b3 cd0502        	call	_t4_init
4330                     ; 655 enableInterrupts();	
4333  06b6 9a            rim
4335                     ; 657 mode=mKONST;
4338  06b7 3f0c          	clr	_mode
4339                     ; 658 mode_phase=mpOFF;
4341  06b9 3f0b          	clr	_mode_phase
4342  06bb               L5032:
4343                     ; 664 	if(b1000Hz)
4345  06bb 725d0000      	tnz	_b1000Hz
4346  06bf 270a          	jreq	L1132
4347                     ; 666 		b1000Hz=0;
4349  06c1 725f0000      	clr	_b1000Hz
4350                     ; 667 		but_drv();
4352  06c5 cd01e4        	call	_but_drv
4354                     ; 668 		but_an();
4356  06c8 cd010b        	call	_but_an
4358  06cb               L1132:
4359                     ; 671 	if(b100Hz)
4361  06cb 725d0001      	tnz	_b100Hz
4362  06cf 2707          	jreq	L3132
4363                     ; 673 		b100Hz=0;
4365  06d1 725f0001      	clr	_b100Hz
4366                     ; 674 		led_hndl();	
4368  06d5 cd0385        	call	_led_hndl
4370  06d8               L3132:
4371                     ; 678 	if(b10Hz)
4373  06d8 725d0002      	tnz	_b10Hz
4374  06dc 270d          	jreq	L5132
4375                     ; 680 		b10Hz=0;
4377  06de 725f0002      	clr	_b10Hz
4378                     ; 681 		ind_hndl();	
4380  06e2 cd03dc        	call	_ind_hndl
4382                     ; 682 		out_hndl();	
4384  06e5 cd008f        	call	_out_hndl
4386                     ; 683 		out_drv();
4388  06e8 cd010a        	call	_out_drv
4390  06eb               L5132:
4391                     ; 687 	if(b5Hz)
4393  06eb 725d0003      	tnz	_b5Hz
4394  06ef 2704          	jreq	L7132
4395                     ; 689 		b5Hz=0;
4397  06f1 725f0003      	clr	_b5Hz
4398  06f5               L7132:
4399                     ; 693 	if(b2Hz)
4401  06f5 725d0004      	tnz	_b2Hz
4402  06f9 2704          	jreq	L1232
4403                     ; 695 		b2Hz=0;
4405  06fb 725f0004      	clr	_b2Hz
4406  06ff               L1232:
4407                     ; 699 	if(b1Hz)
4409  06ff 725d0005      	tnz	_b1Hz
4410  0703 27b6          	jreq	L5032
4411                     ; 701 		b1Hz=0;
4413  0705 725f0005      	clr	_b1Hz
4414                     ; 702 		led_stat=0;
4416  0709 3f1b          	clr	_led_stat
4417                     ; 703 		time_hndl();
4419  070b cd0000        	call	_time_hndl
4421  070e 20ab          	jra	L5032
4918                     	xdef	_main
4919                     	xdef	f_TIM4_UPD_Interrupt
4920                     	xdef	_t4_init
4921                     	xdef	_gpio_init
4922                     	xdef	_ind_hndl
4923                     	xdef	_led_hndl
4924                     	xdef	_int2indI_slkuf
4925                     	xdef	_bcd2ind_zero
4926                     	xdef	_bcd2ind
4927                     	xdef	_bin2bcd_int
4928                     	xdef	_but_drv
4929                     	xdef	_but_an
4930                     	xdef	_out_drv
4931                     	xdef	_out_hndl
4932                     	xdef	_time_hndl
4933                     	switch	.ubsct
4934  0000               _loop_pause_cnt:
4935  0000 0000          	ds.b	2
4936                     	xdef	_loop_pause_cnt
4937  0002               _loop_wrk_cnt:
4938  0002 0000          	ds.b	2
4939                     	xdef	_loop_wrk_cnt
4940  0004               _timer_pause_cnt:
4941  0004 0000          	ds.b	2
4942                     	xdef	_timer_pause_cnt
4943  0006               _timer_second_cnt:
4944  0006 0000          	ds.b	2
4945                     	xdef	_timer_second_cnt
4946  0008               _second_cnt:
4947  0008 0000          	ds.b	2
4948                     	xdef	_second_cnt
4949  000a               _out_state:
4950  000a 00            	ds.b	1
4951                     	xdef	_out_state
4952  000b               _mode_phase:
4953  000b 00            	ds.b	1
4954                     	xdef	_mode_phase
4955  000c               _mode:
4956  000c 00            	ds.b	1
4957                     	xdef	_mode
4958  000d               _but_stat:
4959  000d 00            	ds.b	1
4960                     	xdef	_but_stat
4961  000e               _but_onL_temp:
4962  000e 0000          	ds.b	2
4963                     	xdef	_but_onL_temp
4964  0010               _speed:
4965  0010 00            	ds.b	1
4966                     	xdef	_speed
4967  0011               _but1_cnt:
4968  0011 0000          	ds.b	2
4969                     	xdef	_but1_cnt
4970  0013               _but0_cnt:
4971  0013 0000          	ds.b	2
4972                     	xdef	_but0_cnt
4973  0015               _n_but:
4974  0015 00            	ds.b	1
4975                     	xdef	_n_but
4976  0016               _l_but:
4977  0016 00            	ds.b	1
4978                     	xdef	_l_but
4979  0017               _but:
4980  0017 00            	ds.b	1
4981                     	xdef	_but
4982  0018               _but_s:
4983  0018 00            	ds.b	1
4984                     	xdef	_but_s
4985  0019               _but_n:
4986  0019 00            	ds.b	1
4987                     	xdef	_but_n
4988  001a               _but_new:
4989  001a 00            	ds.b	1
4990                     	xdef	_but_new
4991  001b               _led_stat:
4992  001b 00            	ds.b	1
4993                     	xdef	_led_stat
4994  001c               _zero_on:
4995  001c 00            	ds.b	1
4996                     	xdef	_zero_on
4997  001d               _bFL1:
4998  001d 00            	ds.b	1
4999                     	xdef	_bFL1
5000  001e               _bFL2:
5001  001e 00            	ds.b	1
5002                     	xdef	_bFL2
5003  001f               _bFL5:
5004  001f 00            	ds.b	1
5005                     	xdef	_bFL5
5006  0020               _ind_out_:
5007  0020 0000000000    	ds.b	5
5008                     	xdef	_ind_out_
5009  0025               _dig:
5010  0025 000000000000  	ds.b	10
5011                     	xdef	_dig
5012                     	xdef	_DIGISYM
5013                     	xdef	_ind_out
5014  002f               _ind_cnt:
5015  002f 00            	ds.b	1
5016                     	xdef	_ind_cnt
5017                     	xdef	_t0_cnt4
5018                     	xdef	_t0_cnt3
5019                     	xdef	_t0_cnt2
5020                     	xdef	_t0_cnt1
5021                     	xdef	_t0_cnt0
5022                     	xdef	_b1Hz
5023                     	xdef	_b2Hz
5024                     	xdef	_b5Hz
5025                     	xdef	_b10Hz
5026                     	xdef	_b100Hz
5027                     	xdef	_b1000Hz
5028                     	xref.b	c_x
5048                     	xref	c_eewrw
5049                     	xref	c_sdivx
5050                     	xref	c_imul
5051                     	end
