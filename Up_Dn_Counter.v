
module Up_Dn_Counter(  
input [4:0]in,
input load, up, down, //load-->down-->up
input clk,


output reg [4:0] count,
output high, low
);
  
  wire value, addend;
  
  assign high=count[0] &count[1] &count[2] &count[3] &count[4];
  assign low=~(count[0] |count[1] |count[2] |count[3] |count[4]);
  
  
  assign  value =count+addend;
  assign addend= (down ==1)? 00001:11111;
  
  
  
  always @(posedge clk)
  begin
    
    if(load == 1)
      count<=in;
      
    else if(down == 1 && low == 0)
        count<=value;
        
    else if(up == 1 && high == 0 &&down != 1)
         count<=value;
    
    
  end
  
  
endmodule