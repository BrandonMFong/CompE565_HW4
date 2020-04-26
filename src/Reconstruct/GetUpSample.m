
function out = GetUpSample(luma,Cb,Cr) % Replication
    const = Constants();
    Frame = luma; % init just to ensure dimensions           
    Frame(1:2:end,1:2:end,const.Cb) = Cb;
    Frame(1:2:end,1:2:end,const.Cr) = Cr;
    [rows,columns] = size(Frame(:,:,const.Y));
    for r = 1:rows
        for c = 1:columns
            % if we are in an odd row and it's an even column
            if ((mod(c, 2) == 0) && mod(r, 2) ~= 0)
                % copying the value from the column before index
                Frame(r,c,const.Cr) = Frame(r,c-1,const.Cr);
                Frame(r,c,const.Cb) = Frame(r,c-1,const.Cb);
            % if it is an even row
            elseif (mod(r, 2) == 0)
                % copies the entire previous row
                Frame(r,:,const.Cr) = Frame(r-1,:,const.Cr);
                Frame(r,:,const.Cb) = Frame(r-1,:,const.Cb);
            end
        end
    end
    out = uint8(Frame);
end