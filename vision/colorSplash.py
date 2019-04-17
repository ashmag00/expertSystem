import numpy as np
from scipy import linalg, ndimage
from scipy.misc import imread, imsave, imresize
import matplotlib.pyplot as plt
import math

chosenColor = np.array([88,105,154])
def createRatio(rgb):
    return np.array([rgb[0]/rgb[1], rgb[0]/rgb[2], rgb[1]/rgb[2]])
chosenRatio = createRatio(chosenColor)
img = imread("zelda.png")
imgCp = imread("zelda.png", mode="L")

for i in range(0, img.shape[0]):
    for j in range(0, img.shape[1]):
        pixRatio = createRatio(img[i,j,:3])
        ratioDifference = np.sum(abs(pixRatio - chosenRatio))
        if(ratioDifference >= 1.1):
            img[i,j] = np.array([imgCp[i,j],imgCp[i,j],imgCp[i,j], img[i,j,3]])

imsave('blueSplash.png', img)
plt.imshow(img)
plt.show()
