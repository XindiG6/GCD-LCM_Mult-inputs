TITLE GCD1_and_LCM (template.asm)
; Author: Xindi Guo
; Last Modified: 2019 8/17
; OSU email address: guoxin@oregonstate.edu
; Course number/section: cs 271
; Project Number: Final Porject
; Due Date:2019 8/18
; Description: GCD and LCM for Mutiple Inputs
INCLUDE Irvine32.inc
; (insert constant definitions here)
; Do not change the name of Benchmarks. Data Types and Values may change when
;your code is tested.
.data
Benchmark1 BYTE 54, 24
Benchmark2 BYTE 8, 8
Benchmark3 WORD 6, 65422
Benchmark4 WORD 7536, 28260
Benchmark5 QWORD -988422, 286331153
Benchmark6 DWORD -65537, 6700417
Benchmark7 BYTE 56, 77, 42
Benchmark8 BYTE 3
Benchmark9 WORD 6, 28038, 27444
Benchmark10 WORD 11538, 34614, 3205
Benchmark11 DWORD 13400834, -34614, -201274
Benchmark12 DWORD 4673, 65537, 274177
Benchmark13 BYTE 132, 104, 56, 118
Benchmark14 BYTE 16, 4, 8, 2
Benchmark15 TBYTE 112152, 6, 33332, 12
Benchmark16 WORD 8224, 18504, 16448, 46260
Benchmark17 DWORD 83898162, 3658892065, 2987706769, -20416337
Benchmark18 DWORD 4001, 5573, 4649, 6047
Benchmark19 DWORD 104831, 104827, 0, 0
Benchmark20 DWORD 16, 32, 64, 128, 256, 512
Result_Benchmark_GCD DWORD 20 DUP(?)
Result_Benchmark_LCM DWORD 20 DUP(?)
;Result_Benchmark_LCM QWORD 20 DUP(?) ; Extra credit option
; (insert variable definitions here)
count DWORD 0
CURSOR DWORD 20 DUP(?)
inputNums WORD ?
currentType WORD ?
temp2 DWORD ?
temp1 DWORD ?
dividend DWORD ?
temp DWORD ?
PROMPT1 BYTE 'GCD is ',0
PROMPT2 BYTE ' and LCM is ',0
PROMPT3 BYTE '.',0
PROMPT4 BYTE 'The benchmark',0
PROMPT5 BYTE ' are ',0
M DWORD ? 
N DWORD ? 
X DWORD ? 
Y DWORD ? 
originM DWORD ? 
originN DWORD ? 
originX DWORD ? 
originY DWORD ? 
.code
main PROC
rdtsc ; meausre your time
; Calculate GCD1 and LCM for 20 Benchmarks.
; (insert executable instructions here)

GCD1Start:
	mov	SI,0
	mov EDX, type Benchmark1[SI]
	cmp EDX,1
	je	L12
	cmp EDX,2
	je  L13
	cmp EDX,4
	je  L14
	jne L11
	jmp GCD1END;
L11:
	mov EBX,0
	mov Result_Benchmark_GCD[EBX],0
	mov Result_Benchmark_LCM[EBX],0
	jmp GCD1END;
L12:
	mov currentType,1
	mov EDX, LENGTHOF Benchmark1[0]
	cmp EDX,4
	JA L11
	cmp EDX,2
	JB L11
	cmp EDX,2
	JE GCD12
	cmp EDX,3
	JE GCD13
	cmp EDX,4
	JE GCD14
L13:
	mov currentType,2
	mov EDX, LENGTHOF Benchmark1[0]
	cmp EDX,4
	JA L11
	cmp EDX,2
	JB L11
	cmp EDX,2
	JE GCD12
	cmp EDX,3
	JE GCD13
	cmp EDX,4
	JE GCD14
L14:
	call  WriteString
	mov currentType,4
	mov EDX, LENGTHOF Benchmark1[0]
	cmp EDX,4
	JA L11
	cmp EDX,2
	JB L11
	cmp EDX,2
	JE GCD12
	cmp EDX,3
	JE GCD13
	cmp EDX,4
	JE GCD14
GCD12:
	cmp currentType,1
	JNE GCD12T2Sub
	cmp BYTE PTR Benchmark1[0],0
	JE L11
	cmp BYTE PTR Benchmark1[1],0
	JE L11
	cmp BYTE PTR Benchmark1[0],-128
	JL L11
	cmp BYTE PTR Benchmark1[1],-128
	JL L11
	cmp BYTE PTR Benchmark1[0],127
	JA L11
	cmp BYTE PTR Benchmark1[1],127
	JA L11
	cmp BYTE PTR Benchmark1[0],0
	JLE GCD12T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	mov m,eax
	jmp GCD12T1Sub2
GCD12T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	not AL
	add AL,1
	mov m,eax
GCD12T1Sub2:
	cmp BYTE PTR Benchmark1[1],0
	JLE GCD12T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	mov n,eax
	jmp GCD12DATAEND
GCD12T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	not AL
	add AL,1
	mov n,eax
	
GCD12T2Sub:
	   cmp currentType,2
	   JNE GCD12T3sub
	   cmp WORD PTR Benchmark1[0],0
	   JE L11
	   cmp WORD PTR Benchmark1[2],0
	   JE L11
	   cmp WORD PTR Benchmark1[0],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[2],-32768	
	   JL L11
	   cmp WORD PTR Benchmark1[0],32767
	   JA L11
	   cmp WORD PTR Benchmark1[2],32767
	   JA L11
	   cmp WORD PTR Benchmark1[0],0
	   JLE GCD12T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD12T2Sub2
GCD12T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark1[0]
	not ax
	add ax,1
	mov m,eax
GCD12T2Sub2:
	cmp WORD PTR Benchmark1[2],0
	JLE GCD12T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark1[2]
	mov n,eax
	jmp GCD12DATAEND
GCD12T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark1[2]
	not ax
	add ax,1
	mov n,eax
GCD12T3Sub: 
	   cmp currentType,4
	   JNE GCD12DATAEND
	   cmp DWORD PTR Benchmark1[0],0
	   JE L11
	   cmp DWORD PTR Benchmark1[4],0
	   JE L11
	   cmp DWORD PTR Benchmark1[0],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[4],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[0],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[4],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[0],0
	   JLE GCD12T3Sub1
	   mov eax,DWord ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD12T3Sub2
GCD12T3Sub1:
	mov eax,DWord ptr Benchmark1[0]
	not eax
	add eax,1
	mov m,eax
GCD12T3Sub2:
	cmp DWORD PTR Benchmark1[4],0
	JLE GCD12T3Sub3
	mov eax,DWord ptr Benchmark1[4]
	mov n,eax
	jmp GCD12DATAEND
GCD12T3Sub3:	
	mov eax,DWord ptr Benchmark1[4]
	not eax
	add eax,1
	mov n,eax
GCD12DATAEnd:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[0],eax
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y1
	mov Result_Benchmark_LCM[0],eax
	jmp GCD1End
GCD1Y1:
	mov Result_Benchmark_LCM[0],0
	jmp GCD1End

GCD13:
	cmp currentType,1
	JNE GCD13T2Sub
	cmp BYTE PTR Benchmark1[0],0
	JE L11
	cmp BYTE PTR Benchmark1[1],0
	JE L11
	cmp BYTE PTR Benchmark1[2],0
	JE L11
	cmp BYTE PTR Benchmark1[0],-128
	JL L11
	cmp BYTE PTR Benchmark1[1],-128
	JL L11
	cmp BYTE PTR Benchmark1[2],-128
	JL L11
	cmp BYTE PTR  Benchmark1[0],127
	JA L11
	cmp BYTE PTR Benchmark1[1],127
	JA L11
	cmp BYTE PTR Benchmark1[2],127
	JA L11
GCD13T1Sub:
	cmp BYTE PTR Benchmark1[0],0
	JLE GCD13T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	mov m,eax
	jmp GCD13T1Sub2
GCD13T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	not AL
	add AL,1
	mov m,eax
GCD13T1Sub2:
	cmp BYTE PTR Benchmark1[1],0
	JLE GCD13T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	mov n,eax
	jmp GCD13T1Sub4
GCD13T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	not AL
	add AL,1
	mov n,eax
GCD13T1Sub4:
	cmp BYTE PTR Benchmark1[2],0
	JLE GCD13T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark1[2]
	mov x,eax
	jmp GCD13DATAEND
GCD13T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark1[2]
	not AL
	add AL,1
	mov x,eax
	
GCD13T2Sub: cmp currentType,2
	   JNE GCD13T3sub
	   cmp WORD PTR Benchmark1[0],0
	   JE L11
	   cmp WORD PTR Benchmark1[2],0
	   JE L11
	   cmp WORD PTR Benchmark1[4],0
	   JE L11
	   cmp WORD PTR Benchmark1[0],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[2],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[4],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[0],32767
	   JA L11
	   cmp WORD PTR Benchmark1[2],32767
	   JA L11
	   cmp WORD PTR Benchmark1[4],32767
	   JA L11
	   cmp WORD PTR Benchmark1[0],0
	   JLE GCD13T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD13T2Sub2
GCD13T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark1[0]
	not ax
	add ax,1
	mov m,eax
GCD13T2Sub2:
	cmp WORD PTR Benchmark1[2],0
	JLE GCD13T2Sub3
    mov eax,0
	mov ax,word ptr Benchmark1[2]
	mov n,eax
	jmp GCD13T2Sub4
GCD13T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark1[2]
	not ax
	add ax,1
	mov n,eax
GCD13T2Sub4:
	cmp WORD PTR Benchmark1[4],0
	JLE GCD13T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark1[4]
	mov x,eax
	jmp GCD13DATAEND
GCD13T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark1[4]
	not ax
	add ax,1
	mov x,eax

GCD13T3Sub: cmp currentType,4
	   JNE GCD13DATAEND
	   cmp DWORD PTR Benchmark1[0],0
	   JE L11
	   cmp DWORD PTR Benchmark1[4],0
	   JE L11
	   cmp DWORD PTR Benchmark1[8],0
	   JE L11
	   cmp DWORD PTR Benchmark1[0],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[4],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[8],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[0],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[4],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[8],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[0],0
	   JLE GCD13T3Sub1
	   mov eax,DWord ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD13T3Sub2
