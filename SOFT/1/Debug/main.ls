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
2197  0000 18            	dc.b	24
2198  0001 fb            	dc.b	251
2199  0002 f7            	dc.b	247
2200  0003 ef            	dc.b	239
2201  0004 ff            	dc.b	255
2202  0005 ff            	dc.b	255
2203  0006 ff            	dc.b	255
2204                     .const:	section	.text
2205  0000               _DIGISYM:
2206  0000 84            	dc.b	132
2207  0001 9f            	dc.b	159
2208  0002 21            	dc.b	33
2209  0003 09            	dc.b	9
2210  0004 1a            	dc.b	26
2211  0005 48            	dc.b	72
2212  0006 40            	dc.b	64
2213  0007 9d            	dc.b	157
2214  0008 00            	dc.b	0
2215  0009 08            	dc.b	8
2216  000a 11            	dc.b	17
2217  000b 07            	dc.b	7
2218  000c 8d            	dc.b	141
2219  000d 43            	dc.b	67
2220  000e 07            	dc.b	7
2221  000f 0f            	dc.b	15
2222  0010 ff            	dc.b	255
2223  0011 ff            	dc.b	255
2224  0012 ff            	dc.b	255
2225  0013 ff            	dc.b	255
2226  0014 ff            	dc.b	255
2227  0015 fd            	dc.b	253
2228  0016 fb            	dc.b	251
2229  0017 f7            	dc.b	247
2230  0018 ef            	dc.b	239
2231  0019 df            	dc.b	223
2232  001a bf            	dc.b	191
2233  001b 7f            	dc.b	127
2234  001c 0000          	ds.b	2
2266                     ; 49 void but_an(void) 
2266                     ; 50 {
2268                     	switch	.text
2269  0000               _but_an:
2273                     ; 51 if(n_but)
2275  0000 3d09          	tnz	_n_but
2276  0002 271c          	jreq	L1441
2277                     ; 53 	if(but==butK)
2279  0004 b60b          	ld	a,_but
2280  0006 a1fe          	cp	a,#254
2281  0008 2602          	jrne	L3441
2282                     ; 55 		mode=mKONST;
2284  000a 3f00          	clr	_mode
2285  000c               L3441:
2286                     ; 57 	if(but==butT)
2288  000c b60b          	ld	a,_but
2289  000e a1fd          	cp	a,#253
2290  0010 2604          	jrne	L5441
2291                     ; 59 		mode=mTIMER;
2293  0012 35010000      	mov	_mode,#1
2294  0016               L5441:
2295                     ; 61 	if(but==butL)
2297  0016 b60b          	ld	a,_but
2298  0018 a1fb          	cp	a,#251
2299  001a 2604          	jrne	L1441
2300                     ; 63 		mode=mLOOP;
2302  001c 35020000      	mov	_mode,#2
2303  0020               L1441:
2304                     ; 66 n_but=0;
2306  0020 3f09          	clr	_n_but
2307                     ; 67 }
2310  0022 81            	ret
2345                     ; 70 void but_drv(void)
2345                     ; 71 {
2346                     	switch	.text
2347  0023               _but_drv:
2351                     ; 73 but_n=(but_stat)|0xf8; 	
2353  0023 b601          	ld	a,_but_stat
2354  0025 aaf8          	or	a,#248
2355  0027 b70d          	ld	_but_n,a
2356                     ; 74 if((but_n==0xff)||(but_n!=but_s))
2358  0029 b60d          	ld	a,_but_n
2359  002b a1ff          	cp	a,#255
2360  002d 2706          	jreq	L7641
2362  002f b60d          	ld	a,_but_n
2363  0031 b10c          	cp	a,_but_s
2364  0033 273b          	jreq	L5641
2365  0035               L7641:
2366                     ; 76  	speed=0;
2368  0035 3f04          	clr	_speed
2369                     ; 78 	if (((but0_cnt>=BUT_ON)||(but1_cnt!=0))&&(!l_but))
2371  0037 9c            	rvf
2372  0038 be07          	ldw	x,_but0_cnt
2373  003a a30005        	cpw	x,#5
2374  003d 2e04          	jrsge	L3741
2376  003f be05          	ldw	x,_but1_cnt
2377  0041 270b          	jreq	L1741
2378  0043               L3741:
2380  0043 3d0a          	tnz	_l_but
2381  0045 2607          	jrne	L1741
2382                     ; 80    	n_but=1;
2384  0047 35010009      	mov	_n_but,#1
2385                     ; 81     but=(char)but_s;
2387  004b 450c0b        	mov	_but,_but_s
2388  004e               L1741:
2389                     ; 83  	if (but1_cnt>=but_onL_temp)
2391  004e 9c            	rvf
2392  004f be05          	ldw	x,_but1_cnt
2393  0051 b302          	cpw	x,_but_onL_temp
2394  0053 2f0a          	jrslt	L5741
2395                     ; 85     n_but=1;
2397  0055 35010009      	mov	_n_but,#1
2398                     ; 86 		but=((char)but_s)&0x7f;
2400  0059 b60c          	ld	a,_but_s
2401  005b a47f          	and	a,#127
2402  005d b70b          	ld	_but,a
2403  005f               L5741:
2404                     ; 88 	l_but=0;
2406  005f 3f0a          	clr	_l_but
2407                     ; 89 	but_onL_temp=BUT_ONL;
2409  0061 ae2328        	ldw	x,#9000
2410  0064 bf02          	ldw	_but_onL_temp,x
2411                     ; 90 	but0_cnt=0;
2413  0066 5f            	clrw	x
2414  0067 bf07          	ldw	_but0_cnt,x
2415                     ; 91 	but1_cnt=0;          
2417  0069 5f            	clrw	x
2418  006a bf05          	ldw	_but1_cnt,x
2419                     ; 92 	goto but_drv_out;
2420  006c               L1541:
2421                     ; 115 but_drv_out: 
2421                     ; 116 but_s=but_n;
2423  006c 450d0c        	mov	_but_s,_but_n
2424                     ; 118 }
2427  006f 81            	ret
2428  0070               L5641:
2429                     ; 94 if(but_n==but_s)
2431  0070 b60d          	ld	a,_but_n
2432  0072 b10c          	cp	a,_but_s
2433  0074 26f6          	jrne	L1541
2434                     ; 96   but0_cnt++;
2436  0076 be07          	ldw	x,_but0_cnt
2437  0078 1c0001        	addw	x,#1
2438  007b bf07          	ldw	_but0_cnt,x
2439                     ; 97 	if(but0_cnt>=BUT_ON)
2441  007d 9c            	rvf
2442  007e be07          	ldw	x,_but0_cnt
2443  0080 a30005        	cpw	x,#5
2444  0083 2fe7          	jrslt	L1541
2445                     ; 99 		but0_cnt=0;
2447  0085 5f            	clrw	x
2448  0086 bf07          	ldw	_but0_cnt,x
2449                     ; 100 		but1_cnt++;
2451  0088 be05          	ldw	x,_but1_cnt
2452  008a 1c0001        	addw	x,#1
2453  008d bf05          	ldw	_but1_cnt,x
2454                     ; 101 		if(but1_cnt>=but_onL_temp)
2456  008f 9c            	rvf
2457  0090 be05          	ldw	x,_but1_cnt
2458  0092 b302          	cpw	x,_but_onL_temp
2459  0094 2fd6          	jrslt	L1541
2460                     ; 103 			but=(char)(but_s&0x7f);
2462  0096 b60c          	ld	a,_but_s
2463  0098 a47f          	and	a,#127
2464  009a b70b          	ld	_but,a
2465                     ; 104 			but1_cnt=0;
2467  009c 5f            	clrw	x
2468  009d bf05          	ldw	_but1_cnt,x
2469                     ; 105 			n_but=1;
2471  009f 35010009      	mov	_n_but,#1
2472                     ; 106 			l_but=1;
2474  00a3 3501000a      	mov	_l_but,#1
2475                     ; 107 			if(speed)
2477  00a7 3d04          	tnz	_speed
2478  00a9 27c1          	jreq	L1541
2479                     ; 109 				but_onL_temp=but_onL_temp>>1;
2481  00ab 3702          	sra	_but_onL_temp
2482  00ad 3603          	rrc	_but_onL_temp+1
2483                     ; 110 				if(but_onL_temp<=2) but_onL_temp=2;
2485  00af 9c            	rvf
2486  00b0 be02          	ldw	x,_but_onL_temp
2487  00b2 a30003        	cpw	x,#3
2488  00b5 2eb5          	jrsge	L1541
2491  00b7 ae0002        	ldw	x,#2
2492  00ba bf02          	ldw	_but_onL_temp,x
2493  00bc 20ae          	jra	L1541
2537                     ; 120 void bin2bcd_int(unsigned short in) 
2537                     ; 121 {
2538                     	switch	.text
2539  00be               _bin2bcd_int:
2541  00be 89            	pushw	x
2542  00bf 88            	push	a
2543       00000001      OFST:	set	1
2546                     ; 122 char i=5;
2548                     ; 124 for(i=0;i<5;i++)
2550  00c0 0f01          	clr	(OFST+0,sp)
2551  00c2               L3351:
2552                     ; 126 	dig[i]=in%10;
2554  00c2 1e02          	ldw	x,(OFST+1,sp)
2555  00c4 90ae000a      	ldw	y,#10
2556  00c8 65            	divw	x,y
2557  00c9 51            	exgw	x,y
2558  00ca 7b01          	ld	a,(OFST+0,sp)
2559  00cc 905f          	clrw	y
2560  00ce 9097          	ld	yl,a
2561  00d0 01            	rrwa	x,a
2562  00d1 90e719        	ld	(_dig,y),a
2563  00d4 02            	rlwa	x,a
2564                     ; 127 	in/=10;
2566  00d5 1e02          	ldw	x,(OFST+1,sp)
2567  00d7 90ae000a      	ldw	y,#10
2568  00db 65            	divw	x,y
2569  00dc 1f02          	ldw	(OFST+1,sp),x
2570                     ; 124 for(i=0;i<5;i++)
2572  00de 0c01          	inc	(OFST+0,sp)
2575  00e0 7b01          	ld	a,(OFST+0,sp)
2576  00e2 a105          	cp	a,#5
2577  00e4 25dc          	jrult	L3351
2578                     ; 129 }
2581  00e6 5b03          	addw	sp,#3
2582  00e8 81            	ret
2619                     ; 132 void bcd2ind(void) 
2619                     ; 133 {
2620                     	switch	.text
2621  00e9               _bcd2ind:
2623  00e9 88            	push	a
2624       00000001      OFST:	set	1
2627                     ; 136 for (i=4;i>0;i--)
2629  00ea a604          	ld	a,#4
2630  00ec 6b01          	ld	(OFST+0,sp),a
2631  00ee               L7551:
2632                     ; 138 	ind_out_[i-1]=DIGISYM[dig[i-1]];
2634  00ee 7b01          	ld	a,(OFST+0,sp)
2635  00f0 5f            	clrw	x
2636  00f1 97            	ld	xl,a
2637  00f2 5a            	decw	x
2638  00f3 7b01          	ld	a,(OFST+0,sp)
2639  00f5 905f          	clrw	y
2640  00f7 9097          	ld	yl,a
2641  00f9 905a          	decw	y
2642  00fb 90e619        	ld	a,(_dig,y)
2643  00fe 905f          	clrw	y
2644  0100 9097          	ld	yl,a
2645  0102 90d60000      	ld	a,(_DIGISYM,y)
2646  0106 e714          	ld	(_ind_out_,x),a
2647                     ; 136 for (i=4;i>0;i--)
2649  0108 0a01          	dec	(OFST+0,sp)
2652  010a 0d01          	tnz	(OFST+0,sp)
2653  010c 26e0          	jrne	L7551
2654                     ; 140 } 
2657  010e 84            	pop	a
2658  010f 81            	ret
2696                     ; 143 void bcd2ind_zero(void) 
2696                     ; 144 {
2697                     	switch	.text
2698  0110               _bcd2ind_zero:
2700  0110 88            	push	a
2701       00000001      OFST:	set	1
2704                     ; 146 zero_on=1;
2706  0111 35010010      	mov	_zero_on,#1
2707                     ; 147 for (i=4;i>0;i--)
2709  0115 a604          	ld	a,#4
2710  0117 6b01          	ld	(OFST+0,sp),a
2711  0119               L3061:
2712                     ; 149 	if(zero_on&&(!dig[i-1])&&(i-1))
2714  0119 3d10          	tnz	_zero_on
2715  011b 271e          	jreq	L1161
2717  011d 7b01          	ld	a,(OFST+0,sp)
2718  011f 5f            	clrw	x
2719  0120 97            	ld	xl,a
2720  0121 5a            	decw	x
2721  0122 6d19          	tnz	(_dig,x)
2722  0124 2615          	jrne	L1161
2724  0126 7b01          	ld	a,(OFST+0,sp)
2725  0128 5f            	clrw	x
2726  0129 97            	ld	xl,a
2727  012a 5a            	decw	x
2728  012b a30000        	cpw	x,#0
2729  012e 270b          	jreq	L1161
2730                     ; 151 		ind_out_[i-1]=0b11111111;
2732  0130 7b01          	ld	a,(OFST+0,sp)
2733  0132 5f            	clrw	x
2734  0133 97            	ld	xl,a
2735  0134 5a            	decw	x
2736  0135 a6ff          	ld	a,#255
2737  0137 e714          	ld	(_ind_out_,x),a
2739  0139 201c          	jra	L3161
2740  013b               L1161:
2741                     ; 155 		ind_out_[i-1]=DIGISYM[dig[i-1]];
2743  013b 7b01          	ld	a,(OFST+0,sp)
2744  013d 5f            	clrw	x
2745  013e 97            	ld	xl,a
2746  013f 5a            	decw	x
2747  0140 7b01          	ld	a,(OFST+0,sp)
2748  0142 905f          	clrw	y
2749  0144 9097          	ld	yl,a
2750  0146 905a          	decw	y
2751  0148 90e619        	ld	a,(_dig,y)
2752  014b 905f          	clrw	y
2753  014d 9097          	ld	yl,a
2754  014f 90d60000      	ld	a,(_DIGISYM,y)
2755  0153 e714          	ld	(_ind_out_,x),a
2756                     ; 156 		zero_on=0;
2758  0155 3f10          	clr	_zero_on
2759  0157               L3161:
2760                     ; 147 for (i=4;i>0;i--)
2762  0157 0a01          	dec	(OFST+0,sp)
2765  0159 0d01          	tnz	(OFST+0,sp)
2766  015b 26bc          	jrne	L3061
2767                     ; 159 }
2770  015d 84            	pop	a
2771  015e 81            	ret
2858                     ; 162 void int2indI_slkuf(unsigned short in, char start, char len, char unzero, char fl) 
2858                     ; 163 {
2859                     	switch	.text
2860  015f               _int2indI_slkuf:
2862  015f 89            	pushw	x
2863  0160 88            	push	a
2864       00000001      OFST:	set	1
2867                     ; 171 bin2bcd_int(in);
2869  0161 cd00be        	call	_bin2bcd_int
2871                     ; 172 if(unzero)bcd2ind_zero();
2873  0164 0d08          	tnz	(OFST+7,sp)
2874  0166 2704          	jreq	L7561
2877  0168 ada6          	call	_bcd2ind_zero
2880  016a 2003          	jra	L1661
2881  016c               L7561:
2882                     ; 173 else bcd2ind();
2884  016c cd00e9        	call	_bcd2ind
2886  016f               L1661:
2887                     ; 174 if(((fl==1)&&(bFL2)) ||	((fl==2)&&(bFL2)) || ((fl==5)&&(bFL5))) 
2889  016f 7b09          	ld	a,(OFST+8,sp)
2890  0171 a101          	cp	a,#1
2891  0173 2604          	jrne	L7661
2893  0175 3d12          	tnz	_bFL2
2894  0177 2614          	jrne	L5661
2895  0179               L7661:
2897  0179 7b09          	ld	a,(OFST+8,sp)
2898  017b a102          	cp	a,#2
2899  017d 2604          	jrne	L3761
2901  017f 3d12          	tnz	_bFL2
2902  0181 260a          	jrne	L5661
2903  0183               L3761:
2905  0183 7b09          	ld	a,(OFST+8,sp)
2906  0185 a105          	cp	a,#5
2907  0187 2618          	jrne	L3661
2909  0189 3d13          	tnz	_bFL5
2910  018b 2714          	jreq	L3661
2911  018d               L5661:
2912                     ; 176 	for(i=0;i<len;i++) 
2914  018d 0f01          	clr	(OFST+0,sp)
2916  018f 200a          	jra	L1071
2917  0191               L5761:
2918                     ; 178 		ind_out_[i]=DIGISYM[17];
2920  0191 7b01          	ld	a,(OFST+0,sp)
2921  0193 5f            	clrw	x
2922  0194 97            	ld	xl,a
2923  0195 a6ff          	ld	a,#255
2924  0197 e714          	ld	(_ind_out_,x),a
2925                     ; 176 	for(i=0;i<len;i++) 
2927  0199 0c01          	inc	(OFST+0,sp)
2928  019b               L1071:
2931  019b 7b01          	ld	a,(OFST+0,sp)
2932  019d 1107          	cp	a,(OFST+6,sp)
2933  019f 25f0          	jrult	L5761
2934  01a1               L3661:
2935                     ; 182 for(i=0;i<len;i++) 
2937  01a1 0f01          	clr	(OFST+0,sp)
2939  01a3 2016          	jra	L1171
2940  01a5               L5071:
2941                     ; 184 	ind_out[start+i]=ind_out_[i];
2943  01a5 7b06          	ld	a,(OFST+5,sp)
2944  01a7 5f            	clrw	x
2945  01a8 1b01          	add	a,(OFST+0,sp)
2946  01aa 2401          	jrnc	L02
2947  01ac 5c            	incw	x
2948  01ad               L02:
2949  01ad 02            	rlwa	x,a
2950  01ae 7b01          	ld	a,(OFST+0,sp)
2951  01b0 905f          	clrw	y
2952  01b2 9097          	ld	yl,a
2953  01b4 90e614        	ld	a,(_ind_out_,y)
2954  01b7 e700          	ld	(_ind_out,x),a
2955                     ; 182 for(i=0;i<len;i++) 
2957  01b9 0c01          	inc	(OFST+0,sp)
2958  01bb               L1171:
2961  01bb 7b01          	ld	a,(OFST+0,sp)
2962  01bd 1107          	cp	a,(OFST+6,sp)
2963  01bf 25e4          	jrult	L5071
2964                     ; 186 }
2967  01c1 5b03          	addw	sp,#3
2968  01c3 81            	ret
2993                     ; 189 void led_hndl(void)
2993                     ; 190 {
2994                     	switch	.text
2995  01c4               _led_hndl:
2999                     ; 191 if(mode==mKONST)
3001  01c4 3d00          	tnz	_mode
3002  01c6 2606          	jrne	L5271
3003                     ; 193 	led_stat=0x01;
3005  01c8 3501000f      	mov	_led_stat,#1
3007  01cc 2016          	jra	L7271
3008  01ce               L5271:
3009                     ; 195 else if(mode==mTIMER)
3011  01ce b600          	ld	a,_mode
3012  01d0 a101          	cp	a,#1
3013  01d2 2606          	jrne	L1371
3014                     ; 197 	led_stat=0x02;
3016  01d4 3502000f      	mov	_led_stat,#2
3018  01d8 200a          	jra	L7271
3019  01da               L1371:
3020                     ; 199 else if(mode==mLOOP)
3022  01da b600          	ld	a,_mode
3023  01dc a102          	cp	a,#2
3024  01de 2604          	jrne	L7271
3025                     ; 201 	led_stat=0x04;
3027  01e0 3504000f      	mov	_led_stat,#4
3028  01e4               L7271:
3029                     ; 203 }
3032  01e4 81            	ret
3057                     ; 232 void ind_hndl(void) 
3057                     ; 233 {
3058                     	switch	.text
3059  01e5               _ind_hndl:
3063                     ; 234 int2indI_slkuf(but, 0, 4, 0, 0);
3065  01e5 4b00          	push	#0
3066  01e7 4b00          	push	#0
3067  01e9 4b04          	push	#4
3068  01eb 4b00          	push	#0
3069  01ed b60b          	ld	a,_but
3070  01ef 5f            	clrw	x
3071  01f0 97            	ld	xl,a
3072  01f1 cd015f        	call	_int2indI_slkuf
3074  01f4 5b04          	addw	sp,#4
3075                     ; 236 }
3078  01f6 81            	ret
3101                     ; 239 void gpio_init(void){
3102                     	switch	.text
3103  01f7               _gpio_init:
3107                     ; 240 	GPIOA->DDR|=((1<<1)|(1<<2));
3109  01f7 c65002        	ld	a,20482
3110  01fa aa06          	or	a,#6
3111  01fc c75002        	ld	20482,a
3112                     ; 241 	GPIOA->CR1|=((1<<1)|(1<<2));
3114  01ff c65003        	ld	a,20483
3115  0202 aa06          	or	a,#6
3116  0204 c75003        	ld	20483,a
3117                     ; 242 	GPIOA->CR2&=~((1<<1)|(1<<2));
3119  0207 c65004        	ld	a,20484
3120  020a a4f9          	and	a,#249
3121  020c c75004        	ld	20484,a
3122                     ; 243 	GPIOD->DDR|=((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3124  020f c65011        	ld	a,20497
3125  0212 aa7c          	or	a,#124
3126  0214 c75011        	ld	20497,a
3127                     ; 244 	GPIOD->CR1&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3129  0217 c65012        	ld	a,20498
3130  021a a483          	and	a,#131
3131  021c c75012        	ld	20498,a
3132                     ; 245 	GPIOD->CR2&=~((1<<2)|(1<<3)|(1<<4)|(1<<5)|(1<<6));
3134  021f c65013        	ld	a,20499
3135  0222 a483          	and	a,#131
3136  0224 c75013        	ld	20499,a
3137                     ; 249 	GPIOB->CR1&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3139  0227 c65008        	ld	a,20488
3140  022a a4f0          	and	a,#240
3141  022c c75008        	ld	20488,a
3142                     ; 250 	GPIOB->CR2&=~((1<<0)|(1<<1)|(1<<2)|(1<<3));
3144  022f c65009        	ld	a,20489
3145  0232 a4f0          	and	a,#240
3146  0234 c75009        	ld	20489,a
3147                     ; 251 	GPIOB->DDR|=((1<<0)|(1<<1)|(1<<2)|(1<<3));
3149  0237 c65007        	ld	a,20487
3150  023a aa0f          	or	a,#15
3151  023c c75007        	ld	20487,a
3152                     ; 254 	GPIOC->CR1|=((1<<3));
3154  023f 7216500d      	bset	20493,#3
3155                     ; 255 	GPIOC->CR2&=~((1<<3));
3157  0243 7217500e      	bres	20494,#3
3158                     ; 256 	GPIOB->CR1|=((1<<4)|(1<<5));
3160  0247 c65008        	ld	a,20488
3161  024a aa30          	or	a,#48
3162  024c c75008        	ld	20488,a
3163                     ; 257 	GPIOB->CR2&=~((1<<4)|(1<<5));
3165  024f c65009        	ld	a,20489
3166  0252 a4cf          	and	a,#207
3167  0254 c75009        	ld	20489,a
3168                     ; 260 	GPIOC->CR1&=~0xfe;
3170  0257 c6500d        	ld	a,20493
3171  025a a401          	and	a,#1
3172  025c c7500d        	ld	20493,a
3173                     ; 261 	GPIOC->CR2&=~0xfe;
3175  025f c6500e        	ld	a,20494
3176  0262 a401          	and	a,#1
3177  0264 c7500e        	ld	20494,a
3178                     ; 262 	GPIOC->DDR|=0xfe;
3180  0267 c6500c        	ld	a,20492
3181  026a aafe          	or	a,#254
3182  026c c7500c        	ld	20492,a
3183                     ; 282 	GPIOB->DDR&=~(1<<5);	
3185  026f 721b5007      	bres	20487,#5
3186                     ; 283 	GPIOB->CR1|=(1<<5);
3188  0273 721a5008      	bset	20488,#5
3189                     ; 284 	GPIOB->CR2&=~(1<<5);
3191  0277 721b5009      	bres	20489,#5
3192                     ; 286 	GPIOB->ODR|=0x0f;
3194  027b c65005        	ld	a,20485
3195  027e aa0f          	or	a,#15
3196  0280 c75005        	ld	20485,a
3197                     ; 287 }
3200  0283 81            	ret
3223                     ; 290 void t4_init(void){
3224                     	switch	.text
3225  0284               _t4_init:
3229                     ; 291 	TIM4->PSCR = 7;
3231  0284 35075347      	mov	21319,#7
3232                     ; 292 	TIM4->ARR= 123;
3234  0288 357b5348      	mov	21320,#123
3235                     ; 293 	TIM4->IER|= TIM4_IER_UIE;					// enable break interrupt
3237  028c 72105343      	bset	21315,#0
3238                     ; 295 	TIM4->CR1=(TIM4_CR1_URS | TIM4_CR1_CEN | TIM4_CR1_ARPE);	
3240  0290 35855340      	mov	21312,#133
3241                     ; 296 }	
3244  0294 81            	ret
3285                     ; 302 @far @interrupt void TIM4_UPD_Interrupt (void) 
3285                     ; 303 {
3287                     	switch	.text
3288  0295               f_TIM4_UPD_Interrupt:
3292                     ; 305 ind_cnt++;
3294  0295 3c23          	inc	_ind_cnt
3295                     ; 307 if(ind_cnt>=5)ind_cnt=0;
3297  0297 b623          	ld	a,_ind_cnt
3298  0299 a105          	cp	a,#5
3299  029b 2502          	jrult	L7771
3302  029d 3f23          	clr	_ind_cnt
3303  029f               L7771:
3304                     ; 309 GPIOC->ODR|=0xf0;
3306  029f c6500a        	ld	a,20490
3307  02a2 aaf0          	or	a,#240
3308  02a4 c7500a        	ld	20490,a
3309                     ; 312 GPIOA->ODR|=0x06;
3311  02a7 c65000        	ld	a,20480
3312  02aa aa06          	or	a,#6
3313  02ac c75000        	ld	20480,a
3314                     ; 313 GPIOA->ODR&=(ind_out[ind_cnt]<<1)|0xf9;
3316  02af b623          	ld	a,_ind_cnt
3317  02b1 5f            	clrw	x
3318  02b2 97            	ld	xl,a
3319  02b3 e600          	ld	a,(_ind_out,x)
3320  02b5 48            	sll	a
3321  02b6 aaf9          	or	a,#249
3322  02b8 c45000        	and	a,20480
3323  02bb c75000        	ld	20480,a
3324                     ; 314 GPIOD->ODR|=0x7c;
3326  02be c6500f        	ld	a,20495
3327  02c1 aa7c          	or	a,#124
3328  02c3 c7500f        	ld	20495,a
3329                     ; 315 GPIOD->ODR&=(ind_out[ind_cnt])|0x83;
3331  02c6 b623          	ld	a,_ind_cnt
3332  02c8 5f            	clrw	x
3333  02c9 97            	ld	xl,a
3334  02ca e600          	ld	a,(_ind_out,x)
3335  02cc aa83          	or	a,#131
3336  02ce c4500f        	and	a,20495
3337  02d1 c7500f        	ld	20495,a
3338                     ; 319 GPIOC->ODR&=~(0x10<<ind_cnt);
3340  02d4 b623          	ld	a,_ind_cnt
3341  02d6 5f            	clrw	x
3342  02d7 97            	ld	xl,a
3343  02d8 a610          	ld	a,#16
3344  02da 5d            	tnzw	x
3345  02db 2704          	jreq	L43
3346  02dd               L63:
3347  02dd 48            	sll	a
3348  02de 5a            	decw	x
3349  02df 26fc          	jrne	L63
3350  02e1               L43:
3351  02e1 43            	cpl	a
3352  02e2 c4500a        	and	a,20490
3353  02e5 c7500a        	ld	20490,a
3354                     ; 320 if(ind_cnt==4)
3356  02e8 b623          	ld	a,_ind_cnt
3357  02ea a104          	cp	a,#4
3358  02ec 2604          	jrne	L1002
3359                     ; 322 	GPIOC->ODR&=~(0x10);
3361  02ee 7219500a      	bres	20490,#4
3362  02f2               L1002:
3363                     ; 325 GPIOC->CR1|=((1<<3));
3365  02f2 7216500d      	bset	20493,#3
3366                     ; 326 GPIOC->CR2&=~((1<<3));
3368  02f6 7217500e      	bres	20494,#3
3369                     ; 327 GPIOB->CR1|=((1<<4)|(1<<5));
3371  02fa c65008        	ld	a,20488
3372  02fd aa30          	or	a,#48
3373  02ff c75008        	ld	20488,a
3374                     ; 328 GPIOB->CR2&=~((1<<4)|(1<<5));
3376  0302 c65009        	ld	a,20489
3377  0305 a4cf          	and	a,#207
3378  0307 c75009        	ld	20489,a
3379                     ; 330 if(ind_cnt==4)	
3381  030a b623          	ld	a,_ind_cnt
3382  030c a104          	cp	a,#4
3383  030e 260e          	jrne	L3002
3384                     ; 332 	GPIOC->DDR&=~(1<<3);
3386  0310 7217500c      	bres	20492,#3
3387                     ; 333 	GPIOB->DDR&=~((1<<4)|(1<<5));
3389  0314 c65007        	ld	a,20487
3390  0317 a4cf          	and	a,#207
3391  0319 c75007        	ld	20487,a
3393  031c 2010          	jra	L5002
3394  031e               L3002:
3395                     ; 335 else if(ind_cnt==0)	
3397  031e 3d23          	tnz	_ind_cnt
3398  0320 260c          	jrne	L5002
3399                     ; 337 	GPIOC->DDR|=((1<<3));
3401  0322 7216500c      	bset	20492,#3
3402                     ; 338 	GPIOB->DDR|=((1<<4)|(1<<5));
3404  0326 c65007        	ld	a,20487
3405  0329 aa30          	or	a,#48
3406  032b c75007        	ld	20487,a
3407  032e               L5002:
3408                     ; 347 if(ind_cnt==0)	
3410  032e 3d23          	tnz	_ind_cnt
3411  0330 2632          	jrne	L1102
3412                     ; 349 	if(led_stat&0x01)	GPIOC->ODR&=~(1<<3);
3414  0332 b60f          	ld	a,_led_stat
3415  0334 a501          	bcp	a,#1
3416  0336 2706          	jreq	L3102
3419  0338 7217500a      	bres	20490,#3
3421  033c 2004          	jra	L5102
3422  033e               L3102:
3423                     ; 350 	else 			GPIOC->ODR|=(1<<3);
3425  033e 7216500a      	bset	20490,#3
3426  0342               L5102:
3427                     ; 351 	if(led_stat&0x02)	GPIOB->ODR&=~(1<<4);
3429  0342 b60f          	ld	a,_led_stat
3430  0344 a502          	bcp	a,#2
3431  0346 2706          	jreq	L7102
3434  0348 72195005      	bres	20485,#4
3436  034c 2004          	jra	L1202
3437  034e               L7102:
3438                     ; 352 	else 			GPIOB->ODR|=(1<<4);
3440  034e 72185005      	bset	20485,#4
3441  0352               L1202:
3442                     ; 353 	if(led_stat&0x04)	GPIOB->ODR&=~(1<<5);
3444  0352 b60f          	ld	a,_led_stat
3445  0354 a504          	bcp	a,#4
3446  0356 2706          	jreq	L3202
3449  0358 721b5005      	bres	20485,#5
3451  035c 203f          	jra	L7202
3452  035e               L3202:
3453                     ; 354 	else 			GPIOB->ODR|=(1<<5);
3455  035e 721a5005      	bset	20485,#5
3456  0362 2039          	jra	L7202
3457  0364               L1102:
3458                     ; 356 else if(ind_cnt==4)	
3460  0364 b623          	ld	a,_ind_cnt
3461  0366 a104          	cp	a,#4
3462  0368 2633          	jrne	L7202
3463                     ; 358 	if(!(GPIOC->IDR&(1<<3)))but_stat&=0xfe;
3465  036a c6500b        	ld	a,20491
3466  036d a508          	bcp	a,#8
3467  036f 2606          	jrne	L3302
3470  0371 72110001      	bres	_but_stat,#0
3472  0375 2004          	jra	L5302
3473  0377               L3302:
3474                     ; 359 	else but_stat|=0x01;
3476  0377 72100001      	bset	_but_stat,#0
3477  037b               L5302:
3478                     ; 360 	if(!(GPIOB->IDR&(1<<4)))but_stat&=0xfd;
3480  037b c65006        	ld	a,20486
3481  037e a510          	bcp	a,#16
3482  0380 2606          	jrne	L7302
3485  0382 72130001      	bres	_but_stat,#1
3487  0386 2004          	jra	L1402
3488  0388               L7302:
3489                     ; 361 	else but_stat|=0x02;
3491  0388 72120001      	bset	_but_stat,#1
3492  038c               L1402:
3493                     ; 362 	if(!(GPIOB->IDR&(1<<5)))but_stat&=0xfb;
3495  038c c65006        	ld	a,20486
3496  038f a520          	bcp	a,#32
3497  0391 2606          	jrne	L3402
3500  0393 72150001      	bres	_but_stat,#2
3502  0397 2004          	jra	L7202
3503  0399               L3402:
3504                     ; 363 	else but_stat|=0x04;	
3506  0399 72140001      	bset	_but_stat,#2
3507  039d               L7202:
3508                     ; 366 b1000Hz=1;
3510  039d 35010000      	mov	_b1000Hz,#1
3511                     ; 368 if(++t0_cnt0>=10)
3513  03a1 725c0006      	inc	_t0_cnt0
3514  03a5 c60006        	ld	a,_t0_cnt0
3515  03a8 a10a          	cp	a,#10
3516  03aa 2575          	jrult	L7402
3517                     ; 370 	t0_cnt0=0;
3519  03ac 725f0006      	clr	_t0_cnt0
3520                     ; 371     	b100Hz=1;
3522  03b0 35010001      	mov	_b100Hz,#1
3523                     ; 372 	if(++t0_cnt1>=10)
3525  03b4 725c0007      	inc	_t0_cnt1
3526  03b8 c60007        	ld	a,_t0_cnt1
3527  03bb a10a          	cp	a,#10
3528  03bd 2508          	jrult	L1502
3529                     ; 374 		t0_cnt1=0;
3531  03bf 725f0007      	clr	_t0_cnt1
3532                     ; 375 		b10Hz=1;
3534  03c3 35010002      	mov	_b10Hz,#1
3535  03c7               L1502:
3536                     ; 378 	if(++t0_cnt2>=20)
3538  03c7 725c0008      	inc	_t0_cnt2
3539  03cb c60008        	ld	a,_t0_cnt2
3540  03ce a114          	cp	a,#20
3541  03d0 2513          	jrult	L3502
3542                     ; 380 		t0_cnt2=0;
3544  03d2 725f0008      	clr	_t0_cnt2
3545                     ; 381 		b5Hz=1;
3547  03d6 35010003      	mov	_b5Hz,#1
3548                     ; 382 		bFL5=!bFL5;
3550  03da 3d13          	tnz	_bFL5
3551  03dc 2604          	jrne	L04
3552  03de a601          	ld	a,#1
3553  03e0 2001          	jra	L24
3554  03e2               L04:
3555  03e2 4f            	clr	a
3556  03e3               L24:
3557  03e3 b713          	ld	_bFL5,a
3558  03e5               L3502:
3559                     ; 385 	if(++t0_cnt3>=50)
3561  03e5 725c0009      	inc	_t0_cnt3
3562  03e9 c60009        	ld	a,_t0_cnt3
3563  03ec a132          	cp	a,#50
3564  03ee 2513          	jrult	L5502
3565                     ; 387 		t0_cnt3=0;
3567  03f0 725f0009      	clr	_t0_cnt3
3568                     ; 388 		b2Hz=1;
3570  03f4 35010004      	mov	_b2Hz,#1
3571                     ; 389 		bFL2=!bFL2;		
3573  03f8 3d12          	tnz	_bFL2
3574  03fa 2604          	jrne	L44
3575  03fc a601          	ld	a,#1
3576  03fe 2001          	jra	L64
3577  0400               L44:
3578  0400 4f            	clr	a
3579  0401               L64:
3580  0401 b712          	ld	_bFL2,a
3581  0403               L5502:
3582                     ; 392 	if(++t0_cnt4>=100)
3584  0403 725c000a      	inc	_t0_cnt4
3585  0407 c6000a        	ld	a,_t0_cnt4
3586  040a a164          	cp	a,#100
3587  040c 2513          	jrult	L7402
3588                     ; 394 		t0_cnt4=0;
3590  040e 725f000a      	clr	_t0_cnt4
3591                     ; 395 		b1Hz=1;
3593  0412 35010005      	mov	_b1Hz,#1
3594                     ; 396 		bFL1=!bFL1;
3596  0416 3d11          	tnz	_bFL1
3597  0418 2604          	jrne	L05
3598  041a a601          	ld	a,#1
3599  041c 2001          	jra	L25
3600  041e               L05:
3601  041e 4f            	clr	a
3602  041f               L25:
3603  041f b711          	ld	_bFL1,a
3604  0421               L7402:
3605                     ; 402 TIM4->SR1&=~TIM4_SR1_UIF;			// disable break interrupt
3607  0421 72115344      	bres	21316,#0
3608                     ; 403 return;
3611  0425 80            	iret
3648                     ; 410 main()
3648                     ; 411 {
3650                     	switch	.text
3651  0426               _main:
3655                     ; 412 CLK->CKDIVR=0;
3657  0426 725f50c6      	clr	20678
3658                     ; 414 gpio_init();
3660  042a cd01f7        	call	_gpio_init
3662                     ; 418 FLASH_DUKR=0xae;
3664  042d 35ae5064      	mov	_FLASH_DUKR,#174
3665                     ; 419 FLASH_DUKR=0x56;	
3667  0431 35565064      	mov	_FLASH_DUKR,#86
3668                     ; 468 t4_init();
3670  0435 cd0284        	call	_t4_init
3672                     ; 469 enableInterrupts();	
3675  0438 9a            rim
3677  0439               L1702:
3678                     ; 476 	if(b1000Hz)
3680  0439 725d0000      	tnz	_b1000Hz
3681  043d 270a          	jreq	L5702
3682                     ; 478 		b1000Hz=0;
3684  043f 725f0000      	clr	_b1000Hz
3685                     ; 479 		but_drv();
3687  0443 cd0023        	call	_but_drv
3689                     ; 480 		but_an();
3691  0446 cd0000        	call	_but_an
3693  0449               L5702:
3694                     ; 483 	if(b100Hz)
3696  0449 725d0001      	tnz	_b100Hz
3697  044d 2707          	jreq	L7702
3698                     ; 485 		b100Hz=0;
3700  044f 725f0001      	clr	_b100Hz
3701                     ; 486 		led_hndl();	
3703  0453 cd01c4        	call	_led_hndl
3705  0456               L7702:
3706                     ; 490 	if(b10Hz)
3708  0456 725d0002      	tnz	_b10Hz
3709  045a 2707          	jreq	L1012
3710                     ; 492 		b10Hz=0;
3712  045c 725f0002      	clr	_b10Hz
3713                     ; 495 		ind_hndl();
3715  0460 cd01e5        	call	_ind_hndl
3717  0463               L1012:
3718                     ; 499 	if(b5Hz)
3720  0463 725d0003      	tnz	_b5Hz
3721  0467 2704          	jreq	L3012
3722                     ; 501 		b5Hz=0;
3724  0469 725f0003      	clr	_b5Hz
3725  046d               L3012:
3726                     ; 505 	if(b2Hz)
3728  046d 725d0004      	tnz	_b2Hz
3729  0471 2704          	jreq	L5012
3730                     ; 507 		b2Hz=0;
3732  0473 725f0004      	clr	_b2Hz
3733  0477               L5012:
3734                     ; 511 	if(b1Hz)
3736  0477 725d0005      	tnz	_b1Hz
3737  047b 27bc          	jreq	L1702
3738                     ; 513 		b1Hz=0;
3740  047d 725f0005      	clr	_b1Hz
3741                     ; 514 		led_stat=0;
3743  0481 3f0f          	clr	_led_stat
3744  0483 20b4          	jra	L1702
4118                     	xdef	_main
4119                     	xdef	f_TIM4_UPD_Interrupt
4120                     	xdef	_t4_init
4121                     	xdef	_gpio_init
4122                     	xdef	_ind_hndl
4123                     	xdef	_led_hndl
4124                     	xdef	_int2indI_slkuf
4125                     	xdef	_bcd2ind_zero
4126                     	xdef	_bcd2ind
4127                     	xdef	_bin2bcd_int
4128                     	xdef	_but_drv
4129                     	xdef	_but_an
4130                     	switch	.ubsct
4131  0000               _mode:
4132  0000 00            	ds.b	1
4133                     	xdef	_mode
4134  0001               _but_stat:
4135  0001 00            	ds.b	1
4136                     	xdef	_but_stat
4137  0002               _but_onL_temp:
4138  0002 0000          	ds.b	2
4139                     	xdef	_but_onL_temp
4140  0004               _speed:
4141  0004 00            	ds.b	1
4142                     	xdef	_speed
4143  0005               _but1_cnt:
4144  0005 0000          	ds.b	2
4145                     	xdef	_but1_cnt
4146  0007               _but0_cnt:
4147  0007 0000          	ds.b	2
4148                     	xdef	_but0_cnt
4149  0009               _n_but:
4150  0009 00            	ds.b	1
4151                     	xdef	_n_but
4152  000a               _l_but:
4153  000a 00            	ds.b	1
4154                     	xdef	_l_but
4155  000b               _but:
4156  000b 00            	ds.b	1
4157                     	xdef	_but
4158  000c               _but_s:
4159  000c 00            	ds.b	1
4160                     	xdef	_but_s
4161  000d               _but_n:
4162  000d 00            	ds.b	1
4163                     	xdef	_but_n
4164  000e               _but_new:
4165  000e 00            	ds.b	1
4166                     	xdef	_but_new
4167  000f               _led_stat:
4168  000f 00            	ds.b	1
4169                     	xdef	_led_stat
4170  0010               _zero_on:
4171  0010 00            	ds.b	1
4172                     	xdef	_zero_on
4173  0011               _bFL1:
4174  0011 00            	ds.b	1
4175                     	xdef	_bFL1
4176  0012               _bFL2:
4177  0012 00            	ds.b	1
4178                     	xdef	_bFL2
4179  0013               _bFL5:
4180  0013 00            	ds.b	1
4181                     	xdef	_bFL5
4182  0014               _ind_out_:
4183  0014 0000000000    	ds.b	5
4184                     	xdef	_ind_out_
4185  0019               _dig:
4186  0019 000000000000  	ds.b	10
4187                     	xdef	_dig
4188                     	xdef	_DIGISYM
4189                     	xdef	_ind_out
4190  0023               _ind_cnt:
4191  0023 00            	ds.b	1
4192                     	xdef	_ind_cnt
4193                     	xdef	_t0_cnt4
4194                     	xdef	_t0_cnt3
4195                     	xdef	_t0_cnt2
4196                     	xdef	_t0_cnt1
4197                     	xdef	_t0_cnt0
4198                     	xdef	_b1Hz
4199                     	xdef	_b2Hz
4200                     	xdef	_b5Hz
4201                     	xdef	_b10Hz
4202                     	xdef	_b100Hz
4203                     	xdef	_b1000Hz
4223                     	end
