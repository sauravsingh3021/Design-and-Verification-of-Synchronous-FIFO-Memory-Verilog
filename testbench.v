`timescale 1ns/1ps

module tb_fifo();

  parameter DATA_WIDTH = 8;
  parameter DEPTH = 16;

  reg clk, rst, wr_en, rd_en;
  reg [DATA_WIDTH-1:0] din;
  wire [DATA_WIDTH-1:0] dout;
  wire full, empty;
  integer testcase;

  integer i;
  reg [DATA_WIDTH-1:0] temp;

  // Instantiate DUT
  fifo #(DATA_WIDTH, DEPTH) dut (
    .clk(clk),
    .rst(rst),
    .wr_en(wr_en),
    .rd_en(rd_en),
    .din(din),
    .dout(dout),
    .full(full),
    .empty(empty)
  );

  initial clk = 0;
  always #5 clk = ~clk;

  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(0, tb_fifo);
  end

  task reset_fifo();
    begin
      rst = 1; wr_en = 0; rd_en = 0; din = 0;
      #10;
      rst = 0;
      #10;
    end
  endtask

  task write(input [DATA_WIDTH-1:0] data);
    begin
      @(posedge clk);
      if (!full) begin
        wr_en = 1; rd_en = 0; din = data;
      end else begin
        $display("Warning: FIFO full, write skipped");
      end
      @(posedge clk);
      wr_en = 0; din = 0;
    end
  endtask

  task read(output [DATA_WIDTH-1:0] data);
    begin
      @(posedge clk);
      if (!empty) begin
        wr_en = 0; rd_en = 1;
        @(posedge clk);
        data = dout;
        rd_en = 0;
      end else begin
        $display("Warning: FIFO empty, read skipped");
        data = 0;
      end
    end
  endtask

  task tc_01(); // Write Operation Test
    reset_fifo();
    write(8'hAA);
    if (!empty) $display("TC_01 PASS: FIFO not empty after write");
    else $display("TC_01 FAIL: FIFO should not be empty");
  endtask

  task tc_02(); // Read Operation Test
    reset_fifo();
    write(8'h77);
    read(temp);
    if (temp == 8'h77) $display("TC_02 PASS: Read operation");
    else $display("TC_02 FAIL: Data mismatch");
  endtask

  task tc_03(); // Full Condition Test
    reset_fifo();
    for (i = 0; i < DEPTH; i++) write(i+10);
    if (full) $display("TC_03 PASS: FIFO is full");
    else $display("TC_03 FAIL: FIFO should be full");
  endtask

  task tc_04(); // Empty Condition Test
    reset_fifo();
    write(8'h22);
    read(temp);
    if (empty) $display("TC_04 PASS: FIFO is empty");
    else $display("TC_04 FAIL: FIFO should be empty");
  endtask

  task tc_05(); // Single Write/Read Test
    reset_fifo();
    write(8'h55);
    read(temp);
    if (temp == 8'h55) $display("TC_05 PASS: Single write/read");
    else $display("TC_05 FAIL: Data mismatch");
  endtask

  task tc_06(); // Multiple Writes Test
    reset_fifo();
    for (i = 0; i < DEPTH; i++) write(i + 20);
    if (full) $display("TC_06 PASS: Multiple writes");
    else $display("TC_06 FAIL: FIFO should be full");
  endtask

  task tc_07(); // Multiple Reads Test
    reset_fifo();
    for (i = 0; i < DEPTH; i++) write(i + 10);
    for (i = 0; i < DEPTH; i++) begin
      read(temp);
      if (temp !== (i + 10)) $display("TC_07 FAIL: Data mismatch at index %0d", i);
    end
    $display("TC_07 PASS: Multiple reads");
  endtask

  task tc_08(); // Reset Functionality Test
    reset_fifo();
    write(8'h99);
    rst = 1;
    #10 rst = 0;
    if (empty && !full) $display("TC_08 PASS: Reset clears FIFO");
    else $display("TC_08 FAIL: Reset did not clear FIFO");
  endtask

 task tc_09(); // Overflow Handling
    reset_fifo();
   for (i = 0; i < DEPTH; i++) write(i+20);
    write(8'hFF);
   if (full) $display("TC_09 PASS: Overflow handled");
   else $display("TC_09 FAIL: Overflow not handled");
  endtask

  task tc_10(); // Underflow Handling
    reset_fifo();
    read(temp);
    if (empty) $display("TC_10 PASS: Underflow handled");
    else $display("TC_10 FAIL: Underflow not handled");
  endtask

  task tc_11(); // Wrap-Around Test
    reset_fifo();
    for (i = 0; i < DEPTH; i++) write(i+10);
    for (i = 0; i < 2; i++) read(temp);
    for (i = 0; i < 2; i++) write(i + 100);
    for (i = 2; i < DEPTH; i++) read(temp);
    read(temp); read(temp);
    if (empty) $display("TC_11 PASS: Wrap-around test");
    else $display("TC_11 FAIL: FIFO not empty after wrap");
  endtask

  task tc_12(); // Simultaneous Read/Write Test
    reset_fifo();
    @(posedge clk);
    wr_en = 1; rd_en = 1; din = 8'hA5;
    @(posedge clk);
    wr_en = 0; rd_en = 0;
    if (!empty) $display("TC_12 PASS: Simultaneous R/W");
    else $display("TC_12 FAIL: FIFO should contain data");
  endtask

  initial begin
    if (!$value$plusargs("TESTCASE=%d", testcase)) begin
      $display("No TESTCASE provided. Use +TESTCASE=1 .. 12");
      $finish;
    end

    $display("\n=== Running TC_%0d ===", testcase);

    clk = 0;

    case (testcase)
      1:  tc_01();
      2:  tc_02();
      3:  tc_03();
      4:  tc_04();
      5:  tc_05();
      6:  tc_06();
      7:  tc_07();
      8:  tc_08();
      9:  tc_09();
      10: tc_10();
      11: tc_11();
      12: tc_12();
      default: $display("Unknown TESTCASE number: %0d", testcase);
    endcase

    #100;
    $finish;
  end

endmodule
