import os
import json
import shlex
import subprocess
import sys




def main():
	#constant info
	basePath = '/home/aliyasineser/Desktop/Four32Test/RGB_101/'
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
	
		
	print 'Head:'
	search(basePath+'head/',job_id_head)
	print 'Neck:'
	search(basePath+'neck/',job_id_neck)
	print 'Right Hand:'
	search(basePath+'rightHand/',job_id_rightHand)
	print 'Left Hand:'
	search(basePath+'leftHand/',job_id_leftHand)
	print 'Right Shoulder:'
	search(basePath+'rightShoulder/',job_id_rightShoulder)
	print 'Left Shoulder:'
	search(basePath+'leftShoulder/',job_id_leftShoulder)
	print 'Right Elbow:'
	search(basePath+'rightElbow/',job_id_rightElbow)
	print 'Left Elbow:'
	search(basePath+'leftElbow/',job_id_leftElbow)
	print 'Right Hip:'
	search(basePath+'rightHip/',job_id_rightHip)
	print 'Left Hip:'
	search(basePath+'leftHip/',job_id_leftHip)
	print 'Right Knee:'
	search(basePath+'rightKnee/',job_id_rightKnee)
	print 'Left Knee:'
	search(basePath+'leftKnee/',job_id_leftKnee)
	print 'Right Foot:'
	search(basePath+'rightFoot/',job_id_rightFoot)
	print 'Left Foot:'
	search(basePath+'leftFoot/',job_id_leftFoot)
	print 'Torso:'
	search(basePath+'torso/',job_id_torso)
	
	
	return






def search(basePath,job_id):
	countArray = [0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0]
	allCount = [0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0]
	successCount = 0
	count = 0
	classList = os.listdir(basePath)

	for classElem in classList:
		#print 'Predictions for ' , classElem , ' : ' 
		classDir = basePath + classElem
		classTestImages = os.listdir(classDir)
		allPaths = ''
		for testImage in classTestImages:
			allPaths += classDir + '/' + testImage + '\n'
	
		#print allPaths
		outFile = open('tmpTestModel.txt', 'w')
		outFile.write(allPaths)
	
		if(classElem == '0'):
			allPaths = allPaths[:-1]
			pathList =allPaths.splitlines()
			for pathItem in pathList:
				#print pathItem
				exeString = 'curl localhost:5000/models/images/classification/classify_one.json -XPOST -F job_id='+ job_id +' -F image_file=@'+pathItem + ' > AnswerFromModel.txt'
				#print exeString
				os.system(exeString)
				retFile = open('AnswerFromModel.txt','r')	
				content = retFile.read()
				parsedJson = json.loads(content)
				for elem in parsedJson: # Json Object
						bestLabel = parsedJson[elem][0][0]
						bestMatch = parsedJson[elem][0][1]
						#print elem
						#print 'Should: ' , classElem , ' and Model says: ' , bestLabel, ' with success rate: ', bestMatch 
						if(int(bestLabel) == int(classElem) or int(bestLabel) == int(classElem)+1 or int(bestLabel) == int(classElem)-1):
							countArray[int(classElem)] += 1
							successCount += 1
						count += 1	
						allCount[int(classElem)] += 1
				
				os.remove('AnswerFromModel.txt')
			
		else:
			exeString = 'curl localhost:5000/models/images/classification/classify_many.json -XPOST -F job_id='+ job_id +' -F image_list=@'+ os.getcwd() +'/tmpTestModel.txt' + ' > AnswerFromModel.txt'
	
			os.system(exeString)
	
			retFile = open('AnswerFromModel.txt','r')	
			content = retFile.read()
			parsedJson = json.loads(content)
			#print exeString
		
			for elem in parsedJson: # Json Object
				for direc in parsedJson[elem]: # File names
					bestLabel = parsedJson[elem][direc][0][0]
					bestMatch = parsedJson[elem][direc][0][1]
					#print direc
					#print 'Should: ' , classElem , ' and Model says: ' , bestLabel, ' with success rate: ', bestMatch 
					if(int(bestLabel) == int(classElem) or int(bestLabel) == int(classElem)+1 or int(bestLabel) == int(classElem)-1):
						countArray[int(classElem)] += 1
						successCount += 1
					count += 1	
					allCount[int(classElem)] += 1
				
			os.remove('tmpTestModel.txt')
			os.remove('AnswerFromModel.txt')
			print countArray
			print count
	print 'Successful ' ,successCount, ' prediction in ',  count ,' images'
	result = float(successCount)/float(count)
	print 'Success rate: %' , result
	print 'Success rates by class:'
	for i in range(0,len(countArray)):
		result = float(countArray[i])/float(allCount[i])
		print 'Class ', i ,': ', countArray[i] , '/' , allCount[i] , ' -> %', result

if __name__ == "__main__":
    main()


