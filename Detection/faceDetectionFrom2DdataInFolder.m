clear all
[filename, pathname] = uigetfile({'*.mat', 'All MAT-Files (*.mat)'; ...
        '*.*','All Files (*.*)'}, 'Select MAT file')
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
F=repmat(zeros,[80 60 n]);
min_area=2000;max_area=5000;
par_noise=10;
edge=3;delt=1.5;
signature=0;
for i=101:110
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    A=getfield(data,fld{1});
    if ~isa(A,'double')
        A=double(A);
    end
    A=imresize(A,0.5);
    A0=A;
    [height,width]=size(A);
    maxvalue=max(max(A))
    figure,imshow(mat2gray(A),'truesize');
    
    [A,bbg]=ir2bbg(A,[edge,edge]);
    background=bbg
    B0=ir2bw(A,bbg+delt);
    figure,imshow(logical(B0),'truesize')
    B=delete_bw_noise(B0,[min_area max_area]);
    
    figure,imshow(logical(B),'truesize');
    if all(B==0)
        signature=1    
        %disp('No object')
        continue
    end
    [up0,num0]=detect_up0(B);
    unit=min(10,up0);
    if unit>=3
        SE=strel('disk',unit);
        B=imclose(B,SE);
    end
    B = imfill(B,'holes');
    AA=A.*B+0.01;
%    figure,imshow(mat2gray(AA),'truesize');
%    pause
    [left,right,up,down,sig,num]=bw2contour(B);
    if sig==1
        signature=1
        disp('There may be two objects in the bw2contour file')
        continue
    end
    CB=zeros(length(left),max(right));
    for j=1:length(left)
        CB(j, left(j):right(j))=1.0;
    end   
    CB(:,1:min(left))=[];
    figure,imshow(CB,'truesize');
    [left,right,sig]=deshoulder(left,right);
    C=zeros(length(left),max(right));
    for j=1:length(left)
        C(j, left(j):right(j))=1.0;
    end   
    C(:,1:min(left))=[];
    figure,imshow(C,'truesize');
    minleft=min(left);
    maxright=max(right);
    if up <= edge+1
        disp('The upper part of face is cut off')
        signature=1
        continue
    end       
    if (minleft<=edge+1)|(maxright>=width-edge-1)
        disp('The side face is cut off')
        signature=1
        continue
    end       
    [dleft,dright,sig]=useful_data(left,right,par_noise);
    if sig==1
        signature=1
        continue
    end
    alfa=side2rotate(dleft,dright);
    if abs(alfa)<=6
        %disp('No need to rotate')
        alfa=0;        
        AA(1:up-1,:)=[];
        AA(:,[1:minleft-1 maxright+1:end])=[];     
    else        
        disp('Need rotation')
        [countangle,sig]=iterative_rotate(CB,alfa,10);
        angleis = countangle
        if sig==1
            signature=1
            continue
        end
        alfa=sum(countangle);
        A([1:up-2,down+1:end],:)=[];
        A(:,[1:minleft-3 maxright+3:end])=[];
        A=rotate_pad(A,[alfa,bbg]);
        figure,imshow(mat2gray(A),'truesize');
        [left,right,AA]=ir2face(A,[bbg+delt,min_area,max_area]); 
    end
    %figure,imshow(mat2gray(A),'truesize');
    AA=normalize(AA,[80 60],0.01);
    %A=remove_glasses(A);
    F(:,:,i)=AA;
    maxvalue=max(max(AA))
    figure,imshow(mat2gray(AA),'truesize');
    %keyboard
    close all
end