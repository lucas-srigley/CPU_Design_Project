module booths_alg (
  input [31:0] A,
  input [31:0] B,
  output reg [63:0] C
);

  reg [31:0] X;
  reg [31:0] Y;
  reg [2:0] state;
  reg [5:0] count;

  always @(posedge clk or posedge rst) begin
    if (rst) begin
      X <= 0;
      Y <= {32'b0, B};
      state <= 3'b0;
      count <= 6'b0;
      product <= 64'b0;
    end else begin
      // Booth's algorithm state machine
      case (state)
        3'b000: begin // Initial state
          if (count < 6'b111111) begin
            Y <= {Y[31], Y[31:0]}; // Arithmetic right shift S
            count <= count + 1;
          end else begin
            state <= 3'b001;
          end
        end
        3'b001: begin // State for subtracting multiplicand
          Y <= Y - A;
          state <= 3'b010;
        end
        3'b010: begin // State for shifting and updating A
          Y <= {Y[31], Y[31:0]};
          X <= {X[30:0], Y[0]};
          state <= 3'b011;
        end
        3'b011: begin // Final state, prepare product
          X <= 0;
          state <= 3'b000;
          count <= 6'b0;
        end
        default: begin
          // Default case, should not occur
          state <= 3'b000;
        end
      endcase

      // Update product in each cycle
      C <= {X, Y};
    end
  end

endmodule