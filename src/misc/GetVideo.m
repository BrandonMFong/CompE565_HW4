
function out = GetVideo()
    fmtList = VideoReader.getFileFormats();
    if any(ismember({fmtList.Extension},'avi'))
        disp('VideoReader can read AVI files on this system.');
    else
        error('VideoReader cannot read AVI files on this system.');
    end
    out = VideoReader('walk_qcif.avi');
end