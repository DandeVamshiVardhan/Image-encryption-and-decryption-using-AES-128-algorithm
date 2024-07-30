`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 22:26:15
// Design Name: 
// Module Name: decrypt_tb
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


module decrypt_tb();
reg [127:0]ciphertext,ciphertext2,key;
wire [127:0]plaintext;
wire [127:0]plaintext2;
reg clk,reset;
reg [31:0]cnt;
reg [127:0]ecbimage[0:65535];
reg [127:0]cbcimage[0:65535];
reg [127:0]inimage1[0:65535];
reg [127:0]inimage2[0:65535];

initial $readmemh("ecbimage.txt",ecbimage);
initial $readmemh("cbcimage.txt",cbcimage);


aesdecrypt aes1(ciphertext,key,plaintext);// electronic code book

initial clk=1'b0;
always #5clk=~clk;

always @(posedge clk,negedge reset) 
begin
if(reset==1'b0) cnt<=32'b0;
else cnt<=cnt+1'b1;
end

initial
begin
key=128'h0f1571c947d9e8590cb7add6af7f6798;
reset=1'b0;
#2reset=1'b1;
end

always @(cnt) 
begin
ciphertext=ecbimage[cnt];
#1inimage1[cnt]=plaintext;
if(cnt==65536)$writememh("inimage1.txt",inimage1); 
end

aesdecrypt aes2(ciphertext2,key,plaintext2); // cipher blockchain mode

always @(cnt) 
begin
ciphertext2=cbcimage[cnt];
#1 if(cnt==32'b0)inimage2[cnt]=plaintext2^128'h0f1571c947d9e8590cb7add6af7f6798;
    else inimage2[cnt]=plaintext2^cbcimage[cnt-1'b1];
if(cnt==65536)$writememh("inimage2.txt",inimage2); 
end



endmodule
