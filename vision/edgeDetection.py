import numpy as np
from scipy import linalg, ndimage
from scipy.misc import imread, imsave, imresize
import matplotlib.pyplot as plt
import math

threshold = 50
sobelHorizontal = np.array([[1, 2, 1], [0, 0, 0], [-1, -2, -1]])
sobelVertical = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])

img = imread("zelda.png")
imgCp = imread("zelda.png", mode="L")
imgSobel = imread("zelda.png", mode="L")
imgSobelh = imread("zelda.png", mode="L")

for i in range(0, img.shape[0]):
    for j in range(0, img.shape[1]):
        img[i,j] = np.array([imgCp[i,j],imgCp[i,j],imgCp[i,j], img[i,j,3]])

for i in range(1, img.shape[0]-1):
    for j in range(1, img.shape[1]-1):
        #print(np.array([[imgCp[i-1,j-1], imgCp[i, j-1], imgCp[i+1, j-1]],[imgCp[i-1,j],imgCp[i,j],imgCp[i+1,j]],[imgCp[i-1,j],imgCp[i,j],imgCp[i+1,j]]]))
        #a = imgCp[i-1:i+2,j-1:j+2]
        accum = 0
        for ki in range(3):
            for kj in range(3):
                accum += imgCp[i-1+ki, j-1+kj]*sobelVertical[ki,kj]
        if abs(accum) > threshold:
           imgSobel[i,j] = 255
        else:
           imgSobel[i,j] = 0
        accum = 0
        for ki in range(3):
            for kj in range(3):
                accum += imgCp[i-1+ki, j-1+kj]*sobelHorizontal[ki,kj]
        if abs(accum) > threshold:
           imgSobelh[i,j] = 255
        else:
           imgSobelh[i,j] = 0

        #a = imgCp[i,j]*sobelVertical
        #print(imgCp[i,j])
        #print(a)
        #print(ndimage.convolve(a, sobelVertical))
for i in range(0, img.shape[0]):
    for j in range(0, img.shape[1]):
        img[i,j] = np.array([imgSobel[i,j],imgSobel[i,j],imgSobel[i,j], img[i,j,3]])
imsave('lineVertical.png', img)
for i in range(0, img.shape[0]):
    for j in range(0, img.shape[1]):
        img[i,j] = np.array([imgSobelh[i,j],imgSobelh[i,j],imgSobelh[i,j], img[i,j,3]])
imsave('lineHorizontal.png', img)


plt.imshow(img)
plt.show()