GCD13T3Sub1:
	mov eax,DWord ptr Benchmark1[0]
	not eax
	add eax,1
	mov m,eax
GCD13T3Sub2:
	cmp DWORD PTR Benchmark1[4],0
	JLE GCD13T3Sub3
    mov eax,DWord ptr Benchmark1[4]
	mov n,eax
	jmp GCD13T3Sub4
GCD13T3Sub3:	
	mov eax,DWord ptr Benchmark1[4]
	not eax
	add eax,1
	mov n,eax
GCD13T3Sub4:
	cmp DWORD PTR Benchmark1[8],0
	JLE GCD13T3Sub5
	mov eax,DWord ptr Benchmark1[8]
	mov x,eax
	jmp GCD13DATAEND
GCD13T3Sub5:	
	mov eax,DWord ptr Benchmark1[8]
	not eax
	add eax,1
	mov x,eax
GCD13DATAEND:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[0],eax
	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y2
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y2
	mov Result_Benchmark_LCM[0],eax
	jmp GCD1End
GCD1Y2:
	mov Result_Benchmark_LCM[0],0
	jmp GCD1End

GCD14:
	cmp currentType,1
	JNE GCD14T2Sub
	cmp BYTE PTR Benchmark1[0],0
	JE L11
	cmp BYTE PTR Benchmark1[1],0
	JE L11
	cmp BYTE PTR Benchmark1[2],0
	JE L11
	cmp BYTE PTR Benchmark1[3],0
	JE L11
	cmp BYTE PTR Benchmark1[0],-128
	JL L11
	cmp BYTE PTR Benchmark1[1],-128
	JL L11
	cmp BYTE PTR Benchmark1[2],-128
	JL L11
	cmp BYTE PTR Benchmark1[3],-128
	JL L11
	cmp BYTE PTR Benchmark1[0],127
	JA L11
	cmp BYTE PTR Benchmark1[1],127
	JA L11
	cmp BYTE PTR Benchmark1[2],127
	JA L11
	cmp BYTE PTR Benchmark1[3],127
	JA L11
GCD14T1Sub:
	cmp BYTE PTR Benchmark1[0],0
	JLE GCD14T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	mov m,eax
	jmp GCD14T1Sub2
GCD14T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark1[0]
	not AL
	add AL,1
	mov m,eax
GCD14T1Sub2:
	cmp BYTE PTR Benchmark1[1],0
	JLE GCD14T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	mov n,eax
	jmp GCD14T1Sub4
GCD14T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark1[1]
	not AL
	add AL,1
	mov n,eax
GCD14T1Sub4:
	cmp BYTE PTR Benchmark1[2],0
	JLE GCD14T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark1[2]
	mov x,eax
	jmp GCD14T1Sub6
GCD14T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark1[2]
	not AL
	add AL,1
	mov x,eax
GCD14T1Sub6:
	cmp BYTE PTR Benchmark1[3],0
	JLE GCD14T1Sub7
	mov eax,0
	mov AL,byte ptr Benchmark1[3]
	mov y,eax
	jmp GCD14END
GCD14T1Sub7:	
	mov eax,0
	mov AL,byte ptr Benchmark1[3]
	not AL
	add AL,1
	mov y,eax
GCD14T2Sub: cmp currentType,2
	   JNE GCD14T3sub
	   cmp WORD PTR Benchmark1[0],0
	   JE L11
	   cmp WORD PTR Benchmark1[2],0
	   JE L11
	   cmp WORD PTR Benchmark1[4],0
	   JE L11
	   cmp WORD PTR Benchmark1[6],0
	   JE L11
	   cmp WORD PTR Benchmark1[0],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[2],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[4],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[6],-32768
	   JL L11
	   cmp WORD PTR Benchmark1[0],32767
	   JA L11
	   cmp WORD PTR Benchmark1[2],32767
	   JA L11
	   cmp WORD PTR Benchmark1[4],32767
	   JA L11
	   cmp WORD PTR Benchmark1[6],32767
	   JA L11
	   cmp WORD PTR Benchmark1[0],0
	   JLE GCD14T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD14T2Sub2
GCD14T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark1[0]
	not ax
	add ax,1
	mov m,eax
GCD14T2Sub2:
	cmp WORD PTR Benchmark1[2],0
	JLE GCD14T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark1[2]
	mov n,eax
	jmp GCD14T2Sub4
GCD14T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark1[2]
	not ax
	add ax,1
	mov n,eax
GCD14T2Sub4:
	cmp WORD PTR Benchmark1[4],0
	JLE GCD14T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark1[4]
	mov x,eax
	jmp GCD14T2Sub6
GCD14T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark1[4]
	not ax
	add ax,1
	mov x,eax
GCD14T2Sub6:
	cmp WORD PTR Benchmark1[6],0
	JLE GCD14T2Sub6
	mov eax,0
	mov ax,word ptr Benchmark1[6]
	mov y,eax
	jmp GCD14END
GCD14T2Sub7:	
	mov eax,0
	mov ax,word ptr Benchmark1[6]
	not ax
	add ax,1
	mov y,eax

GCD14T3Sub: cmp currentType,4
	   JNE GCD14END
	   cmp DWORD PTR Benchmark1[0],0
	   JE L11
	   cmp DWORD PTR Benchmark1[4],0
	   JE L11
	   cmp DWORD PTR Benchmark1[8],0
	   JE L11
	   cmp DWORD PTR Benchmark1[12],0
	   JE L11
	   cmp DWORD PTR Benchmark1[0],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[4],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[8],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[12],-2147483648
	   JL L11
	   cmp DWORD PTR Benchmark1[0],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[4],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[8],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[12],2147483647
	   JA L11
	   cmp DWORD PTR Benchmark1[0],0
	   JLE GCD14T3Sub1
	   mov eax,DWord ptr Benchmark1[0]
	   mov m,eax
	   jmp GCD14T3Sub2
GCD14T3Sub1:
	mov eax,DWord ptr Benchmark1[0]
	not eax
	add eax,1
	mov m,eax
GCD14T3Sub2:
	cmp DWORD PTR Benchmark1[4],0
	mov eax,DWord ptr Benchmark1[0]
	JLE GCD14T3Sub3
	mov eax,DWord ptr Benchmark1[4]
	mov n,eax
	jmp GCD14T3Sub4
GCD14T3Sub3:	
	mov eax,DWord ptr Benchmark1[4]
	not eax
	add eax,1
	mov n,eax
GCD14T3Sub4:
	cmp DWORD PTR Benchmark1[8],0
	JLE GCD14T3Sub5
	mov eax,DWord ptr Benchmark1[8]
	mov x,eax
	jmp GCD14T3Sub6
GCD14T3Sub5:	
	mov eax,DWord ptr Benchmark1[8]
	not eax
	add eax,1
	mov x,eax
GCD14T3Sub6:
	cmp DWORD PTR Benchmark1[12],0
	JLE GCD14T3Sub7
	mov eax,DWord ptr Benchmark1[12]
	mov y,eax
	jmp GCD14END
GCD14T3Sub7:	
	mov eax,DWord ptr Benchmark1[12]
	not eax
	add eax,1
	mov y,eax
GCD14End:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	mov EAX,Y
	mov ORIGINY,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,y
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[0],eax

	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,y
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD1Y3
	mov Result_Benchmark_LCM[0],eax
	jmp GCD1End
GCD1Y3:
	mov Result_Benchmark_LCM[0],0
	jmp GCD1End
GCD1End:
	jmp GCD2Start
GCD2Start:
	mov SI,0
	mov EDX, type Benchmark2[SI]
	cmp EDX,1
	je L22
	cmp EDX,2
	je  L23
	cmp EDX,4
	je  L24
	jne L21
	jmp GCD2END;
L21:
	mov EBX,4
	mov Result_Benchmark_GCD[EBX],0
	mov Result_Benchmark_LCM[EBX],0
	jmp GCD2END;
L22:
	mov currentType,1
	mov EDX, LENGTHOF Benchmark2[0]
	cmp EDX,4
	JA L21
	cmp EDX,2
	JB L21
	cmp EDX,2
	JE GCD22
	cmp EDX,3
	JE GCD23
	cmp EDX,4
	JE GCD24
L23:
	mov currentType,2
	mov EDX, LENGTHOF Benchmark2[0]
	cmp EDX,4
	JA L21
	cmp EDX,2
	JB L21
	cmp EDX,2
	JE GCD22
	cmp EDX,3
	JE GCD23
	cmp EDX,4
	JE GCD24
L24:
	call  WriteString
	mov currentType,4
	mov EDX, LENGTHOF Benchmark2[0]
	cmp EDX,4
	JA L21
	cmp EDX,2
	JB L21
	cmp EDX,2
	JE GCD22
	cmp EDX,3
	JE GCD23
	cmp EDX,4
	JE GCD24
GCD22:
	cmp currentType,1
	JNE GCD22T2Sub
	cmp BYTE PTR Benchmark2[0],0
	JE L21
	cmp BYTE PTR Benchmark2[1],0
	JE L21
	cmp BYTE PTR Benchmark2[0],-128
	JL L21
	cmp BYTE PTR Benchmark2[1],-128
	JL L21
	cmp BYTE PTR Benchmark2[0],127
	JA L21
	cmp BYTE PTR Benchmark2[1],127
	JA L21
	cmp BYTE PTR Benchmark2[0],0
	JLE GCD22T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	mov m,eax
	jmp GCD22T1Sub2
GCD22T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	not AL
	add AL,1
	mov m,eax
GCD22T1Sub2:
	cmp BYTE PTR Benchmark2[1],0
	JLE GCD22T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	mov n,eax
	jmp GCD22DATAEND
GCD22T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	not AL
	add AL,1
	mov n,eax
	
