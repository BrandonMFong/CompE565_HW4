
function out = GetSearchWindow(Frame,RowMax,RowMin,ColumnMax,ColumnMin)
    % RowMax : Max index for row 
    % RowMin : Min index for row 
    % ColumnMax : Max index for column
    % ColumnMin : Min index for column

    const = Constants();
    var1 = (const.SWSize - const.MacroBSize)/2; % 8
    var2 = const.MacroBSize + (const.SWSize - const.MacroBSize)/2; % 24
    [MaxRowBound,MaxColumnBound] = size(Frame); % For testing if MB is on the right or bottom edges

    % If the intervals are out of range, append the search window with zeroes

    % At corners
    if ((RowMin - var1) < 1) && ((ColumnMin - var1) < 1) % Top left
        out = Frame( 1:var2 , 1:var2 );

    elseif ((RowMax + var1) > MaxRowBound) && ((ColumnMin - var1) < 1) % Bottom left
        out = Frame( (MaxRowBound-var2):MaxRowBound , 1:var2 );

    elseif ((RowMin - var1) < 1) && ((ColumnMax + var1) > MaxColumnBound) % Top right
        out = Frame ( 1:var2 , (MaxColumnBound-var2):MaxColumnBound );

    elseif ((RowMax + var1) > MaxRowBound) && ((ColumnMax + var1) > MaxColumnBound) % Bottom right
        out = Frame ( (MaxRowBound-var2):MaxRowBound , (MaxColumnBound-var2):MaxColumnBound );

    % If we got this far, we are not in any of the corners
    % At edges
    elseif((ColumnMin - var1) < 1) % Left edge
        out = Frame ( RowMin-var1:RowMax+var1 , 1:var2 );

    elseif((ColumnMax + var1) > MaxColumnBound) % Right edge
        out = Frame ( RowMin-var1:RowMax+var1 , (MaxColumnBound-var2):MaxColumnBound );

    elseif((RowMin - var1) < 1) % Top edge
        out = Frame ( 1:var2, ColumnMin-var1:ColumnMax+var1 );

    elseif((RowMax + var1) > MaxRowBound) % Bottom edge
        out = Frame ( (MaxRowBound-var2):MaxRowBound , ColumnMin-var1:ColumnMax+var1 );
        
    % When Macroblock is in the middle of the frame
    else % when the search window does not overlap with the edges
        out = Frame((RowMin-var1):(RowMax+var1),(ColumnMin-var1):(ColumnMax+var1));
    end
end
