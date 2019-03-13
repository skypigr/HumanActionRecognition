function [bgImage, nFrames] = generateBackgroundImage(videoPath, print)
%generateBackgroundImage Summary of this function goes here
%   the background of a video can be represented by the principle
%   components of all the frames in that video
%
%   Input params:
%       @videoPath: the path of the video to be processed
%       @print: wheather or not to show intermedia info
%
%   Output params:
%      @bgImage: background image of current video
%       @nFrames: total frames in current video
    

    filename = videoPath;
    movieObj = VideoReader(filename);
    % get(movieObj);
    nFrames = movieObj.NumberOfFrames;
    width = movieObj.Width; % get image width
    height = movieObj.Height; % get image height
    D = width * height;
    X=zeros(D, nFrames);
    for i=1:nFrames
      imgRGB = read(movieObj,i); 
      inImageD=double(imgRGB(:,:,1));
      X(:,i) = inImageD(:);
    end

    if print, disp('Calculating PCA of current video'); end
    [U,~, ~] = svd(X, 'econ');


    if print, disp('Reconstructing image Using 1 principle component');end
    componentCount = 1;
    Back = U(:,1:componentCount)*(U(:,1:componentCount)'*X);
    if print, disp('Fectch image'); end
    
    bgImage = uint8(reshape(Back(:,1), height, width));
    if print, disp('Background image generated!'); end
end

