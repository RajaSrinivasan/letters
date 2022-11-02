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
      procedure Show( g : Game ) ;
      procedure Solve( g : Game ) ;

end box ;