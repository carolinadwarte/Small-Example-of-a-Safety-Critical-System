pragma SPARK_Mode (ON);

with AS_IO_Wrapper;  use AS_IO_Wrapper; 

package body rocket_control is 
   
   procedure Temp_Measured is
      Temperature : Integer;
   begin
      AS_Put_Line("Please type in current temperature measured");
      loop
         AS_Get(Temperature,"Please type in an integer");
         exit when (Temperature >=0) and (Temperature <= Maximum_Possible_Temp);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Possible_Temp);
         AS_Put_Line("");
      end loop;
      System_Status.Measured_Temp := Temperature_Range(Temperature);
   end Temp_Measured;
   
   procedure Internal_Pressure_Measured is
      Internal_Pressure : Integer;
   begin
      AS_Put_Line("Please type in current internal pressure measured");
      loop
         AS_Get(Internal_Pressure,"Please type in an integer");
         exit when (Internal_Pressure >=0) and (Internal_Pressure <= Maximum_Possible_Internal_Pressure);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Possible_Internal_Pressure);
         AS_Put_Line("");
      end loop;
      System_Status.Measured_Internal_Pressure := Internal_Pressure_Range(Internal_Pressure);
   end Internal_Pressure_Measured;
   
   procedure Propulsion_Speed_Measured is
      Propulsion_Speed : Integer;
   begin
      AS_Put_Line("Please type in current propulsion speed measured");
      loop
         AS_Get(Propulsion_Speed,"Please type in an integer");
         exit when (Propulsion_Speed >=0) and (Propulsion_Speed <= Maximum_Possible_Propulsion_Speed);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Possible_Propulsion_Speed);
         AS_Put_Line("");
      end loop;
      System_Status.Measured_Propulsion_Speed := Propulsion_Speed_Range(Propulsion_Speed);
   end Propulsion_Speed_Measured;
   
   procedure Oxidizer_Level_Measured is
      Oxidizer_Level : Integer;
   begin
      AS_Put_Line("Please type in current oxidizer level measured");
      loop
         AS_Get(Oxidizer_Level,"Please type in an integer");
         exit when (Oxidizer_Level >=0) and (Oxidizer_Level <= Maximum_Possible_Oxidizer_Level);
         AS_Put("Please type in a value between 0 and ");
         AS_Put(Maximum_Possible_Oxidizer_Level);
         AS_Put_Line("");
      end loop;
      System_Status.Measured_Oxidizer_Level := Oxidizer_Level_Range(Oxidizer_Level);
   end Oxidizer_Level_Measured;
   
   procedure Fuel_Level_Measured is
      Fuel_Level : Integer;
   begin
      AS_Put_Line("Please type in current fuel level measured");
      loop
         AS_Get(Fuel_Level,"Please type in an integer");
         exit when (Fuel_Level >=0) and (Fuel_Level <= Maximum_Possible_Fuel_Level);
         AS_Put("Please type in a value between 0 and");
         AS_Put(Maximum_Possible_Fuel_Level);
         AS_Put_Line("");
      end loop;
      System_Status.Measured_Fuel_Level := Fuel_Level_Range(Fuel_Level);
   end Fuel_Level_Measured;
   
   function Rocket_Launch_Pad_Status_To_String (Rocket_Launch_Pad_Status :Rocket_Launch_Pad_Status_Type) return String is
   begin
      if (Rocket_Launch_Pad_Status = On_LaunchPad)
      then return "Liftoff not initiated" ;
      else return "Liftoff successfully started";
      end if;
   end Rocket_Launch_Pad_Status_To_String;
   
   procedure Print_Status is
   begin
      AS_Put("Temperature = ");
      AS_Put(Integer(System_Status.Measured_Temp));
      AS_Put_Line("");
      AS_Put("Internal Pressure = ");
      AS_Put(Integer(System_Status.Measured_Internal_Pressure));
      AS_Put_Line("");
      AS_Put("Propulsion Speed = ");
      AS_Put(Integer(System_Status.Measured_Propulsion_Speed));
      AS_Put_Line("");
      AS_Put("Oxidizer Level = ");
      AS_Put(Integer(System_Status.Measured_Oxidizer_Level));
      AS_Put_Line("");
      AS_Put("Fuel Level = ");
      AS_Put(Integer(System_Status.Measured_Fuel_Level));
      AS_Put_Line("");
      AS_Put("Rocket Launch Pad = ");
      AS_Put_Line(Rocket_Launch_Pad_Status_To_String(System_Status.Rocket_Launch_Pad_Status));
   end Print_Status;
   
   procedure Fuel_Check is
   begin 
      if Integer(System_Status.Measured_Fuel_Level) >= Critical_Fuel_Level 
      then AS_Put_Line("Fuel Level is between bounds");
      else AS_Put_Line("Fuel Level is not enough for liftoff");
      end if;
   end Fuel_Check;
   
   procedure Internal_Pressure_Check is
   begin 
      if Integer(System_Status.Measured_Internal_Pressure) >= Critical_Internal_Pressure
      then AS_Put_Line("Internal pressure is between bounds");
      else AS_Put_Line("Internal pressure is not enough for liftoff");
      end if;
   end Internal_Pressure_Check;
   
   procedure Temperature_Check is
   begin 
      if Integer(System_Status.Measured_Temp) >= Critical_Temp
      then AS_Put_Line("Temperature is between bounds");
      else AS_Put_Line("Temperature is too low for liftoff");
      end if;
   end Temperature_Check;
   
   procedure Propulsion_Speed_Check is
   begin 
      if Integer(System_Status.Measured_Propulsion_Speed) >= Critical_Propulsion_Speed
      then AS_Put_Line("Propulsion speed is between bounds");
      else AS_Put_Line("Propulsion speed is not enough for liftoff");
      end if;
   end Propulsion_Speed_Check;
   
   procedure Oxidizer_Check is
   begin 
      if Integer(System_Status.Measured_Oxidizer_Level) >= Critical_Oxidizer_Level
      then AS_Put_Line("Oxidizer Level is between bounds");
      else AS_Put_Line("Oxidizer Level is not enough for liftoff");
      end if;
   end Oxidizer_Check;

   procedure Initialization is
   begin
   AS_Init_Standard_Input;
   AS_Init_Standard_Output;
   System_Status := (Measured_Temp => 0,
                     Measured_Internal_Pressure => 0,
                     Measured_Propulsion_Speed => 0,
                     Measured_Oxidizer_Level => 0,
                     Measured_Fuel_Level => 0,
                     Rocket_Launch_Pad_Status => On_LaunchPad);
   end Initialization;
   
   procedure CheckTakeOff is 
begin
if Integer(System_Status.Measured_Temp) >= Critical_Temp and
          Integer(System_Status.Measured_Internal_Pressure) >= Critical_Internal_Pressure and
          Integer(System_Status.Measured_Propulsion_Speed) >= Critical_Propulsion_Speed and
          Integer(System_Status.Measured_Oxidizer_Level) >= Critical_Oxidizer_Level and
        Integer(System_Status.Measured_Fuel_Level) >= Critical_Fuel_Level then
         System_Status.Rocket_Launch_Pad_Status := Off_LaunchPad;
      end if;
end CheckTakeOff;

end rocket_control;   
     
