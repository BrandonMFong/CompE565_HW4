
%use getMVCoordinates for the motion vector

function MV = LogarithmicSearch(targetBlock, searchWindow)

p = 16;
imageOffset = 8;
last = false;
offset = p/2;

%Find the SAD at teh center first
SAD = getSAD(targetBlock, searchWindow(p-8:p+8,p-8:p+8));

MV = [p,p];      %center of the searchWindow 

while last ~= true
    
   for i= 1:8
    % 1.Set a search region of 8 points, each separated offset times away
    %   from the center vetically and horizontally. Include center as point
    %   9. 
        reg = getRegion(MV(1), MV(2), offset);
        
        candidateBlock = getCandidateBlock(reg(i, 1), reg(i,2), searchWindow, imageOffset);
        
    % 2. Find the point where the macroblock has the minimum MAD
        candidateSAD = getSAD(targetBlock, candidateBlock);
    
    %. 3. set MV equal to the point with the minimum MAD
        if(candidateSAD <= SAD)
            SAD = candidateSAD;
            MV(1) = reg(i, 1);
            MV(2) = reg(i, 2);
        end
   end
   
    if(offset == 1) 
        last = true;
    end
    
    offset = offset / 2;
end

end

function block = getCandidateBlock(x, y, window, offset)

    [row, column] = size(window);
    
    if(((x + offset) < row) && ((y + offset) < column) && ((x-offset) > 0) && ((y-offset) > 0))
        block = window(x-offset:x+offset,y-offset:y+offset);
    end
    
    %work in progress
    
    
end

function region = getRegion(x, y, offset)
    
   %Region 1
   region(1,1) = x - offset;
   region(1,2) = y;
   
   %Region 2
   region(2,1) = x - offset;
   region(2,2) = y - offset;
   
   
   %Region 3
   region(3,1) = x;
   region(3,2) = y - offset;
   
   %Region 4
   region(4,1) = x + offset;
   region(4,2) = y - offset;
   
   %Region 5
   region(5,1) = x + offset;
   region(5,2) = y;
   
   %Region 6
   region(6,1) = x + offset;
   region(6,2) = y + offset;
   
   %Region 7
   region(7,1) = x;
   region(7,2) = y + offset;
   
   %Region 8
   region(8,1) = x - offset;
   region(8,2) = y + offset;
   
end

function sad = getSAD(image1, image2)

    Z = imabsdiff(X,Y);
    sad = sum(Z(:));
end