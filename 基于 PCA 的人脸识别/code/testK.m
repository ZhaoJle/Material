function ac = testK(T)
%测试不同的K值
ac=zeros(1,100);
[MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,1);
ac(1)=test(MeanFace, MeanNormFaces, EigenFaces);
ac(1)
for i=2:2:10
    [MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,i);
    ac(i)=test(MeanFace, MeanNormFaces, EigenFaces);
    ac(i)
end

for i=15:5:50
    [MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,i);
    ac(i)=test(MeanFace, MeanNormFaces, EigenFaces);
    ac(i)
end

for i=50:10:100
    [MeanFace, MeanNormFaces, EigenFaces] = EigenfaceCore(T,i);
    ac(i)=test(MeanFace, MeanNormFaces, EigenFaces);
    ac(i)
end

for i=2:100
    if ac(i)==0
        ac(i)=ac(i-1);
    end
end

end

