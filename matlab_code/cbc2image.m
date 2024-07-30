fileID=fopen("C:\Users\vamsh\Downloads\myfile3.dat",'r'); %OPEN FILE WHERE CBC ENCRYPTED DATA IS STORED
k=uint8(zeros(1014,1024));
b=fread(fileID);
i=1;
for r=1:1024
    for c=1:1024
        k(r,c)=b(i);
        
        i=i+1;
    end
end

fclose(fileID);
B = repmat(k, [1, 1, 3]);%GRAY TO RGB
imshow(B);%TO SHOW
imtool(B); %to pixel