import cv2
import numpy as np

# Image path — yahi tu ne diya tha
imgpath = "C:/Users/HomePC/Downloads/plant.jpg"

# Image read karo grayscale mode me
img = cv2.imread(imgpath, cv2.IMREAD_GRAYSCALE)

# Check karo image load hui ya nahi
if img is None:
    print(" Image load nahi hui. Path check karo:", imgpath)
else:
    # Resize karo 16x16
    img_resized = cv2.resize(img, (16, 16), interpolation=cv2.INTER_AREA)

    # Save pixel values to .txt file
    np.savetxt('image16x16.txt', img_resized, fmt='%d')

    print(" image16x16.txt file is ready.")
