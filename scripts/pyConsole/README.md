# PyConsole

A small revamp to the default python console.  
The following extra features are implemented

- 'ex' is shorthand for quit()
- Typing an equation saves the equation into a variable, which can be accessed using `$n`
- math and numpy are imported by default
- Opening the console from a directory with a file called 'import.log' in it will cause the file to be executed first. Useful for testing modules.