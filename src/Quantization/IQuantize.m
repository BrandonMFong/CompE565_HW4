
function out = IQuantize(Frame, QuantizationMatrix)


[rows, columns] = size(Frame); 
Q = zeros(rows,columns);

qX = 1;
qY = 1;

%This is simpler
for x = 1:rows
    for y = 1:columns
        
        Q(x, y) = Frame(x, y) * QuantizationMatrix(qX, qY);
        
        if(qY == 8) 
            qY = 0;
        end
        
        qY = qY + 1;
    end
    
    if(qX == 8) 
    	qX = 0;
    end
        
    qX = qX + 1;
    qY = 1;
end


% x = 1;
% y = 1;  %More complicated, I hate my life and it doesnt fully work :(
% 
% while(y < columns-4)
%     while(x < rows-4)
%          
%         temp = deQuantize(Frame(x:x+7, y:y+7), QuantizationMatrix, 8, 8);
%         Q(x:x+7, y:y+7) = temp(:,:);
%         
%         x = x + 8;
%     end
%     y = y + 8;
% end
% 
% if(x-rows ~= 1)
%     
% end

out = Q;

end
% 
% function out = deQuantize(block, QuantizationMatrix, X, Y)
%     
%     out = zeros(blockSize,blockSize);
%     
%     for x = 1:X
%         for y = 1:Y
%             out(x, y) = block(x, y) * QuantizationMatrix(x, y);
%         end
%     end
% end