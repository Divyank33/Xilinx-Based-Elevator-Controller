module tb_elevator_controller();
reg clk,rst;
reg [2:0] current_floor;
reg [2:0] request_floor;
reg over_time,over_weight;
wire [2:0] next_floor;
wire timer_alert,weight_alert;
wire direction,complete;
elevator_controller a1 (clk,rst,current_floor,request_floor,over_time,over_weight,
                        next_floor,timer_alert,weight_alert,direction,complete);
initial begin
clk=1'b1;
rst=1'b1;  
end 

always #50 clk=~clk;   

initial begin
rst=1'b1;
over_time=1'b0;
over_weight=1'b0;
current_floor=4'd0;
request_floor=4'd0;
#100; 
rst=1'b0;
current_floor=4'd0;
request_floor=4'd3;
#400;
current_floor=4'd3;
request_floor=4'd5;
#400;
current_floor=4'd5;
request_floor=4'd2;
#600;
over_time=1'b1;
over_weight=1'b0;
#200;
over_time=1'b0;
over_weight=1'b1;
#200;
over_time=1'b1;
over_weight=1'b1;
#200;
rst=1'b1;
over_time=1'b0;
over_weight=1'b0;
end  
endmodule