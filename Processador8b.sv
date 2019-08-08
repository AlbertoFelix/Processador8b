module Processador8b(
	

);



endmodule: Processador8b


module unidadeDeControle(
	input logic Z, L, LE, E, GE, G,
	input logic [7:0] A,
	input logic [16:0] C,
	
	output logic [7:0] PC, CTE
	output logic LOAD, RESET, LEBR,
	output logic [3:0] SRD, SBA, SBB, SULA
	output logic [1:0] S

);





endmodule: unidadeDeControle

module decoderUla(
	input logic [4:0] C,
	
	output logic [3:0] SULA,
	output logic LE, JMP, SDS
	);
	
	always_comb
		begin
			
			SULA[3] = (~C[4] & C[3] & ~C[2]) || (~C[4] & C[3] & C[2] & C[0]) ||
						 (~C[4] & ~C[3] & C[2] & C[1]) || (C[4] & ~C[3] & ~C[2] & C[1]);
			
			SULA[2] = (~C[4] & ~C[3] & ~C[2] & C[1]) || (~C[4] & C[3] & C[2] & C[0]) || 
						 (~C[4] & C[3] & C[2] & C[1]) || (C[4] & ~C[3] & ~C[2] & ~C[1]) ||
						 (~C[4] & ~C[3] & C[2] & ~C[1] & ~C[0]);
			
			SULA[1] = (~C[4] & C[3] & C[0]) || (~C[4] & C[3] & C[1]) || 
					    (~C[4] & ~C[3] & ~C[2] & ~C[1]);
						 
			SULA[0] = (~C[4] & C[1] & C[0]) || (~C[4] & ~C[3] & ~C[2] & C[1]) ||
						 (~C[4] & C[2] & ~C[1] & ~C[0]) || (~C[4] & C[3] & ~C[1] & ~C[0]) ||
						 (~C[4] & C[3] & C[2] & ~C[0]) || (C[4] & ~C[3] & ~C[2] & ~C[1] & C[0]);
						
			SDS = (~C[4] & ~C[3] & ~C[2] & C[0]) || (~C[4] & ~C[3] & C[2] & ~C[0]) ||
				   (~C[4] & C[3] & ~C[2] & ~C[0]) || (~C[4] & C[3] & C[2] & C[1]);
					
			JMP = (~C[4] & ~C[3] & C[2] & ~C[1] & ~C[0]) || (C[4] & ~C[3] & C[2] & C[1] & ~C[0]);
	
			LE = ~C[4] || (~C[3] & ~C[2]) || (~C[3] & ~C[1]);
 			
			
		end
	
	


endmodule: decoderUla

module decoderMuxCteIn(
	input logic [4:0] cMux,
	output logic [1:0] S,
	output logic inDecoder, outDecoder, muli, mul
	);
	
	S[0] = (~cMux[4] & ~cMux[3] & cMux[2] & ~cMux[1] & ~cMux[0]) ||
			 (cMux[4] & ~cMux[3] & ~cMux[2] & cMux[1] & cMux[0])	;
			 
	S[1] = 
	
	
endmodule: decoderMuxCteIn