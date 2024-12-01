module ddr3_vga_ctrl(
	input clk,
	input reset_n,
	//slave����
	input chipselect,
	input [1:0]as_address,
	input as_write,
	input [31:0]as_writedata,
	input as_read,
	output reg[31:0]as_readdata,
	
	//control����
	output reg[31:0]control_user_base,
	output reg[31:0]control_user_length,
	output control_go,
	output [1:0]control_en,
	input control_state
);

	reg [2:0]control;
	
	assign control_go = control[0];
	assign control_en = control[2:1];

	//���δ����Ĵ���
	always@(posedge clk or negedge reset_n)
	if(!reset_n)
		control <= 0;
	else if(chipselect && as_write)begin
		if(as_address == 2'd0)
			control <= as_writedata[2:0];
		else begin
			control[0] <= 0;
			control[2:1] <= control[2:1];
		end
	end
	else begin
		control[0] <= 0;
		control[2:1] <= control[2:1];
	end

	//����ַ�Ĵ���
	always@(posedge clk or negedge reset_n)
	if(!reset_n)
		control_user_base <= 32'hffffffff;	//��λ����Ϊ���ֵ����ֹ���ⴥ���������𻵴洢��������
	else if(chipselect && as_write)begin
		if(as_address == 2'd1)
			control_user_base <= as_writedata;
		else
			control_user_base <= control_user_base;
	end
	else
		control_user_base <= control_user_base;
	
	//���䳤�ȼĴ���
	always@(posedge clk or negedge reset_n)
	if(!reset_n)
		control_user_length <= 32'd0;	
	else if(chipselect && as_write)begin
		if(as_address == 2'd2)
			control_user_length <= as_writedata;
		else
			control_user_length <= control_user_length;
	end
	else
		control_user_length <= control_user_length;		
	
	//����ַ�Ĵ���
	always@(posedge clk or negedge reset_n)
	if(!reset_n)
		as_readdata <= 32'd0;	//��λ����Ϊ���ֵ����ֹ���ⴥ���������𻵴洢��������
	else if(chipselect && as_read)begin
		case(as_address)
			0:as_readdata <= control;
			1:as_readdata <= control_user_base;
			2:as_readdata <= control_user_length;
			3:as_readdata <= {31'd0,control_state};
		endcase	
	end

endmodule