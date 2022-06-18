with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions ; use Ada.Exceptions ;
with Ada.Text_Io; use Ada.Text_Io;

with box ;

procedure Boxed is
   arg : String := Argument(1);
   g : box.game ;
begin
   g := box.Create(arg);
   box.Show(g);
   exception
      when boxe : box.INVALID_ARG => 
         Put("Invalid box argument "); Put(Exception_Message(boxe));
         New_Line ;
end Boxed;
