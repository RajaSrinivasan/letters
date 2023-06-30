#!/bin/python3
import sys
verfile=open("revisions.ads","w")
verfile.write("package revisions is\n")

verfile.write('   branch_name : constant String := "%s" ;\n ' % sys.argv[1])
verfile.write('   commit_id : constant String := "%s" ;\n' % sys.argv[2])
verfile.write('   short_commit_id : constant String := commit_id(1..7) ; \n')

verfile.write('   build_no : constant Integer := %d ;\n' % int(sys.argv[3]))
verfile.write('   version_build : constant String := "%s" ; \n' % sys.argv[3])
verfile.write('   build_env : constant String := "%s" ;\n' % sys.argv[4])              

verfile.write('   version_canonical : constant String := "%s:%s:%s@%s" ;\n' % (sys.argv[1],sys.argv[2][:7],sys.argv[3],sys.argv[4]) )
verfile.write("end revisions;\n")
verfile.close();
