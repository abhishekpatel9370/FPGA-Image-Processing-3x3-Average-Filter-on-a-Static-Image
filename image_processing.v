`timescale 1ns / 1ps

module image_filter_3x3_avg_16x16 (
    input wire clk,
    input wire rst,
    input wire start,
    output reg done,
    output reg [7:0] pixel_out
);

    localparam SIZE = 16;
    localparam TOTAL_PIXELS = SIZE * SIZE;

    reg [7:0] memory [0:TOTAL_PIXELS-1];         // Input image memory
    reg [7:0] filtered_mem [0:TOTAL_PIXELS-1];  // Filtered image memory

    integer i, j;

    reg [1:0] state;
    localparam IDLE = 0, FILTERING = 1, OUTPUT = 2, DONE_STATE = 3;

    integer filter_i, filter_j;
    integer sum;
    reg [15:0] out_index;

    // Initialize memory from HEX file (only for simulation)
    initial begin
        $readmemh("D:/python image/image hexa.txt", memory);
    end

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            done <= 0;
            pixel_out <= 0;
            out_index <= 0;
            filter_i <= 1;
            filter_j <= 1;
            // Initialize filtered_mem to zero if needed
            for (i = 0; i < TOTAL_PIXELS; i = i + 1)
                filtered_mem[i] <= 0;
        end else begin
            case (state)
                IDLE: begin
                    done <= 0;
                    pixel_out <= 0;
                    out_index <= 0;
                    filter_i <= 1;
                    filter_j <= 1;
                    if (start) begin
                        state <= FILTERING;
                    end
                end

                FILTERING: begin
                    // Compute average for pixel (filter_i, filter_j)
                    sum = memory[(filter_i-1)*SIZE + (filter_j-1)] + memory[(filter_i-1)*SIZE + filter_j] + memory[(filter_i-1)*SIZE + (filter_j+1)] +
                          memory[filter_i*SIZE + (filter_j-1)]     + memory[filter_i*SIZE + filter_j]     + memory[filter_i*SIZE + (filter_j+1)] +
                          memory[(filter_i+1)*SIZE + (filter_j-1)] + memory[(filter_i+1)*SIZE + filter_j] + memory[(filter_i+1)*SIZE + (filter_j+1)];

                    filtered_mem[filter_i*SIZE + filter_j] <= sum / 9;

                    // Increment indices
                    if (filter_j == SIZE - 2) begin
                        filter_j <= 1;
                        if (filter_i == SIZE - 2) begin
                            filter_i <= 1;
                            state <= OUTPUT;
                            // Copy borders unchanged
                            for (i = 0; i < SIZE; i = i + 1) begin
                                filtered_mem[i] <= memory[i];                                   // Top row
                                filtered_mem[(SIZE-1)*SIZE + i] <= memory[(SIZE-1)*SIZE + i];   // Bottom row
                                filtered_mem[i*SIZE] <= memory[i*SIZE];                         // Left column
                                filtered_mem[i*SIZE + (SIZE-1)] <= memory[i*SIZE + (SIZE-1)];   // Right column
                            end
                        end else begin
                            filter_i <= filter_i + 1;
                        end
                    end else begin
                        filter_j <= filter_j + 1;
                    end
                end

                OUTPUT: begin
                    pixel_out <= filtered_mem[out_index];
                    if (out_index == TOTAL_PIXELS - 1) begin
                        done <= 1;
                        state <= DONE_STATE;
                    end else begin
                        out_index <= out_index + 1;
                    end
                end

                DONE_STATE: begin
                    // Wait here until reset or start again
                    done <= 1;
                    if (!start)
                        state <= IDLE;
                end

                default: state <= IDLE;
            endcase
        end
    end

endmodule
