function [RGB, YCBCR] = GetFramesFromVid(index)
    global VideoVar; 
    const = Constants();
    temp = read(VideoVar, index);
    RGB = temp(:,:,:);
    YCBCR = rgb2ycbcr(RGB);
end
