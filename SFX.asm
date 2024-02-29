	org 49152

;BeepFX player by Shiru
;You are free to do whatever you want with this code



playBasic:
	ld a,19
play:
	ld hl,sfxData		;address of sound effects data

	di
	push ix
	push iy

	ld b,0
	ld c,a
	add hl,bc
	add hl,bc
	ld e,(hl)
	inc hl
	ld d,(hl)
	push de
	pop ix				;put it into ix

	ld a,(23624)		;get border color from BASIC vars to keep it unchanged
	rra
	rra
	rra
	and 7
	ld (sfxRoutineToneBorder  +1),a
	ld (sfxRoutineNoiseBorder +1),a
	ld (sfxRoutineSampleBorder+1),a


readData:
	ld a,(ix+0)			;read block type
	ld c,(ix+1)			;read duration 1
	ld b,(ix+2)
	ld e,(ix+3)			;read duration 2
	ld d,(ix+4)
	push de
	pop iy

	dec a
	jr z,sfxRoutineTone
	dec a
	jr z,sfxRoutineNoise
	dec a
	jr z,sfxRoutineSample
	pop iy
	pop ix
	ei
	ret

	

;play sample

sfxRoutineSample:
	ex de,hl
sfxRS0:
	ld e,8				;7
	ld d,(hl)			;7
	inc hl				;6
sfxRS1:
	ld a,(ix+5)			;19
sfxRS2:
	dec a				;4
	jr nz,sfxRS2		;7/12
	rl d				;8
	sbc a,a				;4
	and 16				;7
	and 16				;7	dummy
sfxRoutineSampleBorder:
	or 0				;7
	out (254),a			;11
	dec e				;4
	jp nz,sfxRS1		;10=88t
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRS0		;10=132t

	ld c,6
	
nextData:
	add ix,bc		;skip to the next block
	jr readData



;generate tone with many parameters

sfxRoutineTone:
	ld e,(ix+5)			;freq
	ld d,(ix+6)
	ld a,(ix+9)			;duty
	ld (sfxRoutineToneDuty+1),a
	ld hl,0

sfxRT0:
	push bc
	push iy
	pop bc
sfxRT1:
	add hl,de			;11
	ld a,h				;4
sfxRoutineToneDuty:
	cp 0				;7
	sbc a,a				;4
	and 16				;7
sfxRoutineToneBorder:
	or 0				;7
	out (254),a			;11
	ld a,(0)			;13	dummy
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRT1		;10=88t

	ld a,(sfxRoutineToneDuty+1)	 ;duty change
	add a,(ix+10)
	ld (sfxRoutineToneDuty+1),a

	ld c,(ix+7)			;slide
	ld b,(ix+8)
	ex de,hl
	add hl,bc
	ex de,hl

	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRT0

	ld c,11
	jr nextData



;generate noise with two parameters

sfxRoutineNoise:
	ld e,(ix+5)			;pitch

	ld d,1
	ld h,d
	ld l,d
sfxRN0:
	push bc
	push iy
	pop bc
sfxRN1:
	ld a,(hl)			;7
	and 16				;7
sfxRoutineNoiseBorder:
	or 0				;7
	out (254),a			;11
	dec d				;4
	jp z,sfxRN2			;10
	nop					;4	dummy
	jp sfxRN3			;10	dummy
sfxRN2:
	ld d,e				;4
	inc hl				;6
	ld a,h				;4
	and 31				;7
	ld h,a				;4
	ld a,(0)			;13 dummy
sfxRN3:
	nop					;4	dummy
	dec bc				;6
	ld a,b				;4
	or c				;4
	jp nz,sfxRN1		;10=88 or 112t

	ld a,e
	add a,(ix+6)		;slide
	ld e,a

	pop bc
	dec bc
	ld a,b
	or c
	jr nz,sfxRN0

	ld c,7
	jr nextData


sfxData:

