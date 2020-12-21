module RAM_512x64 (
`ifdef USE_POWER_PINS
    input           VPWR,
    input           VGND,
`endif
    input           CLK,
    input   [7:0]   WE,
    input           EN,
    input   [63:0]  Di,
    output  [63:0]  Do,
    input   [8:0]   A
);
   
    DFFRAM #(.COLS(2)) LBANK (
            `ifdef USE_POWER_PINS
                .VPWR(VPWR),
                .VGND(VGND),
            `endif
                .CLK(CLK),
                .WE(WE[3:0]),
                .EN(EN),
                .Di(Di[31:0]),
                .Do(Do[31:0]),
                .A(A[8:0])
            );

    DFFRAM #(.COLS(2)) HBANK (
            `ifdef USE_POWER_PINS
                .VPWR(VPWR),
                .VGND(VGND),
            `endif
                .CLK(CLK),
                .WE(WE[7:4]),
                .EN(EN),
                .Di(Di[63:32]),
                .Do(Do[63:32]),
                .A(A[8:0])
            );

endmodule        
