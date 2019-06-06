function ac = test(MeanFace, MeanNormFaces, EigenFaces)
%≤‚ ‘À˘”–Õº∆¨
n=0;
for j=1:40
    str='';
    str = strcat('att_faces','\s',int2str(j),'\');
    for i=8:10
      tmpstr='';
      tmpstr=strcat(str,int2str(i),'.pgm');
      result=floor(Recognition(tmpstr, MeanFace, MeanNormFaces, EigenFaces,0));
      if(result==j)
          n=n+1;
      end
    end
end
ac=n/120;
end

