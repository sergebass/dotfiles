# A startup configuration script for gdb in Python

import os

print("Welcome to gdb!")

term = os.getenv("TERM")
print("TERM:", term)

if term == "dumb":
    gdb.execute("set $COLOREDPROMPT = 0")
else:
    gdb.execute("set $COLOREDPROMPT = 1")
