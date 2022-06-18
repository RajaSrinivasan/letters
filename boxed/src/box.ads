with Ada.Containers.Vectors ;
package box is
      INVALID_ARG : exception ;
      type Side is
      ( left, top, right, bottom ) ;
      LETTERS_PER_SIDE : constant := 3 ;
      subtype letters is string(1..LETTERS_PER_SIDE) ;
      type game is array (Side) of letters ;
      type GameLetter is
      record
         S : Side ;
         L : character ;
      end record ;
      function Image(l : GameLetter) return String ;

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
    procedure Show( steps : Steps_Pkg.Vector );

end box ;