GCD22T2Sub:
	   cmp currentType,2
	   JNE GCD22T3sub
	   cmp WORD PTR Benchmark2[0],0
	   JE L21
	   cmp WORD PTR Benchmark2[2],0
	   JE L21
	   cmp WORD PTR Benchmark2[0],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[2],-32768	
	   JL L21
	   cmp WORD PTR Benchmark2[0],32767
	   JA L21
	   cmp WORD PTR Benchmark2[2],32767
	   JA L21
	   cmp WORD PTR Benchmark2[0],0
	   JLE GCD22T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD22T2Sub2
GCD22T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark2[0]
	not ax
	add ax,1
	mov m,eax
GCD22T2Sub2:
	cmp WORD PTR Benchmark2[2],0
	JLE GCD22T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark2[2]
	mov n,eax
	jmp GCD22DATAEND
GCD22T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark2[2]
	not ax
	add ax,1
	mov n,eax
GCD22T3Sub: 
	   cmp currentType,4
	   JNE GCD22DATAEND
	   cmp DWORD PTR Benchmark2[0],0
	   JE L21
	   cmp DWORD PTR Benchmark2[4],0
	   JE L21
	   cmp DWORD PTR Benchmark2[0],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[4],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[0],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[4],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[0],0
	   JLE GCD22T3Sub1
	   mov eax,DWord ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD22T3Sub2
GCD22T3Sub1:
	mov eax,DWord ptr Benchmark2[0]
	not eax
	add eax,1
	mov m,eax
GCD22T3Sub2:
	cmp DWORD PTR Benchmark2[4],0
	JLE GCD22T3Sub3
	mov eax,DWord ptr Benchmark2[4]
	mov n,eax
	jmp GCD22DATAEND
GCD22T3Sub3:	
	mov eax,DWord ptr Benchmark2[4]
	not eax
	add eax,1
	mov n,eax
GCD22DATAEnd:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[4],eax
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y1
	mov Result_Benchmark_LCM[4],eax
	jmp GCD2End
GCD2Y1:
	mov Result_Benchmark_LCM[4],0
	jmp GCD2End

GCD23:
	cmp currentType,1
	JNE GCD23T2Sub
	cmp BYTE PTR Benchmark2[0],0
	JE L21
	cmp BYTE PTR Benchmark2[1],0
	JE L21
	cmp BYTE PTR Benchmark2[2],0
	JE L21
	cmp BYTE PTR Benchmark2[0],-128
	JL L21
	cmp BYTE PTR Benchmark2[1],-128
	JL L21
	cmp BYTE PTR Benchmark2[2],-128
	JL L21
	cmp BYTE PTR  Benchmark2[0],127
	JA L21
	cmp BYTE PTR Benchmark2[1],127
	JA L21
	cmp BYTE PTR Benchmark2[2],127
	JA L21
GCD23T1Sub:
	cmp BYTE PTR Benchmark2[0],0
	JLE GCD23T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	mov m,eax
	jmp GCD23T1Sub2
GCD23T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	not AL
	add AL,1
	mov m,eax
GCD23T1Sub2:
	cmp BYTE PTR Benchmark2[1],0
	JLE GCD23T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	mov n,eax
	jmp GCD23T1Sub4
GCD23T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	not AL
	add AL,1
	mov n,eax
GCD23T1Sub4:
	cmp BYTE PTR Benchmark2[2],0
	JLE GCD23T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark2[2]
	mov x,eax
	jmp GCD23DATAEND
GCD23T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark2[2]
	not AL
	add AL,1
	mov x,eax
	
GCD23T2Sub: cmp currentType,2
	   JNE GCD23T3sub
	   cmp WORD PTR Benchmark2[0],0
	   JE L21
	   cmp WORD PTR Benchmark2[2],0
	   JE L21
	   cmp WORD PTR Benchmark2[4],0
	   JE L21
	   cmp WORD PTR Benchmark2[0],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[2],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[4],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[0],32767
	   JA L21
	   cmp WORD PTR Benchmark2[2],32767
	   JA L21
	   cmp WORD PTR Benchmark2[4],32767
	   JA L21
	   cmp WORD PTR Benchmark2[0],0
	   JLE GCD23T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD23T2Sub2
GCD23T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark2[0]
	not ax
	add ax,1
	mov m,eax
GCD23T2Sub2:
	cmp WORD PTR Benchmark2[2],0
	JLE GCD23T2Sub3
    mov eax,0
	mov ax,word ptr Benchmark2[2]
	mov n,eax
	jmp GCD23T2Sub4
GCD23T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark2[2]
	not ax
	add ax,1
	mov n,eax
GCD23T2Sub4:
	cmp WORD PTR Benchmark2[4],0
	JLE GCD23T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark2[4]
	mov x,eax
	jmp GCD23DATAEND
GCD23T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark2[4]
	not ax
	add ax,1
	mov x,eax

GCD23T3Sub: cmp currentType,4
	   JNE GCD23DATAEND
	   cmp DWORD PTR Benchmark2[0],0
	   JE L21
	   cmp DWORD PTR Benchmark2[4],0
	   JE L21
	   cmp DWORD PTR Benchmark2[8],0
	   JE L21
	   cmp DWORD PTR Benchmark2[0],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[4],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[8],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[0],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[4],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[8],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[0],0
	   JLE GCD23T3Sub1
	   mov eax,DWord ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD23T3Sub2
GCD23T3Sub1:
	mov eax,DWord ptr Benchmark2[0]
	not eax
	add eax,1
	mov m,eax
GCD23T3Sub2:
	cmp DWORD PTR Benchmark2[4],0
	JLE GCD23T3Sub3
    mov eax,DWord ptr Benchmark2[4]
	mov n,eax
	jmp GCD23T3Sub4
GCD23T3Sub3:	
	mov eax,DWord ptr Benchmark2[4]
	not eax
	add eax,1
	mov n,eax
GCD23T3Sub4:
	cmp DWORD PTR Benchmark2[8],0
	JLE GCD23T3Sub5
	mov eax,DWord ptr Benchmark2[8]
	mov x,eax
	jmp GCD23DATAEND
GCD23T3Sub5:	
	mov eax,DWord ptr Benchmark2[8]
	not eax
	add eax,1
	mov x,eax
GCD23DATAEND:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[4],eax
	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y2
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y2
	mov Result_Benchmark_LCM[4],eax
	jmp GCD2End
GCD2Y2:
	mov Result_Benchmark_LCM[4],0
	jmp GCD2End

GCD24:
	cmp currentType,1
	JNE GCD24T2Sub
	cmp BYTE PTR Benchmark2[0],0
	JE L21
	cmp BYTE PTR Benchmark2[1],0
	JE L21
	cmp BYTE PTR Benchmark2[2],0
	JE L21
	cmp BYTE PTR Benchmark2[3],0
	JE L21
	cmp BYTE PTR Benchmark2[0],-128
	JL L21
	cmp BYTE PTR Benchmark2[1],-128
	JL L21
	cmp BYTE PTR Benchmark2[2],-128
	JL L21
	cmp BYTE PTR Benchmark2[3],-128
	JL L21
	cmp BYTE PTR Benchmark2[0],127
	JA L21
	cmp BYTE PTR Benchmark2[1],127
	JA L21
	cmp BYTE PTR Benchmark2[2],127
	JA L21
	cmp BYTE PTR Benchmark2[3],127
	JA L21
GCD24T1Sub:
	cmp BYTE PTR Benchmark2[0],0
	JLE GCD24T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	mov m,eax
	jmp GCD24T1Sub2
GCD24T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark2[0]
	not AL
	add AL,1
	mov m,eax
GCD24T1Sub2:
	cmp BYTE PTR Benchmark2[1],0
	JLE GCD24T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	mov n,eax
	jmp GCD24T1Sub4
GCD24T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark2[1]
	not AL
	add AL,1
	mov n,eax
GCD24T1Sub4:
	cmp BYTE PTR Benchmark2[2],0
	JLE GCD24T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark2[2]
	mov x,eax
	jmp GCD24T1Sub6
GCD24T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark2[2]
	not AL
	add AL,1
	mov x,eax
GCD24T1Sub6:
	cmp BYTE PTR Benchmark2[3],0
	JLE GCD24T1Sub7
	mov eax,0
	mov AL,byte ptr Benchmark2[3]
	mov y,eax
	jmp GCD24END
GCD24T1Sub7:	
	mov eax,0
	mov AL,byte ptr Benchmark2[3]
	not AL
	add AL,1
	mov y,eax
GCD24T2Sub: cmp currentType,2
	   JNE GCD24T3sub
	   cmp WORD PTR Benchmark2[0],0
	   JE L21
	   cmp WORD PTR Benchmark2[2],0
	   JE L21
	   cmp WORD PTR Benchmark2[4],0
	   JE L21
	   cmp WORD PTR Benchmark2[6],0
	   JE L21
	   cmp WORD PTR Benchmark2[0],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[2],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[4],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[6],-32768
	   JL L21
	   cmp WORD PTR Benchmark2[0],32767
	   JA L21
	   cmp WORD PTR Benchmark2[2],32767
	   JA L21
	   cmp WORD PTR Benchmark2[4],32767
	   JA L21
	   cmp WORD PTR Benchmark2[6],32767
	   JA L21
	   cmp WORD PTR Benchmark2[0],0
	   JLE GCD24T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD24T2Sub2
GCD24T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark2[0]
	not ax
	add ax,1
	mov m,eax
GCD24T2Sub2:
	cmp WORD PTR Benchmark2[2],0
	JLE GCD24T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark2[2]
	mov n,eax
	jmp GCD24T2Sub4
GCD24T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark2[2]
	not ax
	add ax,1
	mov n,eax
GCD24T2Sub4:
	cmp WORD PTR Benchmark2[4],0
	JLE GCD24T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark2[4]
	mov x,eax
	jmp GCD24T2Sub6
GCD24T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark2[4]
	not ax
	add ax,1
	mov x,eax
GCD24T2Sub6:
	cmp WORD PTR Benchmark2[6],0
	JLE GCD24T2Sub6
	mov eax,0
	mov ax,word ptr Benchmark2[6]
	mov y,eax
	jmp GCD24END
