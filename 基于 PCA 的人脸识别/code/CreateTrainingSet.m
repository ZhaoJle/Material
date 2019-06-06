function T = CreateTrainingSet(TrainingSetPath)
%TrainingSetPath为图片路径
%T为所有训练人脸生成的矩阵，每行向量是一个人脸。
TrainFiles = dir(TrainingSetPath);
Train_Class_Number = 40;    %人脸种类
T = [];
Each_Class_Train_Num=7;     %每类用于训练的人脸数
for i = 1 : Train_Class_Number
    str='';
    str = strcat(TrainingSetPath,'\s',int2str(i),'\');
    for j=1:Each_Class_Train_Num
        tmpstr='';
        tmpstr=strcat(str,int2str(j),'.pgm');
        img=imread(tmpstr);
        if length(size(img))>2
            img=rgb2gray(img);
        end
        vecimg=double(reshape(img,1,size(img,1)*size(img,2)));
        T=cat(1,T,vecimg);
    end
end
