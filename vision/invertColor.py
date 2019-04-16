import numpy as np
from scipy import linalg
from scipy.misc import imread, imsave, imresize
import matplotlib.pyplot as plt
img = imread("zelda.png")
print(img.shape)
for i in range(img.shape[0]):
    for j in range(img.shape[1]):
        img[i,j] = [255-img[i,j,0], 255-img[i,j,1], 255-img[i,j,2], img[i,j,3]]

plt.imshow(img)
plt.show()
imsave('inverted.png', img)
