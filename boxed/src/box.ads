with Ada.Containers.Vectors ;
with Ada.Containers.Doubly_Linked_Lists ;
with Ada.Strings.Unbounded; Use Ada.Strings.Unbounded ;
package box is
      
      INVALID_ARG : exception ;
      MAXWORDLENGTH : constant := 6 ;
      MAXWORDCOUNT : constant := 64 ;

      procedure Initialize ;
      type Side is
      ( left, top, right, bottom ) ;
      LETTERS_PER_SIDE : constant := 3 ;
      type Position is new integer range 1..LETTERS_PER_SIDE ;

      type Game is array (Side'Range , Position'Range ) of Character ;
      function Create( arg : string ) return Game with
         Precondition => ( arg'Length = Game'Length(1) * Game'Length(2) );
      type GameLetter is
      record
         s : Side ;
         p : Position ;
      end record;
      package GameLetters_Pkg is new Ada.Containers.Vectors (Natural,GameLetter) ;
      function Equal( L, R : GameLetters_Pkg.Vector ) return boolean ;
      package GameWords_Pkg is new Ada.Containers.Vectors(Natural,GameLetters_Pkg.Vector,Equal) ;
      function Get( g : Game ; s : Side ; p : Position ) return Character ;

      type GameWords is array (Side'Range, Position'Range) of GameWords_Pkg.Vector ;
      function EnumerateWords( g : Game; s : Side ; p : Position) return GameWords_Pkg.Vector ;
      function EnumerateWords( g : Game ) return GameWords ;

      procedure Show( g : game ; w : GameLetters_Pkg.Vector );
      procedure Show( g : game ; wl : GameWords_Pkg.Vector );
      
end box ;