SoundEffectsData:
	defw SoundEffect0Data
	defw SoundEffect1Data
	defw SoundEffect2Data
	defw SoundEffect3Data
	defw SoundEffect4Data
	defw SoundEffect5Data
	defw SoundEffect6Data
	defw SoundEffect7Data
	defw SoundEffect8Data
	defw SoundEffect9Data
	defw SoundEffect10Data
	defw SoundEffect11Data
	defw SoundEffect12Data
	defw SoundEffect13Data
	defw SoundEffect14Data
	defw SoundEffect15Data
	defw SoundEffect16Data
	defw SoundEffect17Data
	defw SoundEffect18Data
	defw SoundEffect19Data
	defw SoundEffect20Data
	defw SoundEffect21Data
	defw SoundEffect22Data
	defw SoundEffect23Data
	defw SoundEffect24Data
	defw SoundEffect25Data
	defw SoundEffect26Data
	defw SoundEffect27Data
	defw SoundEffect28Data
	defw SoundEffect29Data
	defw SoundEffect30Data
	defw SoundEffect31Data
	defw SoundEffect32Data
	defw SoundEffect33Data
	defw SoundEffect34Data
	defw SoundEffect35Data
	defw SoundEffect36Data
	defw SoundEffect37Data
	defw SoundEffect38Data
	defw SoundEffect39Data
	defw SoundEffect40Data
	defw SoundEffect41Data
	defw SoundEffect42Data
	defw SoundEffect43Data
	defw SoundEffect44Data
	defw SoundEffect45Data
	defw SoundEffect46Data
	defw SoundEffect47Data
	defw SoundEffect48Data
	defw SoundEffect49Data
	defw SoundEffect50Data
	defw SoundEffect51Data
	defw SoundEffect52Data
	defw SoundEffect53Data
	defw SoundEffect54Data
	defw SoundEffect55Data
	defw SoundEffect56Data
	defw SoundEffect57Data
	defw SoundEffect58Data
	defw SoundEffect59Data
	defw SoundEffect60Data
	defw SoundEffect61Data
	defw SoundEffect62Data
	defw SoundEffect63Data
	defw SoundEffect64Data
	defw SoundEffect65Data
	defw SoundEffect66Data
	defw SoundEffect67Data
	defw SoundEffect68Data
	defw SoundEffect69Data
	defw SoundEffect70Data
	defw SoundEffect71Data
	defw SoundEffect72Data
	defw SoundEffect73Data
	defw SoundEffect74Data
	defw SoundEffect75Data
	defw SoundEffect76Data
	defw SoundEffect77Data

SoundEffect0Data:
	defb 1 ;tone
	defw 20,50,2000,65486,128
	defb 0
SoundEffect1Data:
	defb 2 ;noise
	defw 20,50,257
	defb 0
SoundEffect2Data:
	defb 1 ;tone
	defw 100,20,500,2,128
	defb 0
SoundEffect3Data:
	defb 1 ;tone
	defw 100,20,500,2,16
	defb 0
SoundEffect4Data:
	defb 1 ;tone
	defw 10,100,2000,100,128
	defb 0
SoundEffect5Data:
	defb 1 ;tone
	defw 50,100,200,65531,128
	defb 0
SoundEffect6Data:
	defb 2 ;noise
	defw 100,50,356
	defb 0
SoundEffect7Data:
	defb 2 ;noise
	defw 1,1000,10
	defb 2 ;noise
	defw 1,1000,1
	defb 0
SoundEffect8Data:
	defb 2 ;noise
	defw 1,1000,20
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 2 ;noise
	defw 1,1000,1
	defb 0
SoundEffect9Data:
	defb 1 ;tone
	defw 20,1000,200,0,63104
	defb 0
SoundEffect10Data:
	defb 1 ;tone
	defw 400,50,200,0,63104
	defb 0
SoundEffect11Data:
	defb 1 ;tone
	defw 2000,10,400,0,63104
	defb 0
SoundEffect12Data:
	defb 1 ;tone
	defw 100,100,1000,0,32896
	defb 0
SoundEffect13Data:
	defb 1 ;tone
	defw 1000,10,100,0,25728
	defb 0
SoundEffect14Data:
	defb 1 ;tone
	defw 100,100,1000,0,32640
	defb 0
SoundEffect15Data:
	defb 1 ;tone
	defw 100,20,400,1,25728
	defb 0
SoundEffect16Data:
	defb 2 ;noise
	defw 2,2000,32776
	defb 0
SoundEffect17Data:
	defb 2 ;noise
	defw 1,1000,10
	defb 1 ;tone
	defw 20,100,400,65526,128
	defb 2 ;noise
	defw 1,2000,1
	defb 0
