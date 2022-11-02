with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions ; use Ada.Exceptions ;
with Ada.Text_Io; use Ada.Text_Io;

with box ;
--  claohmjteiup 

procedure Boxed is
   defaultarg : constant String := "claohmjteiup" ;
   g : box.game ;
begin
   box.Initialize ;
   if Argument_Count >= 1
   then 
      g := box.Create(Argument(1));
   Else 
      g := box.Create(defaultarg);
   end if ;
   box.Show (g) ;
   box.Solve (g) ;

   exception
      when boxe : box.INVALID_ARG => 
         Put("Invalid box argument "); Put(Exception_Message(boxe));
         New_Line ;
end Boxed;
