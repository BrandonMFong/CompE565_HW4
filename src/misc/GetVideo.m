
function out = GetVideo()
    fmtList = VideoReader.getFileFormats();
    if any(ismember({fmtList.Extension},'avi'))
        disp('SYSTEM CHECK: VideoReader can read AVI files!');
    else
        error('SYSTEM CHECK: VideoReader cannot read AVI files!');
    end
    out = VideoReader('walk_qcif.avi');
end