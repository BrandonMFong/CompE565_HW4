% Encoder: (Use 4:2:0 YCbCr component image)

% 4:2:0 SubSample
cbcrsubsample = GetCbCrSubSample(); % From GetSubSample.m
luma = GetLuma(); % From GetLuma.m

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (a) Compute the 8x8 block DCT transform coefficients of the luminance and chrominance components of the image.
    % • Please display the DCT coefficient matrix as well as image of the DCT transformed image blocks of the first 2
    % blocks in the 6th row (of blocks) from top for the luminance component. (15 points)

% Define constants in Constant.m
const = Constants();

% Debug
CbComps = cbcrsubsample(:,:,const.Cb);
CrComps = cbcrsubsample(:,:,const.Cr);

% GetDCT.m
DCT_Y = GetDCT(luma,GetVarName(luma));
DCT_CbCr = double(cbcrsubsample);
DCT_CbCr(:,:,const.Cb) = GetDCT(cbcrsubsample(:,:,const.Cb),GetVarName(cbcrsubsample));
DCT_CbCr(:,:,const.Cr) = GetDCT(cbcrsubsample(:,:,const.Cr),GetVarName(cbcrsubsample));

% Display the image
DCTBlock1 = DCT_Y(41:48,1:8);
DCTBlock2 = DCT_Y(41:48,9:16);
figure, imshow(DCTBlock1);title('DCT Image - Block 1 [Y]'); 
figure, imshow(DCTBlock2);title('DCT Image - Block 2 [Y]');


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% (b) Quantize the DCT image by using the JPEG luminance and chrominance quantizer matrix from the lecture notes.
    % • Report the following output only for the first 2 blocks in the 6th row from top of the luminance component:
        % (a) DC DCT coefficient; 
        % (b) Zigzag scanned AC DCT coefficients. (20 points)

% Quantizer.m 
QDCT_CbCr = DCT_CbCr;
QDCT_Y = Quantize(DCT_Y,const.Lum_Quant_Matrix,GetVarName(DCT_Y));
QDCT_CbCr(:,:,const.Cb) = Quantize(DCT_CbCr(:,:,const.Cb),const.Chrom_Quant_Matrix,GetVarName(DCT_CbCr));
QDCT_CbCr(:,:,const.Cr) = Quantize(DCT_CbCr(:,:,const.Cr),const.Chrom_Quant_Matrix,GetVarName(DCT_CbCr));

% b - a
IDCTBlock1 = QDCT_Y(41:48,1:8) % First block 
IDCTBlock2 = QDCT_Y(41:48,9:16) % Second block

% b - b 
vector1 = ZigzagScan(IDCTBlock1);
vector2 = ZigzagScan(IDCTBlock2);

fprintf('%d ', vector1);
fprintf('\n');
fprintf('%d ', vector2);
fprintf('\n');

%%% Debug %%%

DCT_Cb = DCT_CbCr(:,:,const.Cb);
DCT_Cr = DCT_CbCr(:,:,const.Cr);
QDCT_Cb = QDCT_CbCr(:,:,const.Cb);
QDCT_Cr = QDCT_CbCr(:,:,const.Cr);
