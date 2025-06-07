# FPGA Project: 3x3 Average Image Filter (16x16 Image)

## Project Overview

This project demonstrates the implementation of a **3x3 average filter** on a small grayscale image (16x16 pixels) using **Verilog HDL** on an FPGA platform. The primary goal is to apply basic image smoothing by averaging each pixel’s value with its immediate neighbors.

The image data is loaded into the FPGA from an external file in hexadecimal format, processed by the filter logic, and the filtered pixel values are output to a file for verification and visualization.

---

## Project Workflow

### 1. Image Preparation

- A static grayscale image (e.g., a plant image) of size 16x16 pixels is prepared.
- The image is converted into grayscale if it was originally in color.
- Pixel intensity values (ranging from 0 to 255) are extracted and saved in a text or hexadecimal format.
- This prepared image file serves as the input data for the FPGA.

### 2. Loading Image into FPGA Memory

- The image pixel data file is loaded into the FPGA’s internal memory using Verilog’s file reading capabilities.
- This allows the FPGA to access pixel values directly during filtering.
- The image is stored in a block RAM or ROM-like memory structure inside the FPGA.

### 3. Applying the 3x3 Average Filter

- The filtering algorithm applies a sliding 3x3 window over the image pixels.
- For each non-border pixel, the filter computes the average of the pixel and its eight neighbors.
- Border pixels remain unchanged to avoid boundary artifacts.
- The filtered pixel values are stored in a separate memory array inside the FPGA.

### 4. Output and Verification

- After filtering, the FPGA sequentially outputs the filtered pixel values.
- A testbench captures these values and writes them into an output text file.
- The output file can be reloaded into a PC-based tool (such as Python or MATLAB) to visualize and verify the filtering effect.
- This step closes the loop between FPGA processing and software-level verification.

---

## How to Run the Project

- Convert your chosen image to grayscale and save pixel values in a text or hex file.
- Add the Verilog design files and testbench to your FPGA simulation environment (e.g., Vivado).
- Run the simulation; filtered pixel values will be generated in an output text file.
- Use software tools to visualize the filtered image and validate the results.

---

## Additional Information

- The design uses a clock frequency of 100 MHz.
- Filtering is performed on a fixed 16x16 image.
- Border pixels are preserved without filtering.
- The filter runs once per activation signal (start pulse).

---

## Potential Future Enhancements

- Use dynamic block RAM for image storage instead of static ROM.
- Implement more advanced filters such as Sobel (edge detection) or Gaussian smoothing.
- Enable dynamic image loading via communication interfaces like UART or AXI.
- Extend the design for real-time video streaming and filtering.

---

## Tools and Credits

- **Tools Used:** Xilinx Vivado (for Verilog simulation and FPGA synthesis), Python (for image preprocessing and visualization).