SoundEffect18Data:
	defb 1 ;tone
	defw 100,20,1000,65535,2176
	defb 0
SoundEffect19Data:
	defb 2 ;noise
	defw 20,2000,1290
	defb 0
SoundEffect20Data:
	defb 2 ;noise
	defw 100,400,2562
	defb 0
SoundEffect21Data:
	defb 2 ;noise
	defw 5,1000,5124
	defb 1 ;tone
	defw 50,100,200,65534,128
	defb 0
SoundEffect22Data:
	defb 2 ;noise
	defw 8,200,20
	defb 2 ;noise
	defw 4,2000,5220
	defb 0
SoundEffect23Data:
	defb 2 ;noise
	defw 25,2500,28288
	defb 0
SoundEffect24Data:
	defb 2 ;noise
	defw 100,40,20
	defb 1 ;tone
	defw 100,40,400,65532,128
	defb 2 ;noise
	defw 100,40,40
	defb 1 ;tone
	defw 100,40,350,65532,128
	defb 2 ;noise
	defw 100,40,80
	defb 1 ;tone
	defw 100,40,320,65532,128
	defb 2 ;noise
	defw 100,40,100
	defb 1 ;tone
	defw 100,40,310,65532,128
	defb 2 ;noise
	defw 100,40,120
	defb 1 ;tone
	defw 100,40,300,65532,128
	defb 0
SoundEffect25Data:
	defb 2 ;noise
	defw 5,1000,5130
	defb 1 ;tone
	defw 20,100,200,65526,128
	defb 2 ;noise
	defw 1,10000,200
	defb 0
SoundEffect26Data:
	defb 1 ;tone
	defw 8,400,300,65511,128
	defb 2 ;noise
	defw 6,5000,5270
	defb 0
SoundEffect27Data:
	defb 2 ;noise
	defw 1,1000,4
	defb 1 ;tone
	defw 4,1000,400,65436,128
	defb 2 ;noise
	defw 1,5000,150
	defb 0
SoundEffect28Data:
	defb 1 ;tone
	defw 10,400,1000,65136,2688
	defb 0
SoundEffect29Data:
	defb 1 ;tone
	defw 10,400,1000,65336,2688
	defb 0
SoundEffect30Data:
	defb 1 ;tone
	defw 4,1000,1000,400,128
	defb 0
SoundEffect31Data:
	defb 1 ;tone
	defw 4,1000,1000,65136,128
	defb 0
SoundEffect32Data:
	defb 1 ;tone
	defw 1,1000,1000,0,128
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 1 ;tone
	defw 1,2000,2000,0,128
	defb 1 ;tone
	defw 1,2000,2000,0,16
	defb 0
SoundEffect33Data:
	defb 1 ;tone
	defw 1,1000,2000,0,64
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 1 ;tone
	defw 1,1000,1500,0,64
	defb 0
SoundEffect34Data:
	defb 2 ;noise
	defw 1,1000,4
	defb 1 ;tone
	defw 1,1000,2000,0,128
	defb 0
SoundEffect35Data:
	defb 2 ;noise
	defw 1,1000,8
	defb 1 ;tone
	defw 1,1000,800,0,128
	defb 2 ;noise
	defw 1,1000,16
	defb 1 ;tone
	defw 1,1000,700,0,128
	defb 0
SoundEffect36Data:
	defb 1 ;tone
	defw 10,400,400,65516,128
	defb 1 ;pause
	defw 10,400,0,0,0
	defb 1 ;tone
	defw 10,400,350,65516,96
	defb 1 ;pause
	defw 10,400,0,0,0
	defb 1 ;tone
	defw 10,400,300,65516,64
	defb 1 ;pause
	defw 10,400,0,0,0
	defb 1 ;tone
	defw 10,400,250,65516,32
	defb 1 ;pause
	defw 10,400,0,0,0
	defb 1 ;tone
	defw 10,400,200,65516,16
	defb 0
SoundEffect37Data:
	defb 1 ;tone
	defw 5,1800,1000,1000,65408
	defb 0
SoundEffect38Data:
	defb 1 ;tone
	defw 3500,10,2,0,25728
	defb 0
SoundEffect39Data:
	defb 1 ;tone
	defw 20,200,3400,10,64
	defb 0
