pragma SPARK_Mode (ON);

with SPARK.Text_IO; use  SPARK.Text_IO;

--Checking conditions for liftoff:
--temperature, pressure, propulsion, fuel, oxidizer,
--if these conditions are met the rocket starts takeoff.

package rocket_control is 
   
   Maximum_Possible_Temp : constant Integer := 3300;
   Critical_Temp : constant Integer := 12;
   type Temperature_Range is new Integer range 0 .. Maximum_Possible_Temp;
   
   Maximum_Possible_Internal_Pressure : constant Integer := 200;
   Critical_Internal_Pressure : constant Integer := 10;
   type Internal_Pressure_Range is new Integer range 0 .. Maximum_Possible_Internal_Pressure;
   
   Maximum_Possible_Propulsion_Speed : constant Integer := 365000;
   Critical_Propulsion_Speed : constant Integer := 40000;
   type Propulsion_Speed_Range is new Integer range 0 .. Maximum_Possible_Propulsion_Speed;
   
   Maximum_Possible_Oxidizer_Level : constant Integer := 80;
   Critical_Oxidizer_Level : constant Integer := 70;
   type Oxidizer_Level_Range is new Integer range 0 .. Maximum_Possible_Oxidizer_Level;
   
   Maximum_Possible_Fuel_Level : constant Integer := 1540000;
   Critical_Fuel_Level : constant Integer := 770000;
   type Fuel_Level_Range is new Integer range 0 ..Maximum_Possible_Fuel_Level;
   
   --is rocket on launch pad
   --On_LaunchPad -> Liftoff did not occur / Off_LaunchPad -> Liftoff occured
   type Rocket_Launch_Pad_Status_Type is (On_LaunchPad, Off_LaunchPad);
   
   type System_Status_Type is 
      record
         Measured_Temp : Temperature_Range;
         Measured_Internal_Pressure : Internal_Pressure_Range;
         Measured_Propulsion_Speed : Propulsion_Speed_Range;
         Measured_Oxidizer_Level : Oxidizer_Level_Range;
         Measured_Fuel_Level : Fuel_Level_Range;
         Rocket_Launch_Pad_Status : Rocket_Launch_Pad_Status_Type;
      end record;
   
   System_Status : System_Status_Type;
   
   procedure Temp_Measured with
     Global => (In_Out => (Standard_Output, Standard_Input,System_Status)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 System_Status   => (System_Status, Standard_Input));
   
   procedure Internal_Pressure_Measured with
     Global => (In_Out => (Standard_Output, Standard_Input,System_Status)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 System_Status   => (System_Status, Standard_Input));
   
   procedure Propulsion_Speed_Measured with
     Global => (In_Out => (Standard_Output, Standard_Input,System_Status)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 System_Status   => (System_Status, Standard_Input));
   
   procedure Oxidizer_Level_Measured with
     Global => (In_Out => (Standard_Output, Standard_Input,System_Status)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 System_Status   => (System_Status, Standard_Input));
   
   procedure Fuel_Level_Measured with
     Global => (In_Out => (Standard_Output, Standard_Input,System_Status)),
     Depends => (Standard_Output => (Standard_Output,Standard_Input),
                 Standard_Input  => Standard_Input,
                 System_Status   => (System_Status, Standard_Input));

   function Rocket_Launch_Pad_Status_To_String (Rocket_Launch_Pad_Status :Rocket_Launch_Pad_Status_Type) return String;
   
   procedure Print_Status with
     Global => (In_Out => Standard_Output, 
                Input  => System_Status),
     Depends => (Standard_Output => (Standard_Output,System_Status));
   
   function Is_Safe (Status : System_Status_Type) return Boolean is
     (if Integer(Status.Measured_Temp) >= Critical_Temp and
          Integer(Status.Measured_Internal_Pressure) >= Critical_Internal_Pressure and
          Integer(Status.Measured_Propulsion_Speed) >= Critical_Propulsion_Speed and
          Integer(Status.Measured_Oxidizer_Level) >= Critical_Oxidizer_Level and
          Integer(Status.Measured_Fuel_Level) >= Critical_Fuel_Level    
      then Status.Rocket_Launch_Pad_Status = Off_LaunchPad
      else Status.Rocket_Launch_Pad_Status = On_LaunchPad);
   
   procedure Fuel_Check with
     Global  => (In_Out => Standard_Output,
                Input => System_Status),
     Depends => (Standard_Output => (Standard_Output, System_Status)),
     Post    => Is_Safe(System_Status);
   
   procedure Internal_Pressure_Check with
     Global  => (In_Out => Standard_Output,
                Input => System_Status),
     Depends => (Standard_Output => (Standard_Output, System_Status)),
     Post    => Is_Safe(System_Status);
   
   procedure Temperature_Check with
     Global  => (In_Out => Standard_Output,
                Input => System_Status),
     Depends => (Standard_Output => (Standard_Output, System_Status)),
     Post    => Is_Safe(System_Status);
   
   procedure Propulsion_Speed_Check with
     Global  => (In_Out => Standard_Output,
                Input => System_Status),
     Depends => (Standard_Output => (Standard_Output, System_Status)),
     Post    => Is_Safe(System_Status);
   
   procedure Oxidizer_Check with
     Global  => (In_Out => Standard_Output,
                Input => System_Status),
     Depends => (Standard_Output => (Standard_Output, System_Status)),
     Post    => Is_Safe(System_Status);
   
   
   procedure Initialization with
     Global => (Output => (Standard_Output,Standard_Input,System_Status)),
     Depends => ((Standard_Output,Standard_Input,System_Status) => null),
     Post    => Is_Safe(System_Status);
   
   procedure CheckTakeOff;
    
end rocket_control;
