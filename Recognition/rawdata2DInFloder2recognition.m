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
for i=1:n
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    I=getfield(data,fld{1});
    if (~isa(I,'double'))
        I=double(I);
    end
    I=faceDetection(I);
    I=bloodFlow(I);
    A=I(:);
    [u,v]=size(A);
    TFF=E'*U'*A;
    zs0=dist(w1,TFF)./(w'*ones(1,v));
    a0=radbas(zs0);
    a0=w2*a0;
    [value,n]=max(a0);
    a0(n)=0;
    [value1,n1]=max(a0);
    results2(i,:)=[n,n1,value,value1,value/value1];
    keyboard
end

disp('finished')
