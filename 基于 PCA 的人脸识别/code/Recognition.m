
function OutputNum = Recognition(TestImagePath, MeanFace, MeanNormFaces, EigenFaces,flag)
%TestImagePath测试图像的路径
%MeanFace -EigenfaceCore函数的输出结果，用来对测试图像中心化
%MeanNormFaces -EigenfaceCore函数的输出结果，用来求矩阵T在新的特征空间的值
%EigenFaces -EigenfaceCore函数的输出结果，映射矩阵
%flag -测试单张图像时参数flag输入1,测试全部图像输入其他数
 
ProjectedImages = [];
Train_Number = size(MeanNormFaces,1);

%得到训练样本矩阵在新的特征空间的值
for i = 1 : Train_Number
    temp = (EigenFaces*MeanNormFaces(i,:)')'; 
    ProjectedImages(i,:) =temp; 
end

%对测试图片做同样的运算，得到它在新的特征空间的位置
InputImage = imread(TestImagePath);
VecInput=reshape(InputImage,1,size(InputImage,1)*size(InputImage,2));
MeanNormInput = double(VecInput)-MeanFace;
ProjectedTestImage = (EigenFaces*MeanNormInput')';

% 求出测试图像位置与每个样本图像在新空间中的二范数，即这两个向量间的距离
% 二范数最小的样本图像为最接近的图
Euc_dist = zeros(1,280);
for i = 1 : Train_Number
    Euc_dist(i) = ( norm( ProjectedTestImage - ProjectedImages(i,:) ) )^2;
end
[Euc_dist_min , Recognized_index] = min(Euc_dist);
OutputNum=(Recognized_index-1)/7+1;
%输出结果
if  flag==1
    figure,
    subplot(121);
    imshow(InputImage,[]);
    title('输入人脸');
    subplot(122);
    imshow(reshape((MeanNormFaces(Recognized_index,:)+MeanFace),112,92),[]);
    title(strcat('最相似人脸，类别:',int2str(floor((Recognized_index-1)/7+1))));
end


