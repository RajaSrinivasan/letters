with Ada.Containers.Vectors ;
with Ada.Containers.Doubly_Linked_Lists ;
with Ada.Strings.Unbounded; Use Ada.Strings.Unbounded ;
package box is
      
      INVALID_ARG : exception ;

      procedure Initialize ;
      type Side is
      ( left, top, right, bottom ) ;
      LETTERS_PER_SIDE : constant := 3 ;
      subtype letters is string(1..LETTERS_PER_SIDE) ;
      type game is array (Side) of letters ;
      type GameLetter is
      record
         S : Side ;
         LP : Integer ;
         -- L : character ;
      end record ;
      function Image( g : game ; l : GameLetter) return String ;

    type GameLetters is array (1.. Side'Pos(Side'Last)  * Letters'Length) of GameLetter ;
    type Step is
    record
       from : GameLetter ;
       to : GameLetter ;
    end record ;

    function Same( l : Step ; r : Step ) return boolean ;
    package Steps_Pkg is new Ada.Containers.Vectors( Natural , step , Same );
   
    function Create( arg : String ) return game ;
    procedure Show( g : Game );

    function EnumerateSteps( g : game ) return Steps_Pkg.Vector ;
    procedure Show( g : game ; steps : Steps_Pkg.Vector );
    type Word is
    record
       start : GameLetter ;
       steps : Steps_Pkg.Vector ;
       w : Unbounded_String := Null_Unbounded_String ;
    end record ;

    type puzzle is
    record
       g : Game ;
       steps : Steps_Pkg.Vector ;
    end record ;
    package WordList_Pkg is new Ada.Containers.Doubly_Linked_Lists( Word );
    procedure EnumerateWords( p : puzzle ; 
                              gl : GameLetter ; 
                              wl : in out WordList_Pkg.List ; 
                              max_depth : integer := 12 );
    function IsSolution( wl : WordList_Pkg.List ) return boolean ;
    function Solve( p : Puzzle ) return WordList_Pkg.List ;

    
end box ;