GCD24T2Sub7:	
	mov eax,0
	mov ax,word ptr Benchmark2[6]
	not ax
	add ax,1
	mov y,eax

GCD24T3Sub: cmp currentType,4
	   JNE GCD24END
	   cmp DWORD PTR Benchmark2[0],0
	   JE L21
	   cmp DWORD PTR Benchmark2[4],0
	   JE L21
	   cmp DWORD PTR Benchmark2[8],0
	   JE L21
	   cmp DWORD PTR Benchmark2[12],0
	   JE L21
	   cmp DWORD PTR Benchmark2[0],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[4],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[8],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[12],-2147483648
	   JL L21
	   cmp DWORD PTR Benchmark2[0],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[4],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[8],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[12],2147483647
	   JA L21
	   cmp DWORD PTR Benchmark2[0],0
	   JLE GCD24T3Sub1
	   mov eax,DWord ptr Benchmark2[0]
	   mov m,eax
	   jmp GCD24T3Sub2
GCD24T3Sub1:
	mov eax,DWord ptr Benchmark2[0]
	not eax
	add eax,1
	mov m,eax
GCD24T3Sub2:
	cmp DWORD PTR Benchmark2[4],0
	mov eax,DWord ptr Benchmark2[0]
	JLE GCD24T3Sub3
	mov eax,DWord ptr Benchmark2[4]
	mov n,eax
	jmp GCD24T3Sub4
GCD24T3Sub3:	
	mov eax,DWord ptr Benchmark2[4]
	not eax
	add eax,1
	mov n,eax
GCD24T3Sub4:
	cmp DWORD PTR Benchmark2[8],0
	JLE GCD24T3Sub5
	mov eax,DWord ptr Benchmark2[8]
	mov x,eax
	jmp GCD24T3Sub6
GCD24T3Sub5:	
	mov eax,DWord ptr Benchmark2[8]
	not eax
	add eax,1
	mov x,eax
GCD24T3Sub6:
	cmp DWORD PTR Benchmark2[12],0
	JLE GCD24T3Sub7
	mov eax,DWord ptr Benchmark2[12]
	mov y,eax
	jmp GCD24END
GCD24T3Sub7:	
	mov eax,DWord ptr Benchmark2[12]
	not eax
	add eax,1
	mov y,eax
GCD24End:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	mov EAX,Y
	mov ORIGINY,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,y
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[4],eax

	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,y
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD2Y3
	mov Result_Benchmark_LCM[4],eax
	jmp GCD2End
GCD2Y3:
	mov Result_Benchmark_LCM[4],0
	jmp GCD2End
GCD2End:
	jmp GCD3Start
GCD3Start:
	mov SI,0
	mov EDX, type Benchmark3[SI]
	cmp EDX,1
	je L32
	cmp EDX,2
	je  L33
	cmp EDX,4
	je  L34
	jne L31
	jmp GCD3END;
L31:
	mov EBX,8
	mov Result_Benchmark_GCD[EBX],0
	mov Result_Benchmark_LCM[EBX],0
	jmp GCD3END;
L32:
	mov currentType,1
	mov EDX, LENGTHOF Benchmark3[0]
	cmp EDX,4
	JA L31
	cmp EDX,2
	JB L31
	cmp EDX,2
	JE GCD32
	cmp EDX,3
	JE GCD33
	cmp EDX,4
	JE GCD34
L33:
	mov currentType,2
	mov EDX, LENGTHOF Benchmark3[0]
	cmp EDX,4
	JA L31
	cmp EDX,2
	JB L31
	cmp EDX,2
	JE GCD32
	cmp EDX,3
	JE GCD33
	cmp EDX,4
	JE GCD34
L34:
	call  WriteString
	mov currentType,4
	mov EDX, LENGTHOF Benchmark3[0]
	cmp EDX,4
	JA L31
	cmp EDX,2
	JB L31
	cmp EDX,2
	JE GCD32
	cmp EDX,3
	JE GCD33
	cmp EDX,4
	JE GCD34
GCD32:
	cmp currentType,1
	JNE GCD32T2Sub
	cmp BYTE PTR Benchmark3[0],0
	JE L31
	cmp BYTE PTR Benchmark3[1],0
	JE L31
	cmp BYTE PTR Benchmark3[0],-128
	JL L31
	cmp BYTE PTR Benchmark3[1],-128
	JL L31
	cmp BYTE PTR Benchmark3[0],127
	JA L31
	cmp BYTE PTR Benchmark3[1],127
	JA L31
	cmp BYTE PTR Benchmark3[0],0
	JLE GCD32T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	mov m,eax
	jmp GCD32T1Sub2
GCD32T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	not AL
	add AL,1
	mov m,eax
GCD32T1Sub2:
	cmp BYTE PTR Benchmark3[1],0
	JLE GCD32T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	mov n,eax
	jmp GCD32DATAEND
GCD32T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	not AL
	add AL,1
	mov n,eax
	
GCD32T2Sub:
	   cmp currentType,2
	   JNE GCD32T3sub
	   cmp WORD PTR Benchmark3[0],0
	   JE L31
	   cmp WORD PTR Benchmark3[2],0
	   JE L31
	   cmp WORD PTR Benchmark3[0],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[2],-32768	
	   JL L31
	   cmp WORD PTR Benchmark3[0],32767
	   JA L31
	   cmp WORD PTR Benchmark3[2],32767
	   JA L31
	   cmp WORD PTR Benchmark3[0],0
	   JLE GCD32T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD32T2Sub2
GCD32T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark3[0]
	not ax
	add ax,1
	mov m,eax
GCD32T2Sub2:
	cmp WORD PTR Benchmark3[2],0
	JLE GCD32T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark3[2]
	mov n,eax
	jmp GCD32DATAEND
GCD32T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark3[2]
	not ax
	add ax,1
	mov n,eax
GCD32T3Sub: 
	   cmp currentType,4
	   JNE GCD32DATAEND
	   cmp DWORD PTR Benchmark3[0],0
	   JE L31
	   cmp DWORD PTR Benchmark3[4],0
	   JE L31
	   cmp DWORD PTR Benchmark3[0],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[4],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[0],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[4],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[0],0
	   JLE GCD32T3Sub1
	   mov eax,DWord ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD32T3Sub2
GCD32T3Sub1:
	mov eax,DWord ptr Benchmark3[0]
	not eax
	add eax,1
	mov m,eax
GCD32T3Sub2:
	cmp DWORD PTR Benchmark3[4],0
	JLE GCD32T3Sub3
	mov eax,DWord ptr Benchmark3[4]
	mov n,eax
	jmp GCD32DATAEND
GCD32T3Sub3:	
	mov eax,DWord ptr Benchmark3[4]
	not eax
	add eax,1
	mov n,eax
GCD32DATAEnd:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[8],eax
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y1
	mov Result_Benchmark_LCM[8],eax
	jmp GCD3End
GCD3Y1:
	mov Result_Benchmark_LCM[8],0
	jmp GCD3End

GCD33:
	cmp currentType,1
	JNE GCD33T2Sub
	cmp BYTE PTR Benchmark3[0],0
	JE L31
	cmp BYTE PTR Benchmark3[1],0
	JE L31
	cmp BYTE PTR Benchmark3[2],0
	JE L31
	cmp BYTE PTR Benchmark3[0],-128
	JL L31
	cmp BYTE PTR Benchmark3[1],-128
	JL L31
	cmp BYTE PTR Benchmark3[2],-128
	JL L31
	cmp BYTE PTR  Benchmark3[0],127
	JA L31
	cmp BYTE PTR Benchmark3[1],127
	JA L31
	cmp BYTE PTR Benchmark3[2],127
	JA L31
GCD33T1Sub:
	cmp BYTE PTR Benchmark3[0],0
	JLE GCD33T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	mov m,eax
	jmp GCD33T1Sub2
GCD33T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	not AL
	add AL,1
	mov m,eax
GCD33T1Sub2:
	cmp BYTE PTR Benchmark3[1],0
	JLE GCD33T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	mov n,eax
	jmp GCD33T1Sub4
GCD33T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	not AL
	add AL,1
	mov n,eax
GCD33T1Sub4:
	cmp BYTE PTR Benchmark3[2],0
	JLE GCD33T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark3[2]
	mov x,eax
	jmp GCD33DATAEND
GCD33T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark3[2]
	not AL
	add AL,1
	mov x,eax
	
GCD33T2Sub: cmp currentType,2
	   JNE GCD33T3sub
	   cmp WORD PTR Benchmark3[0],0
	   JE L31
	   cmp WORD PTR Benchmark3[2],0
	   JE L31
	   cmp WORD PTR Benchmark3[4],0
	   JE L31
	   cmp WORD PTR Benchmark3[0],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[2],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[4],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[0],32767
	   JA L31
	   cmp WORD PTR Benchmark3[2],32767
	   JA L31
	   cmp WORD PTR Benchmark3[4],32767
	   JA L31
	   cmp WORD PTR Benchmark3[0],0
	   JLE GCD33T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD33T2Sub2
GCD33T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark3[0]
	not ax
	add ax,1
	mov m,eax
GCD33T2Sub2:
	cmp WORD PTR Benchmark3[2],0
	JLE GCD33T2Sub3
    mov eax,0
	mov ax,word ptr Benchmark3[2]
	mov n,eax
	jmp GCD33T2Sub4
GCD33T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark3[2]
	not ax
	add ax,1
	mov n,eax
GCD33T2Sub4:
	cmp WORD PTR Benchmark3[4],0
	JLE GCD33T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark3[4]
	mov x,eax
	jmp GCD33DATAEND
GCD33T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark3[4]
	not ax
	add ax,1
	mov x,eax

GCD33T3Sub: cmp currentType,4
	   JNE GCD33DATAEND
	   cmp DWORD PTR Benchmark3[0],0
	   JE L31
	   cmp DWORD PTR Benchmark3[4],0
	   JE L31
	   cmp DWORD PTR Benchmark3[8],0
	   JE L31
	   cmp DWORD PTR Benchmark3[0],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[4],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[8],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[0],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[4],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[8],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[0],0
	   JLE GCD33T3Sub1
	   mov eax,DWord ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD33T3Sub2
