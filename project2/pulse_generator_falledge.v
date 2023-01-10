module pulse_generator_falledge
(
    output pulse,
    input clock, signal
);
    reg r1, r2, r3;

    always @(posedge clock) 
	 begin
        r1 <= signal;   // first stage of 2-stage synchronizer
        r2 <= r1;       // second stage of 2-stage synchronizer
        r3 <= r2;       // edge detector memory
    end

    assign pulse = !r2 && r3;   // pulse on falling edge
endmodule
