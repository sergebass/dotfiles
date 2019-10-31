# A startup configuration script for gdb in Python

import os

print("Loading user gdb configuration (Python)...")

term = os.getenv("TERM")
print("TERM:", term)

if term == "dumb":
    gdb.execute("set $COLOREDPROMPT = 0")
else:
    gdb.execute("set $COLOREDPROMPT = 1")

# Load workspace-specific configuration
gdb.execute("source ~/.gdbinit.workspace.py")

# Load project-specific configuration (if gdb is invoked in project root directory)
gdb.execute("source .gdbinit.project.py")