GCD33T3Sub1:
	mov eax,DWord ptr Benchmark3[0]
	not eax
	add eax,1
	mov m,eax
GCD33T3Sub2:
	cmp DWORD PTR Benchmark3[4],0
	JLE GCD33T3Sub3
    mov eax,DWord ptr Benchmark3[4]
	mov n,eax
	jmp GCD33T3Sub4
GCD33T3Sub3:	
	mov eax,DWord ptr Benchmark3[4]
	not eax
	add eax,1
	mov n,eax
GCD33T3Sub4:
	cmp DWORD PTR Benchmark3[8],0
	JLE GCD33T3Sub5
	mov eax,DWord ptr Benchmark3[8]
	mov x,eax
	jmp GCD33DATAEND
GCD33T3Sub5:	
	mov eax,DWord ptr Benchmark3[8]
	not eax
	add eax,1
	mov x,eax
GCD33DATAEND:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[8],eax
	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y2
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y2
	mov Result_Benchmark_LCM[8],eax
	jmp GCD3End
GCD3Y2:
	mov Result_Benchmark_LCM[8],0
	jmp GCD3End

GCD34:
	cmp currentType,1
	JNE GCD34T2Sub
	cmp BYTE PTR Benchmark3[0],0
	JE L31
	cmp BYTE PTR Benchmark3[1],0
	JE L31
	cmp BYTE PTR Benchmark3[2],0
	JE L31
	cmp BYTE PTR Benchmark3[3],0
	JE L31
	cmp BYTE PTR Benchmark3[0],-128
	JL L31
	cmp BYTE PTR Benchmark3[1],-128
	JL L31
	cmp BYTE PTR Benchmark3[2],-128
	JL L31
	cmp BYTE PTR Benchmark3[3],-128
	JL L31
	cmp BYTE PTR Benchmark3[0],127
	JA L31
	cmp BYTE PTR Benchmark3[1],127
	JA L31
	cmp BYTE PTR Benchmark3[2],127
	JA L31
	cmp BYTE PTR Benchmark3[3],127
	JA L31
GCD34T1Sub:
	cmp BYTE PTR Benchmark3[0],0
	JLE GCD34T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	mov m,eax
	jmp GCD34T1Sub2
GCD34T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark3[0]
	not AL
	add AL,1
	mov m,eax
GCD34T1Sub2:
	cmp BYTE PTR Benchmark3[1],0
	JLE GCD34T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	mov n,eax
	jmp GCD34T1Sub4
GCD34T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark3[1]
	not AL
	add AL,1
	mov n,eax
GCD34T1Sub4:
	cmp BYTE PTR Benchmark3[2],0
	JLE GCD34T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark3[2]
	mov x,eax
	jmp GCD34T1Sub6
GCD34T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark3[2]
	not AL
	add AL,1
	mov x,eax
GCD34T1Sub6:
	cmp BYTE PTR Benchmark3[3],0
	JLE GCD34T1Sub7
	mov eax,0
	mov AL,byte ptr Benchmark3[3]
	mov y,eax
	jmp GCD34END
GCD34T1Sub7:	
	mov eax,0
	mov AL,byte ptr Benchmark3[3]
	not AL
	add AL,1
	mov y,eax
GCD34T2Sub: cmp currentType,2
	   JNE GCD34T3sub
	   cmp WORD PTR Benchmark3[0],0
	   JE L31
	   cmp WORD PTR Benchmark3[2],0
	   JE L31
	   cmp WORD PTR Benchmark3[4],0
	   JE L31
	   cmp WORD PTR Benchmark3[6],0
	   JE L31
	   cmp WORD PTR Benchmark3[0],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[2],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[4],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[6],-32768
	   JL L31
	   cmp WORD PTR Benchmark3[0],32767
	   JA L31
	   cmp WORD PTR Benchmark3[2],32767
	   JA L31
	   cmp WORD PTR Benchmark3[4],32767
	   JA L31
	   cmp WORD PTR Benchmark3[6],32767
	   JA L31
	   cmp WORD PTR Benchmark3[0],0
	   JLE GCD34T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD34T2Sub2
GCD34T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark3[0]
	not ax
	add ax,1
	mov m,eax
GCD34T2Sub2:
	cmp WORD PTR Benchmark3[2],0
	JLE GCD34T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark3[2]
	mov n,eax
	jmp GCD34T2Sub4
GCD34T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark3[2]
	not ax
	add ax,1
	mov n,eax
GCD34T2Sub4:
	cmp WORD PTR Benchmark3[4],0
	JLE GCD34T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark3[4]
	mov x,eax
	jmp GCD34T2Sub6
GCD34T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark3[4]
	not ax
	add ax,1
	mov x,eax
GCD34T2Sub6:
	cmp WORD PTR Benchmark3[6],0
	JLE GCD34T2Sub6
	mov eax,0
	mov ax,word ptr Benchmark3[6]
	mov y,eax
	jmp GCD34END
GCD34T2Sub7:	
	mov eax,0
	mov ax,word ptr Benchmark3[6]
	not ax
	add ax,1
	mov y,eax

GCD34T3Sub: cmp currentType,4
	   JNE GCD34END
	   cmp DWORD PTR Benchmark3[0],0
	   JE L31
	   cmp DWORD PTR Benchmark3[4],0
	   JE L31
	   cmp DWORD PTR Benchmark3[8],0
	   JE L31
	   cmp DWORD PTR Benchmark3[12],0
	   JE L31
	   cmp DWORD PTR Benchmark3[0],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[4],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[8],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[12],-2147483648
	   JL L31
	   cmp DWORD PTR Benchmark3[0],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[4],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[8],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[12],2147483647
	   JA L31
	   cmp DWORD PTR Benchmark3[0],0
	   JLE GCD34T3Sub1
	   mov eax,DWord ptr Benchmark3[0]
	   mov m,eax
	   jmp GCD34T3Sub2
GCD34T3Sub1:
	mov eax,DWord ptr Benchmark3[0]
	not eax
	add eax,1
	mov m,eax
GCD34T3Sub2:
	cmp DWORD PTR Benchmark3[4],0
	mov eax,DWord ptr Benchmark3[0]
	JLE GCD34T3Sub3
	mov eax,DWord ptr Benchmark3[4]
	mov n,eax
	jmp GCD34T3Sub4
GCD34T3Sub3:	
	mov eax,DWord ptr Benchmark3[4]
	not eax
	add eax,1
	mov n,eax
GCD34T3Sub4:
	cmp DWORD PTR Benchmark3[8],0
	JLE GCD34T3Sub5
	mov eax,DWord ptr Benchmark3[8]
	mov x,eax
	jmp GCD34T3Sub6
GCD34T3Sub5:	
	mov eax,DWord ptr Benchmark3[8]
	not eax
	add eax,1
	mov x,eax
GCD34T3Sub6:
	cmp DWORD PTR Benchmark3[12],0
	JLE GCD34T3Sub7
	mov eax,DWord ptr Benchmark3[12]
	mov y,eax
	jmp GCD34END
GCD34T3Sub7:	
	mov eax,DWord ptr Benchmark3[12]
	not eax
	add eax,1
	mov y,eax
GCD34End:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	mov EAX,Y
	mov ORIGINY,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,y
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[8],eax

	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,y
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD3Y3
	mov Result_Benchmark_LCM[8],eax
	jmp GCD3End
GCD3Y3:
	mov Result_Benchmark_LCM[8],0
	jmp GCD3End
GCD3End:
	jmp GCD4START
GCD4Start:
	mov SI,0
	mov EDX, type Benchmark4[SI]
	cmp EDX,1
	je L42
	cmp EDX,2
	je  L43
	cmp EDX,4
	je  L44
	jne L41
	jmp GCD4END;
L41:
	mov EBX,12
	mov Result_Benchmark_GCD[EBX],0
	mov Result_Benchmark_LCM[EBX],0
	jmp GCD4END;
L42:
	mov currentType,1
	mov EDX, LENGTHOF Benchmark4[0]
	cmp EDX,4
	JA L41
	cmp EDX,2
	JB L41
	cmp EDX,2
	JE GCD42
	cmp EDX,3
	JE GCD43
	cmp EDX,4
	JE GCD44
L43:
	mov currentType,2
	mov EDX, LENGTHOF Benchmark4[0]
	cmp EDX,4
	JA L41
	cmp EDX,2
	JB L41
	cmp EDX,2
	JE GCD42
	cmp EDX,3
	JE GCD43
	cmp EDX,4
	JE GCD44
L44:
	call  WriteString
	mov currentType,4
	mov EDX, LENGTHOF Benchmark4[0]
	cmp EDX,4
	JA L41
	cmp EDX,2
	JB L41
	cmp EDX,2
	JE GCD42
	cmp EDX,3
	JE GCD43
	cmp EDX,4
	JE GCD44
GCD42:
	cmp currentType,1
	JNE GCD42T2Sub
	cmp BYTE PTR Benchmark4[0],0
	JE L41
	cmp BYTE PTR Benchmark4[1],0
	JE L41
	cmp BYTE PTR Benchmark4[0],-128
	JL L41
	cmp BYTE PTR Benchmark4[1],-128
	JL L41
	cmp BYTE PTR Benchmark4[0],127
	JA L41
	cmp BYTE PTR Benchmark4[1],127
	JA L41
	cmp BYTE PTR Benchmark4[0],0
	JLE GCD42T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	mov m,eax
	jmp GCD42T1Sub2
GCD42T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	not AL
	add AL,1
	mov m,eax
GCD42T1Sub2:
	cmp BYTE PTR Benchmark4[1],0
	JLE GCD42T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	mov n,eax
	jmp GCD42DATAEND
GCD42T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	not AL
	add AL,1
	mov n,eax
	
GCD42T2Sub:
	   cmp currentType,2
	   JNE GCD42T3sub
	   cmp WORD PTR Benchmark4[0],0
	   JE L41
	   cmp WORD PTR Benchmark4[2],0
	   JE L41
	   cmp WORD PTR Benchmark4[0],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[2],-32768	
	   JL L41
	   cmp WORD PTR Benchmark4[0],32767
	   JA L41
	   cmp WORD PTR Benchmark4[2],32767
	   JA L41
	   cmp WORD PTR Benchmark4[0],0
	   JLE GCD42T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD42T2Sub2
