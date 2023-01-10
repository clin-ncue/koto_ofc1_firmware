/*
    OL_controller_5G
	 Author: Y.-C. Tung, arranged by C. Lin at Oct 27, 2022 
	   
       The automatic alignment block with diagnosis function.
		 The original was designed by Y.-C. Tung, I modifed it to fit with 5G block.

		 Comments were added for other developers to understand the logic faster.
		 
*/

module OL_Controller_5G(	
	clk,
	LIVE,
	data_tx,
	data_rx,
	ena_rx,
	data_out,
	ena_tx,
	datak,
	error,
	send_err
);

input wire clk;
input wire LIVE;
input wire [31:0] data_tx;
input wire [31:0] data_rx;
input wire ena_rx;

output reg [31:0] data_out;
output reg ena_tx = 1'b1;
output reg [3:0] datak;
output reg error = 1'b1;
output reg send_err = 1'b0;

reg error_reg = 1'b1;

// 
// constants
//
reg [31:0] pattern_align = 32'h3CBC3CBC;
reg [31:0] byteflip_test_word = 32'hFFFF0000;

//
// 0: alignment mode 1: test mode, 2: data mode
//
reg [1:0] mode = 2'b11; 

reg [19:0] control = 20'b0;
reg [10:0] cnt_pattern = 11'b0;

// split 32 bit words into 2 16-bit words
reg [15:0] pipe_rx0 [1:0];
reg [15:0] pipe_rx1 [1:0];

reg [15:0] counter = 16'b0;

always @(posedge clk)
begin
	
	// switch to alignment mode while LIVE is off.
	mode = (LIVE==1'b0)? 2'b00:mode;
	
	case(mode)
	
	// alignment mode (triggered while LIVE is off)
	2'b00: begin	
		//
		// switch transceiver to alignment mode by 20'hFDDDD clocks.
		// - set datak = 4'b1111
		// - data output should be alignment word.
		//
		ena_tx   = (control<20'hFDDDD)? 1'b0 : 1'b1;
		
		datak    = (control<20'hFDDDD)? 4'b1111 : 4'b0000;	
	   data_out = pattern_align; 
	
	   //
	   // "control" is continuously incremented until it hits 20'hFEEEE.	
		// When the LIVE is on, it switches to test mode.
		// - Send 0xFFFF0000 for one clock at LIVE rising edge(according to Joseph's design).
		// - Next clock goes to test mode.
		// 
		control = (control < 20'hFEEEE) ? (control + 1'b1) : control;

		if( control==20'hFEEEE && LIVE==1'b1 ) begin
		   mode = 2'b01;
			data_out = byteflip_test_word;
		end
		
		//
		// By default, error is reset to be 1'b1 during LIVE off. 
		// - error:    TLK error
	   // - send_err: 1'b1 if OL robustness has been tested.	
		//
		error = 1'b1;
		error_reg = 1'b1;
		cnt_pattern = 11'b0;
		send_err = 1'b0;
		
	end
	
	// test mode 
	2'b01: begin
	
	   // 
		// pipelined the inputs for two clocks for the consecutiveness check.
		// - pipe_rx0 for the lowest 16 bits.
		// - pipe_rx1 for the highest 16 bits.
		//
		pipe_rx0[1] = pipe_rx0[0];
		pipe_rx0[0] = data_rx[15:0];		
		
		pipe_rx1[1] = pipe_rx1[0];
		pipe_rx1[0] = data_rx[31:16];	
		
		//
		// set transceiver to operation mode (datak = 0)
		// start sending counter
		//
		ena_tx = 1'b1;
		datak = 4'b0000;
		
		//
		// the output is the concatanation of two 16-bit counter
		//
		data_out = {counter, counter};
		
		//
		// only when both 16-bit words can be correctly incremented 
		// for 2048 clocks is the error_reg = 1'b0;
		//
		cnt_pattern = (    (pipe_rx0[0]-pipe_rx0[1])==1'b1 
		                && (pipe_rx1[0]-pipe_rx1[1])==1'b1 ) 
						  ? cnt_pattern + 1'b1 : 10'b0;
						  
		error_reg = (cnt_pattern==11'b11111111111)? 1'b0 : error_reg;
		error = 1'b1;
		
		//
		// when control reaches 20'hFFFFF, switches to data mode.
		//    send_err = 1'b1: OL robustness has been tested.
		//    
		// 
		if(control==20'hFFFFF)
		begin
			mode = 2'b10;
			send_err = 1'b1;
			error = (ena_rx==1'b0)? 1'b0 : error_reg;
		end
		
		counter = counter + 1'b1;
		control = control + 1'b1;
		
	end
	
	// data mode
	2'b10: begin
	
	   //
		// start sending out the data_tx.
		//
		ena_tx = 1'b1;
		datak = 4'b0000;
		data_out = data_tx;
		send_err = 1'b1;
		
	end
	
	endcase
	
end

endmodule
