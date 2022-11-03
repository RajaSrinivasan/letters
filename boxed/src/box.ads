with Ada.Containers.Vectors ;
with Ada.Containers.Doubly_Linked_Lists ;
with Ada.Strings.Unbounded; Use Ada.Strings.Unbounded ;
package box is
      
      INVALID_ARG : exception ;

      MAXWORDLENGTH : constant := 6 ;
      MAXWORDCOUNT : constant := 64 ;

      procedure Initialize ;      -- Load the dictionary

      type Side is
      ( left, top, right, bottom ) ;

      LETTERS_PER_SIDE : constant := 3 ;
      type Position is new integer range 1..LETTERS_PER_SIDE ;

      type Game is array (Side'Range , Position'Range ) of Character ;
      function Create( arg : string ) return Game with
         Precondition => ( arg'Length = Game'Length(1) * Game'Length(2) );
      
      package Words_Pkg is new Ada.Containers.Vectors( 
         Natural ,
         Ada.Strings.Unbounded.Unbounded_String );

      type WordsType is array (Side'Range , Position'Range ) of Words_Pkg.Vector ;

      procedure Show( g : Game ) ;
      procedure Solve( g : Game ) ;

      function FindWords( g : Game ) return wordsType ;
      procedure Show( w : WordsType );

      function Findwords( g : Game ; s : Side ; p : Position ) return Words_Pkg.Vector ;
      procedure Show( wv : Words_Pkg.Vector );
   
end box ;