GCD42T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark4[0]
	not ax
	add ax,1
	mov m,eax
GCD42T2Sub2:
	cmp WORD PTR Benchmark4[2],0
	JLE GCD42T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark4[2]
	mov n,eax
	jmp GCD42DATAEND
GCD42T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark4[2]
	not ax
	add ax,1
	mov n,eax
GCD42T3Sub: 
	   cmp currentType,4
	   JNE GCD42DATAEND
	   cmp DWORD PTR Benchmark4[0],0
	   JE L41
	   cmp DWORD PTR Benchmark4[4],0
	   JE L41
	   cmp DWORD PTR Benchmark4[0],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[4],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[0],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[4],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[0],0
	   JLE GCD42T3Sub1
	   mov eax,DWord ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD42T3Sub2
GCD42T3Sub1:
	mov eax,DWord ptr Benchmark4[0]
	not eax
	add eax,1
	mov m,eax
GCD42T3Sub2:
	cmp DWORD PTR Benchmark4[4],0
	JLE GCD42T3Sub3
	mov eax,DWord ptr Benchmark4[4]
	mov n,eax
	jmp GCD42DATAEND
GCD42T3Sub3:	
	mov eax,DWord ptr Benchmark4[4]
	not eax
	add eax,1
	mov n,eax
GCD42DATAEnd:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[12],eax
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y1
	mov Result_Benchmark_LCM[12],eax
	jmp GCD4End
GCD4Y1:
	mov Result_Benchmark_LCM[12],0
	jmp GCD4End

GCD43:
	cmp currentType,1
	JNE GCD43T2Sub
	cmp BYTE PTR Benchmark4[0],0
	JE L41
	cmp BYTE PTR Benchmark4[1],0
	JE L41
	cmp BYTE PTR Benchmark4[2],0
	JE L41
	cmp BYTE PTR Benchmark4[0],-128
	JL L41
	cmp BYTE PTR Benchmark4[1],-128
	JL L41
	cmp BYTE PTR Benchmark4[2],-128
	JL L41
	cmp BYTE PTR  Benchmark4[0],127
	JA L41
	cmp BYTE PTR Benchmark4[1],127
	JA L41
	cmp BYTE PTR Benchmark4[2],127
	JA L41
GCD43T1Sub:
	cmp BYTE PTR Benchmark4[0],0
	JLE GCD43T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	mov m,eax
	jmp GCD43T1Sub2
GCD43T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	not AL
	add AL,1
	mov m,eax
GCD43T1Sub2:
	cmp BYTE PTR Benchmark4[1],0
	JLE GCD43T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	mov n,eax
	jmp GCD43T1Sub4
GCD43T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	not AL
	add AL,1
	mov n,eax
GCD43T1Sub4:
	cmp BYTE PTR Benchmark4[2],0
	JLE GCD43T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark4[2]
	mov x,eax
	jmp GCD43DATAEND
GCD43T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark4[2]
	not AL
	add AL,1
	mov x,eax
	
GCD43T2Sub: cmp currentType,2
	   JNE GCD43T3sub
	   cmp WORD PTR Benchmark4[0],0
	   JE L41
	   cmp WORD PTR Benchmark4[2],0
	   JE L41
	   cmp WORD PTR Benchmark4[4],0
	   JE L41
	   cmp WORD PTR Benchmark4[0],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[2],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[4],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[0],32767
	   JA L41
	   cmp WORD PTR Benchmark4[2],32767
	   JA L41
	   cmp WORD PTR Benchmark4[4],32767
	   JA L41
	   cmp WORD PTR Benchmark4[0],0
	   JLE GCD43T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD43T2Sub2
GCD43T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark4[0]
	not ax
	add ax,1
	mov m,eax
GCD43T2Sub2:
	cmp WORD PTR Benchmark4[2],0
	JLE GCD43T2Sub3
    mov eax,0
	mov ax,word ptr Benchmark4[2]
	mov n,eax
	jmp GCD43T2Sub4
GCD43T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark4[2]
	not ax
	add ax,1
	mov n,eax
GCD43T2Sub4:
	cmp WORD PTR Benchmark4[4],0
	JLE GCD43T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark4[4]
	mov x,eax
	jmp GCD43DATAEND
GCD43T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark4[4]
	not ax
	add ax,1
	mov x,eax

GCD43T3Sub: cmp currentType,4
	   JNE GCD43DATAEND
	   cmp DWORD PTR Benchmark4[0],0
	   JE L41
	   cmp DWORD PTR Benchmark4[4],0
	   JE L41
	   cmp DWORD PTR Benchmark4[8],0
	   JE L41
	   cmp DWORD PTR Benchmark4[0],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[4],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[8],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[0],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[4],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[8],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[0],0
	   JLE GCD43T3Sub1
	   mov eax,DWord ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD43T3Sub2
GCD43T3Sub1:
	mov eax,DWord ptr Benchmark4[0]
	not eax
	add eax,1
	mov m,eax
GCD43T3Sub2:
	cmp DWORD PTR Benchmark4[4],0
	JLE GCD43T3Sub3
    mov eax,DWord ptr Benchmark4[4]
	mov n,eax
	jmp GCD43T3Sub4
GCD43T3Sub3:	
	mov eax,DWord ptr Benchmark4[4]
	not eax
	add eax,1
	mov n,eax
GCD43T3Sub4:
	cmp DWORD PTR Benchmark4[8],0
	JLE GCD43T3Sub5
	mov eax,DWord ptr Benchmark4[8]
	mov x,eax
	jmp GCD43DATAEND
GCD43T3Sub5:	
	mov eax,DWord ptr Benchmark4[8]
	not eax
	add eax,1
	mov x,eax
GCD43DATAEND:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[12],eax
	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y2
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y2
	mov Result_Benchmark_LCM[12],eax
	jmp GCD4End
GCD4Y2:
	mov Result_Benchmark_LCM[12],0
	jmp GCD4End

GCD44:
	cmp currentType,1
	JNE GCD44T2Sub
	cmp BYTE PTR Benchmark4[0],0
	JE L41
	cmp BYTE PTR Benchmark4[1],0
	JE L41
	cmp BYTE PTR Benchmark4[2],0
	JE L41
	cmp BYTE PTR Benchmark4[3],0
	JE L41
	cmp BYTE PTR Benchmark4[0],-128
	JL L41
	cmp BYTE PTR Benchmark4[1],-128
	JL L41
	cmp BYTE PTR Benchmark4[2],-128
	JL L41
	cmp BYTE PTR Benchmark4[3],-128
	JL L41
	cmp BYTE PTR Benchmark4[0],127
	JA L41
	cmp BYTE PTR Benchmark4[1],127
	JA L41
	cmp BYTE PTR Benchmark4[2],127
	JA L41
	cmp BYTE PTR Benchmark4[3],127
	JA L41
GCD44T1Sub:
	cmp BYTE PTR Benchmark4[0],0
	JLE GCD44T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	mov m,eax
	jmp GCD44T1Sub2
GCD44T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark4[0]
	not AL
	add AL,1
	mov m,eax
GCD44T1Sub2:
	cmp BYTE PTR Benchmark4[1],0
	JLE GCD44T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	mov n,eax
	jmp GCD44T1Sub4
GCD44T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark4[1]
	not AL
	add AL,1
	mov n,eax
GCD44T1Sub4:
	cmp BYTE PTR Benchmark4[2],0
	JLE GCD44T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark4[2]
	mov x,eax
	jmp GCD44T1Sub6
GCD44T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark4[2]
	not AL
	add AL,1
	mov x,eax
GCD44T1Sub6:
	cmp BYTE PTR Benchmark4[3],0
	JLE GCD44T1Sub7
	mov eax,0
	mov AL,byte ptr Benchmark4[3]
	mov y,eax
	jmp GCD44END
GCD44T1Sub7:	
	mov eax,0
	mov AL,byte ptr Benchmark4[3]
	not AL
	add AL,1
	mov y,eax
GCD44T2Sub: cmp currentType,2
	   JNE GCD44T3sub
	   cmp WORD PTR Benchmark4[0],0
	   JE L41
	   cmp WORD PTR Benchmark4[2],0
	   JE L41
	   cmp WORD PTR Benchmark4[4],0
	   JE L41
	   cmp WORD PTR Benchmark4[6],0
	   JE L41
	   cmp WORD PTR Benchmark4[0],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[2],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[4],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[6],-32768
	   JL L41
	   cmp WORD PTR Benchmark4[0],32767
	   JA L41
	   cmp WORD PTR Benchmark4[2],32767
	   JA L41
	   cmp WORD PTR Benchmark4[4],32767
	   JA L41
	   cmp WORD PTR Benchmark4[6],32767
	   JA L41
	   cmp WORD PTR Benchmark4[0],0
	   JLE GCD44T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD44T2Sub2
GCD44T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark4[0]
	not ax
	add ax,1
	mov m,eax
GCD44T2Sub2:
	cmp WORD PTR Benchmark4[2],0
	JLE GCD44T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark4[2]
	mov n,eax
	jmp GCD44T2Sub4
GCD44T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark4[2]
	not ax
	add ax,1
	mov n,eax
GCD44T2Sub4:
	cmp WORD PTR Benchmark4[4],0
	JLE GCD44T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark4[4]
	mov x,eax
	jmp GCD44T2Sub6
GCD44T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark4[4]
	not ax
	add ax,1
	mov x,eax
GCD44T2Sub6:
	cmp WORD PTR Benchmark4[6],0
	JLE GCD44T2Sub6
	mov eax,0
	mov ax,word ptr Benchmark4[6]
	mov y,eax
	jmp GCD44END
GCD44T2Sub7:	
	mov eax,0
	mov ax,word ptr Benchmark4[6]
	not ax
	add ax,1
	mov y,eax

