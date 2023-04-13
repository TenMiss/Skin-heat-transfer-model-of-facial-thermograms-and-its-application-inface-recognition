clear
T=[];objectFeatures =[];accumHist =[]; XProjection =[];YProjection=[];
data=load('D:\MATLAB6p5\Project\Data\Normalized data\DongYan.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I1=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF1,TF1,AH1,RM1,CM1]=imageFeatures(I1);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\EePing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I2=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF2,TF2,AH2,RM2,CM2]=imageFeatures(I2);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\HongTao.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I3=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF3,TF3,AH3,RM3,CM3]=imageFeatures(I3);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\HowLung.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I4=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF4,TF4,AH4,RM4,CM4]=imageFeatures(I4);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\JinHui.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I5=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF5,TF5,AH5,RM5,CM5]=imageFeatures(I5);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\KeJian.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I6=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF6,TF6,AH6,RM6,CM6]=imageFeatures(I6);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\LiHao.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I7=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF7,TF7,AH7,RM7,CM7]=imageFeatures(I7);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\LiJun.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I8=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF8,TF8,AH8,RM8,CM8]=imageFeatures(I8);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\LiTe.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I9=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF9,TF9,AH9,RM9,CM9]=imageFeatures(I9);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\MenHan.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I10=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF10,TF10,AH10,RM10,CM10]=imageFeatures(I10);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\PanFeng.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I11=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF11,TF11,AH11,RM11,CM11]=imageFeatures(I11);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\QiuBo.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I12=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF12,TF12,AH12,RM12,CM12]=imageFeatures(I12);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ShaoXi.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I13=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF13,TF13,AH13,RM13,CM13]=imageFeatures(I13);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ShiQian.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I14=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF14,TF14,AH14,RM14,CM14]=imageFeatures(I14);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ShouLie.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I15=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF15,TF15,AH15,RM15,CM15]=imageFeatures(I15);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\SongWei.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I16=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF16,TF16,AH16,RM16,CM16]=imageFeatures(I16);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\SuSu.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I17=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF17,TF17,AH17,RM17,CM17]=imageFeatures(I17);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\TongXiaoFeng.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I18=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF18,TF18,AH18,RM18,CM18]=imageFeatures(I18);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\TuanKiang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I19=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF19,TF19,AH19,RM19,CM19]=imageFeatures(I19);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\Venessa.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I20=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF20,TF20,AH20,RM20,CM20]=imageFeatures(I20);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\XiaoKang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I21=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF21,TF21,AH21,RM21,CM21]=imageFeatures(I21);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\XingRong.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I22=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF22,TF22,AH22,RM22,CM22]=imageFeatures(I22);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\YaoWei.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I23=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF23,TF23,AH23,RM23,CM23]=imageFeatures(I23);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ZhengGuo.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I24=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF24,TF24,AH24,RM24,CM24]=imageFeatures(I24);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ZhengHui.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I25=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF25,TF25,AH25,RM25,CM25]=imageFeatures(I25);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ZhongKang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I26=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF26,TF26,AH26,RM26,CM26]=imageFeatures(I26);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ZhuKe.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I27=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF27,TF27,AH27,RM27,CM27]=imageFeatures(I27);

data=load('D:\MATLAB6p5\Project\Data\Normalized data\ZtongLing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I28=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF28,TF28,AH28,RM28,CM28]=imageFeatures(I28);

DB=struct('Name',{'DongYan','EePing','HongTao','HowLung','JinHui','KeJian','LiHao','LiJun','LiTe','MenHan',...
        'PanFeng','QiuBo','ShaoXi','ShiQian','ShouLie','SongWei','SuSu','TongXiaoFeng','TuanKiang','Venessa',...
        'XiaoKang','XingRong','YaoWei','ZhengGuo','ZhengHui','ZhongKang','HuKe','TongLing'},...
    'Templates',{I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,I13,I14,I15,I16,I17,I18,I19,I20,I21,I22,I23,...
        I24,I25,I26,I27,I28},...
    'shapeFeatures',{SF1,SF2,SF3,SF4,SF5,SF6,SF7,SF8,SF9,SF10,SF11,SF12,SF13,SF14,SF15,SF16,SF17,SF18,...
        SF19,SF20,SF21,SF22,SF23,SF24,SF25,SF26,SF27,SF28},...
    'thermalFeatures',{TF1,TF2,TF3,TF4,TF5,TF6,TF7,TF8,TF9,TF10,TF11,TF12,TF13,TF14,TF15,TF16,TF17,...
        TF18,TF19,TF20,TF21,TF22,TF23,TF24,TF25,TF26,TF27,TF28},...
    'accumulatedHist',{AH1,AH2,AH3,AH4,AH5,AH6,AH7,AH8,AH9,AH10,AH11,AH12,AH13,AH14,AH15,AH16,AH17,AH18,...
        AH19,AH20,AH21,AH22,AH23,AH24,AH25,AH26,AH27,AH28},...
    'xProjections',{RM1,RM2,RM3,RM4,RM5,RM6,RM7,RM8,RM9,RM10,RM11,RM12,RM13,RM14,RM15,RM16,RM17,RM18,RM19,...
        RM20,RM21,RM22,RM23,RM24,RM25,RM26,RM27,RM28},...
    'yProjections',{CM1,CM2,CM3,CM4,CM5,CM6,CM7,CM8,CM9,CM10,CM11,CM12,CM13,CM14,CM15,CM16,CM17,CM18,CM19,...
        CM20,CM21,CM22,CM23,CM24,CM25,CM26,CM27,CM28}); 
save ('D:\MATLAB6p5\Project\Data\dataBase.mat','DB');
save ('D:\MATLAB6p5\Project\Data\testData.mat','T');

disp('database set up')