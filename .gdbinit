# A startup configuration script for gdb

echo Loading gdb-dashboard configuration...\n
source ~/.gdb-dashboard

echo Loading user configuration...\n

set confirm off
set verbose off

set history filename ~/.gdb_history
set history size unlimited
set history save on

set output-radix 0x10
set input-radix 0x10

# These make gdb never pause in its output
set height 0
set width 0

set listsize 5

set prompt gdb =>\040
set extended-prompt \[\e[0;1;32m\]gdb \[\e[0;7;33m\]\f\[\e[0;1;36m\] => \[\e[0m\]

# Enable demangling of C++ names
set print demangle on
set print asm-demangle on

# define hook-stop
#     info args
#     info locals
#     echo --- Source ---\n
#     list
# end

# Load the Python version of the initialization script
source ~/.gdbinit.py

# Load workspace-specific script (if available)
source ~/.workspace.gdb

# Load project-specific script (if available in current directory)
source .project.gdb
