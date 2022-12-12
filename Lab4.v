// Ripple counter (see Fig. 6.8(b))
`timescale 1 ns/100 ps
module Ripple_Counter_4bit (A3, A2, A1, A0, Count, Reset);
output A3, A2, A1, A0;
input Count, Reset;
// Instantiate complementing flip-flop
Comp_D_flip_flop F0 (A0, Count, Reset);
Comp_D_flip_flop F1 (A1, A0, Reset);
Comp_D_flip_flop F2 (A2, A1, Reset);
Comp_D_flip_flop F3 (A3, A2, Reset);
endmodule

// Complementing flip-flop with delay
// Input to D flip-flop = Q'
module Comp_D_flip_flop (Q, CLK, Reset);
    output Q;
    input CLK, Reset;
    reg Q;
    always @ (negedge CLK, posedge Reset)
        if (Reset) Q <= 1'b0;
        else Q <= #2 ~Q; // intra-assignment delay
endmodule

// Stimulus for testing four-bit ripple counter
module t_Ripple_Counter_4bit;
    reg Count;
    reg Reset;
    wire A0, A1, A2, A3;

// Instantiate ripple counter
    Ripple_Counter_4bit M0 (A3, A2, A1, A0, Count, Reset);
    always
    #5 Count = ~Count;
    initial begin
        $dumpfile("Lab4.vcd");
        $dumpvars(0, t_Ripple_Counter_4bit);

        Count = 1'b0;
        Reset = 1'b1;
        #4 Reset = 1'b0;
    end
    initial #170 $finish;

endmodule