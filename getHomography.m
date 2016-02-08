function [H,p2] = getHomography(blueBlob,p1)

    %mapping of blue points to coordinates
    bp=[blueBlob.uc',blueBlob.vc']';
    %calculate square coordinates enclosing all points
    umin=min(bp(1,:));
    umax=max(bp(1,:));
    vmin=min(bp(2,:));
    vmax=max(bp(2,:));
    blueBox=[umin,umin,umax,umax
             vmin,vmax,vmax,vmin];


    %returns counter clockwise order list of corners from bp
    blueCorner=convhull(bp(2,:),bp(1,:),'simplify',true);
    blueCorner=blueCorner(1:4);
    k=setdiff(1:length(bp),blueCorner);
    %be is a subset of bp containing edges and center point
    be=bp(:,k);
    %returns counter clockwise order list of edges from be
    k=convhull(be(2,:),be(1,:));
    [~,~,blueEdge] = intersect(be(:,k)',bp','rows','stable');
    %middle blue point. everything but corners and edges
    blueMiddle=setdiff(1:length(bp),union(blueCorner,blueEdge));
    H=homography(bp(:,blueCorner(1:4)'), blueBox);
    %standardise each blue points of the image plane and find the largest
    maxoutArea=0;
    for i=1:length(blueEdge)
        bbox=[blueBlob(blueEdge(i)).bbox];
        bluebbox=[bbox(1,1),bbox(1,1),bbox(1,2),bbox(1,2)
                  bbox(2,1),bbox(2,2),bbox(2,2),bbox(2,1)];
        out=homtrans(H, bluebbox);
        [~,outArea]=convhull(out(2,:),out(1,:));
        if outArea >maxoutArea
            maxoutArea=outArea;
            bigblueIndex=i;
        end
    end
    %order edge points starting with big blue 
    lBlueEdge=length(blueEdge);
    i=0:(lBlueEdge-1);
    l=mod(bigblueIndex-1+i,lBlueEdge)+1;
    blueEdge=blueEdge(l);
    H=homography(bp(:,blueEdge(1:4)'), p1(:,[2 4 6 8]));
    %standardise each blue corner points of the image plane and find top left
    Hbp=homtrans(H, bp(:,blueCorner));
    [~,topLeftIndex]=min(Hbp(1,:)+Hbp(2,:));
    %order corner points starting with top left 
    lblueCorner=length(blueCorner);
    i=0:(lblueCorner-1);
    l=mod(topLeftIndex-1+i,lblueCorner)+1;
    blueCorner=blueCorner(l);

    C = [blueCorner,blueEdge]';
    pindex = [C(:);blueMiddle];

    p2=bp(:,pindex');
    H=homography(bp(:,[blueCorner;blueMiddle]'), p1(:,[1 3 5 7 9]));

end