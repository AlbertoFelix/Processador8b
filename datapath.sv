`include "registersBankSC/registersBankSC.sv"
`include "ulaProcSc/ulaProcSc.sv"

module datapath(
	input logic [7:0] In, CTE,
	input logic [3:0] SRD, SBA, SBB, SULA,
	input logic [1:0] selMuxCTE,
	input logic clk, LE,
	
	output logic [7:0] outDataPath,
	output logic [4:0] outComparator, // Saída para testes de comparação entre palavras.
	output logic [7:0] outUlaF
	
);

logic [7:0] outMuxA, outMuxB, outBankA, outBankB;
//logic [4:0] outComparator;  
logic [15:0] outUla;


muxCTE_In muxCTE(CTE, outBankA, outBankB, selMuxCTE, outMuxA, outMuxB);
					  
comparatorValues comparator(outMuxA, outMuxB, outComparator);

registersBankSC bank(outUla[7:0], outUla[15:8], In, clk, SRD, LE, SBA, SBB, outBankA, outBankB, outDataPath);
							
ulaProcSc ula(outMuxA, outMuxB, SULA, outUla);

assign outUlaF = outMuxA;



endmodule: datapath

module muxCTE_In(
	input logic [7:0] CTE, inMuxCTE_A, inMuxCTE_B,
	input [1:0] selInCTE,
	output logic [7:0] outMuxCTE_A, outMuxCTE_B
);

	always_comb
		begin
			case(selInCTE)

					2'b00: 
						begin
							outMuxCTE_A = inMuxCTE_A;
							outMuxCTE_B = inMuxCTE_B;
						end
					2'b01:
						begin
							outMuxCTE_A = CTE;
							outMuxCTE_B = inMuxCTE_B;
						end
					2'b10:
						begin
							outMuxCTE_A = inMuxCTE_A;
							outMuxCTE_B = CTE;
						end
					2'b11:
						begin
							outMuxCTE_A = CTE;
							outMuxCTE_B = CTE;
						end
					default: 
						begin
							outMuxCTE_A = inMuxCTE_A;
							outMuxCTE_B = inMuxCTE_B;
						end
			endcase
		end

endmodule: muxCTE_In

module comparatorValues(
	input logic [7:0] word_A, word_B,
	output logic [4:0] compared//[0]lower, [1]lower_equal, [2]equal, [3]greater_equal, [4]greater;
);

	always_comb
		begin
			if(word_A < word_B)
				compared = 5'b00011;
			else if(word_A == word_B)
				compared = 5'b01110;
			else
				compared = 5'b11000;
		end

endmodule: comparatorValues