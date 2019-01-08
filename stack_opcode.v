module stack_opcode
(
    input  clock,
    input  reset,
    input  push,
    input  pop,

    input  [3:0] write_data,
    output [3:0] read_data
);

    reg [3:0] stack [0:15];

    assign read_data = stack [0];

    integer i;

    always @(posedge clock)
    begin
        if (reset)
        begin
            for (i = 0; i < 16; i = i + 1)
                stack [i] <= 0;
        end
        else if (push)
        begin
            for (i = 0; i < 16 - 1; i = i + 1)
                stack [i + 1] <= stack [i];

            stack [0] <= write_data;
        end
        else if (pop)
        begin
            for (i = 0; i < 16 - 1; i = i + 1)
                stack [i] <= stack [i + 1];

            stack [16 - 1] <= 0;
        end

    end

endmodule
