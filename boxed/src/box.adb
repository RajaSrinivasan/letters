with Ada.Characters.Handling; use Ada.Characters.Handling ;
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
      return result ;
   end Create ;
end box ;