SoundEffect40Data:
	defb 1 ;tone
	defw 1,2000,400,0,128
	defb 1 ;tone
	defw 1,2000,400,0,16
	defb 1 ;tone
	defw 1,2000,600,0,128
	defb 1 ;tone
	defw 1,2000,600,0,16
	defb 1 ;tone
	defw 1,2000,800,0,128
	defb 1 ;tone
	defw 1,2000,800,0,16
	defb 0
SoundEffect41Data:
	defb 1 ;tone
	defw 1,2000,400,0,128
	defb 1 ;tone
	defw 1,2000,600,0,128
	defb 1 ;tone
	defw 1,2000,800,0,128
	defb 1 ;tone
	defw 1,2000,400,0,16
	defb 1 ;tone
	defw 1,2000,600,0,16
	defb 1 ;tone
	defw 1,2000,800,0,16
	defb 0
SoundEffect42Data:
	defb 1 ;tone
	defw 4,1000,500,100,384
	defb 1 ;tone
	defw 4,1000,500,100,64
	defb 1 ;tone
	defw 4,1000,500,100,16
	defb 0
SoundEffect43Data:
	defb 1 ;tone
	defw 5,2000,200,100,128
	defb 0
SoundEffect44Data:
	defb 1 ;tone
	defw 4,1000,400,100,128
	defb 1 ;tone
	defw 4,1000,400,100,64
	defb 1 ;tone
	defw 4,1000,400,100,32
	defb 1 ;tone
	defw 4,1000,400,100,16
	defb 0
SoundEffect45Data:
	defb 1 ;tone
	defw 4,2000,600,65436,61504
	defb 1 ;tone
	defw 4,2000,600,65436,8
	defb 1 ;tone
	defw 4,2000,600,65436,4
	defb 0
SoundEffect46Data:
	defb 1 ;tone
	defw 2,4000,400,200,64
	defb 1 ;tone
	defw 2,4000,200,200,32
	defb 0
SoundEffect47Data:
	defb 1 ;tone
	defw 2,1000,400,100,64
	defb 1 ;tone
	defw 2,1000,400,100,64
	defb 1 ;tone
	defw 2,1000,400,100,64
	defb 1 ;tone
	defw 2,1000,400,100,64
	defb 0
SoundEffect48Data:
	defb 1 ;tone
	defw 32,1000,2000,16384,320
	defb 0
SoundEffect49Data:
	defb 1 ;tone
	defw 200,20,400,0,384
	defb 1 ;tone
	defw 200,20,800,0,384
	defb 1 ;tone
	defw 200,20,400,0,384
	defb 1 ;tone
	defw 200,20,800,0,384
	defb 1 ;tone
	defw 200,20,400,0,384
	defb 1 ;tone
	defw 200,20,800,0,384
	defb 0
SoundEffect50Data:
	defb 1 ;tone
	defw 20,100,200,10,1025
	defb 1 ;pause
	defw 30,100,0,0,0
	defb 1 ;tone
	defw 50,100,200,10,1025
	defb 0
SoundEffect51Data:
	defb 1 ;tone
	defw 50,200,500,65516,128
	defb 0
SoundEffect52Data:
	defb 1 ;tone
	defw 1,2000,200,0,128
	defb 1 ;pause
	defw 1,2000,0,0,0
	defb 1 ;tone
	defw 1,2000,200,0,32
	defb 1 ;pause
	defw 1,2000,0,0,0
	defb 1 ;tone
	defw 1,2000,200,0,16
	defb 1 ;pause
	defw 1,2000,0,0,0
	defb 1 ;tone
	defw 1,2000,200,0,8
	defb 0
SoundEffect53Data:
	defb 1 ;tone
	defw 10,1000,200,2,272
	defb 1 ;pause
	defw 1,4000,0,0,0
	defb 1 ;tone
	defw 10,1000,200,65534,272
	defb 0
SoundEffect54Data:
	defb 1 ;tone
	defw 20,500,200,5,272
	defb 1 ;pause
	defw 1,1000,0,0,0
	defb 1 ;tone
	defw 30,500,200,8,272
	defb 0
SoundEffect55Data:
	defb 1 ;tone
	defw 40,2125,16384,45459,128
	defb 0
SoundEffect56Data:
	defb 1 ;tone
	defw 100,100,200,65516,30848
	defb 0
SoundEffect57Data:
	defb 1 ;tone
	defw 10,500,1200,65526,18582
	defb 0
