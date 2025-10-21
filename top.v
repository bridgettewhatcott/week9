
module mux(
    input [1:0] Sel,
    input [3:0] Fred, Jill, CEO, You,
    input Enable,
    output [3:0] lib
);
    assign lib = Sel == 'b00 ? CEO :
    Sel == 'b01 ? You:
    Sel == 'b10 ? Fred: Jill;

endmodule

module demux(
    input [3:0] In,
    input [1:0]Sel, 
    output [3:0] LIB, FD, SC, RS

);

    assign LIB = (Sel == 'b00 ? In : 0); // Drive Y1 if Sel == 0
    assign FD = (Sel == 'b01 ? In : 0); // Drive Y2 if Sel == 1
    assign SC = (Sel == 'b10 ? In : 0); // Drive Y2 if Sel == 1
    assign RS = (Sel == 'b11 ? In : 0); // Drive Y2 if Sel == 1

endmodule


module top(
    input [15:0]sw,
    input btnL, btnU, btnD, btnR, btnC,
    output [15:0]led
    );
    wire [3:0]data;
    wire [1:0]mult;
    wire [1:0] demult;
    wire [1:0] enable;
    
    assign mult[0] = btnL;
    assign mult[1] = btnU;
    assign demult[0] = btnD;
    assign demult[1] = btnR;
    assign enable[0] = btnC;
    assign enable[1] = btnC;
    
    mux muxx(
        .CEO(sw[3:0]),
        .You(sw[7:4]),
        .Fred(sw[11:8]),
        .Sel(mult),
        .Jill(sw[15:12]),
        .lib(data[3:0])
    );
    demux demuxx(
        .In(data[3:0]),
        .LIB(led[3:0]),
        .FD(led[7:4]),
        .Sel(demult),
        .SC(led[11:8]),
        .RS(led[15:12])
    );
endmodule
