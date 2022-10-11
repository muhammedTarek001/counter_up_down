module Up_Dn_Counter_tb  () ;
  

// all design inputs are defined in testbench as reg to be used inside initial block 
// all design outputs are defined in testbench as wire   
  reg    [4:0]     IN_tb;
  reg              Load_tb, Up_tb, Down_tb;
  reg              clk_tb;
  wire   [4:0]     Counter_tb;  
  wire             High_tb, Low_tb ;
  
  
//initial block
initial 
  begin
    $dumpfile("Up_Dn_Counter.vcd") ;
    $dumpvars ;
    //initial values
    IN_tb = 5'b01010 ;  // 10 decimal 
    Load_tb = 1'b0 ;
    Up_tb = 1'b0 ;
    Down_tb = 1'b0 ;
    clk_tb = 1'b0 ;
    
    $display ("TEST CASE 1") ;  // test Load Function
    #3
    Load_tb = 1'b1 ;
    Up_tb = 1'b0 ;
    Down_tb = 1'b0 ; 
    #7
    if(Counter_tb != 5'b01010)
      $display ("TEST CASE 1 IS FAILED") ;
    else
      $display ("TEST CASE 1 IS PASSED") ;

    $display ("TEST CASE 2") ;  // test Load has highest priority
    #3
    Load_tb = 1'b1 ;
    Up_tb = 1'b1 ;
    Down_tb = 1'b1 ; 
    #7
    if(Counter_tb != 5'b01010)
      $display ("TEST CASE 2 IS FAILED") ;
    else
      $display ("TEST CASE 2 IS PASSED") ;    

    $display ("TEST CASE 3") ;  // Test Down Function
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b0 ;
    Down_tb = 1'b1 ; 
    #27
    if(Counter_tb != 5'b00111)
      $display ("TEST CASE 3 IS FAILED") ;
    else
      $display ("TEST CASE 3 IS PASSED") ;
    
    $display ("TEST CASE 4") ;  // test Down has higher priority than Up
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b1 ;
    Down_tb = 1'b1 ; 
    #37
    if(Counter_tb != 5'b00011)
      $display ("TEST CASE 4 IS FAILED") ;
    else
      $display ("TEST CASE 4 IS PASSED") ;        

    $display ("TEST CASE 5") ;  // test if all control signals are down
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b0 ;
    Down_tb = 1'b0 ; 
    #37
    if(Counter_tb != 5'b00011)
      $display ("TEST CASE 5 IS FAILED",Counter_tb) ;
    else
      $display ("TEST CASE 5 IS PASSED") ; 

    $display ("TEST CASE 6") ;  // test Low signal
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b0 ;
    Down_tb = 1'b1 ; 
    #27
    if(Low_tb != 1'b1)
      $display ("TEST CASE 6 IS FAILED") ;
    else
      $display ("TEST CASE 6 IS PASSED") ;    

    $display ("TEST CASE 7") ;  // test Up Function
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b1 ;
    Down_tb = 1'b0 ; 
    #97
    if(Counter_tb != 5'b01010)
      $display ("TEST CASE 7 IS FAILED") ;
    else
      $display ("TEST CASE 7 IS PASSED") ; 
    
    $display ("TEST CASE 8") ;  // test Up Function
    #3
    Load_tb = 1'b0 ;
    Up_tb = 1'b1 ;
    Down_tb = 1'b0 ; 
    #207
    if(Counter_tb != 5'b11111)
      $display ("TEST CASE 8 IS FAILED") ;
    else
      $display ("TEST CASE 8 IS PASSED") ;        
    
    #100
    $finish ;
    
  end
  
// Clock Generator  
  always #5 clk_tb = !clk_tb ;
  
// instaniate design instance 
  Up_Dn_Counter DUT (
    .in(IN_tb),
    .load(Load_tb), 
    .up(Up_tb), 
    .down(Down_tb),
    .clk(clk_tb),
    .count(Counter_tb),
    .high(High_tb),
    .low(Low_tb)
  );

  
  endmodule
  