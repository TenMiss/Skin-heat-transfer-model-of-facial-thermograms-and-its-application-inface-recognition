clear all
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%          
%%            $Revision: 1.0 $  $Date: 27 Oct 2004 $
%
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file');
if isequal([filename,pathname],[0,0])
    return
end
dir_struct = dir(pathname);
%%% (1)name, (2)date, (3)bytes and (4) isdir
[sorted_names,sorted_index]=sortrows({dir_struct.name}');
a=[dir_struct.isdir];
a(1:2)=[];             %%% Delete the dot dir
sorted_names(1:2)=[];
[n,m]=size(sorted_names);
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    [p,q,r]=size(I);
    if (~isa(I,'double'))
        I=double(I);
    end
    for j =1:r
        A = I(:,:,j);
        total = sum(A(:));       % moment m00 
        [row,column]=find(A>1);
        num = length(row);
        x0 = sum(row)/num;
        y0 = sum(column)/num;   % x0,y0 are centroid of shape
        xm1 =0; ym1 =0;
        for k = 1:num
            xm1 = xm1 + row(k)*A(row(k),column(k));
            ym1 = ym1 + column(k)*A(row(k),column(k));
        end
        xc = xm1/total;   
        yc = ym1/total;   % xc,yc are centroid of mass
        F((i-1)*6+j,:) = [total/num,x0,xc,y0,yc]
        numbers=find(A(:)<1);
        A(numbers)=295;
        figure,imshow(mat2gray(A))        
    end
    keyboard
    close all        
end
disp('finish')
