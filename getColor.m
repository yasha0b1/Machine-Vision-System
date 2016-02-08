function [rbimage,gbimage,bbimage] = getColor(img)
    filterSize=3;
    filterMid=ceil(((filterSize)^2)/2);
    filterKernel=ones(filterSize,filterSize);
    iRedWorksheet=irank(img(:,:,1),filterMid,filterKernel);
    iGreenWorksheet=irank(img(:,:,2),filterMid,filterKernel);
    iBlueWorksheet=irank(img(:,:,3),filterMid,filterKernel);
    lWorksheet=iBlueWorksheet+iGreenWorksheet+iRedWorksheet;
    iredWorksheet = iRedWorksheet ./ lWorksheet;
    igreenWorksheet = iGreenWorksheet ./ lWorksheet;
    iblueWorksheet = iBlueWorksheet ./ lWorksheet;
    meanRed=mean(mean(iredWorksheet));
    meanGreen=mean(mean(igreenWorksheet));
    meanBlue=mean(mean(iblueWorksheet));
    stdRed=std(std(iredWorksheet));
    stdGreen=std(std(igreenWorksheet));
    stdBlue=std(std(iblueWorksheet));
    rbimage=iredWorksheet   > meanRed+6*stdRed     & (igreenWorksheet < meanGreen | iblueWorksheet < meanBlue);
    gbimage=igreenWorksheet > meanGreen+6*stdGreen & (iredWorksheet < meanRed | iblueWorksheet <  meanBlue);
    bbimage=iblueWorksheet  > meanBlue+6*stdBlue   & (igreenWorksheet < meanGreen | iredWorksheet < meanRed);      
    
end

