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
   function Get( g : Game ; s : Side ; p : Position ) return Character is
   begin
      return g(s,p) ;
   end Get ;
   function Equal( L, R : GameLetters_Pkg.Vector ) return boolean is
   begin
      return false;
   end Equal;

   function EnumerateWords( g : Game; s : Side ; p : Position) return GameWords_Pkg.Vector is
      result : GameWords_Pkg.Vector ;
   begin
      return result ;
   end EnumerateWords;

   function EnumerateWords( g : Game ) return GameWords is
      result : GameWords ;
   begin
      for s in Side'Range
      loop
         for p in Position'Range
         loop
            result(s,p) := EnumerateWords(g,s,p);
         end loop ;
      end loop ;
      return result ;
   end EnumerateWords;
   
   procedure Show( g : game ; w : GameLetters_Pkg.Vector ) is
      procedure Show( c : GameLetters_Pkg.Cursor ) is
         gc : GameLetter := GameLetters_Pkg.Element(c) ;
      begin
         Put( g(gc.s,gc.p) ) ;
      end Show ;
   begin
      w.Iterate( Show'Access );
   end Show ;

   procedure Show( g : game ; wl : GameWords_Pkg.Vector ) is
      procedure Show( w : GameWords_Pkg.cursor ) is
         gw : GameLetters_Pkg.Vector := GameWords_Pkg.Element(w);
      begin
         Show(g , gw ) ;
         New_Line ;
      end Show ;
   begin
      wl.Iterate(Show'access) ;
   end Show ;

end box ;
