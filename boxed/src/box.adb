with Ada.Characters.Handling; use Ada.Characters.Handling ;
with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; Use Ada.Integer_Text_Io;
with GNAT.Source_Info ;
with dictionary ;
package body box is

   fulldict : dictionary.Words_Pkg.Set ;

   procedure Initialize is
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      fulldict := dictionary.Load ("etc/spellcheck-dict.txt") ;
   end Initialize ;

   function Create( arg : string ) return Game is
      result : Game ;
      nextc : Integer := 0 ;
   begin
      for s in Side'range
      loop
         for c in Position'Range
         loop
            nextc := nextc + 1 ;
            result(s,c) := arg(nextc) ;
         end loop ;
      end loop ;
      return result ;
   end Create ;

   procedure Show( g : Game ) is
   begin
      Put("     ") ;
      for p in Position
      loop
         Put("  ");
         Put(g(top,p));
         Put("  ");
      end loop ;
      Put("     ") ;
      New_Line ;
      for p in Position
      loop
         Put("  ");
         Put(g(left,p));
         Put("  ");
         for p1 in Position
         loop
             Put("     ");
         end loop;
         Put("  ");
         Put(g(right,p));
         Put("  ");
         New_Line;
      end loop;

      Put("     ") ;
      for p in Position
      loop
         Put("  ");
         Put(g(bottom,p));
         Put("  ");
      end loop ;
      Put("     ") ;
      New_Line ;
   end Show ;

   procedure Solve( g : Game ) is
      w : WordsType ;
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      w := FindWords(g) ;
   end Solve ;

   function Get( g : Game ; s : Side ; p : Position ) return Character is
   begin
      return g(s,p) ;
   end Get ;
  
   function FindWords( g : Game ) return WordsType is
      result : WordsType ;
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            result(s,p) := Findwords( g , s , p );
         end loop ;
      end loop ;
      return result ;
   end FindWords ;
   procedure Show( w : WordsType ) is
   begin
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            Put("Words Starting with ");
            Put( To_String(Words_Pkg.Element(Words_Pkg.First(w(s,p))))'First ) ;
            New_Line;
            Show( w(s,p) );
         end loop ;
      end loop ;
   end Show ;

   procedure Addwords( v : in out Words_Pkg.Vector ; g : game ; s : side ; p : Position ; starter : String ) is
   begin
      --Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      for ss in side'Range
      loop
         if ss /= s
         then 
            for pp in Position'Range
            loop
               declare
                  xpword : String := starter & g(ss,pp) ;
               begin
                  --Put_Line(xpword);
                  if xpword'Length >= 3 and then dictionary.IsWord(fulldict,xpword)
                  then
                     Words_Pkg.Append(v , To_Unbounded_String(xpword)) ;
                     Put_Line(xpword);
                  end if ;
                  if xpword'Length <= 6
                  then
                     AddWords( v , g , ss , pp , xpword );
                  end if ;
               end;
            end loop ;
         end if ;
      end loop ;
   end AddWords ;

   function Findwords( g : Game ; s : Side ; p : Position ) return Words_Pkg.Vector is
      result : Words_Pkg.Vector;
      wstart : String (1..1) := (others => g(s,p)) ;
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      AddWords( result , g , s , p , wstart );
      return result ;
   end FindWords ;

   procedure Show( p : Words_Pkg.Cursor ) is
   begin
       Put_Line( To_String(Words_Pkg.Element(p)) ); 
   end Show ;
   procedure Show( wv : Words_Pkg.Vector ) is
   begin
       Words_Pkg.Iterate( wv , Show'Access );
   end Show ;

end box ;
