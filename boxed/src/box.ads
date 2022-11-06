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
      type Visited is array (Side'Range , Position'Range) of boolean ;

      function Create( arg : string ) return Game with
         Precondition => ( arg'Length = Game'Length(1) * Game'Length(2) );
      
      package Words_Pkg is new Ada.Containers.Vectors( 
         Natural ,
         Ada.Strings.Unbounded.Unbounded_String );

      type WordsType is array (Side'Range , Position'Range ) of Words_Pkg.Vector ;
      type WordsIndexType is array (character'Range) of Words_Pkg.Vector ;
      type GameSummaryType is
      record
         w : WordsType ;
         wi : WordsIndexType ;
      end record ;

      procedure Show( g : Game ) ;
      procedure Solve( g : Game ) ;

      function FindWords( g : Game ) return GameSummaryType ;

      procedure Show( w : WordsType );

      function Findwords( g : Game ; s : Side ; p : Position ) return Words_Pkg.Vector ;
      procedure Show( wv : Words_Pkg.Vector );

      procedure MarkVisited( g : Game ; v : in out Visited ; w : String );
      function MapVisited(g : Game ; wv : Words_Pkg.Vector ) return Visited ;
      function Covered( v : Visited ) return boolean ;

      MAXWORDSINSOLUTION : Integer := 6 ;
      type SolutionWordsType is array(1..8) of
         Ada.Strings.Unbounded.Unbounded_String ;

      type SolutionType is
      record
         length : Integer := 0 ;
         words : SolutionWordsType ;
      end record ;

      procedure ListSolutions(g : Game ; gs : GameSummaryType) ;
      procedure ListSolutions(g : Game ; gs : GameSummaryType; sol : in out SolutionType) ;
      
      procedure Show(sol : SolutionType) ;
      function IsSolution( g : Game ; sol : SolutionType ) return boolean ;
      procedure Add( sol : in out SolutionType ; w : Unbounded_String) ;
      procedure Remove( sol : in out SolutionType );
      procedure Init( sol : in out SolutionType ; w : Unbounded_String );
end box ;