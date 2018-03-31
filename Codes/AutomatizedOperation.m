function [ output_args ] = AutomatizedOperation( inDir, outDir )
%AUTOMATÝZEDOPERATÝON Summary of this function goes here
%   Detailed explanation goes here

    listOfItems = dir(inDir);
    for i=1:length(listOfItems)
        if exist(strcat(inDir,'/',listOfItems(i).name), 'dir')==7 && ~strcmp(listOfItems(i).name,'.') && ~strcmp(listOfItems(i).name,'..')
            fprintf('%s\n',strcat(inDir,'/',listOfItems(i).name,'.txt'));
            gatherSkeleton( strcat(inDir,'/',listOfItems(i).name), strcat(inDir,'/',listOfItems(i).name,'.txt'), listOfItems(i).name , strcat(outDir,'/',listOfItems(i).name))
        end
    end
end

