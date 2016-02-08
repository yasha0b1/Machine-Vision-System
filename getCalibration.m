function Object=getCalibration(Object,count)
    Object=iclean(Object);
    blob=iblobs(Object,'touch',0);
    sortedArea=sort(blob.area,'descend');
    Object=blob(blob.area>=sortedArea(count));
end