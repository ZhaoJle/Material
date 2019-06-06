function [MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,K)
%T为所有训练样本图像组成的矩阵
%K为取的特征值数量
%MeanFace为对T每列求均值的结果，用于中心化
%MeanNormFaces为T中心化的结果
%EigenFaces为新的特征空间的映射矩阵。

MeanFace=mean(T,1);
TrainNumber=size(T,1);
%中心化
MeanNormFaces=[];
for i=1:TrainNumber
    MeanNormFaces(i,:)=double(T(i,:)-MeanFace);
end

%求出特征值和特征矩阵
L=MeanNormFaces*MeanNormFaces'; 
[E,D] = eigs(L,K);
eigenValue1=fliplr(D);
eigenVector1=MeanNormFaces'*E;
%得到最后的映射矩阵
for i=1:K
    EigenFaces(i,:)=eigenVector1(:,i)';
end
end


