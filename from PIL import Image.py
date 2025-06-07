from PIL import Image
import numpy as np

# Load image
img = Image.open("C:\Users\HomePC\Downloads\16.avif").convert("L")  # convert to grayscale

# Resize to 16x16
img_resized = img.resize((16, 16), Image.LANCZOS)

# Convert to numpy array
pixels = np.array(img_resized)

# Save as txt (space-separated pixel values, row by row)
np.savetxt("16x16_grayscale_image.txt", pixels, fmt='%d', delimiter=' ')

print("Conversion complete! Saved as 16x16_grayscale_image.txt")
