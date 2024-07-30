`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.07.2024 22:01:23
// Design Name: 
// Module Name: aes
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



module sbox(input [127:0]a,output [127:0]b);

reg [7:0]box[0:255];

initial
$readmemh("sbox.txt",box);  // program the memory

assign b={box[a[127:120]],box[a[119:112]],box[a[111:104]],box[a[103:96]],box[a[95:88]],box[a[87:80]],box[a[79:72]],box[a[71:64]],box[a[63:56]],box[a[55:48]],box[a[47:40]],box[a[39:32]],box[a[31:24]],box[a[23:16]],box[a[15:8]],box[a[7:0]]};

endmodule

module shift(input [127:0]a,output [127:0]b);


assign b={a[127:120],a[87:80],a[47:40],a[7:0],a[95:88],a[55:48],a[15:8],a[103:96],a[63:56],a[23:16],a[111:104],a[71:64],a[31:24],a[119:112],a[79:72],a[39:32]};


endmodule


module mix(input [127:0]a,output reg[127:0]b);

always @*
begin
b[127:120]={a[126:120],1'b0}^{{8{a[127]}}&8'b00011011}^{a[118:112],1'b0}^{{8{a[119]}}&8'b00011011}^a[119:112]^a[111:104]^a[103:96];
b[119:112]={a[118:112],1'b0}^{{8{a[119]}}&8'b00011011}^{a[110:104],1'b0}^{{8{a[111]}}&8'b00011011}^a[111:104]^a[127:120]^a[103:96];
b[111:104]={a[110:104],1'b0}^{{8{a[111]}}&8'b00011011}^{a[102:96],1'b0}^{{8{a[103]}}&8'b00011011}^a[103:96]^a[127:120]^a[119:112];
b[103:96]={a[102:96],1'b0}^{{8{a[103]}}&8'b00011011}^{a[126:120],1'b0}^{{8{a[127]}}&8'b00011011}^a[127:120]^a[119:112]^a[111:104];
b[95:88]= {a[94:88],1'b0}^{{8{a[95]}}&8'b00011011}^{a[86:80],1'b0}^{{8{a[87]}}&8'b00011011}^a[87:80]^a[79:72]^a[71:64];
b[87:80]= {a[86:80],1'b0}^{{8{a[87]}}&8'b00011011}^{a[78:72],1'b0}^{{8{a[79]}}&8'b00011011}^a[79:72]^a[95:88]^a[71:64];
b[79:72]= {a[78:72],1'b0}^{{8{a[79]}}&8'b00011011}^{a[70:64],1'b0}^{{8{a[71]}}&8'b00011011}^a[71:64]^a[95:88]^a[87:80];
b[71:64]={a[70:64],1'b0}^{{8{a[71]}}&8'b00011011}^{a[94:88],1'b0}^{{8{a[95]}}&8'b00011011}^a[95:88]^a[87:80]^a[79:72];
b[63:56]={a[62:56],1'b0}^{{8{a[63]}}&8'b00011011}^{a[54:48],1'b0}^{{8{a[55]}}&8'b00011011}^a[55:48]^a[47:40]^a[39:32];
b[55:48]={a[54:48],1'b0}^{{8{a[55]}}&8'b00011011}^{a[46:40],1'b0}^{{8{a[47]}}&8'b00011011}^a[47:40]^a[63:56]^a[39:32];
b[47:40]={a[46:40],1'b0}^{{8{a[47]}}&8'b00011011}^{a[38:32],1'b0}^{{8{a[39]}}&8'b00011011}^a[39:32]^a[63:56]^a[55:48];
b[39:32]={a[38:32],1'b0}^{{8{a[39]}}&8'b00011011}^{a[62:56],1'b0}^{{8{a[63]}}&8'b00011011}^a[63:56]^a[55:48]^a[47:40];
b[31:24]={a[30:24],1'b0}^{{8{a[31]}}&8'b00011011}^{a[22:16],1'b0}^{{8{a[23]}}&8'b00011011}^a[23:16]^a[15:8]^a[7:0];
b[23:16]={a[22:16],1'b0}^{{8{a[23]}}&8'b00011011}^{a[14:8],1'b0}^{{8{a[15]}}&8'b00011011}^a[15:8]^a[31:24]^a[7:0];
b[15:8]={a[14:8],1'b0}^{{8{a[15]}}&8'b00011011}^{a[6:0],1'b0}^{{8{a[7]}}&8'b00011011}^a[7:0]^a[31:24]^a[23:16];
b[7:0]={a[6:0],1'b0}^{{8{a[7]}}&8'b00011011}^{a[30:24],1'b0}^{{8{a[31]}}&8'b00011011}^a[31:24]^a[23:16]^a[15:8];
end



endmodule


module add(input [127:0]a,b,output [127:0]c);



assign c=a^b;


endmodule


module fourtrans(input [127:0]a,b,output [127:0]c);

wire [127:0]k,l,m;

sbox s1(a,k);
shift sh1(k,l);
mix mi1(l,m);
add a1(m,b,c);


endmodule

module threetrans(input [127:0]a,b,output [127:0]c);

wire [127:0]k,l,m;

sbox s2(a,k);
shift sh2(k,l);
add a2(l,b,c);

endmodule


module aes(input [127:0]plaintext,key,output [127:0]ciphertext);


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


add a3(plaintext,expkey[0],a);

fourtrans T1(a,expkey[1],c);
fourtrans T2(c,expkey[2],d);
fourtrans T3(d,expkey[3],e);
fourtrans T4(e,expkey[4],f);
fourtrans T5(f,expkey[5],g);
fourtrans T6(g,expkey[6],h);
fourtrans T7(h,expkey[7],i);
fourtrans T8(i,expkey[8],j);
fourtrans T9(j,expkey[9],z);

threetrans tr1(z,expkey[10],ciphertext);

initial $monitor("%b",z);

endmodule


module sbox2(input [31:0]a,input [7:0]c,output [31:0]b);

reg [7:0]box[0:255];

initial
$readmemh("sbox.txt",box);  // program the memory

assign b={box[a[23:16]]^c,box[a[15:8]],box[a[7:0]],box[a[31:24]]};


endmodule