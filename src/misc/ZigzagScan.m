
%It takes an 8x8 matrix and does a zigzag scan of it and returns a 1D vetor
%from the fist element to the last non-zero element. 

function out = ZigzagScan(block)

array = zeros(1, 64);

index = 2;

startX = 1;
startY = 2;

%Add the first element of the matrix into the array
array(1,1) = block(1,1);

for i = 2:14
    endX = startY;  %Set the values of the last (x,y) coordinate
    endY = startX;  
    
    while true      %Add all elements in (x,y) coordinates to the array
        array(1, index) = block(startX, startY); index = index + 1;
        
        if((startX == endX) && (startY == endY)) 
            break; 
        end
        
        
        if(startX < endX)           %If the x-coordinate starts at 1,
            startX = startX + 1;    %it will increment until it reaches
            startY = startY - 1;    %endX value and the y-coordinate will
        else                        %decrease until it reaches 1
            
            startX = startX - 1;    %Here the x-coordinate decreases while
            startY = startY + 1;    %while the y-coordinate increases
        end
    end
    
    %Setting the start and end points
    if(i < 8)
        if(startX == 1) 
            startY = startY + 1;
        else
            startX = startX + 1; 
        end
    else 
        if(startX == 8) 
            startY = startY + 1;
        else
            startX = startX + 1;
        end
    end
end

array(1,64) = block(8,8);

lastNonZero = 64;

%Finding the index of the last non-zero number
while(lastNonZero > 1 && array(1,lastNonZero) == 0)
    lastNonZero = lastNonZero - 1;
end

out = zeros(1, lastNonZero);
out(1,:) = array(1, 1:lastNonZero);

end