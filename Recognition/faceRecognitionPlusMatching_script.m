clear all
thresh = 0.3;
bigthresh = 0.8;
identification = 0;
middle=0;
strong=0;
load('D:\MATLAB6p5\Project\Data\dataBase.mat')%,'DB');
load('D:\MATLAB6p5\Project\Data\features.mat');
U=features(1).values;
E=features(2).values;
w=features(3).values;
w1=features(4).values;
w2=features(5).values;
load('D:\MATLAB6p5\Project\Data\bioFeatures.mat');
UU=bioFeatures(1).values;
EE=bioFeatures(2).values;
ww=bioFeatures(3).values;
ww1=bioFeatures(4).values;
ww2=bioFeatures(5).values;
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
% T=repmat(zeros,[80 60 n]);
% bioT=repmat(zeros,[80 60 n]);
recognitionResults=[];
for i=1:10
    select_file=fullfile(pathname,sorted_names{i});
    data=load(select_file);
    fld=fieldnames(data);
    Im=getfield(data,fld{1});
    if (~isa(Im,'double'))
        Im=double(Im);
    end
    [p,q,r]=size(Im);
    %identification = 0;
    
    for j=1:r
        I0=Im(:,:,j);
        %figure,imshow(mat2gray(I0))
        [I,flag]=faceDetection(I0);
        [p,q]=size(I);
        [sFeatures,tFeatures]=imageFeatures(I);
        bioI=bloodFlow(I);
        A0=I;
        A=A0(:);
        TFF=E'*U'*A;
        zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
        a0=radbas(zs0);
        a0=w2*a0;
        
        [value0,refer]=max(a0);
        
        a0(refer)=0;
        [value01,refer01]=max(a0);
        first(i,:)=[refer value0 refer01 value01]
%         if value0>=thresh
%             name=refer; n=refer01;score1=value0;score2=value01; ratio=score1/score2;sig=1;
%             break
%         end
        AC=A0(:);
        ADOWN=[zeros(2,q);A0];
        ADOWN(end-1:end,:)=[];
        ADOWN2=ADOWN(:);
        ADOWN=[zeros(2,q);ADOWN];
        ADOWN(end-1:end,:)=[];
        ADOWN4=ADOWN(:);
        ADOWN=[zeros(2,q);ADOWN];
        ADOWN(end-1:end,:)=[];   
        ADOWN6=ADOWN(:);
        %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%   
        AUP = [A0;A0(end-1:end,:)];
        AUP(1:2,:)=[];
        AUP2 =AUP(:);
        AUP = [AUP;A0(end-1:end,:)];
        AUP(1:2,:)=[];
        AUP4 =AUP(:);
        AUP = [AUP;A0(end-1:end,:)];
        AUP(1:2,:)=[];
        AUP6 =AUP(:);
        AUD=[AUP6,AUP4,AUP2,AC,ADOWN2,ADOWN4,ADOWN6];
        TFF=E'*U'*AUD;
        zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
        a0=radbas(zs0);
        a0=w2*a0;
        a=max(a0,[],2);
        resultUD=a0
        [value0,refer]=max(a);
        a(refer)=0;
        [value01,refer01]=max(a);
        afterupdown(i,:)=[refer value0 refer01 value01]
        
        a=max(a0,[],1);
        [value,numIm]=max(a);
        AC=AUD(:,numIm);
        A0=reshape(AC,p,q);
        AR=[zeros(p,1) A0];
        AR(:,end)=[];
        AR1=AR(:);
        AR=[zeros(p,1) AR];
        AR(:,end)=[];
        AR2=AR(:);
        
        AL=[A0 zeros(p,1)];
        AL(:,1)=[];
        AL1=AL(:);
        AL=[AL zeros(p,1)];
        AL(:,1)=[];
        AL2=AL(:);
        ARL=[AL2,AL1,AC,AR1,AR2];
        TFF=E'*U'*ARL;
        zs0=dist(w1,TFF)./(w'*ones(1,size(TFF,2)));
        a0=radbas(zs0);
        a0=w2*a0;
        a=max(a0,[],2);
        resultLR =a0;
        whoafterLR=a';
        whichafterLR=max(a0,[],1);
        
        [value0,refer]=max(a);
        a(refer)=0;
        [value01,refer01]=max(a);
        afterLR(i,:)=[refer value0 refer01 value01]
        %     [score1,num1]=max(a0(refer,:));
        %     [score2,num2]=max(a0(refer01,:));
        %     name=num1;
        %     a=max(a0,[],2);
        %     [score1,num1]=max(a);
        %     a(num1)=-10;
        %     [score2,num2]=max(a);
        %     name=num1;
        %     if score1 >= thresh1 | (score1-score2)/score1 >= thresh2
        %         sig=1;
        %         break
        %     else
        %         sig=0;
        %     end  
        %    results(i,:)=[name,refer,score1,value0,score2,value01];
    end
    keyboard
end