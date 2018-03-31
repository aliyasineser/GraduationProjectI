import os
import json
import shlex
import subprocess
import sys
import numpy as np
import cv2


def main():
	if(len(sys.argv) != 3):
		print 'Usage: program imagePath outputDirectory' 
		sys.exit()
	partialize()
	#constant info
	basePath = '/home/aliyasineser/Desktop/output/'
	job_id_neck = '20171213-040047-78f7'
	job_id_head = '20171210-022430-5d35'
	job_id_rightHand = '20171212-232650-7103'
	job_id_leftHand = '20171212-215622-51f0'
	job_id_rightShoulder = '20171214-042203-85f5'
	job_id_leftShoulder = '20171214-030610-0f82'
	job_id_rightElbow = '20171215-043127-4ec5'
	job_id_leftElbow = '20171215-004238-f1c0'
	job_id_rightHip = '20171213-233249-0feb'
	job_id_leftHip = '20171214-225920-a1a4'
	job_id_rightKnee = '20171213-211848-7e27'
	job_id_leftKnee = '20171213-200218-d7dd'
	job_id_rightFoot = '20171212-201355-f195'
	job_id_leftFoot = '20171212-033444-0e2d'
	job_id_torso = '20171212-014543-b59e'
	
	img = cv2.imread(sys.argv[1], 1)	
	print 'Head:'
	img = search(basePath,job_id_head,img,(0,0,255))
	print 'Neck:'
	img = search(basePath,job_id_neck,img,(0,255,0))
	print 'Right Hand:'
	img = search(basePath,job_id_rightHand,img,(255,0,0))
	print 'Left Hand:'
	img = search(basePath,job_id_leftHand,img,(255,0,0))
	print 'Right Shoulder:'
	img = search(basePath,job_id_rightShoulder,img,(0,255,255))
	print 'Left Shoulder:'
	img = search(basePath,job_id_leftShoulder,img,(0,255,255))
	print 'Right Elbow:'
	img = search(basePath,job_id_rightElbow,img,(255,255,0))
	print 'Left Elbow:'
	img = search(basePath,job_id_leftElbow,img,(255,255,0))
	print 'Right Hip:'
	img = search(basePath,job_id_rightHip,img,(255,0,255))
	print 'Left Hip:'
	img = search(basePath,job_id_leftHip,img,(255,0,255))
	print 'Right Knee:'
	img = search(basePath,job_id_rightKnee,img,(0,0,150))
	print 'Left Knee:'
	img = search(basePath,job_id_leftKnee,img,(0,0,150))
	print 'Right Foot:'
	img = search(basePath,job_id_rightFoot,img,(150,0,0))
	print 'Left Foot:'
	img = search(basePath,job_id_leftFoot,img,(150,0,0))
	print 'Torso:'
	img = search(basePath,job_id_torso,img,(150,0,150))
	
	
	cv2.imshow('image',img)
	cv2.waitKey()
	cv2.imwrite(sys.argv[1]+'map.png',img)
	return



def partialize():
	img = cv2.imread(sys.argv[1], 1)
	print img.any()
	if(not img.any()):
		print 'Image couldn\'t be loaded'
		sys.exit()
	height, width, depth = img.shape

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
	return


def search(basePath,job_id, img, color):
	
	imageList = os.listdir(basePath)
	allPaths = ''
	for testImage in imageList:
		allPaths += basePath + '/' + testImage + '\n'
	
	#print allPaths
	outFile = open('tmpTestModel.txt', 'w')
	outFile.write(allPaths)
	count = 0
	xmean = 0
	ymean = 0
		
	allPaths = allPaths[:-1]
	pathList = allPaths.splitlines()
	exeString = 'curl localhost:5000/models/images/classification/classify_many.json -XPOST -F job_id='+ job_id +' -F image_list=@'+ os.getcwd() +'/tmpTestModel.txt' + ' > AnswerFromModel.txt'
	#print exeString
	os.system(exeString)
	retFile = open('AnswerFromModel.txt','r')	
	content = retFile.read()	
	parsedJson = json.loads(content)
	
	for elem in parsedJson: # Json Object
		for direc in parsedJson[elem]: # File names
			bestLabel = parsedJson[elem][direc][0][0]
			bestMatch = parsedJson[elem][direc][0][1]
			x,y = getCoords(direc)
			#print direc , ' -> ' , x , ' , ' , y
			if(int(bestLabel) < 5 ):
				print 'Model says for (',x,',',y, '): ' , bestLabel, ' with success rate: ', bestMatch 
				xmean= xmean+x
				ymean = ymean+y
				count = count + 1	
	if(count != 0):
		print 'count is: ' , count , ' and xmean is: ' , xmean, ' and ymean is: ', ymean
		print 'x: ' , int(float(xmean)/count)
		print 'y: ' , int(float(ymean)/count)
		cv2.circle(img,(int(float(ymean)/count),int(float(xmean)/count)), 7, color , -1)
	
	os.remove('tmpTestModel.txt')
	os.remove('AnswerFromModel.txt')
	return img



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




def getCoords(path):
	result = path[path.rfind('/')+1:path.rfind('.png')]
	x = result[:result.rfind('_')]
	y = result[result.rfind('_')+1:]
	return [int(x),int(y)]


if __name__ == "__main__":
    main()
