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
   begin
      null ;
   end Solve ;

   function Get( g : Game ; s : Side ; p : Position ) return Character is
   begin
      return g(s,p) ;
   end Get ;
  
end box ;
