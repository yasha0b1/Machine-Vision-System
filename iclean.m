function clean = iclean(img)
    S = kcircle(3);
    closed = iclose(img, S);
    clean = iopen(closed, S);
end