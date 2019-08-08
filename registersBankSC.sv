module registersBankSC (Di, Xh, In, clk, SRD, LE, SBA, SBB, OutA, OutB, Out);
	/* Declarações de entrada e saída*/
	
	input logic [7:0] Di, Xh, In;                   
	input logic [3:0] SRD, SBA, SBB;
	input logic clk, LE;
	output logic [7:0] OutA, OutB, Out;
	
	/*Definições de barramentos OSR e OR*/
	
	logic [15:0] OutSelectRegister;  // Barramento de 16 bits
	logic [7:0] OutRegistors [15:0]; // 16 barramentos de 8 bits
	
	/* Declaração dos demux (das saídas OutA e OutB)*/
	
	demuxReg demuxA(OutRegistors, SBA, OutA);
	demuxReg demuxB(OutRegistors, SBB, OutB);
	
	/*Declaração dos 16 registradores do banco*/
	
	register reg0(Di, OutRegistors[0], clk, OutSelectRegister[0]);          // Di - Entrada do banco vinda da ULA (Unidade logica e aritimética)
	register reg1(Di, OutRegistors[1], clk, OutSelectRegister[1]);          // OutRegistors [16] - saída de 8bits do registrador que se conecta ao demux
	register reg2(Di, OutRegistors[2], clk, OutSelectRegister[2]);          // clk - clock invariante de modulo
	register reg3(Di, OutRegistors[3], clk, OutSelectRegister[3]);          // OutSelectRegister - Saida do selecionador de registrador (enable do reg)
	register reg4(Di, OutRegistors[4], clk, OutSelectRegister[4]);
	register reg5(Di, OutRegistors[5], clk, OutSelectRegister[5]);
	register reg6(Di, OutRegistors[6], clk, OutSelectRegister[6]);
	register reg7(Di, OutRegistors[7], clk, OutSelectRegister[7]);
	register reg8(Di, OutRegistors[8], clk, OutSelectRegister[8]);
	register reg9(Di, OutRegistors[9], clk, OutSelectRegister[9]);
	register regPIN(In, OutRegistors[10], clk, OutSelectRegister[10]);
	register regPOUT(Di, OutRegistors[11], clk, OutSelectRegister[11]);
	register regRcTimer(Di, OutRegistors[12], clk, OutSelectRegister[12]);
	registerTimer regTimer(Di, OutRegistors[13], clk, OutSelectRegister[13], OutRegistors[12][2], OutRegistors[12][1], OutRegistors[12][0], In[0]);
	register regXl(Di, OutRegistors[14], clk, OutSelectRegister[14]);           /* OutRegistors[12][2]: Clock_source - Escolher a fonte do clock (IN0/ CLK) */
	register regXh(Xh, OutRegistors[15], clk, OutSelectRegister[15]);           /* OutRegistors[12][1]: Direction - Escolher contagem crescente ou decrescente do timer */
	                                                                            /* OutRegistors[12][0]: enableTimer - Habilitar contagem do timer*/
																										 /* In[0]: Usar entrada In0 como o clock do contador*/
	/* Declaração do selectRegister (Barramento de seleção dos registradores)*/
	selectRegister selReg(clk, SRD, LE, OutSelectRegister);
	
	assign Out = OutRegistors[11]; // Saída do registrador de propósito específico "POUT"
	
endmodule: registersBankSC

module demuxReg(In_demux, sel_demux, Out_demux);
	input logic [7:0] In_demux [15:0];
	input logic [3:0] sel_demux;
	output logic [7:0] Out_demux;	
	
	always_comb 
		begin
			case(sel_demux)
				4'd0: Out_demux = In_demux[0];
				4'd1: Out_demux = In_demux[1];
				4'd2: Out_demux = In_demux[2];
				4'd3: Out_demux = In_demux[3];
				4'd4: Out_demux = In_demux[4];
				4'd5: Out_demux = In_demux[5];
				4'd6: Out_demux = In_demux[6];
				4'd7: Out_demux = In_demux[7];
				4'd8: Out_demux = In_demux[8];
				4'd9: Out_demux = In_demux[9];
				4'd10: Out_demux = In_demux[10];
				4'd11: Out_demux = In_demux[11];
				4'd12: Out_demux = In_demux[12];
				4'd13: Out_demux = In_demux[13];
				4'd14: Out_demux = In_demux[14];
				4'd15: Out_demux = In_demux[15];
				default: Out_demux = 7'b0;
			endcase
		end
endmodule: demuxReg


module selectRegister(clk, select_R, LE, Out_Register);
	input logic [3:0] select_R;
	input logic LE, clk;
	output logic [15:0] Out_Register;
	
	always @(posedge clk)
		begin
			if(LE == 1'b1)	
				case(select_R)
					4'd0: Out_Register =  16'b0000000000000001;
					4'd1: Out_Register =  16'b0000000000000010;
					4'd2: Out_Register =  16'b0000000000000100;
					4'd3: Out_Register =  16'b0000000000001000;
					4'd4: Out_Register =  16'b0000000000010000;
					4'd5: Out_Register =  16'b0000000000100000;
					4'd6: Out_Register =  16'b0000000001000000;
					4'd7: Out_Register =  16'b0000000010000000;
					4'd8: Out_Register =  16'b0000000100000000;
					4'd9: Out_Register =  16'b0000001000000000;
					4'd10: Out_Register = 16'b0000010000000000;
					4'd11: Out_Register = 16'b0000100000000000;
					4'd12: Out_Register = 16'b0001000000000000;
					4'd13: Out_Register = 16'b0010000000000000;
					4'd14: Out_Register = 16'b1100000000000000;
					4'd15: Out_Register = 16'b1100000000000000;
					default: Out_Register = 16'b0000000000000000;
				endcase
			else
				Out_Register = 16'b0000000000000000;
		end
endmodule: selectRegister

module register(In_register, Out_register, clk, en);
	
	input logic [7:0] In_register;
	input logic clk, en;
	output logic [7:0] Out_register;
	
	always @(posedge clk)
		begin
			if (en == 1'd1)
				Out_register = In_register;
		end 
endmodule: register

module registerTimer(In_timer, Out_timer, clk, select_timer, clk_source, Direction, en_timer, In_0);

	input logic [7:0] In_timer;
	input logic clk, en_timer, clk_source, Direction, select_timer, In_0;
	output logic [7:0] Out_timer;
	
	//assign uclk = ~Direction & ((In_0 & clk_source) | (clk & ~clk_source));
	
	logic [7:0] cont_clk;
	logic [7:0] cont_In0;
	
	always_ff @(posedge clk )
		begin
			if (clk_source == 1'd0)
				begin
					if (select_timer == 1'd1)
						cont_clk = In_timer;
					else 
						begin
							if (en_timer == 1'd1)
								begin
									if (~Direction)
										cont_clk += 1'd1;
									else
										cont_clk -= 1'd1;
								end
						end
				end
			
			
		end
		
	always_ff @(posedge In_0)
		begin
			if (clk_source == 1'd1)
				begin
					if (select_timer == 1'd1)
						cont_In0 = In_timer;
					else 
						begin
							if (en_timer == 1'd1)
								begin
									if (~Direction)
										cont_In0 += 1'd1;
									else
										cont_In0 -= 1'd1;
								end
						end
				end
		end
		
	always_ff @(*)
		begin
			if (clk_source == 1'd0)
				Out_timer = cont_clk;
			else
				Out_timer = cont_In0;
		end
	
		
	
				
	
endmodule: registerTimer