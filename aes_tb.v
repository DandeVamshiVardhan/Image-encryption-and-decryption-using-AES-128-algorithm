`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.07.2024 12:29:47
// Design Name: 
// Module Name: aes_tb
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


module aes_tb();
reg [127:0]plaintext,key,plaintext2;
reg [31:0]cnt;
reg clk,reset;
wire [127:0]ciphertext;
wire [127:0]ciphertext2;
reg [127:0]inimage[0:65535];
reg [127:0]ecbimage[0:65535];
reg [127:0]cbcimage[0:65535];

initial $readmemh("Input Image 16 bytesperline.txt",inimage);

initial clk=1'b0;
always #5clk=~clk;

aes ae1(plaintext,key,ciphertext);     //electronic codebook mode

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
plaintext=inimage[cnt];
#1ecbimage[cnt]=ciphertext;
if(cnt==65536)$writememh("ecbimage.txt",ecbimage); 
end

aes ae2(plaintext2,key,ciphertext2);  //cipher feedback mode

always@(cnt)
begin
if(cnt==32'b0)plaintext2=128'h0f1571c947d9e8590cb7add6af7f6798^inimage[cnt];
else plaintext2=ciphertext2^inimage[cnt];
#1cbcimage[cnt]=ciphertext2;
if(cnt==65536) $writememh("cbcimage.txt",cbcimage);
end

endmodule
