package revisions is

  branch_name : constant String := "default" ;
  commit_id : constant String := "0a0b0c0d0e0f" ;
  short_commit_id : constant String := commit_id(1..7) ; 

  build_no : constant Integer := 99 ;
  version_build : constant String := "99" ; 
  build_env : constant String := "system" ;              

  version_canonical : constant String := branch_name & ":" & version_build & ":" & short_commit_id & "@" & build_env ;)

end revisions ;
