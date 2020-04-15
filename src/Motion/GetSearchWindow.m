
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

%%% DEPRECATED %%% 
function out = GetMatrix(Matrix,Location)
    const = Constants();
    [row,col]=size(Matrix);
    NewMatrix = zeros(const.SWSize,const.SWSize);
    var1 = (const.SWSize - const.MacroBSize)/2; % 8
    var2 = const.MacroBSize + (const.SWSize - const.MacroBSize)/2; % 24

    % if we are on the corners
    if(col < const.SWSize) && (row < const.SWSize) % this is the case if the col/row are both 24 long

        % if we are on the top left corner
        if(Location == const.TopLeft)
            NewMatrix = [zeros(var2,var1) Matrix]; 
            out = [zeros(var1,const.SWSize);NewMatrix];

        % if we are on the bottom left corner
        elseif (Location == const.BottomLeft)
            NewMatrix = [zeros(var2,var1) Matrix];
            out = [NewMatrix;zeros(var1,const.SWSize)];

        % if we are on the top rigth corner
        elseif (Location == const.TopRight)
            NewMatrix = [Matrix zeros(var2,var1)]; 
            out = [zeros(var1,const.SWSize);NewMatrix];
            
        % if we are on the bottom right corner
        elseif(Location == const.BottomRight)
            NewMatrix = [Matrix zeros(var2,var1)];
            out = [NewMatrix;zeros(var1,const.SWSize)];

        else 
            fprintf("Something didn't go right");
        end
    else
        % if we are on the left side
        if(Location == const.Left)
            out = [zeros(var1,const.SWSize) NewMatrix];

        % if we are on the right side
        elseif(Location == const.Right)
            out = [NewMatrix zeros(var1,const.SWSize)];
        
        % if we are on the top side
        elseif(Location == const.Top)
            out = [zeros(var1,const.SWSize);NewMatrix];

        % if we are on the bottom side
        elseif(Location == const.Bottom)
            out = [NewMatrix;zeros(var1,const.SWSize)];

        else 
            fprintf("Something didn't go right");
        end
    end
end
