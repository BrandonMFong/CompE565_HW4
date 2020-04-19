const = Constants();
%%% Get Video %%%
global VideoVar;
VideoVar = GetVideo();

%%% Get Frame %%%
[RefFrame_rbg, RefFrame_ycbcr] = GetFramesFromVid(const.RefNum); % Find imgages in output folder
RefFrame_cbcr_SS = GetCbCrSS(RefFrame_ycbcr);

% Get frame by frame 
% Using a slice size of one just for simplicity
for index = const.RefNum+1:(const.RefNum + (const.GOPSize-1))

    %%% Get Frame %%%
    [CurrFrame_rbg, CurrFrame_ycbcr] = GetFramesFromVid(6); % Find imgages in output folder
    
    %%% SubSample %%%
    CurrFrame_y = CurrFrame_ycbcr(:,:,const.Y);
    CurrFrame_cbcr_SS = GetCbCrSS(CurrFrame_ycbcr);
    
    %%% Motion Estimation %%%
    % Do I need to care for Cb/Cr?
    [Y_vectorX, Y_vectorY, Y_error] = GetErrAndMV(RefFrame_ycbcr(:,:,const.Y),CurrFrame_y);
    [Cb_vectorX, Cb_vectorY, Cb_error] = GetErrAndMV(RefFrame_cbcr_SS(:,:,const.SubCb),CurrFrame_cbcr_SS(:,:,const.SubCb));
    [Cr_vectorX, Cr_vectorY, Cr_error] = GetErrAndMV(RefFrame_cbcr_SS(:,:,const.SubCr),CurrFrame_cbcr_SS(:,:,const.SubCr));
    
    %%% DCT %%% 

    %%% Quantize %%%

    %%% Inverse Quantize %%%

    %%% Inverse DCT %%%
     
    %%% 
    
end
