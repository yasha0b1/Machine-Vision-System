iworksheet=iread('path\to\worksheet','gamma', 2.2);

p1=[20.6400   20.6400   20.6400  200.0250  371.4750  371.4750  371.4750  200.0250  200.0250
   20.6400  200.0250  381.0000  381.0000  381.0000  200.0250   20.6400   20.6400  200.0250];

[redObject,greenObject,blueObject]=getColor(iworksheet);

blueBlob=getCalibration(blueObject,9);
[H,p2] = getHomography(blueBlob,p1);
idisp(iworksheet);
plot_point(p2(:,2),'*g');
plot_point(p2(:,[1 3 4 5 6 7 8 9]),'*r');
redBlob = getCalibration(redObject,6);
redBlob.plot_box('g');
greenBlob = getCalibration(greenObject,6);
greenBlob.plot_box('b');
figure(2)
homwarp(H,iworksheet)
hredObject=homwarp(H, redObject);
hredObject(isnan(hredObject))=0;
hredBlob = getCalibration(hredObject,6);
[triBlobs, sqrBlobs, cirBlobs] = classifyBlob(hredBlob);
xy=homtrans(inv(H),[triBlobs.uc',triBlobs.vc']');
p1
p2
H
fprintf('==================================================================\n');
fprintf('%20s %28s %28s\n', 'Red 2D objects', 'Blob pos (px) ', 'XY pos (mm)');
fprintf('%20s %28s %28s\n','1 : small triangle',mat2str([xy(1,1),xy(2,1)],5),mat2str([triBlobs(1).vc',triBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large triangle',mat2str([xy(1,2),xy(2,2)],5),mat2str([triBlobs(2).vc',triBlobs(2).uc'],5));
xy=homtrans(inv(H),[sqrBlobs.uc',sqrBlobs.vc']');
fprintf('%20s %28s %28s\n','1 : small square',mat2str([xy(1,1),xy(2,1)],5),mat2str([sqrBlobs(1).vc',sqrBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large triangle',mat2str([xy(1,2),xy(2,2)],5),mat2str([sqrBlobs(2).vc',sqrBlobs(2).uc'],5));
xy=homtrans(inv(H),[cirBlobs.uc',cirBlobs.vc']');
fprintf('%20s %28s %28s\n','1 : small square',mat2str([xy(1,1),xy(2,1)],5),mat2str([cirBlobs(1).vc',cirBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large triangle',mat2str([xy(1,2),xy(2,2)],5),mat2str([cirBlobs(2).vc',cirBlobs(2).uc'],5));
hgreenObject=homwarp(H, greenObject);
hgreenObject(isnan(hgreenObject))=0;
hgreenBlob = getCalibration(hgreenObject,6);
[triBlobs, sqrBlobs, cirBlobs] = classifyBlob(hgreenBlob);
xy=homtrans(inv(H),[triBlobs.uc',triBlobs.vc']');
fprintf('==================================================================\n');
fprintf('%20s %28s %28s\n', 'green 2D objects', 'Blob pos (px)', 'XY pos (mm)');
fprintf('%20s %28s %28s\n','1 : small triangle',mat2str([xy(1,1),xy(2,1)],5),mat2str([triBlobs(1).vc',triBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large triangle',mat2str([xy(1,2),xy(2,2)],5),mat2str([triBlobs(2).vc',triBlobs(2).uc'],5));
xy=homtrans(inv(H),[sqrBlobs.uc',sqrBlobs.vc']');
fprintf('%20s %28s %28s\n','1 : small square',mat2str([xy(1,1),xy(2,1)],5),mat2str([sqrBlobs(1).vc',sqrBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large square',mat2str([xy(1,2),xy(2,2)],5),mat2str([sqrBlobs(2).vc',sqrBlobs(2).uc'],5));
xy=homtrans(inv(H),[cirBlobs.uc',cirBlobs.vc']');
fprintf('%20s %28s %28s\n','1 : small circle',mat2str([xy(1,1),xy(2,1)],5),mat2str([cirBlobs(1).vc',cirBlobs(1).uc'],5));
fprintf('%20s %28s %28s\n','1 : large circle',mat2str([xy(1,2),xy(2,2)],5),mat2str([cirBlobs(2).vc',cirBlobs(2).uc'],5));
