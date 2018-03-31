function [ outDir ] = partitionAugmentation( fileName, x, y, outDir, uniqueBase)
%PARTÝTÝONAUGMENTATÝON Summary of this function goes here
%   Detailed explanation goes here
% Image size will be cropImgSize+1 * cropImgSize+1, so you need to
% arrange that as you want. For example, for 16 by 16 images,
% cropImgSize should be 15.
cropImgSize = 15;
cropHalfSize = (cropImgSize-1)/2;

img = imread(fileName);
%imshow(img);

mkdir(outDir)



%imshow(croppedImg);
mkdir(strcat(outDir,'/0'))
croppedImg = imcrop(img, [x-cropHalfSize y-cropHalfSize cropImgSize cropImgSize]);
[row,column,page] = size(croppedImg);
croppedImg = padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );


Doubled = (cropImgSize*2+1);
DoubleHalf = (cropHalfSize*2+1);
croppedImgDoubled = imcrop(img, [x-DoubleHalf y-DoubleHalf Doubled Doubled]);
[row,column,page] = size(croppedImgDoubled);
croppedImgDoubled = padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );



Doubled2 = (Doubled*2+1);
Double2Half = (DoubleHalf*2+1);
croppedImgDoubled2 = imcrop(img, [x-Double2Half y-Double2Half Doubled2 Doubled2]);

[row,column,page] = size(croppedImgDoubled2);
croppedImgDoubled2 = padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);

Doubled3 = (Doubled2*2+1);
Double3Half = (Double2Half*2+1);
croppedImgDoubled3 = imcrop(img, [x-Double3Half y-Double3Half Doubled3 Doubled3]);

[row,column,page] = size(croppedImgDoubled3);
croppedImgDoubled3 = padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);


[row,column,page] = size(croppedImg);
if(page == 1)
    croppedImg = cat(3,croppedImg,croppedImg);
    croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
end
[row,column,page] = size(croppedImgDoubled);
if(page == 1)
    croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
    croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
end
croppedImg = imresize(croppedImg, [32 32]);
croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
smalls = cat(2,croppedImg,croppedImgDoubled);
bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);

croppedImg = cat(1,smalls,bigs);
imwrite(croppedImg, strcat(  outDir,'/0/', uniqueBase ,'_0.png'));




