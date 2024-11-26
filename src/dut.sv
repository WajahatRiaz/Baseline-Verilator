module dut(
	/*verilator coverage_off*/
	input logic clk,
	input logic rst,
	input logic [15:0] a_in,
	input logic [15:0] b_in,
	output logic [31:0] c_out
	/*verilator coverage_on*/
);

always_ff @( posedge clk ) begin : flopLogic 
	if (!rst) c_out <= 0;
	else begin
		c_out <= {a_in, b_in};
	end

end

endmodule