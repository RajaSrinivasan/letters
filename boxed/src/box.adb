with Ada.Characters.Handling; use Ada.Characters.Handling ;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; Use Ada.Integer_Text_Io;
package body box is
   function Create( arg : String ) return game is
      result : game ;
   begin
      if arg'length /= 12
      then
         raise INVALID_ARG with "exactly 12 letters required" ;
      end if ;
      for c in arg'range
      loop
         if Is_Letter(arg(c)) 
         then
            null;
         else
            raise INVALID_ARG with "only alphabetic characters" & arg(c) ;
         end if ;
      end loop ;
      for s in Side'Range
      loop
         for l in Letters'Range
         loop
            result(s)(l) := arg( (Side'Pos(s)) * Letters'Last + l ); 
         end loop ;
      end loop ;
      return result ;
   end Create ;

    procedure Show( g : Game ) is
    begin
        for s in g'Range
        loop 
            Put( S'Image ); Put (" => "); Set_Col(12);
            for c in g(s)'range 
            loop
               Put (g(s)(C)) ; Put (", ");
            end loop ;
            New_Line ;
        end loop ;
    end Show ;

end box ;
