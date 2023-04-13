clear all
load('D:\MATLAB6p5\Project\Data\dataBase.mat');
data={DB.Templates};
[p,q,r]=size(data{1});
tempData=zeros(p*q,r*length(data));
for i=1:length(data)
    a=data{i};
    tempData(:,r*(i-1)+1:r*i)=reshape(a,p*q,r);
end
[eigenFeatures,U]=eigen_train(tempData);
[FF,E]=fisher_train(eigenFeatures,length(data),r);
[width,w1,w2]=RBF_train(FF,length(data),r);
features=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{U,E,width,w1,w2});
handles.features=features;
handles.eigenFeatures=eigenFeatures;
guidata(hObject, handles);
msgbox('Training has been finished!','Message:');
