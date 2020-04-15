% Reconstructed RGB Image. (Note: This image should not look very different from the original) (10 points)
% • Display the Error Image (by subtracting the reconstructed image form the original) for the luminance image. (10 points)
% • PSNR for the luminance component of the decoded image. (10 points)

% Upsample
NewImgYCbCr = GetUpSample(Inverse_QDCT_Y,Inverse_QDCT_CbCr);

NewImgRGB = ycbcr2rgb(NewImgYCbCr);
figure, imshow(NewImgYCbCr);title('New Image [YCbCr]');
figure, imshow(NewImgRGB);title('New Image [RGB]');

OriginalImgRGB = imread('Flooded_house.jpg','jpg');

DiffImg = GetDifference(OriginalImgRGB,NewImgRGB);
figure, imshow(DiffImg);title('Difference Image');

PSNRValue = GetPSNR(OriginalImgRGB,NewImgRGB);

fprintf('Y PSNR %f\n', PSNRValue(:,:,const.Y));
fprintf('Cb PSNR %f\n', PSNRValue(:,:,const.Cb));
fprintf('Cr PSNR %f\n', PSNRValue(:,:,const.Cr));

%%%% Debug %%%%
PSNR_Y = PSNRValue(:,:,const.Y);
PSNR_Cb = PSNRValue(:,:,const.Y);
PSNR_Cr = PSNRValue(:,:,const.Y);