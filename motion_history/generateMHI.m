function [mhi] = generateMHI(video, back_frame, show)
  
% Input frames with VideoReader

inputObj = VideoReader(video); %video
nFrames = inputObj.NumberOfFrames;
[x, y] = size(back_frame);
foreground2 = zeros(x,y);

%get the motion energy image with threshold of 50
for k1 = 1:nFrames
    
    foreground1 = abs(double(back_frame) - double(rgb2gray(read(inputObj, k1))));
    foreground1 = uint8(foreground1);
   
    for i=1:x
        for j=1:y
            if foreground1(i,j) < 30
                foreground1(i,j) = 0;
           end
            foreground2(i,j)= uint8(foreground2(i,j) + 0.8* foreground1(i,j) - 2);
         end
    end

    if show
        figure(4);
        imshow(uint8(foreground2));
    end
end

mhi = uint8(foreground2);
%store the motion history image
% imwrite(mhi, 'motion_history_image.jpg');
end

