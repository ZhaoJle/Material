
function OutputNum = Recognition(TestImagePath, MeanFace, MeanNormFaces, EigenFaces,flag)
%TestImagePath����ͼ���·��
%MeanFace -EigenfaceCore�������������������Բ���ͼ�����Ļ�
%MeanNormFaces -EigenfaceCore�����������������������T���µ������ռ��ֵ
%EigenFaces -EigenfaceCore��������������ӳ�����
%flag -���Ե���ͼ��ʱ����flag����1,����ȫ��ͼ������������
 
ProjectedImages = [];
Train_Number = size(MeanNormFaces,1);

%�õ�ѵ�������������µ������ռ��ֵ
for i = 1 : Train_Number
    temp = (EigenFaces*MeanNormFaces(i,:)')'; 
    ProjectedImages(i,:) =temp; 
end

%�Բ���ͼƬ��ͬ�������㣬�õ������µ������ռ��λ��
InputImage = imread(TestImagePath);
VecInput=reshape(InputImage,1,size(InputImage,1)*size(InputImage,2));
MeanNormInput = double(VecInput)-MeanFace;
ProjectedTestImage = (EigenFaces*MeanNormInput')';

% �������ͼ��λ����ÿ������ͼ�����¿ռ��еĶ���������������������ľ���
% ��������С������ͼ��Ϊ��ӽ���ͼ
Euc_dist = zeros(1,280);
for i = 1 : Train_Number
    Euc_dist(i) = ( norm( ProjectedTestImage - ProjectedImages(i,:) ) )^2;
end
[Euc_dist_min , Recognized_index] = min(Euc_dist);
OutputNum=(Recognized_index-1)/7+1;
%������
if  flag==1
    figure,
    subplot(121);
    imshow(InputImage,[]);
    title('��������');
    subplot(122);
    imshow(reshape((MeanNormFaces(Recognized_index,:)+MeanFace),112,92),[]);
    title(strcat('���������������:',int2str(floor((Recognized_index-1)/7+1))));
end


