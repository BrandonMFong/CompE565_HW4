const = Constants();
%%% Get Video %%%
global VideoVar;
VideoVar = GetVideo();

%%% Get Frame %%%
[RefFrame_rbg, RefFrame_ycbcr] = GetFramesFromVid(const.RefNum); % Find imgages in output folder

% Get frame by frame 
for index = const.RefNum:(const.RefNum + (const.GOPSize-1))

    %%% Get Frame %%%
    [Frame_rbg, Frame_ycbcr] = GetFramesFromVid(6); % Find imgages in output folder
    
    %%% SubSample %%%
    Frame_y = Frame_ycbcr(:,:,const.Y);
    Frame_cbcr = GetCbCrSS(Frame_ycbcr);
    
    %%% Motion Estimation %%%
    
    
    %%% DCT %%% 

    %%% Quantize %%%

    %%% Inverse Quantize %%%

    %%% Inverse DCT %%%
     
    %%% 
    
end
