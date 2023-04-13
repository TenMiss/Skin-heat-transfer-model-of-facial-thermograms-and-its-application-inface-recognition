clear all
thresh=0.35;bigthresh = 0.75;
signature = 1;
badImages=0;badSegmentation = 0;
occlusions=0; notface =0;
count=0; maxNum=5;
topScore=0;
bestImage=[];
strong=0;middle=0;weak=0;
middleResults=[];
weakResults=[];

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
for i=1:n
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
        if flag(1)==1
            msgbox('Your face cannot completely detected!','Occlusion occurs!');
            nameIndex=nan;s1=nan;s2=nan;known=nan;
            %return
            break
        end
        if flag(2)==1
            msgbox('Bad images are detected!','Bad images occurs!');
             nameIndex=nan;s1=nan;s2=nan;known=nan;
            break
        end
        [sFeatures,tFeatures]=imageFeatures(I);
        if sFeatures(1)< 3400
           msgbox('The face is not well segmented!','Segmentation error!');
            nameIndex=nan;s1=nan;s2=nan;known=nan;
           break
        end
        if (tFeatures(1)< 308) || (tFeatures(1)> 311) ...
                ||(tFeatures(2)< 306.8) || (tFeatures(2)> 309)...
                ||(tFeatures(3)< 0.40)|| (tFeatures(3)>1.0)...
                ||(sFeatures(3)<0.73)||(sFeatures(2)>250)
            msgbox('This is not a face!','Nonface detected!');
             nameIndex=nan;s1=nan;s2=nan;known=nan;
            break
        end
        bioI=bloodFlow(I);
        [nameIndex11,nameIndex12,s11,s12,ratio1,flag1]=faceRecognition(I,U,E,w,w1,w2,thresh);
        [nameIndex21,nameIndex22,s21,s22,ratio2,flag2]=faceRecognition(bioI,UU,EE,ww,ww1,ww2,thresh);
        testResults=[nameIndex11,nameIndex12,s11,s12,ratio1,flag1;...
                nameIndex21,nameIndex22,s21,s22,ratio2,flag2]
        if s11>=bigthresh && abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
            nameIndex = nameIndex11;
            s1=s11;s2=s12;
            identification = 1;
            strong=1;
            known=1
            break
        end
        if s21>=bigthresh && abs(sFeatures(3)>=min(DB(nameIndex21).shapeFeatures(3,:)))&&...
                abs(sFeatures(3)<=max(DB(nameIndex21).shapeFeatures(3,:)))&&...
                abs(tFeatures(3)<=max(DB(nameIndex21).thermalFeatures(3,:)))&&...
                abs(tFeatures(3)>=min(DB(nameIndex21).thermalFeatures(3,:)))
            nameIndex = nameIndex21;
            s1=s21;s2=s22;
            identification = 1;
            strong=1;
            known=2
            break
        end
        if flag1 == 1 && flag2 == 1 && nameIndex11==nameIndex21
            if abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                    abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                    abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                    abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
                identification = 1;
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
                strong=1;
                known=3
                break
            else
                unknown=1
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
                identification = 0;
            end
        elseif flag1 == 1 && flag2 == 1 && nameIndex11~=nameIndex21
            SRD1=abs(DB(nameIndex11).shapeFeatures(3,:)-sFeatures(3));
            SRD2=abs(DB(nameIndex21).shapeFeatures(3,:)-sFeatures(3));
            TVD1=abs(DB(nameIndex11).thermalFeatures(3,:)-tFeatures(3));
            TVD2=abs(DB(nameIndex21).thermalFeatures(3,:)-tFeatures(3));
            delt=[min(SRD1),min(TVD1),mean(SRD1),mean(TVD1);min(SRD2),min(TVD2),mean(SRD2),mean(TVD2)];
            delta = delt(2,:)-delt(1,:);
            if all(delta >=0)
                identification = 1;
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
                middle=1;
                known=4
                if isempty(middleResults)
                    middleResults =[middleResults;[nameIndex s1 1]];
                else
                    namefind=find(middleResults(:,1)==nameIndex);
                    if isempty(namefind)
                        middleResults =[middleResults;[nameIndex s1 1]];
                    else
                        middleResults(namefind,2)= max(middleResults(namefind,2),s1);
                        middleResults(namefind,3)= middleResults(namefind,2)+1;
                    end
                end
            elseif all(delta <=0)
                identification = 1;
                nameIndex = nameIndex21;
                s1=s21;s2=s22;
                weak=1;
                known=5
                if isempty(weakResults)
                    weakResults =[weakResults;[nameIndex s1 1]];
                else
                    namefind=find(weakResults(:,1)==nameIndex);
                    if isempty(namefind)
                        weakResults =[weakResults;[nameIndex s1 1]];
                    else
                        weakResults(namefind,2)= max(weakResults(namefind,2),s1);
                        weakResults(namefind,3)= weakResults(namefind,2)+1;
                    end
                end
            else
                unknown=2
                nameIndex = nameIndex11;
                s1=s11;s2=s12;
                identification = 0;
            end
        elseif flag1 == 1 || flag2 == 1 
            if nameIndex11==nameIndex21 && abs(sFeatures(3)>=min(DB(nameIndex11).shapeFeatures(3,:)))&&...
                    abs(sFeatures(3)<=max(DB(nameIndex11).shapeFeatures(3,:)))&&...
                    abs(tFeatures(3)<=max(DB(nameIndex11).thermalFeatures(3,:)))&&...
                    abs(tFeatures(3)>=min(DB(nameIndex11).thermalFeatures(3,:)))
                identification = 1;
                nameIndex = nameIndex21;
                s1=s11;s2=s12;
                middle=1;
                if isempty(middleResults)
                    middleResults =[middleResults;[nameIndex s1 1]];
                else
                    namefind=find(middleResults(:,1)==nameIndex);
                    if isempty(namefind)
                        middleResults =[middleResults;[nameIndex s1 1]];
                    else
                        middleResults(namefind,2)= max(middleResults(namefind,2),s1);
                        middleResults(namefind,3)= middleResults(namefind,2)+1;
                    end
                end
                known=6
            else
                if s11>s21
                    s1=s11;s2=s12;
                    nameIndex1 = nameIndex11;nameIndex2 = nameIndex12;
                else
                    s1=s21;s2=s22;
                    nameIndex1 = nameIndex21;nameIndex2 = nameIndex22;
                end
                if abs(sFeatures(3)>=min(DB(nameIndex1).shapeFeatures(3,:)))&&...
                        abs(sFeatures(3)<=max(DB(nameIndex1).shapeFeatures(3,:)))&&...
                        abs(tFeatures(3)<=max(DB(nameIndex1).thermalFeatures(3,:)))&&...
                        abs(tFeatures(3)>=min(DB(nameIndex1).thermalFeatures(3,:)))
                    identification = 1;
                    nameIndex = nameIndex1;
                    weak=1;
                    if isempty(weakResults)
                        weakResults =[weakResults;[nameIndex s1 1]];
                    else
                        namefind=find(weakResults(:,1)==nameIndex);
                        if isempty(namefind)
                            weakResults =[weakResults;[nameIndex s1 1]];
                        else
                            weakResults(namefind,2)= max(weakResults(namefind,2),s1);
                            weakResults(namefind,3)= weakResults(namefind,2)+1;
                        end
                    end
                    known=7
                else
                    unknown=3
                    nameIndex = nameIndex11;
                    s1=s11;s2=s12;
                    identification = 0;
                end
            end
        else
            if s11>s21
                s1=s11;s2=s12;
                nameIndex = nameIndex11;%nameIndex2 = nameIndex12;
            else
                s1=s21;s2=s22;
                nameIndex = nameIndex21;%nameIndex2 = nameIndex22;
            end
            unknown=4
            identification = 0;            
        end
        
    end
    count=count+1;  
    badImages=0;
    badSegmentation = 0;
    occlusions=0;
    notface =0;
    if s1>topScore
        bestImage = I;
        topScore=s1;
    end
    if count > maxNum
        break
    end
end
if  strong==1
    isp('a=1 warmly')
elseif middle==1 && size(middleResults,1)==1
    disp('a=2 warmly')
elseif middle==1 && size(middleResults,1)>1
    [v1,scorePosition]=max(middleResults(:,2));
    [v1,numberPosition]=max(middleResults(:,3));
    if scorePosition==numberPosition;
        disp('a=3 welcome')        
    else
        disp('a=4 maybe')
    end
elseif weak ==1 && size(weakResults,1)==1       
    disp('a=5 maybe')
elseif weak ==1 && size(weakResults,1)>1
    disp('a=6 Are you')
else
    disp('You are not identified')
end