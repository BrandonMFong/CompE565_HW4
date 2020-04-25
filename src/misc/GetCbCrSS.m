function [CBsubsample, CRsubsample] = GetCbCrSS(Frame)
    const = Constants();
    CBsubsample = Frame(1:2:end,1:2:end,const.Cb);  
    CRsubsample = Frame(1:2:end,1:2:end,const.Cr);  
end