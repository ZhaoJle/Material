function [MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,K)
%TΪ����ѵ������ͼ����ɵľ���
%KΪȡ������ֵ����
%MeanFaceΪ��Tÿ�����ֵ�Ľ�����������Ļ�
%MeanNormFacesΪT���Ļ��Ľ��
%EigenFacesΪ�µ������ռ��ӳ�����

MeanFace=mean(T,1);
TrainNumber=size(T,1);
%���Ļ�
MeanNormFaces=[];
for i=1:TrainNumber
    MeanNormFaces(i,:)=double(T(i,:)-MeanFace);
end

%�������ֵ����������
L=MeanNormFaces*MeanNormFaces'; 
[E,D] = eigs(L,K);
eigenValue1=fliplr(D);
eigenVector1=MeanNormFaces'*E;
%�õ�����ӳ�����
for i=1:K
    EigenFaces(i,:)=eigenVector1(:,i)';
end
end


