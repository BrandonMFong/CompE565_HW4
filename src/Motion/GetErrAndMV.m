function [rowPoints, colPoints, errorFrame] = GetErrAndMV(RefFrame, CurrFrame)
    const = Constants();
    [MaxRefRowBound, MaxRefColBound] = size(RefFrame);
    [MaxCurrRowBound, MaxCurrColBound] = size(CurrFrame);

    if( (MaxRefRowBound ~= MaxCurrRowBound) || (MaxRefColBound ~= MaxCurrColBound))
        fprintf(const.DimNoMatch);
        return;
    end
    
    MaxRow = const.MacroBSize;
    MaxCol = const.MacroBSize;

    n = 1;
    
    % Taking some of the bound checks from hw2 GetDCT.m
    for MinRow = 1:const.MacroBSize:MaxRefRowBound
        
        if(MaxRow > MaxRefRowBound) 
            break; 
        end 
        
        m = 1;
        
        for MinCol = 1:const.MacroBSize:MaxRefColBound
            if (MaxCol > MaxRefColBound) 
                MaxCol = const.MacroBSize; 
                if(MaxCol < MinCol)
                    % Here I'm disregarding the left over 7 column indexes
                    % This only happens when I'm passing Cb/Cr frames
                    break;
                end
            end 

            % targetBlock = CurrFrame(MinRow:MaxRow, MinCol:MaxCol)
            % GetSearchWindow(Frame,RowMax,RowMin,ColumnMax,ColumnMin)
            [MV, blockError] = getMVCoordinates(CurrFrame(MinRow:MaxRow, MinCol:MaxCol), uint8(GetSearchWindow(RefFrame,MaxRow,MinRow,MaxCol,MinCol)));

            errorFrame(MinRow:MinRow+(const.MacroBSize-1), MinCol:MinCol+(const.MacroBSize-1)) = blockError(:,:);
            % when search widows can be 24x24, 24x32, 32x24, 32x32
            rowPoints(n, m) = MV(1);
            colPoints(n, m) = MV(2);

           m = m + 1; 
            
            MaxCol = MaxCol + const.MacroBSize;
        end
        MaxRow = MaxRow + const.MacroBSize;
        
        n = n + 1;
    end

end
