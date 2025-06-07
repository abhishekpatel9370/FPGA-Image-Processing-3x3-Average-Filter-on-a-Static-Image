`timescale 1ns / 1ps

module tb_image_filter_3x3_avg_16x16;

    reg clk = 0;
    reg rst = 1;
    reg start = 0;
    wire done;
    wire [7:0] pixel_out;

    integer file;  // File handle
    integer pixel_counter = 0;

    // Instantiate the DUT
    image_filter_3x3_avg_16x16 uut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .done(done),
        .pixel_out(pixel_out)
    );

    // Clock generation (100 MHz)
    always #5 clk = ~clk;

    // Main stimulus
    initial begin
        // Open the output file
        file = $fopen("D:/python image/python filter image from vivado.txt", "w");

        // Apply reset
        #20 rst = 0;
        #10 start = 1;
        #10 start = 0;

        // Wait for done
        wait(done);

        // Close file
        $fclose(file);

        // Finish simulation
        #20 $finish;
    end

    // Write pixels to file as they appear on pixel_out
    always @(posedge clk) begin
        if (uut.filtering_done && !done) begin
            // Write pixel in hex format (02X ? 2-digit hex uppercase)
            $fwrite(file, "%02X ", pixel_out);

            pixel_counter = pixel_counter + 1;

            // After 16 pixels, go to new line
            if (pixel_counter % 16 == 0)
                $fwrite(file, "\n");
        end
    end

endmodule
