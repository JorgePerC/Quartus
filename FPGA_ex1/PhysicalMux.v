module PhysicalMux (
	input A,
	input B,
	input select,
	output m_out
	
);

assign m_out = (select) ? A : B;

endmodule