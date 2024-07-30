`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 18:54:57
// Design Name: 
// Module Name: aesdecrypt
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////
// sbox declaration
module sbox(input [127:0]a,output [127:0]b);

reg [7:0]box[0:255];

initial
$readmemh("isbox.txt",box);  // program the memory

assign b={box[a[127:120]],box[a[119:112]],box[a[111:104]],box[a[103:96]],box[a[95:88]],box[a[87:80]],box[a[79:72]],box[a[71:64]],box[a[63:56]],box[a[55:48]],box[a[47:40]],box[a[39:32]],box[a[31:24]],box[a[23:16]],box[a[15:8]],box[a[7:0]]};

endmodule

//used to shift
module shift(input [127:0]a,output [127:0]b);


assign b={a[127:120],a[23:16],a[47:40],a[71:64],a[95:88],a[119:112],a[15:8],a[39:32],a[63:56],a[87:80],a[111:104],a[7:0],a[31:24],a[55:48],a[79:72],a[103:96]};


endmodule






// used to mixstates
module mix(input [127:0]a,output reg[127:0]b);

always @*
begin
b[127:120]=w[0]^w1[1]^w2[2]^w3[3];
b[119:112]=w3[0]^w[1]^w1[2]^w2[3];
b[111:104]=w2[0]^w3[1]^w[2]^w1[3];
b[103:96] =w1[0]^w2[1]^w3[2]^w[3];
b[95:88]= w[4]^w1[5]^w2[6]^w3[7];
b[87:80]= w3[4]^w[5]^w1[6]^w2[7];
b[79:72]= w2[4]^w3[5]^w[6]^w1[7];
b[71:64]=w1[4]^w2[5]^w3[6]^w[7];
b[63:56]=w[8]^w1[9]^w2[10]^w3[11];
b[55:48]=w3[8]^w[9]^w1[10]^w2[11];
b[47:40]=w2[8]^w3[9]^w[10]^w1[11];
b[39:32]=w1[8]^w2[9]^w3[10]^w[11];
b[31:24]=w[12]^w1[13]^w2[14]^w3[15];
b[23:16]=w3[12]^w[13]^w1[14]^w2[15];
b[15:8]=w2[12]^w3[13]^w[14]^w1[15];
b[7:0]=w1[12]^w2[13]^w3[14]^w[15];
end

wire [7:0]w[0:15];
wire [7:0]w1[0:15];
wire [7:0]w2[0:15];
wire [7:0]w3[0:15];

mix0E me1(a[127:120],w[0]);
mix0E me2(a[119:112],w[1]);
mix0E me3(a[111:104],w[2]);
mix0E me4(a[103:96],w[3]);
mix0E me5(a[95:88],w[4]);
mix0E me6(a[87:80],w[5]);
mix0E me7(a[79:72],w[6]);
mix0E me8(a[71:64],w[7]);
mix0E me9(a[63:56],w[8]);
mix0E me10(a[55:48],w[9]);
mix0E me11(a[47:40],w[10]);
mix0E me12(a[39:32],w[11]);
mix0E me13(a[31:24],w[12]);
mix0E me14(a[23:16],w[13]);
mix0E me15(a[15:8],w[14]);
mix0E me16(a[7:0],w[15]);

mix0B mb1(a[127:120],w1[0]);
mix0B mb2(a[119:112],w1[1]);
mix0B mb3(a[111:104],w1[2]);
mix0B mb4(a[103:96],w1[3]);
mix0B mb5(a[95:88],w1[4]);
mix0B mb6(a[87:80],w1[5]);
mix0B mb7(a[79:72],w1[6]);
mix0B mb8(a[71:64],w1[7]);
mix0B mb9(a[63:56],w1[8]);
mix0B mb10(a[55:48],w1[9]);
mix0B mb11(a[47:40],w1[10]);
mix0B mb12(a[39:32],w1[11]);
mix0B mb13(a[31:24],w1[12]);
mix0B mb14(a[23:16],w1[13]);
mix0B mb15(a[15:8],w1[14]);
mix0B mb16(a[7:0],w1[15]);

mix0D md1(a[127:120],w2[0]);
mix0D md2(a[119:112],w2[1]);
mix0D md3(a[111:104],w2[2]);
mix0D md4(a[103:96],w2[3]);
mix0D md5(a[95:88],w2[4]);
mix0D md6(a[87:80],w2[5]);
mix0D md7(a[79:72],w2[6]);
mix0D md8(a[71:64],w2[7]);
mix0D md9(a[63:56],w2[8]);
mix0D md10(a[55:48],w2[9]);
mix0D md11(a[47:40],w2[10]);
mix0D md12(a[39:32],w2[11]);
mix0D md13(a[31:24],w2[12]);
mix0D md14(a[23:16],w2[13]);
mix0D md15(a[15:8],w2[14]);
mix0D md16(a[7:0],w2[15]);

mix09 mn1(a[127:120],w3[0]);
mix09 mn2(a[119:112],w3[1]);
mix09 mn3(a[111:104],w3[2]);
mix09 mn4(a[103:96],w3[3]);
mix09 mn5(a[95:88],w3[4]);
mix09 mn6(a[87:80],w3[5]);
mix09 mn7(a[79:72],w3[6]);
mix09 mn8(a[71:64],w3[7]);
mix09 mn9(a[63:56],w3[8]);
mix09 mn10(a[55:48],w3[9]);
mix09 mn11(a[47:40],w3[10]);
mix09 mn12(a[39:32],w3[11]);
mix09 mn13(a[31:24],w3[12]);
mix09 mn14(a[23:16],w3[13]);
mix09 mn15(a[15:8],w3[14]);
mix09 mn16(a[7:0],w3[15]);

endmodule






// used to add
module add(input [127:0]a,b,output [127:0]c);



assign c=a^b;


endmodule





module fourtrans(input [127:0]a,c,output [127:0]b);

wire [127:0]i,j,l;

shift sh1(a,i);
sbox s1(i,j);
add a1(j,c,l);
mix mix1(l,b);

endmodule




module threetrans(input [127:0]a,c,output [127:0]b);

wire [127:0]i,j;

shift sh2(a,i);
sbox s2(i,j);
add a2(j,c,b);

endmodule




module aesdecrypt(input [127:0]ciphertext,key,output [127:0]plaintext);


reg [127:0]expkey[0:10];
wire [31:0]k1,l1,m1,n1,o1,p1,q1,r1,s1,t1,k,l,m,n,o,p,q,r,s,t;

always@*
begin
expkey[0]=key;
expkey[1]={k,expkey[0][95:64]^k,expkey[0][95:64]^k^expkey[0][63:32],expkey[0][95:64]^k^expkey[0][63:32]^expkey[0][31:0]};
expkey[2]={l,expkey[1][95:64]^l,expkey[1][95:64]^l^expkey[1][63:32],expkey[1][95:64]^l^expkey[1][63:32]^expkey[1][31:0]};
expkey[3]={m,expkey[2][95:64]^m,expkey[2][95:64]^m^expkey[2][63:32],expkey[2][95:64]^m^expkey[2][63:32]^expkey[2][31:0]};
expkey[4]={n,expkey[3][95:64]^n,expkey[3][95:64]^n^expkey[3][63:32],expkey[3][95:64]^n^expkey[3][63:32]^expkey[3][31:0]};
expkey[5]={o,expkey[4][95:64]^o,expkey[4][95:64]^o^expkey[4][63:32],expkey[4][95:64]^o^expkey[4][63:32]^expkey[4][31:0]};
expkey[6]={p,expkey[5][95:64]^p,expkey[5][95:64]^p^expkey[5][63:32],expkey[5][95:64]^p^expkey[5][63:32]^expkey[5][31:0]};
expkey[7]={q,expkey[6][95:64]^q,expkey[6][95:64]^q^expkey[6][63:32],expkey[6][95:64]^q^expkey[6][63:32]^expkey[6][31:0]};
expkey[8]={r,expkey[7][95:64]^r,expkey[7][95:64]^r^expkey[7][63:32],expkey[7][95:64]^r^expkey[7][63:32]^expkey[7][31:0]};
expkey[9]={s,expkey[8][95:64]^s,expkey[8][95:64]^s^expkey[8][63:32],expkey[8][95:64]^s^expkey[8][63:32]^expkey[8][31:0]};
expkey[10]={t,expkey[9][95:64]^t,expkey[9][95:64]^t^expkey[9][63:32],expkey[9][95:64]^t^expkey[9][63:32]^expkey[9][31:0]};
end

assign k=k1^expkey[0][127:96];
assign l=l1^expkey[1][127:96];
assign m=m1^expkey[2][127:96];
assign n=n1^expkey[3][127:96];
assign o=o1^expkey[4][127:96];
assign p=p1^expkey[5][127:96];
assign q=q1^expkey[6][127:96];
assign r=r1^expkey[7][127:96];
assign s=s1^expkey[8][127:96];
assign t=t1^expkey[9][127:96];

sbox2 sb1(expkey[0][31:0],8'b00000001,k1);
sbox2 sb2(expkey[1][31:0],8'b00000010,l1);
sbox2 sb3(expkey[2][31:0],8'b00000100,m1);
sbox2 sb4(expkey[3][31:0],8'b00001000,n1);
sbox2 sb5(expkey[4][31:0],8'b00010000,o1);
sbox2 sb6(expkey[5][31:0],8'b00100000,p1);
sbox2 sb7(expkey[6][31:0],8'b01000000,q1);
sbox2 sb8(expkey[7][31:0],8'b10000000,r1);
sbox2 sb9(expkey[8][31:0],8'b00011011,s1);
sbox2 sb10(expkey[9][31:0],8'b00110110,t1);

wire [127:0]a,b,c,d,e,f,g,h,i,j,z;

add a3(ciphertext,expkey[10],a);

fourtrans T1(a,expkey[9],b);
fourtrans T2(b,expkey[8],c);
fourtrans T3(c,expkey[7],d);
fourtrans T4(d,expkey[6],e);
fourtrans T5(e,expkey[5],f);
fourtrans T6(f,expkey[4],g);
fourtrans T7(g,expkey[3],h);
fourtrans T8(h,expkey[2],i);
fourtrans T9(i,expkey[1],j);

threetrans t2(j,expkey[0],plaintext);

endmodule


module sbox2(input [31:0]a,input [7:0]c,output [31:0]b);

reg [7:0]box[0:255];

initial
$readmemh("sbox.txt",box);  // program the memory

assign b={box[a[23:16]]^c,box[a[15:8]],box[a[7:0]],box[a[31:24]]};


endmodule






module mix0E(input [7:0]a,output [7:0]b);

reg [7:0]d,f,g;

always @*
begin
d={a[6:0],1'b0}^{{8{a[7]}}&8'b00011011};
f={d[6:0],1'b0}^{{8{d[7]}}&8'b00011011};
g={f[6:0],1'b0}^{{8{f[7]}}&8'b00011011};
end

assign b=d^f^g;

endmodule


module mix0B(input [7:0]a,output [7:0]b);

reg [7:0]d,f,g,e;

always @*
begin
d=a[7:0];
f={d[6:0],1'b0}^{{8{d[7]}}&8'b00011011};
e={f[6:0],1'b0}^{{8{f[7]}}&8'b00011011};
g={e[6:0],1'b0}^{{8{e[7]}}&8'b00011011};
end

assign b=d^f^g;

endmodule


module mix0D(input [7:0]a,output [7:0]b);

reg [7:0]d,f,g,e;

always @*
begin
d=a[7:0];
e={d[6:0],1'b0}^{{8{d[7]}}&8'b00011011};
f={e[6:0],1'b0}^{{8{e[7]}}&8'b00011011};
g={f[6:0],1'b0}^{{8{f[7]}}&8'b00011011};
end

assign b=d^f^g;

endmodule


module mix09(input [7:0]a,output [7:0]b);

reg [7:0]d,f,g,e;

always @*
begin
d=a[7:0];
e={d[6:0],1'b0}^{{8{d[7]}}&8'b00011011};
f={e[6:0],1'b0}^{{8{e[7]}}&8'b00011011};
g={f[6:0],1'b0}^{{8{f[7]}}&8'b00011011};
end

assign b=d^g;

endmodule