//  �� 1
// ������ 1: 22 �����
LDA 0x0021
MOV B, A
LDA 0x0020
SUB B
MOV C, A                                                                                          
LDA 0x0023
MOV B, A
LDA 0x0022
SUB B
ADD C
STA 0x0026
HLT

// ������ 2: 15 ����
LXI H, 0x0021
MOV A, M
INX H
SUB M
MOV B, A
INX H
MOV A, M
INX H
SUB M
ADD B
INX H
MOV M, A
HLT

// �� 2
// ������ 1: 18 ����
LXI H, 0x0021
MOV A, M
CMA
INX H
ANA M
MOV B, A
INX H
MOV C, M
INX H
MOV A, M
CMA
ANA C
ORA B
INX H
MOV M, A
HLT

 //������ �����
�1 = 0000 0010
�2 = 0000 0101     �� �2 = 1111 1010

0000 0010
*   1111 1010
---------
0000 0010


�3 = 0000 0111     �� �3 = 1111 1000
�4 = 0000 0000     �� �4 = 1111 1111

1111 1000
*   1111 1111
---------
1111 1000

�����

0000 0010
+  1111 1000
---------
1111 1010 = FA


---------------------------------------------------

�1 = 0000 0010
�2 = 0000 0101     �� �2 = 1111 1010

0000 0010
*   1111 1010
---------
0000 0010


�3 = 0000 0100     �� �3 = 1111 1011
�4 = 0000 0000     �� �4 = 1111 1111

1111 1011
*   1111 1111
---------
1111 1011

�����

0000 0010
+  1111 1011
---------
1111 1011 = FB

//��������� ������� 

// �� 3  (������ 1)
MVI D, 9       ; �������
LXI H, 0x0021        ; ������ �������
MOV A, M             ; ������������ �������� ������� �������� � ���.
INX H                ; ������� � ����. �������� �������    (���� ������� 0�0006)
ADD M                ; ���������� ���� ����.
DCR D                ; ����������� �������
JNZ 0x0006           ; ���� ����������� �������������� �������� �������� ������� � �� ��� ��� �� ����� 0, �� ��������� ������ � ������ 0�0006 
INX H                ; ����� (���� ������� D ���� ����� 0) ��������� � ���� ������� � ��������� �� ��������� ������� �������
MOV M, A             ; ������������� �����
HLT  


// �� 3 (������ 2)   (2-� � ������ ������ �����)    (31 ����)
MVI D, 9        ; ������� 
MVI E, 0x0001        ; ����� �������� ������� ������� � 1-�� 
LXI H, 0x0020        ; ������ ����. �������
MOV C, M             ; ��� ��� 0000 00001 (������ 1 ��������) ����� �������� ����� ������, ������ ��� �������� ������� ����. � � (����� �����������)
INX H                ; (0x0008) ��������� � ����. ����. 
INR E                ; ����������� ����� �������� �������
JPO 0x0013           ; ���� ����. �����. �������� �������� �������, ��� �������� ����� �������� ����� ������ �� ������� �� ������ 0�0013
MOV A, M             ; �����  (����� ������ �����) ��������� � ����. ��������, ������������ �������� ���. �������� ������� � ���. 
ADD B                ; ���������� � ���. ������ ����. 
MOV B, A             ; ������ � ������� ������               
JMP 0x0016           ; ������������� ������ � ��������� 
MOV A, M             ; (0x0013)
ADD C                ; ��� ��� �� ��� � � �.
MOV C, A             ;
DCR D                ; (0x0016) ��������� �������
JNZ 0x0008           ; ���� �� ����� �� 0, ������� � ������ 
INX H                ; ������ ����� ����������� � �������
MOV M, C
INX H
MOV M, B
HLT

// (������ 2) : 26 ����
LXI H, 0x001B
INR D 			
MOV A, M 
JPO 0x000D           
ADD B
MOV B, A
JMP 0x000F
ADD C			
MOV C, A
MOV A, D			
CPI 0x000A
INX H
JM 0x0003
MOV M, B
INX H
MOV M, C
HLT
---------
////////////
1-���
2-���
3-�
4-���
5-�
6-�
7-���
8-���23
9-�
10-�
//////////

// (������ 3)
LXI H, 0x001B
INR D 
MOV A, M 
JPO 0x000D           
ADD B
MOV B, A
JMP 0x000F
ADD C
MOV C, A
MOV A, D
CPI 0x000A
INX H
JM 0x0003
MOV M, B
INX H
MOV M, C
HLT

// ������ 4 (�� �����)
LXI H, 0x0030
MVI E,11
BEGIN:
	DCR E
	JZ END
	MOV A,M
	INR C
	JPO ODD
	ADD D
	MOV D,A
	INX H
	JMP BEGIN	
ODD:
	ADD B
	MOV B,A
	INX H
	JMP BEGIN

END: 
	MOV M,D
	INX H
	MOV M,B
	HLT