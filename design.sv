// Design Synchronous FIFO Memory
module fifo #(
    parameter DATA_WIDTH = 8,  // Width of the data bus
    parameter DEPTH = 16        // Number of FIFO locations
)(
  
   input wire clk,               // Clock input
    input wire rst,               // Active-high synchronous reset
    input wire wr_en,             // Write enable signal
    input wire rd_en,             // Read enable signal
    input wire [DATA_WIDTH-1:0] din,  // Data input
    output reg [DATA_WIDTH-1:0] dout, // Data output
    output wire full,             // FIFO full indicator
    output wire empty             // FIFO empty indicator
);

  reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];     // FIFO memory array
  reg [$clog2(DEPTH)-1:0] wptr, rptr;          // Write and read pointers
  reg [$clog2(DEPTH):0] count;
  
  always@(posedge clk) begin
    if(rst) begin
      wptr<=0;
      rptr<=0;
      count<=0;
      dout<=0;
    end
    
    else begin
       // Write operation
      if(wr_en && !full) begin
        memory[wptr]<=din;
        wptr<=(wptr+1) % DEPTH;
        count<=count+1;
      end
      
      // Read operation
      if(rd_en && !empty) begin
        dout<=memory[rptr];
        rptr<=(rptr+1) % DEPTH;
        count<= count-1;
      end
    end
  end
  
  assign full=(count==DEPTH);    // FIFO full
  assign empty=(count==0);         // FIFO empty
  
endmodule
        
      
  
