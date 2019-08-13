`include "datapath.sv"
`include "registersBankSC.sv"
`include "ulaProcSc.sv"

module Processador8b(
	input logic in[7:0],
	input logic clock,
	input logic [16:0] C,
	output logic [7:0] pOut

);

logic [7:0] barPc, barOutPc;
logic [1:0] barLR;
logic [4:0] outComparator;

logic [7:0] barCTe;
logic [4:0] barSRd, barSBa, barSBb, barSULa;
logic barLEBr;
logic [1:0] barS;


programCounter pCounter(barPc, barLR[1], barLR[0], barOutPc);

datapath dataPATH(in, barCTe, barSRd, barSBa, barSBb, barSULa, barS, clock, barLEBr, pOut, outComparator);

unidadeDeControle controlUnit(Z, outComparator[0], outComparator[1], outComparator[2],
										outComparator[3], outComparator[4], barOutPc, C, barPc, 
										barCTe, barLR[0], barLR[1], barLEBr, barSRd, barSBa, barSBb, barSULa, barS);

endmodule: Processador8b


module unidadeDeControle(
	input logic Z, L, LE, E, BE, B,
	input logic [7:0] A,
	input logic [16:0] C,
	
	output logic [7:0] PC, CTE,
	output logic LOAD, RESET, LEBR,
	output logic [3:0] SRD, SBA, SBB, uSULA,
	output logic [1:0] S

);
	always_comb
		begin
			case (C[16:12])
			//***Instruções aritméticas e lógicas
				5'd0:
					begin
						uSULA = 4'b0010;
						SRD = C[11:8];
						SBA = C[7:4];
						SBB = C[3:0];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd1: 
					begin
						uSULA = 4'b0010;
						SRD = C[11:8];
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						
						break;
					end
				5'd2:
					begin
						uSULA = 4'b0101;
						SRD = C[11:8];
						SBA = C[7:4];
						SBB = C[3:0];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd3:
					begin
						uSULA = 4'b0101;
						SRD = C[11:8];
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						break;
					end
				5'd4:
					begin
						uSULA = 4'b0101;
						SRD = C[11:8];
						SBB = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b10;
						break;
					end
				5'd5:
					begin
						uSULA = 4'b1000;
						SRD = C[11:8];
						SBA = C[7:4];
						SBB = C[3:0];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd6:
					begin
						uSULA = 4'b1000;
						SRD = C[11:8];
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						break;
					end
				5'd7:
					begin
						uSULA = 4'b1001;
						SRD = C[11:8];
						SBA = C[7:4];
						SBB = C[3:0];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd8:
					begin
						uSULA = 4'b1001;
						SRD = C[11:8];
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						break;
					end
				5'd9:
					begin
						uSULA = 4'b1010;
						SRD = C[11:8];
						SBA = C[7:4];
						SBB = C[3:0];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd10:
					begin
						uSULA = 4'b1010;
						SRD = C[11:8];
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						break;
					end
				5'd11:
					begin
						uSULA = 4'b1011;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd12:
					begin
						uSULA = 4'b0001;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd13:
					begin
						uSULA = 4'b0110;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd14:
					begin
						uSULA = 4'b0111;
						SRD = 4'b1110;
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd15:
					begin
						uSULA = 4'b0111;
						SRD = 4'b1110;
						SBA = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b01;
						break;
					end
				5'd16:
					begin
						uSULA = 4'b1100;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd17:
					begin
						uSULA = 4'b1101;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
					
				//***Instruções de transferência de dados
				5'd18:
					begin
						uSULA = 4'b0000;
						SRD = C[11:8];
						SBA = C[7:4];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd19:
					begin
						uSULA = 4'b0000;
						SRD = C[11:8];
						CTE = C[7:0];
						LEBR = 1;
						LOAD = 0;
						S = 2'b10;
						break;
					end
				5'd20:
					begin
						uSULA = 4'b0000;
						SRD = 4'b1010;
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				5'd21:
					begin
						uSULA = 4'b0000;
						SRD = 4'b1011;
						SBA = C[11:8];
						LEBR = 1;
						LOAD = 0;
						S = 0;
						break;
					end
				
				//***Instruções de desvio
				5'd22:
					begin
						PC = C[11:4];
						LEBR = 0;
						RESET = 0;
						LOAD = 1;
						break;
					end
				5'd23:
					begin
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(L)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd24:
					begin
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(LE)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd25:
					begin
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(E)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd26:
					begin
						SBA = C[11:8];
						SBB = c[7:4];
						LEBR = 0;
						S = 0;
						if(~E)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd27:
					begin
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(BE)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd28:
					begin
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(B)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				5'd29:
					begin
						uSULA = 4'b0000;
						SBA = C[11:8];
						SBB = C[7:4];
						LEBR = 0;
						S = 0;
						if(L)
							begin
								PC = A + 2;
								RESET = 0;
								LOAD = 1;
							end
						break;
					end
				
				//***Instruções de controle do processador
				5'd30:
					begin
						RESET = 0;
						LOAD = 0;
						break;
					end
				5'd31:
					begin
						RESET = 1;
						LOAD = 0;
						break;
					end
			endcase
		end
	
endmodule: unidadeDeControle

module programCounter(
	input logic [7:0] pc,
	input logic load, reset, uClk,
	output logic [7:0] outProgramCounter
);

	always_ff @(posedge uClk)
		begin
			if(reset)
				outProgramCounter <= 0;
			else
				begin
					if(load)
						outProgramCounter <= pc + 1;
					else
						outProgramCounter <= outProgramCounter + 1;
				end
		end

endmodule: programCounter