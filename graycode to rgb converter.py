import numpy as np
import matplotlib.pyplot as plt

# Read filtered image (grayscale) from hex file
with open("D:/python image/python filter image from vivado.txt", "r") as f:
    lines = f.readlines()

image_data = []
for line in lines:
    numbers = line.strip().split()
    row = [int(n, 16) for n in numbers]
    image_data.append(row)

image_np = np.array(image_data, dtype=np.uint8)

# Load original image (grayscale)
original = np.loadtxt("D:/python image/image16x16.txt", dtype=np.uint8)

# Plot side by side with color maps
plt.figure(figsize=(10, 5))

plt.subplot(1, 2, 1)
plt.imshow(original, cmap='viridis')  # pseudo color map for grayscale
plt.title('Original Image')
plt.colorbar()

plt.subplot(1, 2, 2)
plt.imshow(image_np, cmap='viridis')
plt.title('Filtered Image')
plt.colorbar()

plt.show()
