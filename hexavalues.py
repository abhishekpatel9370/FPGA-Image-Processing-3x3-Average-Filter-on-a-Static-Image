with open("D:/python image/image16x16.txt", "r") as f_in, open("D:/python image/image hexa.txt", "w") as f_out:
    for line in f_in:
        numbers = line.strip().split()
        hex_line = ' '.join(f"{int(n):02X}" for n in numbers)
        f_out.write(hex_line + "\n")
