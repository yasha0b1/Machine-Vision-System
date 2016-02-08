function [triBlobs, sqrBlobs, cirBlobs] = classifyBlob(blob)
    [~,gic]=sort(blob.circularity);
    triBlobs=blob(gic([1 2]));
    [~,gia]=sort(triBlobs.area);
    triBlobs=triBlobs(gia);
    sqrBlobs=blob(gic([3 4]));
    [~,gia]=sort(sqrBlobs.area);
    sqrBlobs=sqrBlobs(gia);
    cirBlobs=blob(gic([5 6]));
    [~,gia]=sort(cirBlobs.area);
    cirBlobs=cirBlobs(gia);
end