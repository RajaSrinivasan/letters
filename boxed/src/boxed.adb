with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions ; use Ada.Exceptions ;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io ; use Ada.Integer_Text_Io ;

with box ;
--  claohmjteiup 

procedure Boxed is
   defaultarg : constant String := "claohmjteiup" ;
   g : box.game ;
begin
   box.Initialize ;
   if Argument_Count >= 1
   then 
      if Argument(1) /= "."
      then
         g := box.Create(Argument(1));
      else
         g := box.Create(defaultarg) ;
      end if;
   Else 
      g := box.Create(defaultarg);
   end if ;

   if Argument_Count >= 2
   then
      box.MAXWORDSINSOLUTION := Integer'Value(Argument(2)) ;
   end if ;

   box.Show (g) ;
   box.Solve (g) ;
   Put("Total "); Put(box.totalsolutions); Put_Line(" solutions found");
   exception
      when boxe : box.INVALID_ARG => 
         Put("Invalid box argument "); Put(Exception_Message(boxe));
         New_Line ;
end Boxed;
