with Ada.Command_Line; use Ada.Command_Line;
with Ada.Exceptions ; use Ada.Exceptions ;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io ; use Ada.Integer_Text_Io ;
with GNAT.Source_Info ;
with revisions;

with box ;
--  claohmjteiup 

procedure Boxed is
   comp_date : constant String := GNAT.Source_Info.Compilation_Date ;
   comp_time : constant String := GNAT.Source_Info.Compilation_Time ;

   defaultarg : constant String := "claohmjteiup" ;
   g : box.game ;

begin

   Put("boxed - letterboxed - ");
   Put(revisions.canonical);
   Put(comp_date) ; Put(" ");
   Put(comp_time) ; 
   New_Line;

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