SoundEffect58Data:
	defb 1 ;tone
	defw 4,500,800,65436,40064
	defb 1 ;tone
	defw 4,500,800,65436,40064
	defb 1 ;tone
	defw 4,500,800,65436,40064
	defb 0
SoundEffect59Data:
	defb 2 ;noise
	defw 50,100,2815
	defb 0
SoundEffect60Data:
	defb 1 ;tone
	defw 100,100,400,65526,640
	defb 0
SoundEffect61Data:
	defb 1 ;tone
	defw 20,300,400,65526,64
	defb 1 ;tone
	defw 20,300,300,65526,48
	defb 1 ;tone
	defw 20,300,200,65526,32
	defb 0
SoundEffect62Data:
	defb 1 ;tone
	defw 400,20,100,20000,62464
	defb 0
SoundEffect63Data:
	defb 1 ;tone
	defw 10,1000,200,65336,128
	defb 0
SoundEffect64Data:
	defb 1 ;tone
	defw 50,50,1000,65526,128
	defb 1 ;tone
	defw 50,50,1100,65526,64
	defb 1 ;tone
	defw 50,50,1200,65526,32
	defb 1 ;tone
	defw 50,50,1300,65526,16
	defb 1 ;tone
	defw 50,50,1400,65526,8
	defb 0
SoundEffect65Data:
	defb 1 ;tone
	defw 100,25,400,65535,128
	defb 1 ;tone
	defw 100,25,450,65535,96
	defb 1 ;tone
	defw 100,25,550,65535,64
	defb 1 ;tone
	defw 100,25,600,65535,48
	defb 1 ;tone
	defw 100,25,650,65535,32
	defb 0
SoundEffect66Data:
	defb 1 ;tone
	defw 150,100,50,4,63552
	defb 1 ;tone
	defw 300,100,650,0,2056
	defb 0
SoundEffect67Data:
	defb 1 ;tone
	defw 10,1429,17153,0,128
	defb 0
SoundEffect68Data:
	defb 2 ;noise
	defw 20,100,2561
	defb 1 ;tone
	defw 30,100,1000,65446,257
	defb 0
SoundEffect69Data:
	defb 1 ;tone
	defw 500,10,200,65535,25720
	defb 0
SoundEffect70Data:
	defb 1 ;tone
	defw 10,500,200,3,2176
	defb 1 ;tone
	defw 10,500,200,65534,2049
	defb 0
SoundEffect71Data:
	defb 1 ;tone
	defw 10,500,200,65535,257
	defb 1 ;tone
	defw 10,500,210,65535,65290
	defb 0
SoundEffect72Data:
	defb 1 ;tone
	defw 500,10,101,65535,32780
	defb 1 ;tone
	defw 500,10,101,65535,20608
	defb 0
SoundEffect73Data:
	defb 1 ;tone
	defw 1000,1,200,1,7808
	defb 1 ;tone
	defw 1000,1,200,65535,10368
	defb 1 ;tone
	defw 1000,1,200,65535,12928
	defb 0
SoundEffect74Data:
	defb 1 ;tone
	defw 3,1500,200,1000,2624
	defb 1 ;tone
	defw 3,1500,200,1000,2564
	defb 0
SoundEffect75Data:
	defb 1 ;tone
	defw 3,1000,400,200,128
	defb 1 ;tone
	defw 3,1000,400,200,64
	defb 1 ;tone
	defw 3,1000,400,200,32
	defb 1 ;tone
	defw 3,1000,400,200,16
	defb 1 ;tone
	defw 3,1000,400,200,8
	defb 1 ;tone
	defw 3,1000,400,200,4
	defb 0
SoundEffect76Data:
	defb 1 ;tone
	defw 4,1000,800,65336,128
	defb 1 ;pause
	defw 1,5000,0,0,0
	defb 1 ;tone
	defw 4,1000,800,65336,64
	defb 1 ;pause
	defw 1,5000,0,0,0
	defb 1 ;tone
	defw 4,1000,800,65336,16
	defb 1 ;pause
	defw 1,5000,0,0,0
	defb 1 ;tone
	defw 4,1000,800,65336,8
	defb 0
SoundEffect77Data:
	defb 1 ;tone
	defw 500,10,2000,0,2176
	defb 0
