import numpy as np
import matplotlib.pyplot as plt

# Read filtered image from hex file with RGB values (3 values per pixel)
with open("D:/python image/python filter image from vivado.txt", "r") as f:
    lines = f.readlines()

image_data = []
for line in lines:
    numbers = line.strip().split()
    row = []
    # Parse every 3 values as R, G, B
    for i in range(0, len(numbers), 3):
        r = int(numbers[i], 16)
        g = int(numbers[i+1], 16)
        b = int(numbers[i+2], 16)
        row.append([r, g, b])
    image_data.append(row)

# Convert filtered image data to numpy array of shape (height, width, 3)
image_np = np.array(image_data, dtype=np.uint8)

# Load original image (decimal RGB values), same assumption: each line has width*3 numbers
original_data = np.loadtxt("D:/python image/image16x16.txt", dtype=np.uint8)

# Reshape original data into (height, width, 3)
# You need to know image width and height; assuming 16x16 here:
height, width = 16, 16
original = original_data.reshape((height, width, 3))

# Plot both images side by side in color
plt.figure(figsize=(10, 5))

plt.subplot(1, 2, 1)
plt.imshow(original)
plt.title('Original Image')

plt.subplot(1, 2, 2)
plt.imshow(image_np)
plt.title('Filtered Image')

plt.show()
