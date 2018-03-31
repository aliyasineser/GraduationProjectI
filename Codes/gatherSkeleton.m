function [ output_args ] = gatherSkeleton( directory_path, skeleton_file, dirName , outDir)
%GATHERSKELETON Summary of this function goes here
%   Detailed explanation goes here
%   directory_path -> path that includes RGB_x.png files
%   skeleton_file -> path of the text file that includes skeleton info of the
%   corresponding RGB_x.png file
    mkdir(outDir)
    skFile = fopen(skeleton_file);
    n = 0;
    tline = fgetl(skFile);
    while ischar(tline)
      tline = fgetl(skFile);
      n = n+1;
    end
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
    for frame=1:100:300
        parsedSkeleton = parseSkeleton(skeleton_file, frame);
        rgbFileDir = strcat(outDir,'/RGB_',int2str(frame));
        mkdir(  rgbFileDir );
        pngFile = strcat(directory_path,'/RGB_',int2str(frame),'.png');
        partitionAugmentation( pngFile, parsedSkeleton(1,1), parsedSkeleton(1,2), strcat(rgbFileDir,'/head'), strcat(dirName,'_RGB_',int2str(frame)) );
        partitionAugmentation( pngFile, parsedSkeleton(2,1), parsedSkeleton(2,2), strcat(rgbFileDir,'/neck'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(3,1), parsedSkeleton(3,2), strcat(rgbFileDir,'/torso'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(4,1), parsedSkeleton(4,2), strcat(rgbFileDir,'/leftShoulder'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(5,1), parsedSkeleton(5,2), strcat(rgbFileDir,'/leftElbow'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(6,1), parsedSkeleton(6,2), strcat(rgbFileDir,'/rightShoulder'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(7,1), parsedSkeleton(7,2), strcat(rgbFileDir,'/rightElbow'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(8,1), parsedSkeleton(8,2), strcat(rgbFileDir,'/leftHip'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(9,1), parsedSkeleton(9,2), strcat(rgbFileDir,'/leftKnee'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(10,1), parsedSkeleton(10,2), strcat(rgbFileDir,'/rightHip'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(11,1), parsedSkeleton(11,2), strcat(rgbFileDir,'/rightKnee'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(12,1), parsedSkeleton(12,2), strcat(rgbFileDir,'/leftHand'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(13,1), parsedSkeleton(13,2), strcat(rgbFileDir,'/rightHand'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(14,1), parsedSkeleton(14,2), strcat(rgbFileDir,'/leftFoot'), strcat(dirName,'_RGB_',int2str(frame)));
        partitionAugmentation( pngFile, parsedSkeleton(15,1), parsedSkeleton(15,2), strcat(rgbFileDir,'/rightFoot'), strcat(dirName,'_RGB_',int2str(frame)));
        
    end
    fprintf('ALL DONE.\n');
    
end

