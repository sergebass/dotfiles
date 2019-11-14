# workspace-specific gdb configuration file
import gdb
import re

print("Loading workspace configuration (Python)...")

class FixmePrinter:
    def __init__(self, val):
        self.val = int(val)
 
    def to_string(self):
        return "Generic object with the following members:"
 
    def children(self):
        for field in self.val.type.fields():
            yield field.name, str(field.type)

def lookup_function(val):
    lookup_tag = val.type.tag
    if lookup_tag == None:
        return None

    regex = re.compile("^FixmeType$")
    if regex.match(lookup_tag):
        return FixmePrinter(val)

    return None

gdb.pretty_printers.append(lookup_function)
