with Ada.Text_Io; use Ada.Text_Io;
with Ada.Integer_Text_Io; use Ada.Integer_Text_IO ;
package body dictionary is 

   function Load(filename : String) return Words_Pkg.Set is
      wfile : File_Type ;
      line : String(1..64) ;
      linelen : natural ;
      wordcount : Integer := 0 ;
      result : Words_Pkg.Set ;
   begin
      Open(wfile,In_File,filename);
      while Not End_Of_File(wfile)
      loop
        get_line(wfile,line,linelen);
        wordcount := wordcount + 1 ;
        Words_Pkg.Insert( result , To_Unbounded_String(line(1..linelen))) ;
      end loop ;
      Close(wfile) ;
      Put(wordcount); Put_Line(" word lines read");
      Put("Dictionary contains "); Put(Integer(Words_Pkg.Length(result))); Put_Line(" entries");
      return result ;
   end Load ;

   function IsWord(fulldict : Words_Pkg.Set ; cand : String) return boolean is
   begin
      -- Put("Searching dict for "); Put_Line(cand) ;
      if Words_Pkg.Contains(fulldict,To_Unbounded_String(cand))
      then
         -- Put_Line("Foundit");
         return True ;
      end if ;
      return false ;
   end IsWord ;
end dictionary ;