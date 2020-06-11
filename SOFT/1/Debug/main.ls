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
2279                     ; 75 void time_hndl(void) 
2279                     ; 76 {
2281                     	switch	.text
2282  0000               _time_hndl:
2286                     ; 77 if(out_state==osON)
2288  0000 b60a          	ld	a,_out_state
2289  0002 a101          	cp	a,#1
2290  0004 2627          	jrne	L1441
2291                     ; 79 	second_cnt++;
2293  0006 be08          	ldw	x,_second_cnt
2294  0008 1c0001        	addw	x,#1
2295  000b bf08          	ldw	_second_cnt,x
2296                     ; 80 	if(second_cnt>=SEC_IN_HOUR)
2298  000d 9c            	rvf
2299  000e be08          	ldw	x,_second_cnt
2300  0010 a30014        	cpw	x,#20
2301  0013 2f18          	jrslt	L1441
2302                     ; 82 		second_cnt=0;
2304  0015 5f            	clrw	x
2305  0016 bf08          	ldw	_second_cnt,x
2306                     ; 83 		if(main_cnt_ee)
2308  0018 ce4002        	ldw	x,_main_cnt_ee
2309  001b 2710          	jreq	L1441
2310                     ; 85 			main_cnt_ee--;
2312  001d ce4002        	ldw	x,_main_cnt_ee
2313  0020 1d0001        	subw	x,#1
2314  0023 cf4002        	ldw	_main_cnt_ee,x
2315                     ; 86 			if(!main_cnt_ee)
2317  0026 ce4002        	ldw	x,_main_cnt_ee
2318  0029 2602          	jrne	L1441
2319                     ; 88 				mode_phase=mpOFF;
2321  002b 3f0b          	clr	_mode_phase
2322  002d               L1441:
2323                     ; 93 if(timer_pause_cnt)
2325  002d be04          	ldw	x,_timer_pause_cnt
2326  002f 2720          	jreq	L1541
2327                     ; 95 	timer_pause_cnt--;
2329  0031 be04          	ldw	x,_timer_pause_cnt
2330  0033 1d0001        	subw	x,#1
2331  0036 bf04          	ldw	_timer_pause_cnt,x
2332                     ; 96 	if((timer_pause_cnt==0)&&(main_cnt_ee))
2334  0038 be04          	ldw	x,_timer_pause_cnt
2335  003a 2615          	jrne	L1541
2337  003c ce4002        	ldw	x,_main_cnt_ee
2338  003f 2710          	jreq	L1541
2339                     ; 98 		mode_phase=mpON;
2341  0041 3501000b      	mov	_mode_phase,#1
2342                     ; 99 		timer_second_cnt=SEC_IN_MIN*timer_period_ee;
2344  0045 ce4008        	ldw	x,_timer_period_ee
2345  0048 90ae0014      	ldw	y,#20
2346  004c cd0000        	call	c_imul
2348  004f bf06          	ldw	_timer_second_cnt,x
2349  0051               L1541:
2350                     ; 102 if(timer_second_cnt)
2352  0051 be06          	ldw	x,_timer_second_cnt
2353  0053 270d          	jreq	L5541
2354                     ; 104 	timer_second_cnt--;
2356  0055 be06          	ldw	x,_timer_second_cnt
2357  0057 1d0001        	subw	x,#1
2358  005a bf06          	ldw	_timer_second_cnt,x
2359                     ; 105 	if(timer_second_cnt==0)
2361  005c be06          	ldw	x,_timer_second_cnt
2362  005e 2602          	jrne	L5541
2363                     ; 107 		mode_phase=mpOFF;
2365  0060 3f0b          	clr	_mode_phase
2366  0062               L5541:
2367                     ; 111 if(mode==mLOOP)
2369  0062 b60c          	ld	a,_mode
2370  0064 a102          	cp	a,#2
2371  0066 2636          	jrne	L1641
2372                     ; 113 	if(loop_wrk_cnt)
2374  0068 be02          	ldw	x,_loop_wrk_cnt
2375  006a 2717          	jreq	L3641
2376                     ; 115 		loop_wrk_cnt--;
2378  006c be02          	ldw	x,_loop_wrk_cnt
2379  006e 1d0001        	subw	x,#1
2380  0071 bf02          	ldw	_loop_wrk_cnt,x
2381                     ; 116 		mode_phase=mpON;
2383  0073 3501000b      	mov	_mode_phase,#1
2384                     ; 117 		if(loop_wrk_cnt<=0)
2386  0077 9c            	rvf
2387  0078 be02          	ldw	x,_loop_wrk_cnt
2388  007a 2c28          	jrsgt	L5741
2389                     ; 119 			loop_pause_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2391  007c ae00c8        	ldw	x,#200
2392  007f bf00          	ldw	_loop_pause_cnt,x
2393  0081 2021          	jra	L5741
2394  0083               L3641:
2395                     ; 122 	else if(loop_pause_cnt)
2397  0083 be00          	ldw	x,_loop_pause_cnt
2398  0085 271d          	jreq	L5741
2399                     ; 124 		loop_pause_cnt--;
2401  0087 be00          	ldw	x,_loop_pause_cnt
2402  0089 1d0001        	subw	x,#1
2403  008c bf00          	ldw	_loop_pause_cnt,x
2404                     ; 125 		mode_phase=mpPAUSE;
2406  008e 3502000b      	mov	_mode_phase,#2
2407                     ; 126 		if(loop_pause_cnt<=0)
2409  0092 9c            	rvf
2410  0093 be00          	ldw	x,_loop_pause_cnt
2411  0095 2c0d          	jrsgt	L5741
2412                     ; 128 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2414  0097 ae00c8        	ldw	x,#200
2415  009a bf02          	ldw	_loop_wrk_cnt,x
2416  009c 2006          	jra	L5741
2417  009e               L1641:
2418                     ; 134 	loop_wrk_cnt=0;
2420  009e 5f            	clrw	x
2421  009f bf02          	ldw	_loop_wrk_cnt,x
2422                     ; 135 	loop_pause_cnt=0;
2424  00a1 5f            	clrw	x
2425  00a2 bf00          	ldw	_loop_pause_cnt,x
2426  00a4               L5741:
2427                     ; 137 }
2430  00a4 81            	ret
2456                     ; 140 void out_hndl(void) 
2456                     ; 141 {
2457                     	switch	.text
2458  00a5               _out_hndl:
2460  00a5 89            	pushw	x
2461       00000002      OFST:	set	2
2464                     ; 142 if( 	((mode==mKONST)&(mode_phase==mpON)) ||
2464                     ; 143 	((mode==mTIMER)&(mode_phase==mpON)) ||
2464                     ; 144 	((mode==mLOOP)&(mode_phase==mpON))
2464                     ; 145 	)out_state=osON;
2466  00a6 b60b          	ld	a,_mode_phase
2467  00a8 a101          	cp	a,#1
2468  00aa 2605          	jrne	L01
2469  00ac ae0001        	ldw	x,#1
2470  00af 2001          	jra	L21
2471  00b1               L01:
2472  00b1 5f            	clrw	x
2473  00b2               L21:
2474  00b2 1f01          	ldw	(OFST-1,sp),x
2475  00b4 3d0c          	tnz	_mode
2476  00b6 2605          	jrne	L41
2477  00b8 ae0001        	ldw	x,#1
2478  00bb 2001          	jra	L61
2479  00bd               L41:
2480  00bd 5f            	clrw	x
2481  00be               L61:
2482  00be 01            	rrwa	x,a
2483  00bf 1402          	and	a,(OFST+0,sp)
2484  00c1 01            	rrwa	x,a
2485  00c2 1401          	and	a,(OFST-1,sp)
2486  00c4 01            	rrwa	x,a
2487  00c5 a30000        	cpw	x,#0
2488  00c8 264c          	jrne	L1151
2490  00ca b60b          	ld	a,_mode_phase
2491  00cc a101          	cp	a,#1
2492  00ce 2605          	jrne	L02
2493  00d0 ae0001        	ldw	x,#1
2494  00d3 2001          	jra	L22
2495  00d5               L02:
2496  00d5 5f            	clrw	x
2497  00d6               L22:
2498  00d6 1f01          	ldw	(OFST-1,sp),x
2499  00d8 b60c          	ld	a,_mode
2500  00da a101          	cp	a,#1
2501  00dc 2605          	jrne	L42
2502  00de ae0001        	ldw	x,#1
2503  00e1 2001          	jra	L62
2504  00e3               L42:
2505  00e3 5f            	clrw	x
2506  00e4               L62:
2507  00e4 01            	rrwa	x,a
2508  00e5 1402          	and	a,(OFST+0,sp)
2509  00e7 01            	rrwa	x,a
2510  00e8 1401          	and	a,(OFST-1,sp)
2511  00ea 01            	rrwa	x,a
2512  00eb a30000        	cpw	x,#0
2513  00ee 2626          	jrne	L1151
2515  00f0 b60b          	ld	a,_mode_phase
2516  00f2 a101          	cp	a,#1
2517  00f4 2605          	jrne	L03
2518  00f6 ae0001        	ldw	x,#1
2519  00f9 2001          	jra	L23
2520  00fb               L03:
2521  00fb 5f            	clrw	x
2522  00fc               L23:
2523  00fc 1f01          	ldw	(OFST-1,sp),x
2524  00fe b60c          	ld	a,_mode
2525  0100 a102          	cp	a,#2
2526  0102 2605          	jrne	L43
2527  0104 ae0001        	ldw	x,#1
2528  0107 2001          	jra	L63
2529  0109               L43:
2530  0109 5f            	clrw	x
2531  010a               L63:
2532  010a 01            	rrwa	x,a
2533  010b 1402          	and	a,(OFST+0,sp)
2534  010d 01            	rrwa	x,a
2535  010e 1401          	and	a,(OFST-1,sp)
2536  0110 01            	rrwa	x,a
2537  0111 a30000        	cpw	x,#0
2538  0114 2706          	jreq	L7051
2539  0116               L1151:
2542  0116 3501000a      	mov	_out_state,#1
2544  011a               L5151:
2545                     ; 148 }
2548  011a 85            	popw	x
2549  011b 81            	ret
2550  011c               L7051:
2551                     ; 146 else out_state=osOFF; 
2553  011c 3f0a          	clr	_out_state
2554  011e 20fa          	jra	L5151
2577                     ; 151 void out_drv(void) 
2577                     ; 152 {
2578                     	switch	.text
2579  0120               _out_drv:
2583                     ; 154 }
2586  0120 81            	ret
2619                     ; 157 void but_an(void) 
2619                     ; 158 {
2620                     	switch	.text
2621  0121               _but_an:
2625                     ; 159 if(n_but)
2627  0121 3d15          	tnz	_n_but
2628  0123 2603          	jrne	L44
2629  0125 cc021a        	jp	L7351
2630  0128               L44:
2631                     ; 161 	if(but==butK)
2633  0128 b617          	ld	a,_but
2634  012a a1fe          	cp	a,#254
2635  012c 2620          	jrne	L1451
2636                     ; 163 		if((mode!=mKONST)&&(main_cnt_ee))
2638  012e 3d0c          	tnz	_mode
2639  0130 270d          	jreq	L3451
2641  0132 ce4002        	ldw	x,_main_cnt_ee
2642  0135 2708          	jreq	L3451
2643                     ; 165 			mode=mKONST;
2645  0137 3f0c          	clr	_mode
2646                     ; 166 			mode_phase=mpON;
2648  0139 3501000b      	mov	_mode_phase,#1
2650  013d 200f          	jra	L1451
2651  013f               L3451:
2652                     ; 170 			if((mode_phase!=mpON)&&(main_cnt_ee))mode_phase=mpON;
2654  013f b60b          	ld	a,_mode_phase
2655  0141 a101          	cp	a,#1
2656  0143 2709          	jreq	L1451
2658  0145 ce4002        	ldw	x,_main_cnt_ee
2659  0148 2704          	jreq	L1451
2662  014a 3501000b      	mov	_mode_phase,#1
2663  014e               L1451:
2664                     ; 174 	if(but==butK_)
2666  014e b617          	ld	a,_but
2667  0150 a17e          	cp	a,#126
2668  0152 260c          	jrne	L1551
2669                     ; 176 		if((mode==mKONST)&&(mode_phase==mpON))
2671  0154 3d0c          	tnz	_mode
2672  0156 2608          	jrne	L1551
2674  0158 b60b          	ld	a,_mode_phase
2675  015a a101          	cp	a,#1
2676  015c 2602          	jrne	L1551
2677                     ; 178 			mode_phase=mpOFF;
2679  015e 3f0b          	clr	_mode_phase
2680  0160               L1551:
2681                     ; 181 	if(but==butT)
2683  0160 b617          	ld	a,_but
2684  0162 a1fd          	cp	a,#253
2685  0164 265f          	jrne	L5551
2686                     ; 183 		if(mode!=mTIMER)
2688  0166 b60c          	ld	a,_mode
2689  0168 a101          	cp	a,#1
2690  016a 270d          	jreq	L7551
2691                     ; 185 			mode=mTIMER;
2693  016c 3501000c      	mov	_mode,#1
2694                     ; 186 			mode_phase=mpOFF;
2696  0170 3f0b          	clr	_mode_phase
2697                     ; 187 			timer_pause_cnt=4;
2699  0172 ae0004        	ldw	x,#4
2700  0175 bf04          	ldw	_timer_pause_cnt,x
2702  0177 204c          	jra	L5551
2703  0179               L7551:
2704                     ; 189 		else	if(mode==mTIMER)
2706  0179 b60c          	ld	a,_mode
2707  017b a101          	cp	a,#1
2708  017d 2646          	jrne	L5551
2709                     ; 191 			if(timer_pause_cnt)	
2711  017f be04          	ldw	x,_timer_pause_cnt
2712  0181 2737          	jreq	L5651
2713                     ; 193 				timer_period_ee=((timer_period_ee/20)+1)*20;
2715  0183 ce4008        	ldw	x,_timer_period_ee
2716  0186 a614          	ld	a,#20
2717  0188 cd0000        	call	c_sdivx
2719  018b 90ae0014      	ldw	y,#20
2720  018f cd0000        	call	c_imul
2722  0192 1c0014        	addw	x,#20
2723  0195 89            	pushw	x
2724  0196 ae4008        	ldw	x,#_timer_period_ee
2725  0199 cd0000        	call	c_eewrw
2727  019c 85            	popw	x
2728                     ; 194 				if(timer_period_ee>180)timer_period_ee=20;
2730  019d 9c            	rvf
2731  019e ce4008        	ldw	x,_timer_period_ee
2732  01a1 a300b5        	cpw	x,#181
2733  01a4 2f0b          	jrslt	L7651
2736  01a6 ae0014        	ldw	x,#20
2737  01a9 89            	pushw	x
2738  01aa ae4008        	ldw	x,#_timer_period_ee
2739  01ad cd0000        	call	c_eewrw
2741  01b0 85            	popw	x
2742  01b1               L7651:
2743                     ; 195 				timer_pause_cnt=4;
2745  01b1 ae0004        	ldw	x,#4
2746  01b4 bf04          	ldw	_timer_pause_cnt,x
2747                     ; 196 				mode_phase=mpOFF;
2749  01b6 3f0b          	clr	_mode_phase
2751  01b8 200b          	jra	L5551
2752  01ba               L5651:
2753                     ; 199 			else if(mode_phase!=mpON)
2755  01ba b60b          	ld	a,_mode_phase
2756  01bc a101          	cp	a,#1
2757  01be 2705          	jreq	L5551
2758                     ; 203 				timer_pause_cnt=4;
2760  01c0 ae0004        	ldw	x,#4
2761  01c3 bf04          	ldw	_timer_pause_cnt,x
2762  01c5               L5551:
2763                     ; 208 	if(but==butT_)
2765  01c5 b617          	ld	a,_but
2766  01c7 a17d          	cp	a,#125
2767  01c9 260e          	jrne	L5751
2768                     ; 210 		if((mode==mTIMER)&&(mode_phase==mpON))
2770  01cb b60c          	ld	a,_mode
2771  01cd a101          	cp	a,#1
2772  01cf 2608          	jrne	L5751
2774  01d1 b60b          	ld	a,_mode_phase
2775  01d3 a101          	cp	a,#1
2776  01d5 2602          	jrne	L5751
2777                     ; 212 			mode_phase=mpOFF;
2779  01d7 3f0b          	clr	_mode_phase
2780  01d9               L5751:
2781                     ; 216 	if(but==butL)
2783  01d9 b617          	ld	a,_but
2784  01db a1fb          	cp	a,#251
2785  01dd 2613          	jrne	L1061
2786                     ; 218 		if((mode!=mLOOP)||(mode_phase==mpOFF))
2788  01df b60c          	ld	a,_mode
2789  01e1 a102          	cp	a,#2
2790  01e3 2604          	jrne	L5061
2792  01e5 3d0b          	tnz	_mode_phase
2793  01e7 2609          	jrne	L1061
2794  01e9               L5061:
2795                     ; 220 			mode=mLOOP;
2797  01e9 3502000c      	mov	_mode,#2
2798                     ; 221 			loop_wrk_cnt=SEC_IN_MIN*MIN_IN_LOOP;
2800  01ed ae00c8        	ldw	x,#200
2801  01f0 bf02          	ldw	_loop_wrk_cnt,x
2802  01f2               L1061:
2803                     ; 224 	if(but==butL_)
2805  01f2 b617          	ld	a,_but
2806  01f4 a17b          	cp	a,#123
2807  01f6 260e          	jrne	L7061
2808                     ; 226 		if((mode==mLOOP))
2810  01f8 b60c          	ld	a,_mode
2811  01fa a102          	cp	a,#2
2812  01fc 2608          	jrne	L7061
2813                     ; 228 			mode_phase=mpOFF;
2815  01fe 3f0b          	clr	_mode_phase
2816                     ; 229 			loop_wrk_cnt=0;
2818  0200 5f            	clrw	x
2819  0201 bf02          	ldw	_loop_wrk_cnt,x
2820                     ; 230 			loop_pause_cnt=0;
2822  0203 5f            	clrw	x
2823  0204 bf00          	ldw	_loop_pause_cnt,x
2824  0206               L7061:
2825                     ; 233 	if(but==butKTL_)
2827  0206 b617          	ld	a,_but
2828  0208 a178          	cp	a,#120
2829  020a 260e          	jrne	L7351
2830                     ; 235 		main_cnt_ee=MAX_RESURS;
2832  020c ae003c        	ldw	x,#60
2833  020f 89            	pushw	x
2834  0210 ae4002        	ldw	x,#_main_cnt_ee
2835  0213 cd0000        	call	c_eewrw
2837  0216 85            	popw	x
2838                     ; 236 		second_cnt=0;
2840  0217 5f            	clrw	x
2841  0218 bf08          	ldw	_second_cnt,x
2842  021a               L7351:
2843                     ; 239 n_but=0;
2845  021a 3f15          	clr	_n_but
2846                     ; 240 }
2849  021c 81            	ret
2884                     ; 243 void but_drv(void)
2884                     ; 244 {
2885                     	switch	.text
2886  021d               _but_drv:
2890                     ; 246 but_n=(but_stat)|0xf8; 	
2892  021d b60d          	ld	a,_but_stat
2893  021f aaf8          	or	a,#248
2894  0221 b719          	ld	_but_n,a
2895                     ; 247 if((but_n==0xff)||(but_n!=but_s))
2897  0223 b619          	ld	a,_but_n
2898  0225 a1ff          	cp	a,#255
2899  0227 2706          	jreq	L3361
2901  0229 b619          	ld	a,_but_n
2902  022b b118          	cp	a,_but_s
2903  022d 273b          	jreq	L1361
2904  022f               L3361:
2905                     ; 249  	speed=0;
2907  022f 3f10          	clr	_speed
2908                     ; 251 	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
2910  0231 9c            	rvf
2911  0232 be13          	ldw	x,_but0_cnt
2912  0234 a30005        	cpw	x,#5
2913  0237 2e04          	jrsge	L7361
2915  0239 be11          	ldw	x,_but1_cnt
2916  023b 270b          	jreq	L5361
2917  023d               L7361:
2919  023d 3d16          	tnz	_l_but
2920  023f 2607          	jrne	L5361
2921                     ; 253    	n_but=1;
2923  0241 35010015      	mov	_n_but,#1
2924                     ; 254     but=(char)but_s;
2926  0245 451817        	mov	_but,_but_s
2927  0248               L5361:
2928                     ; 256  	if (but1_cnt>=but_onL_temp)
2930  0248 9c            	rvf
2931  0249 be11          	ldw	x,_but1_cnt
2932  024b b30e          	cpw	x,_but_onL_temp
2933  024d 2f0a          	jrslt	L1461
2934                     ; 258     n_but=1;
2936  024f 35010015      	mov	_n_but,#1
2937                     ; 259 		but=((char)but_s)&0x7f;
2939  0253 b618          	ld	a,_but_s
2940  0255 a47f          	and	a,#127
2941  0257 b717          	ld	_but,a
2942  0259               L1461:
2943                     ; 261 	l_but=0;
2945  0259 3f16          	clr	_l_but
2946                     ; 262 	but_onL_temp=BUT_ONL;
2948  025b ae03e8        	ldw	x,#1000
2949  025e bf0e          	ldw	_but_onL_temp,x
2950                     ; 263 	but0_cnt=0;
2952  0260 5f            	clrw	x
2953  0261 bf13          	ldw	_but0_cnt,x
2954                     ; 264 	but1_cnt=0;          
2956  0263 5f            	clrw	x
2957  0264 bf11          	ldw	_but1_cnt,x
2958                     ; 265 	goto but_drv_out;
2959  0266               L5161:
2960                     ; 288 but_drv_out: 
2960                     ; 289 but_s=but_n;
2962  0266 451918        	mov	_but_s,_but_n
2963                     ; 291 }
2966  0269 81            	ret
2967  026a               L1361:
2968                     ; 267 if(but_n==but_s)
2970  026a b619          	ld	a,_but_n
2971  026c b118          	cp	a,_but_s
2972  026e 26f6          	jrne	L5161
2973                     ; 269   but0_cnt++;
2975  0270 be13          	ldw	x,_but0_cnt
2976  0272 1c0001        	addw	x,#1
2977  0275 bf13          	ldw	_but0_cnt,x
2978                     ; 270 	if(but0_cnt>=BUT_ON)
2980  0277 9c            	rvf
2981  0278 be13          	ldw	x,_but0_cnt
2982  027a a30005        	cpw	x,#5
2983  027d 2fe7          	jrslt	L5161
2984                     ; 272 		but0_cnt=0;
2986  027f 5f            	clrw	x
2987  0280 bf13          	ldw	_but0_cnt,x
2988                     ; 273 		but1_cnt++;
2990  0282 be11          	ldw	x,_but1_cnt
2991  0284 1c0001        	addw	x,#1
2992  0287 bf11          	ldw	_but1_cnt,x
2993                     ; 274 		if(but1_cnt>=but_onL_temp)
2995  0289 9c            	rvf
2996  028a be11          	ldw	x,_but1_cnt
2997  028c b30e          	cpw	x,_but_onL_temp
2998  028e 2fd6          	jrslt	L5161
2999                     ; 276 			but=(char)(but_s&0x7f);
3001  0290 b618          	ld	a,_but_s
3002  0292 a47f          	and	a,#127
3003  0294 b717          	ld	_but,a
3004                     ; 277 			but1_cnt=0;
3006  0296 5f            	clrw	x
3007  0297 bf11          	ldw	_but1_cnt,x
3008                     ; 278 			n_but=1;
3010  0299 35010015      	mov	_n_but,#1
3011                     ; 279 			l_but=1;
3013  029d 35010016      	mov	_l_but,#1
3014                     ; 280 			if(speed)
3016  02a1 3d10          	tnz	_speed
3017  02a3 27c1          	jreq	L5161
3018                     ; 282 				but_onL_temp=but_onL_temp>>1;
3020  02a5 370e          	sra	_but_onL_temp
3021  02a7 360f          	rrc	_but_onL_temp+1
3022                     ; 283 				if(but_onL_temp<=2) but_onL_temp=2;
3024  02a9 9c            	rvf
3025  02aa be0e          	ldw	x,_but_onL_temp
3026  02ac a30003        	cpw	x,#3
3027  02af 2eb5          	jrsge	L5161
3030  02b1 ae0002        	ldw	x,#2
3031  02b4 bf0e          	ldw	_but_onL_temp,x
3032  02b6 20ae          	jra	L5161
3076                     ; 293 void bin2bcd_int(unsigned short in) 
3076                     ; 294 {
3077                     	switch	.text
3078  02b8               _bin2bcd_int:
3080  02b8 89            	pushw	x
3081  02b9 88            	push	a
3082       00000001      OFST:	set	1
3085                     ; 295 char i=5;
3087                     ; 297 for(i=0;i<5;i++)
3089  02ba 0f01          	clr	(OFST+0,sp)
3090  02bc               L7761:
3091                     ; 299 	dig[i]=in%10;
3093  02bc 1e02          	ldw	x,(OFST+1,sp)
3094  02be 90ae000a      	ldw	y,#10
3095  02c2 65            	divw	x,y
3096  02c3 51            	exgw	x,y
3097  02c4 7b01          	ld	a,(OFST+0,sp)
3098  02c6 905f          	clrw	y
3099  02c8 9097          	ld	yl,a
3100  02ca 01            	rrwa	x,a
3101  02cb 90e725        	ld	(_dig,y),a
3102  02ce 02            	rlwa	x,a
3103                     ; 300 	in/=10;
3105  02cf 1e02          	ldw	x,(OFST+1,sp)
3106  02d1 90ae000a      	ldw	y,#10
3107  02d5 65            	divw	x,y
3108  02d6 1f02          	ldw	(OFST+1,sp),x
3109                     ; 297 for(i=0;i<5;i++)
3111  02d8 0c01          	inc	(OFST+0,sp)
3114  02da 7b01          	ld	a,(OFST+0,sp)
3115  02dc a105          	cp	a,#5
3116  02de 25dc          	jrult	L7761
3117                     ; 302 }
3120  02e0 5b03          	addw	sp,#3
3121  02e2 81            	ret
3158                     ; 305 void bcd2ind(void) 
3158                     ; 306 {
3159                     	switch	.text
3160  02e3               _bcd2ind:
3162  02e3 88            	push	a
3163       00000001      OFST:	set	1
3166                     ; 309 for (i=4;i>0;i--)
3168  02e4 a604          	ld	a,#4
3169  02e6 6b01          	ld	(OFST+0,sp),a
3170  02e8               L3271:
3171                     ; 311 	ind_out_[i-1]=DIGISYM[dig[i-1]];
3173  02e8 7b01          	ld	a,(OFST+0,sp)
3174  02ea 5f            	clrw	x
3175  02eb 97            	ld	xl,a
3176  02ec 5a            	decw	x
3177  02ed 7b01          	ld	a,(OFST+0,sp)
3178  02ef 905f          	clrw	y
3179  02f1 9097          	ld	yl,a
3180  02f3 905a          	decw	y
3181  02f5 90e625        	ld	a,(_dig,y)
3182  02f8 905f          	clrw	y
3183  02fa 9097          	ld	yl,a
3184  02fc 90d60000      	ld	a,(_DIGISYM,y)
3185  0300 e720          	ld	(_ind_out_,x),a
3186                     ; 309 for (i=4;i>0;i--)
3188  0302 0a01          	dec	(OFST+0,sp)
3191  0304 0d01          	tnz	(OFST+0,sp)
3192  0306 26e0          	jrne	L3271
3193                     ; 313 } 
3196  0308 84            	pop	a
3197  0309 81            	ret
3235                     ; 316 void bcd2ind_zero(void) 
3235                     ; 317 {
3236                     	switch	.text
3237  030a               _bcd2ind_zero:
3239  030a 88            	push	a
3240       00000001      OFST:	set	1
3243                     ; 319 zero_on=1;
3245  030b 3501001c      	mov	_zero_on,#1
3246                     ; 320 for (i=4;i>0;i--)
3248  030f a604          	ld	a,#4
3249  0311 6b01          	ld	(OFST+0,sp),a
3250  0313               L7471:
3251                     ; 322 	if(zero_on&&(!dig[i-1])&&(i-1))
3253  0313 3d1c          	tnz	_zero_on
3254  0315 271e          	jreq	L5571
3256  0317 7b01          	ld	a,(OFST+0,sp)
3257  0319 5f            	clrw	x
3258  031a 97            	ld	xl,a
3259  031b 5a            	decw	x
3260  031c 6d25          	tnz	(_dig,x)
3261  031e 2615          	jrne	L5571
3263  0320 7b01          	ld	a,(OFST+0,sp)
3264  0322 5f            	clrw	x
3265  0323 97            	ld	xl,a
3266  0324 5a            	decw	x
3267  0325 a30000        	cpw	x,#0
3268  0328 270b          	jreq	L5571
3269                     ; 324 		ind_out_[i-1]=0b11111111;
3271  032a 7b01          	ld	a,(OFST+0,sp)
3272  032c 5f            	clrw	x
3273  032d 97            	ld	xl,a
3274  032e 5a            	decw	x
3275  032f a6ff          	ld	a,#255
3276  0331 e720          	ld	(_ind_out_,x),a
3278  0333 201c          	jra	L7571
3279  0335               L5571:
3280                     ; 328 		ind_out_[i-1]=DIGISYM[dig[i-1]];
3282  0335 7b01          	ld	a,(OFST+0,sp)
3283  0337 5f            	clrw	x
3284  0338 97            	ld	xl,a
3285  0339 5a            	decw	x
3286  033a 7b01          	ld	a,(OFST+0,sp)
3287  033c 905f          	clrw	y
3288  033e 9097          	ld	yl,a
3289  0340 905a          	decw	y
3290  0342 90e625        	ld	a,(_dig,y)
3291  0345 905f          	clrw	y
3292  0347 9097          	ld	yl,a
3293  0349 90d60000      	ld	a,(_DIGISYM,y)
3294  034d e720          	ld	(_ind_out_,x),a
3295                     ; 329 		zero_on=0;
3297  034f 3f1c          	clr	_zero_on
3298  0351               L7571:
3299                     ; 320 for (i=4;i>0;i--)
3301  0351 0a01          	dec	(OFST+0,sp)
3304  0353 0d01          	tnz	(OFST+0,sp)
3305  0355 26bc          	jrne	L7471
3306                     ; 332 }
3309  0357 84            	pop	a
3310  0358 81            	ret
3397                     ; 335 void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
3397                     ; 336 {
3398                     	switch	.text
3399  0359               _int2indI_slkuf:
3401  0359 89            	pushw	x
3402  035a 88            	push	a
3403       00000001      OFST:	set	1
3406                     ; 344 bin2bcd_int(in);
3408  035b cd02b8        	call	_bin2bcd_int
3410                     ; 345 if(unzero)bcd2ind_zero();
3412  035e 0d08          	tnz	(OFST+7,sp)
3413  0360 2704          	jreq	L3202
3416  0362 ada6          	call	_bcd2ind_zero
3419  0364 2003          	jra	L5202
3420  0366               L3202:
3421                     ; 346 else bcd2ind();
3423  0366 cd02e3        	call	_bcd2ind
3425  0369               L5202:
3426                     ; 347 if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
3428  0369 7b09          	ld	a,(OFST+8,sp)
3429  036b a101          	cp	a,#1
3430  036d 2604          	jrne	L3302
3432  036f 3d1e          	tnz	_bFL2
3433  0371 2614          	jrne	L1302
3434  0373               L3302:
3436  0373 7b09          	ld	a,(OFST+8,sp)
3437  0375 a102          	cp	a,#2
3438  0377 2604          	jrne	L7302
3440  0379 3d1e          	tnz	_bFL2
3441  037b 260a          	jrne	L1302
3442  037d               L7302:
3444  037d 7b09          	ld	a,(OFST+8,sp)
3445  037f a105          	cp	a,#5
3446  0381 2618          	jrne	L7202
3448  0383 3d1f          	tnz	_bFL5
3449  0385 2714          	jreq	L7202
3450  0387               L1302:
3451                     ; 349 	for(i=0;i<len;i++) 
3453  0387 0f01          	clr	(OFST+0,sp)
3455  0389 200a          	jra	L5402
3456  038b               L1402:
3457                     ; 351 		ind_out_[i]=DIGISYM[17];
3459  038b 7b01          	ld	a,(OFST+0,sp)
3460  038d 5f            	clrw	x
3461  038e 97            	ld	xl,a
3462  038f a6ff          	ld	a,#255
3463  0391 e720          	ld	(_ind_out_,x),a
3464                     ; 349 	for(i=0;i<len;i++) 
3466  0393 0c01          	inc	(OFST+0,sp)
3467  0395               L5402:
3470  0395 7b01          	ld	a,(OFST+0,sp)
3471  0397 1107          	cp	a,(OFST+6,sp)
3472  0399 25f0          	jrult	L1402
3473  039b               L7202:
3474                     ; 355 for(i=0;i<len;i++) 
3476  039b 0f01          	clr	(OFST+0,sp)
3478  039d 2016          	jra	L5502
3479  039f               L1502:
3480                     ; 357 	ind_out[start+i]=ind_out_[i];
3482  039f 7b06          	ld	a,(OFST+5,sp)
3483  03a1 5f            	clrw	x
3484  03a2 1b01          	add	a,(OFST+0,sp)
3485  03a4 2401          	jrnc	L06
3486  03a6 5c            	incw	x
3487  03a7               L06:
3488  03a7 02            	rlwa	x,a
3489  03a8 7b01          	ld	a,(OFST+0,sp)
3490  03aa 905f          	clrw	y
3491  03ac 9097          	ld	yl,a
3492  03ae 90e620        	ld	a,(_ind_out_,y)
3493  03b1 e700          	ld	(_ind_out,x),a
3494                     ; 355 for(i=0;i<len;i++) 
3496  03b3 0c01          	inc	(OFST+0,sp)
3497  03b5               L5502:
3500  03b5 7b01          	ld	a,(OFST+0,sp)
3501  03b7 1107          	cp	a,(OFST+6,sp)
3502  03b9 25e4          	jrult	L1502
3503                     ; 359 }
3506  03bb 5b03          	addw	sp,#3
3507  03bd 81            	ret
3534                     ; 362 void led_hndl(void)
3534                     ; 363 {
3535                     	switch	.text
3536  03be               _led_hndl:
3540                     ; 364 if(mode==mKONST)
3542  03be 3d0c          	tnz	_mode
3543  03c0 2618          	jrne	L1702
3544                     ; 366 	if(mode_phase==mpOFF)led_stat=0x00;
3546  03c2 3d0b          	tnz	_mode_phase
3547  03c4 2604          	jrne	L3702
3550  03c6 3f1b          	clr	_led_stat
3552  03c8 204a          	jra	L3012
3553  03ca               L3702:
3554                     ; 369 		if(bFL1)led_stat=0x01;
3556  03ca 3d1d          	tnz	_bFL1
3557  03cc 2706          	jreq	L7702
3560  03ce 3501001b      	mov	_led_stat,#1
3562  03d2 2040          	jra	L3012
3563  03d4               L7702:
3564                     ; 370 		else led_stat=0x01;
3566  03d4 3501001b      	mov	_led_stat,#1
3567  03d8 203a          	jra	L3012
3568  03da               L1702:
3569                     ; 373 else if(mode==mTIMER)
3571  03da b60c          	ld	a,_mode
3572  03dc a101          	cp	a,#1
3573  03de 2618          	jrne	L5012
3574                     ; 375 	if(mode_phase==mpOFF)led_stat=0x00;
3576  03e0 3d0b          	tnz	_mode_phase
3577  03e2 2604          	jrne	L7012
3580  03e4 3f1b          	clr	_led_stat
3582  03e6 202c          	jra	L3012
3583  03e8               L7012:
3584                     ; 378 		if(bFL1)led_stat=0x02;
3586  03e8 3d1d          	tnz	_bFL1
3587  03ea 2706          	jreq	L3112
3590  03ec 3502001b      	mov	_led_stat,#2
3592  03f0 2022          	jra	L3012
3593  03f2               L3112:
3594                     ; 379 		else led_stat=0x02;
3596  03f2 3502001b      	mov	_led_stat,#2
3597  03f6 201c          	jra	L3012
3598  03f8               L5012:
3599                     ; 382 else if(mode==mLOOP)
3601  03f8 b60c          	ld	a,_mode
3602  03fa a102          	cp	a,#2
3603  03fc 2616          	jrne	L3012
3604                     ; 384 	if(mode_phase==mpOFF)led_stat=0x00;
3606  03fe 3d0b          	tnz	_mode_phase
3607  0400 2604          	jrne	L3212
3610  0402 3f1b          	clr	_led_stat
3612  0404 200e          	jra	L3012
3613  0406               L3212:
3614                     ; 387 		if(bFL1)led_stat=0x04;
3616  0406 3d1d          	tnz	_bFL1
3617  0408 2706          	jreq	L7212
3620  040a 3504001b      	mov	_led_stat,#4
3622  040e 2004          	jra	L3012
3623  0410               L7212:
3624                     ; 388 		else led_stat=0x04;
3626  0410 3504001b      	mov	_led_stat,#4
3627  0414               L3012:
3628                     ; 391 }
3631  0414 81            	ret
3663                     ; 420 void ind_hndl(void) 
3663                     ; 421 {
3664                     	switch	.text
3665  0415               _ind_hndl:
3669                     ; 422 if((main_cnt_ee==0)&&(mode_phase==mpOFF))
3671  0415 ce4002        	ldw	x,_main_cnt_ee
3672  0418 2618          	jrne	L3412
3674  041a 3d0b          	tnz	_mode_phase
3675  041c 2614          	jrne	L3412
3676                     ; 424 	int2indI_slkuf(main_cnt_ee, 0, 4, 0, 1);	
3678  041e 4b01          	push	#1
3679  0420 4b00          	push	#0
3680  0422 4b04          	push	#4
3681  0424 4b00          	push	#0
3682  0426 ce4002        	ldw	x,_main_cnt_ee
3683  0429 cd0359        	call	_int2indI_slkuf
3685  042c 5b04          	addw	sp,#4
3687  042e ac030503      	jpf	L5412
3688  0432               L3412:
3689                     ; 426 else if(mode==mKONST)
3691  0432 3d0c          	tnz	_mode
3692  0434 262e          	jrne	L7412
3693                     ; 428 	if(mode_phase==mpON)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3695  0436 b60b          	ld	a,_mode_phase
3696  0438 a101          	cp	a,#1
3697  043a 2614          	jrne	L1512
3700  043c 4b00          	push	#0
3701  043e 4b00          	push	#0
3702  0440 4b04          	push	#4
3703  0442 4b00          	push	#0
3704  0444 ce4002        	ldw	x,_main_cnt_ee
3705  0447 cd0359        	call	_int2indI_slkuf
3707  044a 5b04          	addw	sp,#4
3709  044c ac030503      	jpf	L5412
3710  0450               L1512:
3711                     ; 429 	else int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3713  0450 4b00          	push	#0
3714  0452 4b00          	push	#0
3715  0454 4b04          	push	#4
3716  0456 4b00          	push	#0
3717  0458 ce4002        	ldw	x,_main_cnt_ee
3718  045b cd0359        	call	_int2indI_slkuf
3720  045e 5b04          	addw	sp,#4
3721  0460 ac030503      	jpf	L5412
3722  0464               L7412:
3723                     ; 431 else if(mode==mTIMER)
3725  0464 b60c          	ld	a,_mode
3726  0466 a101          	cp	a,#1
3727  0468 264a          	jrne	L7512
3728                     ; 433 	if(timer_pause_cnt)int2indI_slkuf(timer_period_ee, 0, 4, 0, 0);
3730  046a be04          	ldw	x,_timer_pause_cnt
3731  046c 2713          	jreq	L1612
3734  046e 4b00          	push	#0
3735  0470 4b00          	push	#0
3736  0472 4b04          	push	#4
3737  0474 4b00          	push	#0
3738  0476 ce4008        	ldw	x,_timer_period_ee
3739  0479 cd0359        	call	_int2indI_slkuf
3741  047c 5b04          	addw	sp,#4
3743  047e cc0503        	jra	L5412
3744  0481               L1612:
3745                     ; 434 	else if(mode_phase==mpON)int2indI_slkuf((timer_second_cnt/SEC_IN_MIN)+1, 0, 3, 0, 0);
3747  0481 b60b          	ld	a,_mode_phase
3748  0483 a101          	cp	a,#1
3749  0485 2617          	jrne	L5612
3752  0487 4b00          	push	#0
3753  0489 4b00          	push	#0
3754  048b 4b03          	push	#3
3755  048d 4b00          	push	#0
3756  048f be06          	ldw	x,_timer_second_cnt
3757  0491 a614          	ld	a,#20
3758  0493 cd0000        	call	c_sdivx
3760  0496 5c            	incw	x
3761  0497 cd0359        	call	_int2indI_slkuf
3763  049a 5b04          	addw	sp,#4
3765  049c 2065          	jra	L5412
3766  049e               L5612:
3767                     ; 435 	else if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3769  049e 3d0b          	tnz	_mode_phase
3770  04a0 2661          	jrne	L5412
3773  04a2 4b00          	push	#0
3774  04a4 4b00          	push	#0
3775  04a6 4b04          	push	#4
3776  04a8 4b00          	push	#0
3777  04aa ce4002        	ldw	x,_main_cnt_ee
3778  04ad cd0359        	call	_int2indI_slkuf
3780  04b0 5b04          	addw	sp,#4
3781  04b2 204f          	jra	L5412
3782  04b4               L7512:
3783                     ; 442 else if(mode==mLOOP)
3785  04b4 b60c          	ld	a,_mode
3786  04b6 a102          	cp	a,#2
3787  04b8 2649          	jrne	L5412
3788                     ; 444 	if(mode_phase==mpOFF)int2indI_slkuf(main_cnt_ee, 0, 4, 0, 0);
3790  04ba 3d0b          	tnz	_mode_phase
3791  04bc 2612          	jrne	L7712
3794  04be 4b00          	push	#0
3795  04c0 4b00          	push	#0
3796  04c2 4b04          	push	#4
3797  04c4 4b00          	push	#0
3798  04c6 ce4002        	ldw	x,_main_cnt_ee
3799  04c9 cd0359        	call	_int2indI_slkuf
3801  04cc 5b04          	addw	sp,#4
3803  04ce 2033          	jra	L5412
3804  04d0               L7712:
3805                     ; 445 	else if(mode_phase==mpON)
3807  04d0 b60b          	ld	a,_mode_phase
3808  04d2 a101          	cp	a,#1
3809  04d4 2617          	jrne	L3022
3810                     ; 447 		int2indI_slkuf((loop_wrk_cnt/SEC_IN_MIN)+1, 0, 4, 0, 0);	
3812  04d6 4b00          	push	#0
3813  04d8 4b00          	push	#0
3814  04da 4b04          	push	#4
3815  04dc 4b00          	push	#0
3816  04de be02          	ldw	x,_loop_wrk_cnt
3817  04e0 a614          	ld	a,#20
3818  04e2 cd0000        	call	c_sdivx
3820  04e5 5c            	incw	x
3821  04e6 cd0359        	call	_int2indI_slkuf
3823  04e9 5b04          	addw	sp,#4
3825  04eb 2016          	jra	L5412
3826  04ed               L3022:
3827                     ; 450 	else if(mode_phase==mpPAUSE)	
3829  04ed b60b          	ld	a,_mode_phase
3830  04ef a102          	cp	a,#2
3831  04f1 2610          	jrne	L5412
3832                     ; 452 		ind_out[0]=0b00001001;
3834  04f3 35090000      	mov	_ind_out,#9
3835                     ; 453 		ind_out[1]=0b00001010;
3837  04f7 350a0001      	mov	_ind_out+1,#10
3838                     ; 454 		ind_out[2]=0b00010000;
3840  04fb 35100002      	mov	_ind_out+2,#16
3841                     ; 455 		ind_out[3]=0b10010100;
3843  04ff 35940003      	mov	_ind_out+3,#148
3844  0503               L5412:
3845                     ; 461 }
3848  0503 81            	ret
3871                     ; 464 void gpio_init(void){
3872                     	switch	.text
3873  0504               _gpio_init:
3877                     ; 465 	GPIOA->DDR|=((1<<1)|(1<<2));
3879  0504 c65002        	ld	a,20482
3880  0507 aa06          	or	a,#6
3881  0509 c75002        	ld	20482,a
3882                     ; 466 	GPIOA->CR1|=((1<<1)|(1<<2));
3884  050c c65003        	ld	a,20483
3885  050f aa06          	or	a,#6
3886  0511 c75003        	ld	20483,a
3887                     ; 467 	GPIOA->CR2&=~((1<<1)|(1<<2));
3889  0514 c65004        	ld	a,20484
3890  0517 a4f9          	and	a,#249
3891  0519 c75004        	ld	20484,a
3892                     ; 468 	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3894  051c c65011        	ld	a,20497
3895  051f aa7c          	or	a,#124
3896  0521 c75011        	ld	20497,a
3897                     ; 469 	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3899  0524 c65012        	ld	a,20498
3900  0527 a483          	and	a,#131
3901  0529 c75012        	ld	20498,a
3902                     ; 470 	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3904  052c c65013        	ld	a,20499
3905  052f a483          	and	a,#131
3906  0531 c75013        	ld	20499,a
3907                     ; 474 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3909  0534 c65008        	ld	a,20488
3910  0537 a4f0          	and	a,#240
3911  0539 c75008        	ld	20488,a
3912                     ; 475 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3914  053c c65009        	ld	a,20489
3915  053f a4f0          	and	a,#240
3916  0541 c75009        	ld	20489,a
3917                     ; 476 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
3919  0544 c65007        	ld	a,20487
3920  0547 aa0f          	or	a,#15
3921  0549 c75007        	ld	20487,a
3922                     ; 479 	GPIOC->CR1|=((1<<3));
3924  054c 7216500d      	bset	20493,#3
3925                     ; 480 	GPIOC->CR2&=~((1<<3));
3927  0550 7217500e      	bres	20494,#3
3928                     ; 481 	GPIOB->CR1|=((1<<4)|(1<<5));
3930  0554 c65008        	ld	a,20488
3931  0557 aa30          	or	a,#48
3932  0559 c75008        	ld	20488,a
3933                     ; 482 	GPIOB->CR2&=~((1<<4)|(1<<5));
3935  055c c65009        	ld	a,20489
3936  055f a4cf          	and	a,#207
3937  0561 c75009        	ld	20489,a
3938                     ; 485 	GPIOC->CR1&=~0xfe;
3940  0564 c6500d        	ld	a,20493
3941  0567 a401          	and	a,#1
3942  0569 c7500d        	ld	20493,a
3943                     ; 486 	GPIOC->CR2&=~0xfe;
3945  056c c6500e        	ld	a,20494
3946  056f a401          	and	a,#1
3947  0571 c7500e        	ld	20494,a
3948                     ; 487 	GPIOC->DDR|=0xfe;
3950  0574 c6500c        	ld	a,20492
3951  0577 aafe          	or	a,#254
3952  0579 c7500c        	ld	20492,a
3953                     ; 507 	GPIOB->DDR&=~(1<<5);	
3955  057c 721b5007      	bres	20487,#5
3956                     ; 508 	GPIOB->CR1|=(1<<5);
3958  0580 721a5008      	bset	20488,#5
3959                     ; 509 	GPIOB->CR2&=~(1<<5);
3961  0584 721b5009      	bres	20489,#5
3962                     ; 511 	GPIOB->ODR|=0x0f;
3964  0588 c65005        	ld	a,20485
3965  058b aa0f          	or	a,#15
3966  058d c75005        	ld	20485,a
3967                     ; 512 }
3970  0590 81            	ret
3993                     ; 515 void t4_init(void){
3994                     	switch	.text
3995  0591               _t4_init:
3999                     ; 516 	TIM4->PSCR = 7;
4001  0591 35075347      	mov	21319,#7
4002                     ; 517 	TIM4->ARR= 123;
4004  0595 357b5348      	mov	21320,#123
4005                     ; 518 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
4007  0599 72105343      	bset	21315,#0
4008                     ; 520 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
4010  059d 35855340      	mov	21312,#133
4011                     ; 521 }	
4014  05a1 81            	ret
4055                     ; 527 @far @interrupt void TIM4_UPD_Interrupt (void) 
4055                     ; 528 {
4057                     	switch	.text
4058  05a2               f_TIM4_UPD_Interrupt:
4062                     ; 530 ind_cnt++;
4064  05a2 3c2f          	inc	_ind_cnt
4065                     ; 532 if(ind_cnt>=5)ind_cnt=0;
4067  05a4 b62f          	ld	a,_ind_cnt
4068  05a6 a105          	cp	a,#5
4069  05a8 2502          	jrult	L1422
4072  05aa 3f2f          	clr	_ind_cnt
4073  05ac               L1422:
4074                     ; 534 GPIOC->ODR|=0xf0;
4076  05ac c6500a        	ld	a,20490
4077  05af aaf0          	or	a,#240
4078  05b1 c7500a        	ld	20490,a
4079                     ; 537 GPIOA->ODR|=0x06;
4081  05b4 c65000        	ld	a,20480
4082  05b7 aa06          	or	a,#6
4083  05b9 c75000        	ld	20480,a
4084                     ; 538 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
4086  05bc b62f          	ld	a,_ind_cnt
4087  05be 5f            	clrw	x
4088  05bf 97            	ld	xl,a
4089  05c0 e600          	ld	a,(_ind_out,x)
4090  05c2 48            	sll	a
4091  05c3 aaf9          	or	a,#249
4092  05c5 c45000        	and	a,20480
4093  05c8 c75000        	ld	20480,a
4094                     ; 539 GPIOD->ODR|=0x7c;
4096  05cb c6500f        	ld	a,20495
4097  05ce aa7c          	or	a,#124
4098  05d0 c7500f        	ld	20495,a
4099                     ; 540 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
4101  05d3 b62f          	ld	a,_ind_cnt
4102  05d5 5f            	clrw	x
4103  05d6 97            	ld	xl,a
4104  05d7 e600          	ld	a,(_ind_out,x)
4105  05d9 aa83          	or	a,#131
4106  05db c4500f        	and	a,20495
4107  05de c7500f        	ld	20495,a
4108                     ; 544 GPIOC->ODR&=~(0x10<<ind_cnt);
4110  05e1 b62f          	ld	a,_ind_cnt
4111  05e3 5f            	clrw	x
4112  05e4 97            	ld	xl,a
4113  05e5 a610          	ld	a,#16
4114  05e7 5d            	tnzw	x
4115  05e8 2704          	jreq	L47
4116  05ea               L67:
4117  05ea 48            	sll	a
4118  05eb 5a            	decw	x
4119  05ec 26fc          	jrne	L67
4120  05ee               L47:
4121  05ee 43            	cpl	a
4122  05ef c4500a        	and	a,20490
4123  05f2 c7500a        	ld	20490,a
4124                     ; 545 if(ind_cnt==4)
4126  05f5 b62f          	ld	a,_ind_cnt
4127  05f7 a104          	cp	a,#4
4128  05f9 2604          	jrne	L3422
4129                     ; 547 	GPIOC->ODR&=~(0x10);
4131  05fb 7219500a      	bres	20490,#4
4132  05ff               L3422:
4133                     ; 550 GPIOC->CR1|=((1<<3));
4135  05ff 7216500d      	bset	20493,#3
4136                     ; 551 GPIOC->CR2&=~((1<<3));
4138  0603 7217500e      	bres	20494,#3
4139                     ; 552 GPIOB->CR1|=((1<<4)|(1<<5));
4141  0607 c65008        	ld	a,20488
4142  060a aa30          	or	a,#48
4143  060c c75008        	ld	20488,a
4144                     ; 553 GPIOB->CR2&=~((1<<4)|(1<<5));
4146  060f c65009        	ld	a,20489
4147  0612 a4cf          	and	a,#207
4148  0614 c75009        	ld	20489,a
4149                     ; 555 if(ind_cnt==4)	
4151  0617 b62f          	ld	a,_ind_cnt
4152  0619 a104          	cp	a,#4
4153  061b 260e          	jrne	L5422
4154                     ; 557 	GPIOC->DDR&=~(1<<3);
4156  061d 7217500c      	bres	20492,#3
4157                     ; 558 	GPIOB->DDR&=~((1<<4)|(1<<5));
4159  0621 c65007        	ld	a,20487
4160  0624 a4cf          	and	a,#207
4161  0626 c75007        	ld	20487,a
4163  0629 2010          	jra	L7422
4164  062b               L5422:
4165                     ; 560 else if(ind_cnt==0)	
4167  062b 3d2f          	tnz	_ind_cnt
4168  062d 260c          	jrne	L7422
4169                     ; 562 	GPIOC->DDR|=((1<<3));
4171  062f 7216500c      	bset	20492,#3
4172                     ; 563 	GPIOB->DDR|=((1<<4)|(1<<5));
4174  0633 c65007        	ld	a,20487
4175  0636 aa30          	or	a,#48
4176  0638 c75007        	ld	20487,a
4177  063b               L7422:
4178                     ; 572 if(ind_cnt==0)	
4180  063b 3d2f          	tnz	_ind_cnt
4181  063d 2632          	jrne	L3522
4182                     ; 574 	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
4184  063f b61b          	ld	a,_led_stat
4185  0641 a501          	bcp	a,#1
4186  0643 2706          	jreq	L5522
4189  0645 7217500a      	bres	20490,#3
4191  0649 2004          	jra	L7522
4192  064b               L5522:
4193                     ; 575 	else 			GPIOC->ODR|=(1<<3);
4195  064b 7216500a      	bset	20490,#3
4196  064f               L7522:
4197                     ; 576 	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
4199  064f b61b          	ld	a,_led_stat
4200  0651 a502          	bcp	a,#2
4201  0653 2706          	jreq	L1622
4204  0655 72195005      	bres	20485,#4
4206  0659 2004          	jra	L3622
4207  065b               L1622:
4208                     ; 577 	else 			GPIOB->ODR|=(1<<4);
4210  065b 72185005      	bset	20485,#4
4211  065f               L3622:
4212                     ; 578 	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
4214  065f b61b          	ld	a,_led_stat
4215  0661 a504          	bcp	a,#4
4216  0663 2706          	jreq	L5622
4219  0665 721b5005      	bres	20485,#5
4221  0669 203f          	jra	L1722
4222  066b               L5622:
4223                     ; 579 	else 			GPIOB->ODR|=(1<<5);
4225  066b 721a5005      	bset	20485,#5
4226  066f 2039          	jra	L1722
4227  0671               L3522:
4228                     ; 581 else if(ind_cnt==4)	
4230  0671 b62f          	ld	a,_ind_cnt
4231  0673 a104          	cp	a,#4
4232  0675 2633          	jrne	L1722
4233                     ; 583 	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
4235  0677 c6500b        	ld	a,20491
4236  067a a508          	bcp	a,#8
4237  067c 2606          	jrne	L5722
4240  067e 7211000d      	bres	_but_stat,#0
4242  0682 2004          	jra	L7722
4243  0684               L5722:
4244                     ; 584 	else but_stat|=0x01;
4246  0684 7210000d      	bset	_but_stat,#0
4247  0688               L7722:
4248                     ; 585 	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
4250  0688 c65006        	ld	a,20486
4251  068b a510          	bcp	a,#16
4252  068d 2606          	jrne	L1032
4255  068f 7213000d      	bres	_but_stat,#1
4257  0693 2004          	jra	L3032
4258  0695               L1032:
4259                     ; 586 	else but_stat|=0x02;
4261  0695 7212000d      	bset	_but_stat,#1
4262  0699               L3032:
4263                     ; 587 	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
4265  0699 c65006        	ld	a,20486
4266  069c a520          	bcp	a,#32
4267  069e 2606          	jrne	L5032
4270  06a0 7215000d      	bres	_but_stat,#2
4272  06a4 2004          	jra	L1722
4273  06a6               L5032:
4274                     ; 588 	else but_stat|=0x04;	
4276  06a6 7214000d      	bset	_but_stat,#2
4277  06aa               L1722:
4278                     ; 591 b1000Hz=1;
4280  06aa 35010000      	mov	_b1000Hz,#1
4281                     ; 593 if(++t0_cnt0>=10)
4283  06ae 725c0006      	inc	_t0_cnt0
4284  06b2 c60006        	ld	a,_t0_cnt0
4285  06b5 a10a          	cp	a,#10
4286  06b7 2575          	jrult	L1132
4287                     ; 595 	t0_cnt0=0;
4289  06b9 725f0006      	clr	_t0_cnt0
4290                     ; 596     	b100Hz=1;
4292  06bd 35010001      	mov	_b100Hz,#1
4293                     ; 597 	if(++t0_cnt1>=10)
4295  06c1 725c0007      	inc	_t0_cnt1
4296  06c5 c60007        	ld	a,_t0_cnt1
4297  06c8 a10a          	cp	a,#10
4298  06ca 2508          	jrult	L3132
4299                     ; 599 		t0_cnt1=0;
4301  06cc 725f0007      	clr	_t0_cnt1
4302                     ; 600 		b10Hz=1;
4304  06d0 35010002      	mov	_b10Hz,#1
4305  06d4               L3132:
4306                     ; 603 	if(++t0_cnt2>=20)
4308  06d4 725c0008      	inc	_t0_cnt2
4309  06d8 c60008        	ld	a,_t0_cnt2
4310  06db a114          	cp	a,#20
4311  06dd 2513          	jrult	L5132
4312                     ; 605 		t0_cnt2=0;
4314  06df 725f0008      	clr	_t0_cnt2
4315                     ; 606 		b5Hz=1;
4317  06e3 35010003      	mov	_b5Hz,#1
4318                     ; 607 		bFL5=!bFL5;
4320  06e7 3d1f          	tnz	_bFL5
4321  06e9 2604          	jrne	L001
4322  06eb a601          	ld	a,#1
4323  06ed 2001          	jra	L201
4324  06ef               L001:
4325  06ef 4f            	clr	a
4326  06f0               L201:
4327  06f0 b71f          	ld	_bFL5,a
4328  06f2               L5132:
4329                     ; 610 	if(++t0_cnt3>=50)
4331  06f2 725c0009      	inc	_t0_cnt3
4332  06f6 c60009        	ld	a,_t0_cnt3
4333  06f9 a132          	cp	a,#50
4334  06fb 2513          	jrult	L7132
4335                     ; 612 		t0_cnt3=0;
4337  06fd 725f0009      	clr	_t0_cnt3
4338                     ; 613 		b2Hz=1;
4340  0701 35010004      	mov	_b2Hz,#1
4341                     ; 614 		bFL2=!bFL2;		
4343  0705 3d1e          	tnz	_bFL2
4344  0707 2604          	jrne	L401
4345  0709 a601          	ld	a,#1
4346  070b 2001          	jra	L601
4347  070d               L401:
4348  070d 4f            	clr	a
4349  070e               L601:
4350  070e b71e          	ld	_bFL2,a
4351  0710               L7132:
4352                     ; 617 	if(++t0_cnt4>=100)
4354  0710 725c000a      	inc	_t0_cnt4
4355  0714 c6000a        	ld	a,_t0_cnt4
4356  0717 a164          	cp	a,#100
4357  0719 2513          	jrult	L1132
4358                     ; 619 		t0_cnt4=0;
4360  071b 725f000a      	clr	_t0_cnt4
4361                     ; 620 		b1Hz=1;
4363  071f 35010005      	mov	_b1Hz,#1
4364                     ; 621 		bFL1=!bFL1;
4366  0723 3d1d          	tnz	_bFL1
4367  0725 2604          	jrne	L011
4368  0727 a601          	ld	a,#1
4369  0729 2001          	jra	L211
4370  072b               L011:
4371  072b 4f            	clr	a
4372  072c               L211:
4373  072c b71d          	ld	_bFL1,a
4374  072e               L1132:
4375                     ; 627 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
4377  072e 72115344      	bres	21316,#0
4378                     ; 628 return;
4381  0732 80            	iret
4423                     ; 635 main()
4423                     ; 636 {
4425                     	switch	.text
4426  0733               _main:
4430                     ; 637 CLK->CKDIVR=0;
4432  0733 725f50c6      	clr	20678
4433                     ; 639 gpio_init();
4435  0737 cd0504        	call	_gpio_init
4437                     ; 643 FLASH_DUKR=0xae;
4439  073a 35ae5064      	mov	_FLASH_DUKR,#174
4440                     ; 644 FLASH_DUKR=0x56;	
4442  073e 35565064      	mov	_FLASH_DUKR,#86
4443                     ; 693 t4_init();
4445  0742 cd0591        	call	_t4_init
4447                     ; 694 enableInterrupts();	
4450  0745 9a            rim
4452                     ; 696 mode=mKONST;
4455  0746 3f0c          	clr	_mode
4456                     ; 697 mode_phase=mpOFF;
4458  0748 3f0b          	clr	_mode_phase
4459  074a               L3332:
4460                     ; 703 	if(b1000Hz)
4462  074a 725d0000      	tnz	_b1000Hz
4463  074e 270a          	jreq	L7332
4464                     ; 705 		b1000Hz=0;
4466  0750 725f0000      	clr	_b1000Hz
4467                     ; 706 		but_drv();
4469  0754 cd021d        	call	_but_drv
4471                     ; 707 		but_an();
4473  0757 cd0121        	call	_but_an
4475  075a               L7332:
4476                     ; 710 	if(b100Hz)
4478  075a 725d0001      	tnz	_b100Hz
4479  075e 2707          	jreq	L1432
4480                     ; 712 		b100Hz=0;
4482  0760 725f0001      	clr	_b100Hz
4483                     ; 713 		led_hndl();	
4485  0764 cd03be        	call	_led_hndl
4487  0767               L1432:
4488                     ; 717 	if(b10Hz)
4490  0767 725d0002      	tnz	_b10Hz
4491  076b 270d          	jreq	L3432
4492                     ; 719 		b10Hz=0;
4494  076d 725f0002      	clr	_b10Hz
4495                     ; 720 		ind_hndl();	
4497  0771 cd0415        	call	_ind_hndl
4499                     ; 721 		out_hndl();	
4501  0774 cd00a5        	call	_out_hndl
4503                     ; 722 		out_drv();
4505  0777 cd0120        	call	_out_drv
4507  077a               L3432:
4508                     ; 726 	if(b5Hz)
4510  077a 725d0003      	tnz	_b5Hz
4511  077e 2704          	jreq	L5432
4512                     ; 728 		b5Hz=0;
4514  0780 725f0003      	clr	_b5Hz
4515  0784               L5432:
4516                     ; 732 	if(b2Hz)
4518  0784 725d0004      	tnz	_b2Hz
4519  0788 2704          	jreq	L7432
4520                     ; 734 		b2Hz=0;
4522  078a 725f0004      	clr	_b2Hz
4523  078e               L7432:
4524                     ; 738 	if(b1Hz)
4526  078e 725d0005      	tnz	_b1Hz
4527  0792 27b6          	jreq	L3332
4528                     ; 740 		b1Hz=0;
4530  0794 725f0005      	clr	_b1Hz
4531                     ; 741 		led_stat=0;
4533  0798 3f1b          	clr	_led_stat
4534                     ; 742 		time_hndl();
4536  079a cd0000        	call	_time_hndl
4538  079d 20ab          	jra	L3332
5042                     	xdef	_main
5043                     	xdef	f_TIM4_UPD_Interrupt
5044                     	xdef	_t4_init
5045                     	xdef	_gpio_init
5046                     	xdef	_ind_hndl
5047                     	xdef	_led_hndl
5048                     	xdef	_int2indI_slkuf
5049                     	xdef	_bcd2ind_zero
5050                     	xdef	_bcd2ind
5051                     	xdef	_bin2bcd_int
5052                     	xdef	_but_drv
5053                     	xdef	_but_an
5054                     	xdef	_out_drv
5055                     	xdef	_out_hndl
5056                     	xdef	_time_hndl
5057                     	switch	.ubsct
5058  0000               _loop_pause_cnt:
5059  0000 0000          	ds.b	2
5060                     	xdef	_loop_pause_cnt
5061  0002               _loop_wrk_cnt:
5062  0002 0000          	ds.b	2
5063                     	xdef	_loop_wrk_cnt
5064  0004               _timer_pause_cnt:
5065  0004 0000          	ds.b	2
5066                     	xdef	_timer_pause_cnt
5067  0006               _timer_second_cnt:
5068  0006 0000          	ds.b	2
5069                     	xdef	_timer_second_cnt
5070  0008               _second_cnt:
5071  0008 0000          	ds.b	2
5072                     	xdef	_second_cnt
5073  000a               _out_state:
5074  000a 00            	ds.b	1
5075                     	xdef	_out_state
5076  000b               _mode_phase:
5077  000b 00            	ds.b	1
5078                     	xdef	_mode_phase
5079  000c               _mode:
5080  000c 00            	ds.b	1
5081                     	xdef	_mode
5082  000d               _but_stat:
5083  000d 00            	ds.b	1
5084                     	xdef	_but_stat
5085  000e               _but_onL_temp:
5086  000e 0000          	ds.b	2
5087                     	xdef	_but_onL_temp
5088  0010               _speed:
5089  0010 00            	ds.b	1
5090                     	xdef	_speed
5091  0011               _but1_cnt:
5092  0011 0000          	ds.b	2
5093                     	xdef	_but1_cnt
5094  0013               _but0_cnt:
5095  0013 0000          	ds.b	2
5096                     	xdef	_but0_cnt
5097  0015               _n_but:
5098  0015 00            	ds.b	1
5099                     	xdef	_n_but
5100  0016               _l_but:
5101  0016 00            	ds.b	1
5102                     	xdef	_l_but
5103  0017               _but:
5104  0017 00            	ds.b	1
5105                     	xdef	_but
5106  0018               _but_s:
5107  0018 00            	ds.b	1
5108                     	xdef	_but_s
5109  0019               _but_n:
5110  0019 00            	ds.b	1
5111                     	xdef	_but_n
5112  001a               _but_new:
5113  001a 00            	ds.b	1
5114                     	xdef	_but_new
5115  001b               _led_stat:
5116  001b 00            	ds.b	1
5117                     	xdef	_led_stat
5118  001c               _zero_on:
5119  001c 00            	ds.b	1
5120                     	xdef	_zero_on
5121  001d               _bFL1:
5122  001d 00            	ds.b	1
5123                     	xdef	_bFL1
5124  001e               _bFL2:
5125  001e 00            	ds.b	1
5126                     	xdef	_bFL2
5127  001f               _bFL5:
5128  001f 00            	ds.b	1
5129                     	xdef	_bFL5
5130  0020               _ind_out_:
5131  0020 0000000000    	ds.b	5
5132                     	xdef	_ind_out_
5133  0025               _dig:
5134  0025 000000000000  	ds.b	10
5135                     	xdef	_dig
5136                     	xdef	_DIGISYM
5137                     	xdef	_ind_out
5138  002f               _ind_cnt:
5139  002f 00            	ds.b	1
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
