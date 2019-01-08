module main
(
		input clock,
		input reset,
		input  [3:0] opcode,
		input  [7:0]data,
		input  CALLproc,
		input  RET,
		output [15:0] result,
		output [15:0] result1,
		output [15:0] result2,
		output [15:0] result3,
		output [15:0] result4
	
);


		 test test (
		.clock        (clock),
		.reset 	      (reset),
		.write_opcode (op),   
		.data	      (data),
		.result	      (result),
		.result1      (result1),
		.result2      (result2),
		.result3      (result3),
		.result4      (result4)
		
		);
		
		
		stack_opcode stack_opcode
    (
        .clock      ( clock            ),
        .reset      ( reset            ),
        .push       ( stack_push       ),
        .pop        ( stack_pop        ),
        .write_data ( stack_write_data ),
        .read_data  ( stack_read_data  )
    );
	 
	 reg         stack_push;
    	 reg         stack_pop;
	 reg  [3:0]  stack_write_data;
   	 wire [3:0]  stack_read_data;
	 reg 	[3:0]  op;


	 
	 always @(*)
	 begin
		  stack_push       = 0;
         	  stack_pop        = 0;
		  op=0;
	 
	 if(CALLproc)
	 begin
			stack_write_data = opcode;	 
			stack_push       = 1;
	 end
	 
	 if(RET)
	 begin
			stack_pop = 1;
			op = stack_read_data;
	 end
	 end
	 

endmodule
