pragma SPARK_Mode (On);

with rocket_control;
use rocket_control;

procedure main is
begin
   Initialization;
   loop
      Temp_Measured;
      Internal_Pressure_Measured;
      Propulsion_Speed_Measured;
      Oxidizer_Level_Measured;
      Fuel_Level_Measured;
      
      Temperature_Check;
      Internal_Pressure_Check;
      Propulsion_Speed_Check;
      Oxidizer_Check;
      Fuel_Check;
      CheckTakeOff;
      Print_Status;
   end loop;
   
end main;
