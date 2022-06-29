with Ada.Characters.Handling; use Ada.Characters.Handling ;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; Use Ada.Integer_Text_Io;

with dictionary ;
package body box is

   fulldict : dictionary.Words_Pkg.Set ;

   procedure Initialize is
   begin
      fulldict := dictionary.Load ("etc/spellcheck-dict.txt") ;
   end Initialize ;

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

   function Image( l : GameLetter ) return String is
   begin
      return Side'Image(l.S) & "." & l.L ;
   end Image ;

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

    function EnumerateSteps( g : game ) return Steps_Pkg.Vector is
       result : Steps_Pkg.Vector ;
       procedure EnumerateSteps( s : Side ; cp : Integer ) is
          res : Step ;
       begin
          res.From := ( s , cp , g(s)(cp));
          for ns in Side'Range
          loop
             if s /= ns
             then
                for nc in 1..LETTERS_PER_SIDE
                loop
                   res.To := ( ns , nc , g(s)(nc));
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
                EnumerateSteps( s , l );
            end loop ;
        end loop ;
       return result ;
    end EnumerateSteps;

    procedure Show( steps : Steps_Pkg.Vector ) is
       procedure Show_Step( st : Steps_Pkg.Cursor ) is
        val : Step := Steps_Pkg.Element(st) ;
       begin
          Put(Image(val.from)); Put( " - "); Put(Image(val.to)) ; New_Line ;
       end Show_Step ;
    begin
       steps.Iterate( Show_Step'access);
    end Show ;
    
    function Equal( l : Steps_Pkg.Vector ; r : Steps_Pkg.Vector ) return boolean is
    begin
       return false;
    end Equal;

    procedure EnumerateWords( p : puzzle ;
                              prevword : String ;
                              newletter : GameLetter; 
                              maxlength : Integer := MAXWORDLENGTH ) is
        newword : String( 1..prevword'length + 1 ) := prevword & "." ;
        nextletter : GameLetter ;
    begin
        newword(newword'Last) := (p.g(newletter.S)(newletter.LP)) ;
        Put(newword'Length); Put(" : word > ") ; Put_Line(newword) ;
        if maxlength = 0
        then
           --Put_Line("Reached max length") ;
           return ;
        end if ;

        for s in Side
        loop
            if newletter.S /= s
            then
               for cp in 1..LETTERS_PER_SIDE
               loop
                  nextletter := ( s , cp , p.g(s)(cp) ) ;
                  EnumerateWords( p , newword , nextletter , maxlength - 1 );
               end loop ;
            end if ;
        end loop ;
    end EnumerateWords ;

    function Solve( p : Puzzle ) return WordList_Pkg.List is
       result : WordList_Pkg.List ;
       sv : Steps_Pkg.Vector ;
       gl : GameLetter ;
    begin
       for s in Side
       loop
          for c in 1..LETTERS_PER_SIDE
          loop
            gl.LP := c ;
            gl.S := s ;
            gl.L := p.g(s)(c);
            EnumerateWords(p  , "" , gl) ;
          end loop ;
       end loop ;
       return result ;
    end Solve ;

    function IsSolution( wl : WordList_Pkg.List ) return boolean is
        vl : array (Side , 1..LETTERS_PER_SIDE) of boolean := (others => (others => false));

        procedure InspectStep( sp : Steps_Pkg.cursor ) is
            spe : Step := Steps_Pkg.Element(sp);
        begin
            vl(spe.from.S,spe.from.LP) := true ;
            vl(spe.to.S, spe.to.LP) := true ;
        end InspectStep ;
        procedure InspectWord( wp : WordList_Pkg.Cursor ) is
        begin
            Steps_Pkg.Iterate( WordList_Pkg.Element(wp).Steps , InspectStep'access );
        end InspectWord ;
    begin
        wl.Iterate(InspectWord'access) ;
        for s in Side'Range
        loop
           for lp in 1..LETTERS_PER_SIDE
           loop
              if not vl(s,lp)
              then 
                return false ;
              end if ;
           end loop ;
        end loop ;
        return true ;
    end IsSolution ;

    function MakeWord( st : Steps_Pkg.Vector ) return String is
        use Steps_Pkg;
        use type Ada.Containers.Count_Type ;
       result : String(1..Integer(st.Length+1)) ;
       curs : Steps_Pkg.Cursor := st.First;
       cp : Integer := 1 ;
    begin
       while curs /= st.Last
       loop
          result(cp) := Steps_Pkg.Element(curs).from.L ;
       end loop ;
       return result ;
    end MakeWord ;

    procedure Solve( p : puzzle ; 
                     gl : GameLetter ; 
                     wl : in out WordList_Pkg.List ; 
                     max_depth : integer := 5 ) is
    begin
        null ;
    end Solve;

end box ;
