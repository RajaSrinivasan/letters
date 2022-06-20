with Ada.Containers.Hashed_Sets ;
with Ada.Strings.Unbounded.Hash ;
with Ada.Strings.Unbounded ; Use Ada.Strings.Unbounded ;

package dictionary is
   package Words_Pkg is new Ada.Containers.Hashed_Sets(Unbounded_String,Ada.Strings.Unbounded.Hash,"=");
   spellcheck : constant String := "spellcheck-dict.txt" ;
   function Load(filename : String) return Words_Pkg.Set ;
   function IsWord(fulldict : Words_Pkg.Set ; cand : String) return boolean ;
end dictionary ;
