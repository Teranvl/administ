module stack
(
    input  clock,
    input  reset,
    input  push,
    input  pop,

    input  [15:0] write_data,
    output [15:0] read_data
);

    reg [15:0] stack [0:3];

    assign read_data = stack [0];

    integer i;

    always @(posedge clock)
    begin
        if (reset)
        begin
            for (i = 0; i < 4; i = i + 1)
                stack [i] <= 0;
        end
        else if (push)
        begin
            for (i = 0; i < 4 - 1; i = i + 1)
                stack [i + 1] <= stack [i];

            stack [0] <= write_data;
        end
        else if (pop)
        begin
            for (i = 0; i < 4 - 1; i = i + 1)
                stack [i] <= stack [i + 1];

            stack [4 - 1] <= 0;
        end

    end

endmodule
