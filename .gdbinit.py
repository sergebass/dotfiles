# A startup configuration script for gdb in Python

import os
import sys

print("Loading user configuration (Python)...")

# term = os.getenv("TERM")
# print("TERM:", term)

# if term == "dumb":
#     gdb.execute("set $COLOREDPROMPT = 0")
# else:
#     gdb.execute("set $COLOREDPROMPT = 1")

# Enable pretty-printers for standard C++ containers
print("Registering libstdc++ pretty-printers...")
sys.path.insert(0, '/usr/share/gcc/python')
# Note that we need to dynamically load the printers here, we cannot do this at the top level of the script
from libstdcxx.v6 import register_libstdcxx_printers
register_libstdcxx_printers(None)
