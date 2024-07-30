fileID=fopen("C:\Users\vamsh\Downloads\myfile4.dat",'r'); %OPEN FILE WHERE AGAIN FILE AFTER DECRYPTION USING CBC IS STORED
i=1;
k=uint8(zeros(1014,1024));
b=fread(fileID);
for r=1:1024
    for c=1:1024
        k(r,c)=b(i);
        i=i+1;
    end
end

fclose(fileID);
B = repmat(k, [1, 1, 3]);%GRAY TO RGB
imshow(k);%TO SHOW
imtool(B); %to pixels