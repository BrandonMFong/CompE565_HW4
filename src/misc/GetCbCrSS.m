function out = GetCbCrSS(Frame)
    out = Frame(1:2:end,1:2:end,const.Cb:const.Cr);  
end