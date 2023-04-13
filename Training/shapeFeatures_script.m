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
    for j =1:6
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
        m10 =0; m01 =0; 
        m20 =0; m02 =0; m11 =0;
        m30 =0; m03 =0; m12 =0;m21 =0;
        m40 =0; m04 =0; m22 =0; m13 =0; m31 =0;
        m50 =0; m05 =0; m14 =0; m23 =0;m32=0; m41=0;
        for k = 1:num
            m10 = m10 + (row(k)-xc)*A(row(k),column(k));
            m01 = m01 + (column(k)-yc)*A(row(k),column(k));
            
            m20 = m20 + (row(k)-xc)^2*A(row(k),column(k));
            m02 = m02 + (column(k)-yc)^2*A(row(k),column(k));
            m11 = m11 + (row(k)-xc)*(column(k)-yc)*A(row(k),column(k));
            
            m30 = m30 + (row(k)-xc)^3*A(row(k),column(k));
            m03 = m03 + (column(k)-yc)^3*A(row(k),column(k));
            m12 = m12 + (row(k)-xc)*(column(k)-yc)^2*A(row(k),column(k));
            m21 = m21 + (row(k)-xc)^2*(column(k)-yc)*A(row(k),column(k));
            
            m40 = m40 + (row(k)-xc)^4*A(row(k),column(k));
            m04 = m04 + (column(k)-yc)^4*A(row(k),column(k));
            m13 = m13 + (row(k)-xc)*(column(k)-yc)^3*A(row(k),column(k));
            m22 = m22 + (row(k)-xc)^2*(column(k)-yc)^2*A(row(k),column(k));
            m31 = m31 + (row(k)-xc)^3*(column(k)-yc)*A(row(k),column(k));
            
            m50 = m50 + (row(k)-xc)^5*A(row(k),column(k));
            m05 = m05 + (column(k)-yc)^5*A(row(k),column(k));
            m14 = m14 + (row(k)-xc)*(column(k)-yc)^4*A(row(k),column(k));
            m23 = m23 + (row(k)-xc)^2*(column(k)-yc)^3*A(row(k),column(k));
            m32 = m32 + (row(k)-xc)^3*(column(k)-yc)^2*A(row(k),column(k));
            m41 = m41 + (row(k)-xc)^4*(column(k)-yc)*A(row(k),column(k));
        end
        m10 = m10/total; m01 = m01/total;
        m20 = m20/total; m02 = m02/total; m11 = m11/total;
        m30 = m30/total; m03 = m03/total; m12 = m12/total; m21 =m21/total;
        m40 = m40/total; m04 = m04/total; m13 = m13/total; m22 =m22/total; m31 = m31/total;
        m50 = m50/total; m05 = m05/total; m14 = m14/total; m23 =m23/total; m32 = m32/total;m41 = m41/total;
        F13((i-1)*6+j,:) = [m10,m01,m20,m02,m11,m30,m03,m12,m21];
        F45((i-1)*6+j,:) = [m40,m04,m13,m22,m31,m50,m05,m14,m23,m32,m41];
    end
        
end
disp('finish')
