`timescale 1ns / 1ps
module elevator_controller(
    input clk,rst,
    input reg [2:0] current_floor,
    input [2:0] request_floor,
    input over_time,over_weight,
    output [2:0] next_floor,
    output timer_alert,weight_alert,
    output direction,complete
    );
logic [2:0] cf_temp1;
logic [2:0] cf_temp2;
logic [2:0] nf_temp;
logic timer_temp=1'b0,weight_temp=1'b0;
logic direction_temp=1'b0;
logic complete_temp=1'b0;

always_ff@(request_floor)
cf_temp1<=current_floor;

assign cf_temp2=cf_temp1;

always_ff@(posedge clk)
begin
if(rst==1'b0)
 begin
  if(over_weight==1'b0 && over_time==1'b0)
   begin
    if(cf_temp2<request_floor)
     begin
      cf_temp2<=cf_temp2+1;
      direction_temp<=1'b1;
      complete_temp<=1'b0;
     end
    else if(cf_temp2>request_floor)
     begin
      cf_temp2<=cf_temp2-1;
      direction_temp<=1'b0;
      complete_temp<=1'b0;
     end
    else if(cf_temp2==request_floor)
     begin
      cf_temp2<=cf_temp2;
      complete_temp<=1'b1;
      direction_temp<=1'b0;
     end
   end
 
  else if(over_weight==1'b1 && over_time==1'b0)
   begin
    weight_temp<=1'b1;
    timer_temp<=1'b0;
    complete_temp<=1'b1;
    cf_temp2<=cf_temp2;
    direction_temp<=1'b0;
   end
 
  else if(over_weight==1'b0 && over_time==1'b1)
   begin
    timer_temp<=1'b1;
    weight_temp<=1'b0;
    complete_temp<=1'b1;
    cf_temp2<=cf_temp2;
    direction_temp<=1'b0;
   end
 
  else
   begin
    cf_temp2<=cf_temp2;
    complete_temp<=1'b1;
    timer_temp<=1'b1;
    weight_temp<=1'b1;
    direction_temp<=1'b0;
   end
 end

else 
 begin
  cf_temp2<=cf_temp2;
  complete_temp<=1'b0;
  direction_temp<=1'b0;
  timer_temp<=1'b0;
  weight_temp<=1'b0;
 end
end

assign next_floor=cf_temp2;
assign timer_alert=timer_temp;
assign weight_alert=weight_temp;
assign direction=direction_temp;
assign complete=complete_temp;
endmodule


