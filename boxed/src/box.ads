package box is
    INVALID_ARG : exception ;
    type Side is
    ( left, top, right, bottom ) ;
    subtype letters is string(1..3) ;
    type game is array (Side) of letters ;
    type GameLetter is
    record
       S : Side ;
       L : character ;
    end record ;
    type GameLetters is array (1.. Side'Pos(Side'Last)  * Letters'Length) of GameLetter ;
    type Step is
    record
       from : GameLetter ;
       to : GameLetter ;
    end record ;

    function Create( arg : String ) return game ;
    procedure Show( g : Game );
end box ;