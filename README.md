# GraduationProjectI
Gebze Technical University Graduation Project I 


This project aims to estimate human pose in a single 2D image.


Data augmentation operation is applied to at most 16 pixel far away neighbour pixel
to every center joint of the person in the image. These neighbour images are the
classes that define distance from the center of the joint. For every neighbour and
center pixel, 16x16, 32x32, 64x64 and 128x128 resolution images are cropped from
the first 2D image. These subimages are concatenated to each other to train the
neural network model. Fifteen deep learning models are obtained for every joint.


For each pixel of the test image during the test phase, estimates of distance from 6
pixels and below were taken correctly and the center of the locations of the correctly
accepted pixels were considered as the center of the joint. Despite the deviation of
the legs and invisible joints, the pose estimation can be considered successful.
