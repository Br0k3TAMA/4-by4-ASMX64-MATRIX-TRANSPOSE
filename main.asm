include win64.inc 

option win64:0111b
option casemap:none
option literals:on
option SWITCHSTYLE: CSTYLE

.data

matrix word 1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16
mem64 dq 3

.code 
main proc
	sub rsp,32
	
	printf("   %d    %d    %d    %d  \n   %d    %d    %d    % d \n   %d   %d   %d   %d  \n  %d   %d   %d   %d  \n\n",word ptr [matrix],word ptr[matrix+2],word ptr[matrix+4],word ptr[matrix+6],word ptr[matrix+8],word ptr[matrix+10],word ptr[matrix+12],word ptr[matrix+14],word ptr[matrix+16],word ptr[matrix+18],word ptr[matrix+20],word ptr[matrix+22],word ptr[matrix+24],word ptr[matrix+26],word ptr[matrix+28],word ptr[matrix+30]) 
	lea rcx, matrix
	
	
	call Transpose

	

	printf("    %d    %d    %d    %d  \n   %d    %d    %d    % d \n   %d   %d   %d   %d  \n  %d   %d   %d   %d  \n\n",word ptr [rcx],word ptr[rcx+2],word ptr[rcx+4],word ptr[rcx+6],word ptr[rcx+8],word ptr[rcx+10],word ptr[rcx+12],word ptr[rcx+14],word ptr[rcx+16],word ptr[rcx+18],word ptr[rcx+20],word ptr[rcx+22],word ptr[rcx+24],word ptr[rcx+26],word ptr[rcx+28],word ptr[rcx+30])
	exit(0)
	add rsp,32
	ret
main endp
Transpose proc uses rbx r13 r14 r15 r12 r10
	sub rsp,32+32
	mov r12,0
	.for(r13 = 0 : r13 <= 3  : r13++ )
		
		mov r10,0
		.for(r14 = 0 : r14 <= 3 : r14++)

			.if r14 > r13 
				
				inc r10
				mov r8 ,0
				mov rax,0

				;index 1
				add r8 ,r13
				mov rax, r8
				mov rdx, 0
				mul mem64
				mov r8, rax
				add r8 ,r14
				add r8 ,r12

				;index 2
				mov rax, 0
				mov rdx, 0
				mov rax, r10
				mul mem64

				add rax,r8

				mov bx, word ptr [rcx+ 2*r8]
				mov r15w, word ptr [rcx + 2*rax]

				mov [rcx+ 2*r8], r15w
				mov [rcx +  2*rax], bx

				
				
			.endif	
			
		.endf
		inc r12
	.endf

	add rsp,32+32
	ret
Transpose endp
end 


