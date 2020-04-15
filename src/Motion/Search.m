function [rowPoints, colPoints, errorFrame] = Search(RefFrame, CurrFrame)
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
            end 

            % targetBlock = CurrFrame(MinRow:MaxRow, MinCol:MaxCol)
            % GetSearchWindow(Frame,RowMax,RowMin,ColumnMax,ColumnMin)
            [MV, blockError] = getMVCoordinates(CurrFrame(MinRow:MaxRow, MinCol:MaxCol), uint8(GetSearchWindow(RefFrame,MaxRow,MinRow,MaxCol,MinCol)));

            errorFrame(MinRow:MinRow+15, MinCol:MinCol+15) = blockError(:,:);
            
            %Adjusting coordinate for top and left edge cases (for 32x32 seach windows only)
%             if(MinRow == 1)
%                 rowPoints(n, m) = MV(1) - 8;
%             else
%                 rowPoints(n, m) = MV(1);
%             end
%             
%             if(MinCol == 1)  
%                 colPoints(n, m) = MV(2) - 8;
%             else
%                 colPoints(n, m) = MV(2);
%             end

           %when search widows can be 24x24, 24x32, 32x24, 32x32
           rowPoints(n, m) = MV(1);
           colPoints(n, m) = MV(2);

           m = m + 1; 
            
            MaxCol = MaxCol + const.MacroBSize;
        end
        MaxRow = MaxRow + const.MacroBSize;
        
        n = n + 1;
    end

end
