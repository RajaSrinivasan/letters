package box is
    INVALID_ARG : exception ;
    type Side is
    ( left, top, right, bottom ) ;
    subtype letters is string(1..3) ;
    type game is array (Side) of letters ;
    function Create( arg : String ) return game ;
end box ;