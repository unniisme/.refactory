#!/usr/bin/python3
import code
import sys
import os
import readline
import re

helpString = """
Refactory Python Console
Mostly just the normal python console with a few added features
Any variable printed to the console is save to $[n] and can be accessed using the same name
use ![command] to type bash commands
use !<[command] to type bash commands and save it's output as a dict to the console
Make a file called 'import.log' in the access directory with all the import statements
    for those statements to be called on launch of the console
'ex' is shortcut for exit()
"""

sys.path.append(".")

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

        # exit shortcut
        if line.strip() == "ex":
            raise SystemExit

        # help
        if line.strip() == "help":
            print(helpString)
            return None

        # Terminal commands
        if line[0] == "!":
            if line[1] == "<":
                self.WriteVar(self.handlecli(line[2:], getReturn=True))
            else:
                self.handlecli(line[1:])
            return None

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
                self.WriteVar("".join(output_buffer[:-1]))
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
    
    def WriteVar(self, value):
        self.push(f"consVars[{self.uniq}] = " + value)
        print(f"${self.uniq} =",value)
        self.uniq += 1

    def handlecli(self, line, getReturn = False):
        if getReturn:
            outStream = os.popen(line)
            return str([ s.strip() for s in outStream.readlines()])
        os.system(line)

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

