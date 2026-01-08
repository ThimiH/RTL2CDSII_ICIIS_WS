// Sequential, resource-optimized implementation of Design 6 adder.
module design6_seq #(parameter WIDTH = 4) (
    input  wire                   clk,
    input  wire                   rst_n,
    input  wire                   start,
    input  wire [WIDTH-1:0]       A,
    input  wire [WIDTH-1:0]       B,
    input  wire [WIDTH-1:0]       C,
    input  wire [WIDTH-1:0]       D,
    output reg  [WIDTH+1:0]       F,
    output reg                    valid
);
    reg [1:0] mux_sel;
    reg       clear_acc;
    reg       enable_acc;
    reg       load_output;

    reg [WIDTH-1:0] mux_out;
    wire [WIDTH+1:0] add_out;
    reg  [WIDTH+1:0] acc_reg;

    localparam IDLE  = 3'd0,
               ADD_A = 3'd1,
               ADD_B = 3'd2,
               ADD_C = 3'd3,
               ADD_D = 3'd4,
               DONE  = 3'd5;

    reg [2:0] current_state, next_state;

    always @(*) begin
        case (mux_sel)
            2'b00: mux_out = A;
            2'b01: mux_out = B;
            2'b10: mux_out = C;
            2'b11: mux_out = D;
            default: mux_out = {WIDTH{1'b0}};
        endcase
    end

    assign add_out = mux_out + acc_reg;

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            acc_reg <= {WIDTH+2{1'b0}};
        else if (clear_acc)
            acc_reg <= {WIDTH+2{1'b0}};
        else if (enable_acc)
            acc_reg <= add_out;
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            F <= {WIDTH+2{1'b0}};
            valid <= 1'b0;
        end else if (load_output) begin
            F <= acc_reg;
            valid <= 1'b1;
        end else begin
            valid <= 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            current_state <= IDLE;
        else
            current_state <= next_state;
    end

    always @(*) begin
        next_state  = current_state;
        mux_sel     = 2'b00;
        clear_acc   = 1'b0;
        enable_acc  = 1'b0;
        load_output = 1'b0;

        case (current_state)
            IDLE: begin
                clear_acc = 1'b1;
                if (start)
                    next_state = ADD_A;
            end
            ADD_A: begin
                mux_sel    = 2'b00;
                enable_acc = 1'b1;
                next_state = ADD_B;
            end
            ADD_B: begin
                mux_sel    = 2'b01;
                enable_acc = 1'b1;
                next_state = ADD_C;
            end
            ADD_C: begin
                mux_sel    = 2'b10;
                enable_acc = 1'b1;
                next_state = ADD_D;
            end
            ADD_D: begin
                mux_sel    = 2'b11;
                enable_acc = 1'b1;
                next_state = DONE;
            end
            DONE: begin
                load_output = 1'b1;
                next_state  = IDLE;
            end
            default: begin
                next_state = IDLE;
            end
        endcase
    end
endmodule
