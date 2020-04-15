function out = GetYFrameFromVid(index)
    global VideoFrames; 
    const = Constants();
    temp = read(VideoFrames, index);
    out = temp(:,:,const.Y);
end
