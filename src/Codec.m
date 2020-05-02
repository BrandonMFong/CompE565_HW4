const = Constants();
%%% Get Video %%%
global VideoVar;
VideoVar = GetVideo();

%%% Get Frame %%%
[RefFrame_rbg, RefFrame_ycbcr] = GetFramesFromVid(const.RefNum); % Find imgages in output folder
[RefFrame_CBSS, RefFrame_CRSS] = GetCbCrSS(RefFrame_ycbcr);

GroupOfFrames = cell(const.GOPSize - 1,1);

% Get frame by frame 
% Using a slice size of one just for simplicity
for index = const.RefNum+1:(const.RefNum + (const.GOPSize-1))

    %%% Get Frame %%%
    [CurrFrame_rbg, CurrFrame_ycbcr] = GetFramesFromVid(index); % Find imgages in output folder
    
    %%% Partition & SubSample %%%
    CurrFrame_y = CurrFrame_ycbcr(:,:,const.Y);
    [CurrFrame_CBSS, CurrFrame_CRSS] = GetCbCrSS(CurrFrame_ycbcr);
    
    %%% Motion Estimation %%%
    [Y_vectorX, Y_vectorY, Y_DiffFrame] = GetErrAndMV(RefFrame_ycbcr(:,:,const.Y),CurrFrame_y);

    [X, Y] = meshgrid(1:11, 1:9);
    
    %Display Motion Vectors
    figure();
    quiver(X, Y, Y_vectorX(:,:), Y_vectorY(:,:));
    title(['Motion Vector [Frame ', num2str(index),']']);
    
    % Do I need to care for Cb/Cr?
    % I dont think you do because we are only dealing with the Y-component
    % in motionestimation
    
    % [Cb_vectorX, Cb_vectorY, Cb_error] = GetErrAndMV(RefFrame_CBSS,CurrFrame_CBSS);
    % [Cr_vectorX, Cr_vectorY, Cr_error] = GetErrAndMV(RefFrame_CRSS,CurrFrame_CRSS);
    
    %%% DCT %%% 
    DCT_Cb = double(CurrFrame_CBSS); DCT_Cr = double(CurrFrame_CBSS);
    
    DCT_Y = GetDCT(Y_DiffFrame,GetVarName(Y_DiffFrame));
    DCT_Cb = GetDCT(CurrFrame_CBSS,GetVarName(CurrFrame_CBSS));
    DCT_Cr = GetDCT(CurrFrame_CRSS,GetVarName(CurrFrame_CRSS));

    %%% Quantize %%%
    QDCT_Cb = DCT_Cb; QDCT_Cr = DCT_Cr;

    QDCT_Y = Quantize(DCT_Y,const.QuantizationMatrix,GetVarName(DCT_Y));
    QDCT_Cb = Quantize(DCT_Cb,const.QuantizationMatrix,GetVarName(DCT_Cb));
    QDCT_Cr = Quantize(DCT_Cr,const.QuantizationMatrix,GetVarName(DCT_Cr));

    %%% Inverse Quantize %%%
    IQuantized_QDCT_Cb = QDCT_Cb; IQuantized_QDCT_Cr = QDCT_Cr;

    IQuantized_QDCT_Y = IQuantize(QDCT_Y, const.QuantizationMatrix,GetVarName(QDCT_Y));
    IQuantized_QDCT_Cb = IQuantize(QDCT_Cb, const.QuantizationMatrix,GetVarName(QDCT_Cb));
    IQuantized_QDCT_Cr = IQuantize(QDCT_Cr, const.QuantizationMatrix,GetVarName(QDCT_Cr));

    %%% Inverse DCT %%%
    Inverse_QDCT_Cb = IQuantized_QDCT_Cb; Inverse_QDCT_Cr = IQuantized_QDCT_Cr;

    Inverse_QDCT_Y = GetInvDCT(IQuantized_QDCT_Y,GetVarName(IQuantized_QDCT_Y));
    Inverse_QDCT_Cb = GetInvDCT(IQuantized_QDCT_Cb,GetVarName(IQuantized_QDCT_Cb));
    Inverse_QDCT_Cr = GetInvDCT(IQuantized_QDCT_Cr,GetVarName(IQuantized_QDCT_Cr));
     
    %%% Reconstruct predicted image %%%
    FrameTemp = GetReconstructedImg(Inverse_QDCT_Y,Inverse_QDCT_Cb,Inverse_QDCT_Cr);
    GroupOfFrames{index - const.RefNum} = ycbcr2rgb(FrameTemp);

    %%% Display %%%
    error = GroupOfFrames{index - const.RefNum};
    DisplayFrame(error);

    % TODO the frame is still the error frame, add ref to error 
    
    Image = GetReconstructedImg(uint8(Inverse_QDCT_Y) + uint8(RefFrame_ycbcr),Inverse_QDCT_Cb,Inverse_QDCT_Cr);
    DisplayFrame(ycbcr2rgb(Image));
    
end
