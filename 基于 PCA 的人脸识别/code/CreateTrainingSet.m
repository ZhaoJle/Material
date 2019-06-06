function T = CreateTrainingSet(TrainingSetPath)
%TrainingSetPathΪͼƬ·��
%TΪ����ѵ���������ɵľ���ÿ��������һ��������
TrainFiles = dir(TrainingSetPath);
Train_Class_Number = 40;    %��������
T = [];
Each_Class_Train_Num=7;     %ÿ������ѵ����������
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
