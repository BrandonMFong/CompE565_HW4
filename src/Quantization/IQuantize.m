
function out = IQuantize(Frame, QuantizationMatrix,var)
    [rows, columns] = size(Frame); 
    Q = zeros(rows,columns);

    qX = 1;
    qY = 1;

    StatusRow = waitbar(0,sprintf('Inverse Quantizing [%s]',var));

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
        
        waitbar((x)/(rows),StatusRow,sprintf('Quantizing [%s]',var))
    end
    close(StatusRow);
    
    out = Q;
end