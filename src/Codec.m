const = Constants();
%%% Get Video %%%
global VideoVar;
VideoVar = GetVideo();

%%% Get Frame %%%
[RefFrame_rbg, RefFrame_ycbcr] = GetFramesFromVid(const.RefNum); % Find imgages in output folder

% Get frame by frame 
% Using a slice size of one just for simplicity
for index = const.RefNum+1:(const.RefNum + (const.GOPSize-1))

    %%% Get Frame %%%
    [CurrFrame_rbg, CurrFrame_ycbcr] = GetFramesFromVid(6); % Find imgages in output folder
    
    %%% SubSample %%%
    CurrFrame_y = CurrFrame_ycbcr(:,:,const.Y);
    CurrFrame_cbcr = GetCbCrSS(Frame_ycbcr);
    
    %%% Motion Estimation %%%
    [Y_vectorX, Y_vectorY, Y_error] = Search(RefFrame(:,:,const.Y),CurrFrame_y);
    [Cb_vectorX, Cb_vectorY, Cb_error] = Search(RefFrame(:,:,const.Y),CurrFrame_cbcr(:,:,const.Cb));
    [Cr_vectorX, Cr_vectorY, Cr_error] = Search(RefFrame(:,:,const.Y),CurrFrame_cbcr(:,:,const.Cr));
    
    %%% DCT %%% 

    %%% Quantize %%%

    %%% Inverse Quantize %%%

    %%% Inverse DCT %%%
     
    %%% 
    
end