GCD44T3Sub: cmp currentType,4
	   JNE GCD44END
	   cmp DWORD PTR Benchmark4[0],0
	   JE L41
	   cmp DWORD PTR Benchmark4[4],0
	   JE L41
	   cmp DWORD PTR Benchmark4[8],0
	   JE L41
	   cmp DWORD PTR Benchmark4[12],0
	   JE L41
	   cmp DWORD PTR Benchmark4[0],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[4],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[8],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[12],-2147483648
	   JL L41
	   cmp DWORD PTR Benchmark4[0],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[4],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[8],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[12],2147483647
	   JA L41
	   cmp DWORD PTR Benchmark4[0],0
	   JLE GCD44T3Sub1
	   mov eax,DWord ptr Benchmark4[0]
	   mov m,eax
	   jmp GCD44T3Sub2
GCD44T3Sub1:
	mov eax,DWord ptr Benchmark4[0]
	not eax
	add eax,1
	mov m,eax
GCD44T3Sub2:
	cmp DWORD PTR Benchmark4[4],0
	mov eax,DWord ptr Benchmark4[0]
	JLE GCD44T3Sub3
	mov eax,DWord ptr Benchmark4[4]
	mov n,eax
	jmp GCD44T3Sub4
GCD44T3Sub3:	
	mov eax,DWord ptr Benchmark4[4]
	not eax
	add eax,1
	mov n,eax
GCD44T3Sub4:
	cmp DWORD PTR Benchmark4[8],0
	JLE GCD44T3Sub5
	mov eax,DWord ptr Benchmark4[8]
	mov x,eax
	jmp GCD44T3Sub6
GCD44T3Sub5:	
	mov eax,DWord ptr Benchmark4[8]
	not eax
	add eax,1
	mov x,eax
GCD44T3Sub6:
	cmp DWORD PTR Benchmark4[12],0
	JLE GCD44T3Sub7
	mov eax,DWord ptr Benchmark4[12]
	mov y,eax
	jmp GCD44END
GCD44T3Sub7:	
	mov eax,DWord ptr Benchmark4[12]
	not eax
	add eax,1
	mov y,eax
GCD44End:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	mov EAX,Y
	mov ORIGINY,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,y
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[12],eax

	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,y
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD4Y3
	mov Result_Benchmark_LCM[12],eax
	jmp GCD4End
GCD4Y3:
	mov Result_Benchmark_LCM[12],0
	jmp GCD4End
GCD4End:
	jmp GCD5Start

GCD5Start:
	mov SI,0
	mov EDX, type Benchmark5[SI]
	cmp EDX,1
	je L52
	cmp EDX,2
	je  L53
	cmp EDX,4
	je  L54
	jne L51
	jmp GCD5END;
L51:
	mov EBX,16
	mov Result_Benchmark_GCD[EBX],0
	mov Result_Benchmark_LCM[EBX],0
	jmp GCD5END;
L52:
	mov currentType,1
	mov EDX, LENGTHOF Benchmark5[0]
	cmp EDX,4
	JA L51
	cmp EDX,2
	JB L51
	cmp EDX,2
	JE GCD52
	cmp EDX,3
	JE GCD53
	cmp EDX,4
	JE GCD54
L53:
	mov currentType,2
	mov EDX, LENGTHOF Benchmark5[0]
	cmp EDX,4
	JA L51
	cmp EDX,2
	JB L51
	cmp EDX,2
	JE GCD52
	cmp EDX,3
	JE GCD53
	cmp EDX,4
	JE GCD54
L54:
	call  WriteString
	mov currentType,4
	mov EDX, LENGTHOF Benchmark5[0]
	cmp EDX,4
	JA L51
	cmp EDX,2
	JB L51
	cmp EDX,2
	JE GCD52
	cmp EDX,3
	JE GCD53
	cmp EDX,4
	JE GCD54
GCD52:
	cmp currentType,1
	JNE GCD52T2Sub
	cmp BYTE PTR Benchmark5[0],0
	JE L51
	cmp BYTE PTR Benchmark5[1],0
	JE L51
	cmp BYTE PTR Benchmark5[0],-128
	JL L51
	cmp BYTE PTR Benchmark5[1],-128
	JL L51
	cmp BYTE PTR Benchmark5[0],127
	JA L51
	cmp BYTE PTR Benchmark5[1],127
	JA L51
	cmp BYTE PTR Benchmark5[0],0
	JLE GCD52T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	mov m,eax
	jmp GCD52T1Sub2
GCD52T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	not AL
	add AL,1
	mov m,eax
GCD52T1Sub2:
	cmp BYTE PTR Benchmark5[1],0
	JLE GCD52T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	mov n,eax
	jmp GCD52DATAEND
GCD52T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	not AL
	add AL,1
	mov n,eax
	
GCD52T2Sub:
	   cmp currentType,2
	   JNE GCD52T3sub
	   cmp WORD PTR Benchmark5[0],0
	   JE L51
	   cmp WORD PTR Benchmark5[2],0
	   JE L51
	   cmp WORD PTR Benchmark5[0],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[2],-32768	
	   JL L51
	   cmp WORD PTR Benchmark5[0],32767
	   JA L51
	   cmp WORD PTR Benchmark5[2],32767
	   JA L51
	   cmp WORD PTR Benchmark5[0],0
	   JLE GCD52T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD52T2Sub2
GCD52T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark5[0]
	not ax
	add ax,1
	mov m,eax
GCD52T2Sub2:
	cmp WORD PTR Benchmark5[2],0
	JLE GCD52T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark5[2]
	mov n,eax
	jmp GCD52DATAEND
GCD52T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark5[2]
	not ax
	add ax,1
	mov n,eax
GCD52T3Sub: 
	   cmp currentType,4
	   JNE GCD52DATAEND
	   cmp DWORD PTR Benchmark5[0],0
	   JE L51
	   cmp DWORD PTR Benchmark5[4],0
	   JE L51
	   cmp DWORD PTR Benchmark5[0],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[4],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[0],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[4],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[0],0
	   JLE GCD52T3Sub1
	   mov eax,DWord ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD52T3Sub2
GCD52T3Sub1:
	mov eax,DWord ptr Benchmark5[0]
	not eax
	add eax,1
	mov m,eax
GCD52T3Sub2:
	cmp DWORD PTR Benchmark5[4],0
	JLE GCD52T3Sub3
	mov eax,DWord ptr Benchmark5[4]
	mov n,eax
	jmp GCD52DATAEND
GCD52T3Sub3:	
	mov eax,DWord ptr Benchmark5[4]
	not eax
	add eax,1
	mov n,eax
GCD52DATAEnd:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[16],eax
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y1
	mov Result_Benchmark_LCM[16],eax
	jmp GCD5End
GCD5Y1:
	mov Result_Benchmark_LCM[16],0
	jmp GCD5End

GCD53:
	cmp currentType,1
	JNE GCD53T2Sub
	cmp BYTE PTR Benchmark5[0],0
	JE L51
	cmp BYTE PTR Benchmark5[1],0
	JE L51
	cmp BYTE PTR Benchmark5[2],0
	JE L51
	cmp BYTE PTR Benchmark5[0],-128
	JL L51
	cmp BYTE PTR Benchmark5[1],-128
	JL L51
	cmp BYTE PTR Benchmark5[2],-128
	JL L51
	cmp BYTE PTR  Benchmark5[0],127
	JA L51
	cmp BYTE PTR Benchmark5[1],127
	JA L51
	cmp BYTE PTR Benchmark5[2],127
	JA L51
GCD53T1Sub:
	cmp BYTE PTR Benchmark5[0],0
	JLE GCD53T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	mov m,eax
	jmp GCD53T1Sub2
GCD53T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	not AL
	add AL,1
	mov m,eax
GCD53T1Sub2:
	cmp BYTE PTR Benchmark5[1],0
	JLE GCD53T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	mov n,eax
	jmp GCD53T1Sub4
GCD53T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	not AL
	add AL,1
	mov n,eax
GCD53T1Sub4:
	cmp BYTE PTR Benchmark5[2],0
	JLE GCD53T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark5[2]
	mov x,eax
	jmp GCD53DATAEND
GCD53T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark5[2]
	not AL
	add AL,1
	mov x,eax
	
GCD53T2Sub: cmp currentType,2
	   JNE GCD53T3sub
	   cmp WORD PTR Benchmark5[0],0
	   JE L51
	   cmp WORD PTR Benchmark5[2],0
	   JE L51
	   cmp WORD PTR Benchmark5[4],0
	   JE L51
	   cmp WORD PTR Benchmark5[0],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[2],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[4],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[0],32767
	   JA L51
	   cmp WORD PTR Benchmark5[2],32767
	   JA L51
	   cmp WORD PTR Benchmark5[4],32767
	   JA L51
	   cmp WORD PTR Benchmark5[0],0
	   JLE GCD53T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD53T2Sub2
GCD53T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark5[0]
	not ax
	add ax,1
	mov m,eax
GCD53T2Sub2:
	cmp WORD PTR Benchmark5[2],0
	JLE GCD53T2Sub3
    mov eax,0
	mov ax,word ptr Benchmark5[2]
	mov n,eax
	jmp GCD53T2Sub4
GCD53T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark5[2]
	not ax
	add ax,1
	mov n,eax
GCD53T2Sub4:
	cmp WORD PTR Benchmark5[4],0
	JLE GCD53T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark5[4]
	mov x,eax
	jmp GCD53DATAEND
GCD53T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark5[4]
	not ax
	add ax,1
	mov x,eax

GCD53T3Sub: cmp currentType,4
	   JNE GCD53DATAEND
	   cmp DWORD PTR Benchmark5[0],0
	   JE L51
	   cmp DWORD PTR Benchmark5[4],0
	   JE L51
	   cmp DWORD PTR Benchmark5[8],0
	   JE L51
	   cmp DWORD PTR Benchmark5[0],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[4],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[8],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[0],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[4],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[8],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[0],0
	   JLE GCD53T3Sub1
	   mov eax,DWord ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD53T3Sub2
GCD53T3Sub1:
	mov eax,DWord ptr Benchmark5[0]
	not eax
	add eax,1
	mov m,eax
