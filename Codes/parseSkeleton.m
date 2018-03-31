function [ mainData ] = parseSkeleton( dataFile, frameNum )
%PARSESKELETON parses and converts skeleton info to 2D Pixel values
%   Skeleton info has orientation and it is not useful all the time.
%   Function gets the position values of joints. 
%   xyz values will be converted to 2D Pixel. 

fprintf('Parse skeleton!!\n');

fprintf(' Skeleton data file: %s\n', dataFile);
fprintf(' Frame number: %d\n', frameNum);

% return value. Since there 2 data arrays, indexMain is out of loop
% From 1 to 15, indexes means x-y pixel values. 
% mainData(index,1) -> x, mainData(index,2) -> y
%  Index number -> Joint name
%     1 -> HEAD
%     2 -> NECK
%     3 -> TORSO
%     4 -> LEFT_SHOULDER
%     5 -> LEFT_ELBOW
%     6 -> RIGHT_SHOULDER
%     7 -> RIGHT_ELBOW
%     8 -> LEFT_HIP
%     9 -> LEFT_KNEE
%    10 -> RIGHT_HIP
%    11 -> RIGHT_KNEE
%    12 -> LEFT_HAND
%    13 -> RIGHT_HAND
%    14 -> LEFT_FOOT
%    15 -> RIGHT_FOOT

mainData = zeros(15,2);
indexMain=1;

if ~exist(dataFile,'file'),
    error('FILE DOES NOT EXIST! CHECK FILE PATH AND FILE NAME!'); 
else
    figureTitle = strcat(dataFile, ' (frame:', int2str(frameNum),')');
    [data,datapos] = readSkeleton(dataFile,frameNum, figureTitle);
    %img = imread('path to the image');
    
    % 3D to 2DPixels
    for i=1:11,
        x = 156.8584456124928 + 0.0976862095248 * data(i,11) - 0.0006444357104 * data(i,12) + 0.0015715946682 * data(i,13)
        y = 125.5357201011431 + 0.0002153447766 * data(i,11) - 0.1184874093530 * data(i,12) - 0.0022134485957 * data(i,13)
        mainData(indexMain,1) = x;
        mainData(indexMain,2) = y;
        indexMain = indexMain +1;
        %fprintf('i->%d, j-> %d for data -> x-> %f, y-> %f\n',i,j,x,y);
    end
    for i=1:4,
        x = 156.8584456124928 + 0.0976862095248 * datapos(i,1) - 0.0006444357104 * datapos(i,2) + 0.0015715946682 * datapos(i,3)
        y = 125.5357201011431 + 0.0002153447766 * datapos(i,1) - 0.1184874093530 * datapos(i,2) - 0.0022134485957 * datapos(i,3)
        mainData(indexMain,1) = x;
        mainData(indexMain,2) = y;
        indexMain = indexMain +1;
        %fprintf('i->%d for datapos -> x-> %f, y-> %f\n',i,x,y);
    end
    
    %For image show
    %imshow(img);
    %impixelregion
    
    %for i=1:15,
    %    fprintf('i->%d for joints -> x-> %f, y-> %f\n',i,mainData(i,1),mainData(i,2));
    %end
    
    
    
    
    
    return
end


end