for i=1:cropImgSize+1
    j = -1*i;
    mkdir(strcat(outDir,'/',int2str(i) ))
    counter=1;
    while j < i
        try
            %First
            croppedImg = imcrop(img, [x-cropHalfSize-i y-cropHalfSize+j cropImgSize cropImgSize]);
            [row,column,page] = size(croppedImg);
            croppedImg = padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
            croppedImg = imresize(croppedImg, [32 32]);
            
            Doubled = (cropImgSize*2+1);
            DoubleHalf = (cropHalfSize*2+1);
            croppedImgDoubled = imcrop(img, [x-DoubleHalf-i y-DoubleHalf+j Doubled Doubled]);
            
            [row,column,page] = size(croppedImgDoubled);
            croppedImgDoubled = padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            
            Doubled2 = (Doubled*2+1);
            Double2Half = (DoubleHalf*2+1);
            croppedImgDoubled2 = imcrop(img, [x-Double2Half-i y-Double2Half+j Doubled2 Doubled2]);
            
            [row,column,page] = size(croppedImgDoubled2);
            croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
            croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
            
            Doubled3 = (Doubled2*2+1);
            Double3Half = (Double2Half*2+1);
            croppedImgDoubled3 = imcrop(img, [x-Double3Half-i y-Double3Half+j Doubled3 Doubled3]);
            
            [row,column,page] = size(croppedImgDoubled3);
            croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
            croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
            
            [row,column,page] = size(croppedImg);
            if(page == 1)
                croppedImg = cat(3,croppedImg,croppedImg);
                croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
            end
            [row,column,page] = size(croppedImgDoubled);
            if(page == 1)
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
            end
            croppedImg = imresize(croppedImg, [cropImgSize+1 cropImgSize+1]);
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            smalls = cat(2,croppedImg,croppedImgDoubled);
            bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
            
            croppedImg = cat(1,smalls,bigs);
            imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
            
            %Second
            counter = counter+1;
            croppedImg = imcrop(img, [x-cropHalfSize+j y-cropHalfSize-i cropImgSize cropImgSize]);
            [row,column,page] = size(croppedImg);
            croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
            croppedImg = imresize(croppedImg, [32 32]);
            
            Doubled = (cropImgSize*2+1);
            DoubleHalf = (cropHalfSize*2+1);
            croppedImgDoubled = imcrop(img, [x-DoubleHalf+j y-DoubleHalf-i Doubled Doubled]);
            
            [row,column,page] = size(croppedImgDoubled);
            croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            
            Doubled2 = (Doubled*2+1);
            Double2Half = (DoubleHalf*2+1);
            croppedImgDoubled2 = imcrop(img, [x-Double2Half+j y-Double2Half-i Doubled2 Doubled2]);
            
            [row,column,page] = size(croppedImgDoubled2);
            croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
            croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
            
            Doubled3 = (Doubled2*2+1);
            Double3Half = (Double2Half*2+1);
            croppedImgDoubled3 = imcrop(img, [x-Double3Half+j y-Double3Half-i Doubled3 Doubled3]);
            
            [row,column,page] = size(croppedImgDoubled3);
            croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
            croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
            
            
            
            [row,column,page] = size(croppedImg);
            if(page == 1)
                croppedImg = cat(3,croppedImg,croppedImg);
                croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
            end
            [row,column,page] = size(croppedImgDoubled);
            if(page == 1)
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
            end
            croppedImg = imresize(croppedImg, [cropImgSize+1 cropImgSize+1]);
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            smalls = cat(2,croppedImg,croppedImgDoubled);
            bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
            
            croppedImg = cat(1,smalls,bigs);
            
            %imshow(croppedImg);
            imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
            
            %Third
            counter = counter+1;
            croppedImg = imcrop(img, [x-cropHalfSize+i y-cropHalfSize+j cropImgSize cropImgSize]);
            [row,column,page] = size(croppedImg);
            croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
            croppedImg = imresize(croppedImg, [32 32]);
            
            
            Doubled = (cropImgSize*2+1);
            DoubleHalf = (cropHalfSize*2+1);
            croppedImgDoubled = imcrop(img, [x-DoubleHalf+i y-DoubleHalf+j Doubled Doubled]);
            
            [row,column,page] = size(croppedImgDoubled);
            croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            
            Doubled2 = (Doubled*2+1);
            Double2Half = (DoubleHalf*2+1);
            croppedImgDoubled2 = imcrop(img, [x-Double2Half+i y-Double2Half+j Doubled2 Doubled2]);
            
            [row,column,page] = size(croppedImgDoubled2);
            croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
            croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
            
            Doubled3 = (Doubled2*2+1);
            Double3Half = (Double2Half*2+1);
            croppedImgDoubled3 = imcrop(img, [x-Double3Half+i y-Double3Half+j Doubled3 Doubled3]);
            
            [row,column,page] = size(croppedImgDoubled3);
            croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
            croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
            
            [row,column,page] = size(croppedImg);
            if(page == 1)
                croppedImg = cat(3,croppedImg,croppedImg);
                croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
            end
            [row,column,page] = size(croppedImgDoubled);
            if(page == 1)
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
            end
            croppedImg = imresize(croppedImg, [cropImgSize+1 cropImgSize+1]);
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            smalls = cat(2,croppedImg,croppedImgDoubled);
            bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
            
            croppedImg = cat(1,smalls,bigs);
            %imshow(croppedImg);
            imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
            
            %Fourth
            counter = counter+1;
            croppedImg = imcrop(img, [x-cropHalfSize+j y-cropHalfSize+i cropImgSize cropImgSize]);
            [row,column,page] = size(croppedImg);
            croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
            croppedImg = imresize(croppedImg, [32 32]);
            
            Doubled = (cropImgSize*2+1);
            DoubleHalf = (cropHalfSize*2+1);
            croppedImgDoubled = imcrop(img, [x-DoubleHalf+j y-DoubleHalf+i Doubled Doubled]);
            
            [row,column,page] = size(croppedImgDoubled);
            croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            
            Doubled2 = (Doubled*2+1);
            Double2Half = (DoubleHalf*2+1);
            croppedImgDoubled2 = imcrop(img, [x-Double2Half+j y-Double2Half+i Doubled2 Doubled2]);
            
            [row,column,page] = size(croppedImgDoubled2);
            croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
            croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
            
            Doubled3 = (Doubled2*2+1);
            Double3Half = (Double2Half*2+1);
            croppedImgDoubled3 = imcrop(img, [x-Double3Half+j y-Double3Half+i Doubled3 Doubled3]);
            
            [row,column,page] = size(croppedImgDoubled3);
            croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
            croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
            
            [row,column,page] = size(croppedImg);
            if(page == 1)
                croppedImg = cat(3,croppedImg,croppedImg);
                croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
            end
            [row,column,page] = size(croppedImgDoubled);
            if(page == 1)
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
                croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
            end
            croppedImg = imresize(croppedImg, [cropImgSize+1 cropImgSize+1]);
            croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
            smalls = cat(2,croppedImg,croppedImgDoubled);
            bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
            
            croppedImg = cat(1,smalls,bigs);
            %imshow(croppedImg);
            imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
            counter = counter+1;
            j=j+1;
        catch Exception
            j=j+1;
            counter = counter+1;
        end
        
    end
    %Edge1
    counter = counter+1;
    croppedImg = imcrop(img, [x-cropHalfSize+i y-cropHalfSize+i cropImgSize cropImgSize]);
    [row,column,page] = size(croppedImg);
    croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
    croppedImg = imresize(croppedImg, [32 32]);
    
    Doubled = (cropImgSize*2+1);
    DoubleHalf = (cropHalfSize*2+1);
    croppedImgDoubled = imcrop(img, [x-DoubleHalf+i y-DoubleHalf+i Doubled Doubled]);
    
    [row,column,page] = size(croppedImgDoubled);
    croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    
    Doubled2 = (Doubled*2+1);
    Double2Half = (DoubleHalf*2+1);
    croppedImgDoubled2 = imcrop(img, [x-Double2Half+i y-Double2Half+i Doubled2 Doubled2]);
    
    [row,column,page] = size(croppedImgDoubled2);
    croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
    croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
    
    
    Doubled3 = (Doubled2*2+1);
    Double3Half = (Double2Half*2+1);
    croppedImgDoubled3 = imcrop(img, [x-Double3Half+i y-Double3Half+i Doubled3 Doubled3]);
    
    [row,column,page] = size(croppedImgDoubled3);
    
    
    croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
    croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
    
    [row,column,page] = size(croppedImg);
    if(page == 1)
        croppedImg = cat(3,croppedImg,croppedImg);
        croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
    end
    [row,column,page] = size(croppedImgDoubled);
    if(page == 1)
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
    end
    croppedImg = imresize(croppedImg, [32 32]);
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    smalls = cat(2,croppedImg,croppedImgDoubled);
    bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
    
    croppedImg = cat(1,smalls,bigs);
    %imshow(croppedImg);
    imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
    
    
    
    %Edge2c
    counter = counter+1;
    croppedImg = imcrop(img, [x-cropHalfSize+i y-cropHalfSize-i cropImgSize cropImgSize]);
    [row,column,page] = size(croppedImg);
    croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
    croppedImg = imresize(croppedImg, [32 32]);
    
    Doubled = (cropImgSize*2+1);
    DoubleHalf = (cropHalfSize*2+1);
    croppedImgDoubled = imcrop(img, [x-DoubleHalf+i y-DoubleHalf-i Doubled Doubled]);
    
    [row,column,page] = size(croppedImgDoubled);
    croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] );
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    
    Doubled2 = (Doubled*2+1);
    Double2Half = (DoubleHalf*2+1);
    croppedImgDoubled2 = imcrop(img, [x-Double2Half+i y-Double2Half-i Doubled2 Doubled2]);
    
    [row,column,page] = size(croppedImgDoubled2);
    croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] );
    croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
    
    Doubled3 = (Doubled2*2+1);
    Double3Half = (Double2Half*2+1);
    croppedImgDoubled3 = imcrop(img, [x-Double3Half+i y-Double3Half-i Doubled3 Doubled3]);
    
    [row,column,page] = size(croppedImgDoubled3);
    croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
    croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
    
    [row,column,page] = size(croppedImg);
    if(page == 1)
        croppedImg = cat(3,croppedImg,croppedImg);
        croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
    end
    [row,column,page] = size(croppedImgDoubled);
    if(page == 1)
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
    end
    croppedImg = imresize(croppedImg, [32 32]);
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    smalls = cat(2,croppedImg,croppedImgDoubled);
    bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
    
    croppedImg = cat(1,smalls,bigs);
    %imshow(croppedImg);
    imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
    
    
    %Edge3
    counter = counter+1;
    croppedImg = imcrop(img, [x-cropHalfSize-i y-cropHalfSize-i cropImgSize cropImgSize]);
    [row,column,page] = size(croppedImg);
    croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)]);
    croppedImg = imresize(croppedImg, [32 32]);
    
    
    Doubled = (cropImgSize*2+1);
    DoubleHalf = (cropHalfSize*2+1);
    croppedImgDoubled = imcrop(img, [x-DoubleHalf-i y-DoubleHalf-i Doubled Doubled]);
    
    [row,column,page] = size(croppedImgDoubled);
    croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)]);
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    
    Doubled2 = (Doubled*2+1);
    Double2Half = (DoubleHalf*2+1);
    croppedImgDoubled2 = imcrop(img, [x-Double2Half-i y-Double2Half-i Doubled2 Doubled2]);
    
    [row,column,page] = size(croppedImgDoubled2);
    croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)]);
    croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
    
    Doubled3 = (Doubled2*2+1);
    Double3Half = (Double2Half*2+1);
    croppedImgDoubled3 = imcrop(img, [x-Double3Half-i y-Double3Half-i Doubled3 Doubled3]);
    
    [row,column,page] = size(croppedImgDoubled3);
    croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] );
    croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
    
    [row,column,page] = size(croppedImg);
    if(page == 1)
        croppedImg = cat(3,croppedImg,croppedImg);
        croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
    end
    [row,column,page] = size(croppedImgDoubled);
    if(page == 1)
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
    end
    croppedImg = imresize(croppedImg, [32 32]);
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    smalls = cat(2,croppedImg,croppedImgDoubled);
    bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
    
    croppedImg = cat(1,smalls,bigs);
    %imshow(croppedImg);
    imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
    
    
    %Edge4
    counter = counter+1;
    croppedImg = imcrop(img, [x-cropHalfSize-i y-cropHalfSize+i cropImgSize cropImgSize]);
    [row,column,page] = size(croppedImg);
    croppedImg=padarray(croppedImg,[fix((cropImgSize+1-row)/2), fix((cropImgSize+1-column)/2)] );
    croppedImg = imresize(croppedImg, [32 32]);
    
    Doubled = (cropImgSize*2+1);
    DoubleHalf = (cropHalfSize*2+1);
    croppedImgDoubled = imcrop(img, [x-DoubleHalf-i y-DoubleHalf+i Doubled Doubled]);
    
    [row,column,page] = size(croppedImgDoubled);
    croppedImgDoubled=padarray(croppedImgDoubled,[fix((Doubled+1-row)/2), fix((Doubled+1-column)/2)] )
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    
    Doubled2 = (Doubled*2+1);
    Double2Half = (DoubleHalf*2+1);
    croppedImgDoubled2 = imcrop(img, [x-Double2Half-i y-Double2Half+i Doubled2 Doubled2]);
    
    [row,column,page] = size(croppedImgDoubled2);
    croppedImgDoubled2=padarray(croppedImgDoubled2,[fix((Doubled2+1-row)/2), fix((Doubled2+1-column)/2)] )
    croppedImgDoubled2 = imresize(croppedImgDoubled2, [32 32]);
    
    Doubled3 = (Doubled2*2+1);
    Double3Half = (Double2Half*2+1);
    croppedImgDoubled3 = imcrop(img, [x-Double3Half-i y-Double3Half+i Doubled3 Doubled3]);
    
    [row,column,page] = size(croppedImgDoubled3);
    croppedImgDoubled3=padarray(croppedImgDoubled3,[fix((Doubled3+1-row)/2), fix((Doubled3+1-column)/2)] )
    croppedImgDoubled3 = imresize(croppedImgDoubled3, [32 32]);
    
    
    [row,column,page] = size(croppedImg);
    if(page == 1)
        croppedImg = cat(3,croppedImg,croppedImg);
        croppedImg = cat(3,croppedImg,croppedImg(:,:,1));
    end
    [row,column,page] = size(croppedImgDoubled);
    if(page == 1)
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled);
        croppedImgDoubled = cat(3,croppedImgDoubled,croppedImgDoubled(:,:,1));
    end
    croppedImg = imresize(croppedImg, [32 32]);
    croppedImgDoubled = imresize(croppedImgDoubled, [32 32]);
    smalls = cat(2,croppedImg,croppedImgDoubled);
    bigs = cat(2,croppedImgDoubled2,croppedImgDoubled3);
    
    croppedImg = cat(1,smalls,bigs);
    %imshow(croppedImg);
    imwrite(croppedImg, strcat(  outDir,'/',  int2str(i),'/', uniqueBase,'_',int2str(counter),'.png'));
    
    counter = counter+1;
end



end

