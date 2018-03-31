import numpy as np
import cv2
import sys

def main():   
    if(len(sys.argv) != 3):
        print 'Usage: program imagePath outputDirectory' 
        sys.exit()
    # Load an color image in grayscale
    img = cv2.imread(sys.argv[1], 1)
    print img.any()
    if(not img.any()):
    	print 'Image couldn\'t be loaded'
    	sys.exit()
    height, width, depth = img.shape
    #cv2.imshow('image',img)
    #cv2.waitKey()

    for i in range(0, height):             
        for j in range(0, (width)):   
			image16 = cropImage(img,i,j,16)
			image32 = cropImage(img,i,j,32)
			image64 = cropImage(img,i,j,64)
			image128 = cropImage(img,i,j,128)
			resized16 = cv2.resize(image16, (16, 16))
			resized32 = cv2.resize(image32, (16, 16))
			resized64 = cv2.resize(image64, (16, 16))
			resized128 = cv2.resize(image128, (16, 16))

			smallImages = np.concatenate( (resized16,resized32) ,1)
			bigImages = np.concatenate( (resized64,resized128),1)
			result = np.concatenate((smallImages,bigImages),0)
			cv2.imwrite(sys.argv[2] + '/'+ str(i) +'_'+str(j)+'.png',result)
			#cv2.imwrite(sys.argv[2] + '/'+ str(i) +'_'+str(j)+'16.png',image16)
			#cv2.imwrite(sys.argv[2] + '/'+ str(i) +'_'+str(j)+'32.png',image32)
			#cv2.imwrite(sys.argv[2] + '/'+ str(i) +'_'+str(j)+'64.png',image64)
			#cv2.imwrite(sys.argv[2] + '/'+ str(i) +'_'+str(j)+'128.png',image128)

    #cv2.imshow('image',cropped128)
    #cv2.waitKey()
    return



def cropImage(img, x,y, cropSize):
    if(x < cropSize/2 and y < cropSize/2):
        result = img[0:x+cropSize/2,0:y+cropSize/2,:]
    elif(x < cropSize/2):
        result = img[0:x+cropSize/2,y-cropSize/2:y+cropSize/2,:]    
    elif(y < cropSize/2):
        result = img[x-cropSize/2:x+cropSize/2,0:y+cropSize/2,:]
    else:
        result = img[x-cropSize/2:x+cropSize/2, y-cropSize/2:y+cropSize/2 ,:]

    height, width, depth = result.shape
    
    emptyImg = np.zeros((cropSize,cropSize,3),np.uint8)
    if(height % 2 == 1 and width % 2 == 1):
        emptyImg[cropSize/2-height/2:cropSize/2+height/2+1, cropSize/2-width/2:cropSize/2+width/2+1, :] = result
    elif(height % 2 == 1 ):
        emptyImg[cropSize/2-height/2:cropSize/2+height/2+1, cropSize/2-width/2:cropSize/2+width/2, :] = result
    elif(width % 2 == 1 ):
        emptyImg[cropSize/2-height/2:cropSize/2+height/2, cropSize/2-width/2:cropSize/2+width/2+1, :] = result
    else:
        emptyImg[cropSize/2-height/2:cropSize/2+height/2, cropSize/2-width/2:cropSize/2+width/2, :] = result
    return emptyImg

if __name__ == "__main__":
    main()
