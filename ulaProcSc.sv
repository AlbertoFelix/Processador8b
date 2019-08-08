module ulaProcSc(
	input logic [7:0] A,
	input logic [7:0] B,
	input logic [3:0] SULA,
	output logic [15:0] S /* [8]S == carryout das operacoes de 8 bits
		[15:8] S --> saida P para operaÃ§ao de multiplicaÃ§ao que esta na especificaÃ§ao
	*/
	
);
	
	always_comb
		begin
			
			if(SULA == 4'd0)
				S = A;
			else if(SULA == 4'd1)
				S = A + 8'd1;
			else if(SULA == 4'd2)
				S = A + B;
			else if(SULA == 4'd3) 
				S = A + B + 8'd1;
			else if(SULA == 4'd4) 
				begin
					S = A + ~B;
				end
			else if(SULA == 4'd5)
				S = A - B;
			else if(SULA == 4'd6)
				S = A - 8'd1;
			else if(SULA == 4'd7) 
				begin
					S = A * B;
				end
			else if(SULA == 4'd8)
				S = A & B;
			else if(SULA == 4'd9)
				S = A | B;
			else if(SULA == 4'd10)
				S = A ^ B;
			else if(SULA == 4'd11)
				S = ~A;
			else if(SULA == 4'd12)
				S = A << 1;
			else if(SULA == 4'd13)
				S = A >> 1;
			else
				S = A;
			
		end
	
endmodule	