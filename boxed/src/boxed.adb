with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions ; use Ada.Exceptions ;
with Ada.Text_Io; use Ada.Text_Io;

with box ;

procedure Boxed is
   arg : String := Argument(1);
   g : box.game ;
   s : box.Steps_Pkg.Vector ;
begin
   g := box.Create(arg);
   box.Show(g);
   s := box.EnumerateSteps (g);
   box.Show (s);
   exception
      when boxe : box.INVALID_ARG => 
         Put("Invalid box argument "); Put(Exception_Message(boxe));
         New_Line ;
end Boxed;
