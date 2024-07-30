A=imread("E:\vivado files\ICHI2021PS2\matlab_code\WhatsApp Image 2024-07-09 at 18.05.15_e1f5ff2b.jpg");%LOADING IMAGE
A=imresize(A,[1024 1024]);% REESIZE IMAGE
A=rgb2gray(A); %rgb to gary
imshow(A);%TO SHOW
imtool(A);%TO SHOW PIXELS
fileID=fopen("E:\vivado files\ICHI2021PS2\matlab_code\Input Image.bin.txt",'w'); %OPEN FILE WHERE INPUT IMAGE PIXELS ARE STORED
for r=1:1024
    for c=1:1024
       fwrite(fileID,A(r,c));
    end
end
fclose(fileID);