GCD53T3Sub2:
	cmp DWORD PTR Benchmark5[4],0
	JLE GCD53T3Sub3
    mov eax,DWord ptr Benchmark5[4]
	mov n,eax
	jmp GCD53T3Sub4
GCD53T3Sub3:	
	mov eax,DWord ptr Benchmark5[4]
	not eax
	add eax,1
	mov n,eax
GCD53T3Sub4:
	cmp DWORD PTR Benchmark5[8],0
	JLE GCD53T3Sub5
	mov eax,DWord ptr Benchmark5[8]
	mov x,eax
	jmp GCD53DATAEND
GCD53T3Sub5:	
	mov eax,DWord ptr Benchmark5[8]
	not eax
	add eax,1
	mov x,eax
GCD53DATAEND:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[16],eax
	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y2
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y2
	mov Result_Benchmark_LCM[16],eax
	jmp GCD5End
GCD5Y2:
	mov Result_Benchmark_LCM[16],0
	jmp GCD5End

GCD54:
	cmp currentType,1
	JNE GCD54T2Sub
	cmp BYTE PTR Benchmark5[0],0
	JE L51
	cmp BYTE PTR Benchmark5[1],0
	JE L51
	cmp BYTE PTR Benchmark5[2],0
	JE L51
	cmp BYTE PTR Benchmark5[3],0
	JE L51
	cmp BYTE PTR Benchmark5[0],-128
	JL L51
	cmp BYTE PTR Benchmark5[1],-128
	JL L51
	cmp BYTE PTR Benchmark5[2],-128
	JL L51
	cmp BYTE PTR Benchmark5[3],-128
	JL L51
	cmp BYTE PTR Benchmark5[0],127
	JA L51
	cmp BYTE PTR Benchmark5[1],127
	JA L51
	cmp BYTE PTR Benchmark5[2],127
	JA L51
	cmp BYTE PTR Benchmark5[3],127
	JA L51
GCD54T1Sub:
	cmp BYTE PTR Benchmark5[0],0
	JLE GCD54T1Sub1
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	mov m,eax
	jmp GCD54T1Sub2
GCD54T1Sub1:
	mov eax,0
	mov AL,byte ptr Benchmark5[0]
	not AL
	add AL,1
	mov m,eax
GCD54T1Sub2:
	cmp BYTE PTR Benchmark5[1],0
	JLE GCD54T1Sub3
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	mov n,eax
	jmp GCD54T1Sub4
GCD54T1Sub3:	
	mov eax,0
	mov AL,byte ptr Benchmark5[1]
	not AL
	add AL,1
	mov n,eax
GCD54T1Sub4:
	cmp BYTE PTR Benchmark5[2],0
	JLE GCD54T1Sub5
	mov eax,0
	mov AL,byte ptr Benchmark5[2]
	mov x,eax
	jmp GCD54T1Sub6
GCD54T1Sub5:	
	mov eax,0
	mov AL,byte ptr Benchmark5[2]
	not AL
	add AL,1
	mov x,eax
GCD54T1Sub6:
	cmp BYTE PTR Benchmark5[3],0
	JLE GCD54T1Sub7
	mov eax,0
	mov AL,byte ptr Benchmark5[3]
	mov y,eax
	jmp GCD54END
GCD54T1Sub7:	
	mov eax,0
	mov AL,byte ptr Benchmark5[3]
	not AL
	add AL,1
	mov y,eax
GCD54T2Sub: cmp currentType,2
	   JNE GCD54T3sub
	   cmp WORD PTR Benchmark5[0],0
	   JE L51
	   cmp WORD PTR Benchmark5[2],0
	   JE L51
	   cmp WORD PTR Benchmark5[4],0
	   JE L51
	   cmp WORD PTR Benchmark5[6],0
	   JE L51
	   cmp WORD PTR Benchmark5[0],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[2],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[4],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[6],-32768
	   JL L51
	   cmp WORD PTR Benchmark5[0],32767
	   JA L51
	   cmp WORD PTR Benchmark5[2],32767
	   JA L51
	   cmp WORD PTR Benchmark5[4],32767
	   JA L51
	   cmp WORD PTR Benchmark5[6],32767
	   JA L51
	   cmp WORD PTR Benchmark5[0],0
	   JLE GCD54T2Sub1
	   mov eax,0
	   mov ax,word ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD54T2Sub2
GCD54T2Sub1:
	mov eax,0
	mov ax,word ptr Benchmark5[0]
	not ax
	add ax,1
	mov m,eax
GCD54T2Sub2:
	cmp WORD PTR Benchmark5[2],0
	JLE GCD54T2Sub3
	mov eax,0
	mov ax,word ptr Benchmark5[2]
	mov n,eax
	jmp GCD54T2Sub4
GCD54T2Sub3:	
	mov eax,0
	mov ax,word ptr Benchmark5[2]
	not ax
	add ax,1
	mov n,eax
GCD54T2Sub4:
	cmp WORD PTR Benchmark5[4],0
	JLE GCD54T2Sub5
	mov eax,0
	mov ax,word ptr Benchmark5[4]
	mov x,eax
	jmp GCD54T2Sub6
GCD54T2Sub5:	
	mov eax,0
	mov ax,word ptr Benchmark5[4]
	not ax
	add ax,1
	mov x,eax
GCD54T2Sub6:
	cmp WORD PTR Benchmark5[6],0
	JLE GCD54T2Sub6
	mov eax,0
	mov ax,word ptr Benchmark5[6]
	mov y,eax
	jmp GCD54END
GCD54T2Sub7:	
	mov eax,0
	mov ax,word ptr Benchmark5[6]
	not ax
	add ax,1
	mov y,eax

GCD54T3Sub: cmp currentType,4
	   JNE GCD54END
	   cmp DWORD PTR Benchmark5[0],0
	   JE L51
	   cmp DWORD PTR Benchmark5[4],0
	   JE L51
	   cmp DWORD PTR Benchmark5[8],0
	   JE L51
	   cmp DWORD PTR Benchmark5[12],0
	   JE L51
	   cmp DWORD PTR Benchmark5[0],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[4],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[8],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[12],-2147483648
	   JL L51
	   cmp DWORD PTR Benchmark5[0],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[4],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[8],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[12],2147483647
	   JA L51
	   cmp DWORD PTR Benchmark5[0],0
	   JLE GCD54T3Sub1
	   mov eax,DWord ptr Benchmark5[0]
	   mov m,eax
	   jmp GCD54T3Sub2
GCD54T3Sub1:
	mov eax,DWord ptr Benchmark5[0]
	not eax
	add eax,1
	mov m,eax
GCD54T3Sub2:
	cmp DWORD PTR Benchmark5[4],0
	mov eax,DWord ptr Benchmark5[0]
	JLE GCD54T3Sub3
	mov eax,DWord ptr Benchmark5[4]
	mov n,eax
	jmp GCD54T3Sub4
GCD54T3Sub3:	
	mov eax,DWord ptr Benchmark5[4]
	not eax
	add eax,1
	mov n,eax
GCD54T3Sub4:
	cmp DWORD PTR Benchmark5[8],0
	JLE GCD54T3Sub5
	mov eax,DWord ptr Benchmark5[8]
	mov x,eax
	jmp GCD54T3Sub6
GCD54T3Sub5:	
	mov eax,DWord ptr Benchmark5[8]
	not eax
	add eax,1
	mov x,eax
GCD54T3Sub6:
	cmp DWORD PTR Benchmark5[12],0
	JLE GCD54T3Sub7
	mov eax,DWord ptr Benchmark5[12]
	mov y,eax
	jmp GCD54END
GCD54T3Sub7:	
	mov eax,DWord ptr Benchmark5[12]
	not eax
	add eax,1
	mov y,eax
GCD54End:
	mov EAX,M
	mov EBX,N
	mov ORIGINM,EAX
	mov ORIGINN,EBX
	mov EAX,X
	mov ORIGINX,EAX
	mov EAX,Y
	mov ORIGINY,EAX
	call GCD
	mov eax,x
	mov n,eax
	call GCD
	mov eax,y
	mov n,eax
	call GCD
	mov eax,m
	mov Result_Benchmark_GCD[16],eax

	mov EAX,ORIGINM
	mov EBX,ORIGINN
	mov M,EAX
	mov N,EBX
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,x
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y3
	mov m,eax
	mov ORIGINM,eax
	mov eax,y
	mov n,eax
	mov ORIGINN,eax
	call GCD
	mov eax,ORIGINM
	mov ebx,m
	div ebx
	mov ebx,ORIGINN
	mul ebx
	jo  GCD5Y3
	mov Result_Benchmark_LCM[16],eax
	jmp GCD5End
GCD5Y3:
	mov Result_Benchmark_LCM[16],0
	jmp GCD5End
GCD5End:


rdtsc ; meausre your time
;****************************************************************************

; Do not change this section
;****************************************************************************

call print_result ; print your final result
exit ; exit to operating system
main ENDP
;****************************************************************************

;****************************************************************************

;Procedure print_result
;explain your print_result procedure here
;****************************************************************************

GCD PROC
mov EAX,M
mov EBX,N
cmp EAX,EBX
JNB CC1
mov N,EAX
mov M,EBX

CC1:
mov EAX,M
mov EBX,N
mov EDX,0
div EBX
cmp EDX,0
JE L_END
mov EAX,N
mov M,EAX
mov N,EDX
jmp CC1
L_END:
mov M,EBX
ret
GCD ENDP

print_result PROC
; your code here
mov count,0
mov ecx,20
s:
	mov esi,count
	mov	  EDX,OFFSET prompt1
	call  WriteString
	mov EAX,Result_Benchmark_GCD[esi]
	call  WriteInt
	mov	  EDX,OFFSET prompt2
	call  WriteString
	mov EAX,Result_Benchmark_LCM[esi]
	call  WriteInt
	mov	  EDX,OFFSET prompt3
	call  WriteString
	call  crlf
	add count,4
	mov eax,count
	call writeInt
loop s

ret ; return to main
print_result ENDP
;****************************************************************************

; (insert additional procedures here)
END main