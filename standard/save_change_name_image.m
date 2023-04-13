clear
load('c:\cap_tomodify\Matlab\template.mat')
for i=1:30
    p=I(:,:,(i-1)*10+1:10*i);
    for j=1:10
        name=['c:\cap_tomodify\Template\' 'A' int2str(i) '_00' int2str(j) '.bmp'];
        imwrite(p(:,:,j),name);
        %keyboard
    end
end