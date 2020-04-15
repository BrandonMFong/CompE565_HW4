% Takes the frame and partitions it by the block 
function out = GetInvDCT(Frame,var)
    ConcatFlag = false;
    const = Constants();
    [rows, columns] = size(Frame); 
    ReconstructedImg = int32(Frame); % Convert to 32 bit

    % If Frame does not have enough rows to create an 8x8 block
    if (mod(rows, 8) ~= 0)
        AddRowsNum = mod(rows,8);
        AddRowsVal = zeros(AddRowsNum, columns);
        Frame = [Frame;AddRowsVal];
        [rows, columns] = size(Frame); % Getting new size
        ConcatFlag = true;
    end

    % Init interval variables when working with blocksizeXblocksize
    RowMax = const.BlockSize;
    ColumnMax = const.BlockSize;
    
    StatusRow = waitbar(0,sprintf('Calculating Inverse DCT [%s]',var));
    for RowMin = 1:const.BlockSize:rows % sweeping rows
        if(RowMax > rows) 
            break; % Nothing left in the photo to sweep
        end % Bounding since I am inc by Blocksize
        
        for ColumnMin = 1:const.BlockSize:columns % Sweeping columns

            if (ColumnMax > columns) 
                ColumnMax = const.BlockSize; % reset
            end % Bounding since I am inc by Blocksize

            % Getting DCT Block [ReconstructedImg[Block] <= InvDCTBlock]
            Block = GetInvDCTBlock(int32(Frame(RowMin:RowMax,ColumnMin:ColumnMax)));
            ReconstructedImg(RowMin:RowMax,ColumnMin:ColumnMax) = Block;

            % Increment Column Block
            ColumnMax = ColumnMax + const.BlockSize; % bound this
        end

        % Increment Row Block
        RowMax = RowMax + const.BlockSize; % bound this

        % Progress
        waitbar((RowMin)/(rows),StatusRow,sprintf('Calculating Inverse DCT [%s]',var))
    end
    close(StatusRow)

    if (ConcatFlag) % Remove rows
        for i = 1:AddRowsNum
            [row,column] = size(ReconstructedImg);
            ReconstructedImg(row,:) = []; %removing last row
        end
    end

    out = ReconstructedImg;
end

% Scans the block and returns a pixel for every coefficient
function out = GetInvDCTBlock(PixelBlock) % PixelBlock is already 32 bit
    [rows, columns] = size(PixelBlock);
    InvDCTOutput = PixelBlock; % declare, ensures same type and size
    for i = 0:rows-1
        for j = 0:columns-1
            InvDCTOutput(i+1,j+1) = GetPixelCoefficient(i,j,PixelBlock);
        end
    end
    out = InvDCTOutput;
end

function out = GetPixelCoefficient(i,j,pixels)
    [M, N] = size(pixels);

    % Calculate the inner loop of DCT
    Loop = int32(0);
    for m = 0:(M-1)
        for n = 0:(N-1)
            var = cm_cn_handler(m,n);
            part1 = cos(((2*i + 1)*m*pi)/(2*M));
            part2 = cos(((2*j + 1)*n*pi)/(2*N));
            pix = pixels(m+1, n+1, :); % Index pixel
            Loop = Loop + int32(var.cm * var.cn * pix * part1 * part2);
        end
    end
    out = (1/4) * Loop;
end

