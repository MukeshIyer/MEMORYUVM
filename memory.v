module mem(clk,rst,addr,wdata,w_en,r_en,rdata);
input clk,rst,w_en,r_en;
input [7:0]wdata;
input [6:0]addr;
output reg [7:0]rdata;
integer i;
reg [7:0] mem[127:0];
always@(posedge clk)begin
	if(rst==1)begin
			rdata <=0;
			ready <=0;
			for(i=0;i<128;i=i+1) begin
				mem[i]<=0;
			end
		end
	else begin
		//WRITE
			if(w_en==1)begin	
				mem[addr]<=wdata;
				$display("mem wdata=%d",wdata);
			end
			//@(posedge clk);
			//w_en<=0;
		//READ
					
			if(r_en==1)begin
					rdata<=mem[addr];
				$display("mem rdata=%d",rdata);

			end
			
		//	@(posedge clk);
		//	r_en<=0;
		end	
end
endmodule
