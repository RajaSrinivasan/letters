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
      gs : GameSummaryType ;
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      gs := FindWords(g) ;
      ListSolutions(g,gs) ;
   end Solve ;

   function Get( g : Game ; s : Side ; p : Position ) return Character is
   begin
      return g(s,p) ;
   end Get ;
  
   function FindWords( g : Game ) return GameSummaryType is
      result : GameSummaryType ;
   begin
      Put(GNAT.Source_Info.Source_Location); Put(" "); Put_Line(GNAT.Source_Info.Enclosing_Entity);
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            result.w(s,p) := Findwords( g , s , p );
            result.wi( g(s,p) ) := result.w(s,p) ;
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
      Put("====== "); Put(wstart) ; Put(" ");
      Put(Integer(Words_Pkg.Length(result))); Put_Line(" words");
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

   procedure MarkVisited( g : Game ; v : in out Visited ; w : String ) is
   begin
      for c in w'Range
      loop
         for s in Side'Range
         loop
            for p in Position'Range
            loop
               if w(c) = g(s,p)
               then
                  v(s,p) := true ;
               end if ;
            end loop ;
         end loop ;
      end loop ;
   end MarkVisited ;

   function MapVisited(g : Game ; wv : Words_Pkg.Vector ) return Visited is
      result : Visited := (others => (others => false) );
      procedure MapVisited( wc : Words_Pkg.Cursor ) is
      begin
         MarkVisited(g,result, To_String(Words_Pkg.Element(wc)) ) ;
      end MapVisited ;
   begin
      Words_Pkg.Iterate( wv , MapVisited'access);
      return result ;
   end MapVisited ;

   function Covered( v : Visited ) return boolean is
   begin
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            if not v(s,p)
            then
               return false ;
            end if ;
         end loop ;
      end loop ;
      return true ;
   end Covered ;

   procedure ListSolutions(g : Game ; gs : GameSummaryType ; sol : in out SolutionType ) is
      nextword : Unbounded_String ;
      nextwordlist : Words_Pkg.Vector ;
   begin
       if IsSolution(g,sol)
       then
         Show(sol) ;
         return ;
       end if ;
       if sol.Length >= sol.words'Length
       then
          return ;
       end if;
       nextword := sol.words(sol.Length) ;
       nextwordlist := gs.wi( Element(nextword,Length(nextword)) ) ;
       for s of nextwordlist
       loop
         Add(sol,s) ;
         ListSolutions(g , gs , sol) ;
         Remove(sol) ;
       end loop ;
   end ListSolutions ;
 
   procedure ListSolutions(g : Game ; gs : GameSummaryType) is
      sol : SolutionType ;
   begin
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            for w of gs.w(s,p)
            loop
              Init(sol,w);
              ListSolutions( g , gs , sol );
            end loop ;
         end loop ;
      end loop ;
   end ListSolutions ;

   procedure Show(sol : SolutionType) is
   begin
      if sol.length >= sol.words'Length
      then
         return ;
      end if ;
      Put("Solution: wordcount "); Put(sol.Length) ; 
      New_Line ;
      for w in 1..sol.Length
      loop
         Put_Line(To_String(sol.words(w)));
      end loop ;
   end Show ;

  procedure MarkVisited( g : Game ; v : in out Visited ; wun : Unbounded_String ) is
   begin
      for c in 1..Length(wun)
      loop
         for s in Side'Range
         loop
            for p in Position'Range
            loop
               if Element(wun,c) = g(s,p)
               then
                  v(s,p) := true ;
               end if ;
            end loop ;
         end loop ;
      end loop ;
   end MarkVisited ;
   function IsSolution( g : Game ; sol : SolutionType ) return boolean is
      v : Visited := (others => (others => false));
   begin
      for p in 1..sol.Length
      loop
         MarkVisited( g , v , sol.words(p)) ;
      end loop ;
      return Covered(v) ;
   end IsSolution ;
   procedure Add( sol : in out SolutionType ; w : Unbounded_String) is
   begin
      sol.Length := sol.Length + 1 ;
      sol.words(sol.Length) := w ;
   end Add ;
   procedure Remove( sol : in out SolutionType ) is
   begin
      sol.words(sol.Length) := Null_Unbounded_String ;
      sol.Length := sol.Length - 1 ;
   end Remove ;
   procedure Init( sol : in out SolutionType ; w : Unbounded_String ) is
   begin
      sol.Length := 1 ;
      sol.words(1) := w ;
   end Init ;
end box ;
