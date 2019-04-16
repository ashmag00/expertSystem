import numpy as np
from scipy import linalg, ndimage
from scipy.misc import imread, imsave, imresize
import matplotlib.pyplot as plt

sobelVertical = np.array([[1, 2, 1], [0, 0, 0], [-1, -2, -1]])
sobelHorizontal = np.array([[-1, 0, 1], [-2, 0, 2], [-1, 0, 1]])

img = imread("zelda.png")
imgCp = imread("zelda.png")
print(img.shape)
for i in range(1, img.shape[0]-1):
    for j in range(1, img.shape[1]-1):
        #print(np.array([[imgCp[i-1,j-1], imgCp[i, j-1], imgCp[i+1, j-1]],[imgCp[i-1,j],imgCp[i,j],imgCp[i+1,j]],[imgCp[i-1,j],imgCp[i,j],imgCp[i+1,j]]]))
        a = np.array(imgCp[i-1:i+2,j-1:j+2])
        print(ndimage.convolve(a, sobelVertical))

plt.imshow(img)
plt.show()
