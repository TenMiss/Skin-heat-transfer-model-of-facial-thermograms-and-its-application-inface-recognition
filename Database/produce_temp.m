clear
eigenFeatures=rand(49,50);
features=struct('name',{'eigen','fisher','RBF_width','RBF_w1','RBF_w2'},...
    'values',{rand(49,50),rand(49,50),rand(49,50),rand(49,50),rand(49,50)});
DB=struct('Name',{'Shiqian','Lijun','a','aa','aaa'},'Templates',{rand(80,60,10),...
        rand(80,60,10),rand(80,60,10),rand(80,60,10),rand(80,60,10)});
save ('D:\MATLAB6p5\Project\Data\dataBase.mat','DB');
save ('D:\MATLAB6p5\Project\Data\features.mat','features');
save ('D:\MATLAB6p5\Project\Data\eigenData.mat','eigenFeatures');

