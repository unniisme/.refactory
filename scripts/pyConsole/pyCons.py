#!/usr/bin/python3
import code
import sys
import os
import readline
import re

# Function to pattern match
def replace_substrings(string):
    return re.sub(r'\$(\d+)', r'consVars[\1]', string)


class PyCons(code.InteractiveConsole):

    def __init__(self, imports, *args, **kwargs):
        super().__init__(*args, **kwargs)

        self._history = []

        # A standard dictionary called "conVars" holds value of each interpreted line
        self.push("consVars = {}")
        self.uniq = 0

        # Imports
        for impo in imports:
            self.push(impo)


    def push(self, line):
        # Save line to history
        self._history.append(line)

        # exit shorcut
        if line.strip() == "ex":
            raise SystemExit

        # interpeter variables are accessed using $n
        line = replace_substrings(line)

        # Create a temporary buffer to capture the output
        output_buffer = []

        # Override sys.stdout.write to capture the output
        original_stdout_write = sys.stdout.write
        sys.stdout.write = lambda text: output_buffer.append(text)

        # Process the line using the parent class's push method
        result = code.InteractiveConsole.push(self, line)

        # Restore the original sys.stdout.write
        sys.stdout.write = original_stdout_write

        if len(output_buffer) > 0:
            if output_buffer[0][0] == "<":
                print("".join(output_buffer[:-1]))
            else:
                self.push(f"consVars[{self.uniq}] = " + "".join(output_buffer[:-1]))
                print(f"${self.uniq} =","".join(output_buffer[:-1]))
                self.uniq += 1

        return result


    def interact(self, *args, **kwargs):
        # Handle history
        readline.set_history_length(1000)
        readline.clear_history()
        readline.set_auto_history(True)
        sys.ps1 = ' >> '

        try:
            super().interact(*args, **kwargs)
        finally:
            readline.set_auto_history(False)

            # Save history to a file if needed
            # readline.write_history_file('history.txt')

            # Print history to console
            # for i in range(readline.get_current_history_length()):
            #     print(readline.get_history_item(i + 1))

def my_repl(imports):
    interpreter = PyCons(imports)
    interpreter.interact()

# Default import
imports = ["from math import *", "from numpy import *"]
# If import.log file exists, add each line of it as import
if os.path.isfile("import.log"):
    with open('import.log') as imps:
        imports += imps.readlines()
    
my_repl(imports)

