module test
(
    input         clock,
    input         reset,
    input         enter,
	 input			check,
	 input 			add,
	 input 			swap,
	 input			pop,
	 input  [ 3:0] write_opcode,
    input  [ 7:0] data,
    output [15:0] result,
	 output [15:0] result1,
	 output [15:0] result2,
	 output [15:0] result3,
	 output [15:0] result4,
    output [ 3:0] error
);

    assign error = 0;
	 
	 reg  [3:0]  opcode;
 
    reg         stack_push;
    reg         stack_pop;
	 reg  [15:0] res;
    reg  [15:0] stack_write_data;
    wire [15:0] stack_read_data;
	 
	 reg  [15:0] sy1;
	 reg  [15:0] sy2;
	 
	 reg  [ 1:0] state;
    reg  [ 1:0] next_state;
	 
	 reg  [15:0] sw1;
	 reg  [15:0] sw2;
	 
	 reg  [15:0] fun;
	 


    stack stack
    (
        .clock      ( clock            ),
        .reset      ( reset            ),
        .push       ( stack_push       ),
        .pop        ( stack_pop        ),
        .write_data ( stack_write_data ),
        .read_data  ( stack_read_data  )
    );
	 

    assign result  = res;  // тут был res
	 assign result1 = sy1;
	 assign result2 = sy2;
	 assign result3 = sw1;
	 assign result4 = sw2;
	 
	 
	 always @(*)
    begin
		  opcode = write_opcode;
        stack_push       = 0;
        stack_pop        = 0;
		  next_state       = state;
			
		  case(opcode)
		  
		  4'b0001:   // enter (push)
		  begin
				   stack_write_data = data;	 
					stack_push       = 1;
					
		  end
		  
		  4'b0010:    //check
		  begin
					stack_pop = 1;
					res   = stack_read_data;
						
		  end
		  
		  4'b0011:		//add
		  begin
					stack_pop  = 1;
					sy1        = stack_read_data;
					next_state = 1;
		  end
		  
		  4'b0100:			//swap
		  begin
				   stack_pop  = 1;
					sw1        = stack_read_data;
					next_state = 2;
		  end
		  
		  4'b0101:			//pop
		  begin
					stack_pop  = 1;
					fun = stack_read_data;
					fun =0;
					next_state = 0;
		  end
		  endcase
	 
	 
		  case(state)
		  1:
				begin
					stack_pop        = 1;
					sy2              = stack_read_data;
					stack_write_data = sy1 + sy2;
					stack_push       = 1;
					next_state       = 0;
				end
		  2:
				begin
					stack_pop        = 1;
					sw2              = stack_read_data;
					stack_write_data = sw1;
					stack_push       = 1;
					next_state       = 3;
				end
		  3:
				begin
					stack_write_data = sw2;
					stack_push       = 1;
					next_state       = 0;
				
				end
		  endcase
	 
	 end
	 

	 	always @(posedge clock)
		begin
		  opcode = 4'b0000;
		  state     <= next_state;
		  
		  if (reset)
        begin
            state     <= 0;
        end
		end
		
	 


endmodule
