
from skimage.io import imread
import numpy as np
import matplotlib.pyplot as plt
from PIL import Image
import caffe
import os



blob = caffe.proto.caffe_pb2.BlobProto()
data = open( '/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/mean.binaryproto' , 'rb' ).read()
blob.ParseFromString(data)
arr = np.array( caffe.io.blobproto_to_array(blob) )
out = arr[0]
np.save( '/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/mean.npy' , out )


caffe.set_device(0)
caffe.set_mode_gpu()
#load the model
net = caffe.Net('/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/deploy.prototxt',
                '/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/snapshot_iter_8580.caffemodel',
                caffe.TEST)



# load input and configure preprocessing
transformer = caffe.io.Transformer({'data': net.blobs['data'].data.shape})
transformer.set_mean('data', np.load('/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/mean.npy').mean(1).mean(1))
transformer.set_transpose('data', (2,0,1))
transformer.set_channel_swap('data', (2,1,0))
transformer.set_raw_scale('data', 255.0)

#note we can change the batch size on-the-fly
#since we classify only one image, we change batch size from 10 to 1
net.blobs['data'].reshape(1,3,128,128)

#load the image in the data layer
im = caffe.io.load_image('/home/aliyasineser/Desktop/Four32Test/RGB_101/head/5/0511123142_RGB_101_26.png')
net.blobs['data'].data[...] = transformer.preprocess('data', im)

#compute
out = net.forward()

# other possibility : out = net.forward_all(data=np.asarray([transformer.preprocess('data', im)]))

#predicted predicted class
print out['softmax'].argmax()

#print predicted labels
labels = np.loadtxt("/home/aliyasineser/Desktop/TrackerHeadSegmentation32Epoch20/labels.txt", str, delimiter='\n')
top_k = net.blobs['softmax'].data[0].flatten().argsort()
print labels[top_k]

