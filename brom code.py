import numpy as np

# Sirf yeh likhna hai
img = np.loadtxt('D:/python image/image16x16.txt', dtype=int)

count = 0
for row in img:
    for pixel in row:
        print(f"bram[{count}] = 8'd{pixel};")
        count += 1
