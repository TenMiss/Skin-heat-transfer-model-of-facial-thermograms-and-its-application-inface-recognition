clear
T=[];objectFeatures =[];accumHist =[]; XProjection =[];YProjection=[];
data=load('F:\Matlab_Programs\Project\Data\Normalized data\DongYan.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I1=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF1,TF1,AH1,RM1,CM1]=imageFeatures(I1);
BF1=bloodFeatures(I1);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\EePing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I2=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF2,TF2,AH2,RM2,CM2]=imageFeatures(I2);
BF2=bloodFeatures(I2);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\HongTao.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I3=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF3,TF3,AH3,RM3,CM3]=imageFeatures(I3);
BF3=bloodFeatures(I3);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\HowLung.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I4=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF4,TF4,AH4,RM4,CM4]=imageFeatures(I4);
BF4=bloodFeatures(I4);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\JinHui.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I5=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF5,TF5,AH5,RM5,CM5]=imageFeatures(I5);
BF5=bloodFeatures(I5);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\KeJian.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I6=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF6,TF6,AH6,RM6,CM6]=imageFeatures(I6);
BF6=bloodFeatures(I6);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\LiHao.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I7=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF7,TF7,AH7,RM7,CM7]=imageFeatures(I7);
BF7=bloodFeatures(I7);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\LiJun.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I8=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF8,TF8,AH8,RM8,CM8]=imageFeatures(I8);
BF8=bloodFeatures(I8);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\LiTe.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I9=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF9,TF9,AH9,RM9,CM9]=imageFeatures(I9);
BF9=bloodFeatures(I9);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\MenHan.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I10=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF10,TF10,AH10,RM10,CM10]=imageFeatures(I10);
BF10=bloodFeatures(I10);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\PanFeng.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I11=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF11,TF11,AH11,RM11,CM11]=imageFeatures(I11);
BF11=bloodFeatures(I11);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\QiuBo.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I12=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF12,TF12,AH12,RM12,CM12]=imageFeatures(I12);
BF12=bloodFeatures(I12);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ShaoXi.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I13=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF13,TF13,AH13,RM13,CM13]=imageFeatures(I13);
BF13=bloodFeatures(I13);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ShiQian.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I14=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF14,TF14,AH14,RM14,CM14]=imageFeatures(I14);
BF14=bloodFeatures(I14);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ShouLie.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I15=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF15,TF15,AH15,RM15,CM15]=imageFeatures(I15);
BF15=bloodFeatures(I15);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\SongWei.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I16=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF16,TF16,AH16,RM16,CM16]=imageFeatures(I16);
BF16=bloodFeatures(I16);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\SuSu.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I17=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF17,TF17,AH17,RM17,CM17]=imageFeatures(I17);
BF17=bloodFeatures(I17);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\TongXiaoFeng.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I18=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF18,TF18,AH18,RM18,CM18]=imageFeatures(I18);
BF18=bloodFeatures(I18);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\TuanKiang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I19=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF19,TF19,AH19,RM19,CM19]=imageFeatures(I19);
BF19=bloodFeatures(I19);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\Venessa.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I20=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF20,TF20,AH20,RM20,CM20]=imageFeatures(I20);
BF20=bloodFeatures(I20);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\XiaoKang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I21=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF21,TF21,AH21,RM21,CM21]=imageFeatures(I21);
BF21=bloodFeatures(I21);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\XingRong.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I22=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF22,TF22,AH22,RM22,CM22]=imageFeatures(I22);
BF22=bloodFeatures(I22);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\YaoWei.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I23=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF23,TF23,AH23,RM23,CM23]=imageFeatures(I23);
BF23=bloodFeatures(I23);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ZhengGuo.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I24=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF24,TF24,AH24,RM24,CM24]=imageFeatures(I24);
BF24=bloodFeatures(I24);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ZhengHui.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I25=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF25,TF25,AH25,RM25,CM25]=imageFeatures(I25);
BF25=bloodFeatures(I25);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ZhongKang.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I26=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF26,TF26,AH26,RM26,CM26]=imageFeatures(I26);
BF26=bloodFeatures(I26);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ZhuKe.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I27=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF27,TF27,AH27,RM27,CM27]=imageFeatures(I27);
BF27=bloodFeatures(I27);

data=load('F:\Matlab_Programs\Project\Data\Normalized data\ZtongLing.mat');
fld=fieldnames(data);
I=getfield(data,fld{1});
I28=I(:,:,1:10);
T=cat(3,T,I(:,:,11:20));
[SF28,TF28,AH28,RM28,CM28]=imageFeatures(I28);
BF28=bloodFeatures(I28);

disp('database set up')