% Design and implement the full search motion estimation technique for video compression, 
% by using the search window of 32x32 pixels, which is centered on the current macroblock. 
% Use five frames (from frame #6 to frame #10) of the given motion video ‘walk_qcif.avi, while 
% ignoring the first five and the remaining frames (note: you should extract these five video frames 
% from the sequence). In QCIF format, the frame size is 176x144 pixels and you should use 4:2:0 format. 
% Please use the IPPPP structure with GOP size of 5 frames, and predict all the P frames from the I 
% frame. You can use the SAD method for motion estimation. You are required to generate the difference 
% frame for each P-frame, and then generate the reconstructed P-frames by performing decoding.

% For this we take two frames and compare them to get calculate motion vector
% As recommended, will rough out just two frames then expand alg

const = Constants();
RefFrame = GetYFrameFromVid(const.RefNum);   %I frame
for Frame = const.RefNum+1:1:(const.RefNum+const.GOPSize-1)
    
    CurrFrame = GetYFrameFromVid(Frame);  %P frame

    % Get vectors 
    [vectorX, vectorY, error] = Search(RefFrame,CurrFrame);

    %Reconstructing Image 
    reconImage = RefFrame + error;
    
end