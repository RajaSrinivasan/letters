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
    function Same( l : Step ; r : Step ) return boolean is
    begin
       if L.from = R.from and L.to = R.to
       then
          return true ;
       end if ;
       return false ;
    end Same ;

    function Image(l : GameLetter) return String is
    begin
        return Side'Image(l.S) & " " & l.L ;
    end Image ;

    function EnumerateSteps( g : game ) return Steps_Pkg.Vector is
       result : Steps_Pkg.Vector ;
       procedure EnumerateSteps( s : Side ; c : character ) is
          res : Step ;
       begin
          res.From := ( s , c );
          for ns in Side'Range
          loop
             if s /= ns
             then
                for nc in 1..LETTERS_PER_SIDE
                loop
                   res.To := ( ns , g(ns)(nc) );
                   result.Append(res);
                end loop ;
             end if ;
          end loop ;
       end EnumerateSteps;
    begin
       for s in Side'Range
       loop
            for l in 1..LETTERS_PER_SIDE
            loop
                EnumerateSteps( s , g(s)(l) );
            end loop ;
        end loop ;
       return result ;
    end EnumerateSteps;

    procedure Show_Step( st : Steps_Pkg.Cursor ) is
       val : Step := Steps_Pkg.Element(st) ;
    begin
       Put(Image(val.from)); Put( " - "); Put(Image(val.to)) ; New_Line ;
    end Show_Step ;

    procedure Show( steps : Steps_Pkg.Vector ) is
    begin
       steps.Iterate( Show_Step'access);
    end Show ;
    
end box ;
