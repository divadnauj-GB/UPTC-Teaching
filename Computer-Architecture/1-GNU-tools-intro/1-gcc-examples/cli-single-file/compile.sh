# single line command to compile multiple files
gcc -g -Og main.c -o main

# get information about the generated binary
size main

# get the symbol table
nm main

# disassemble the binary
objdump -d main

gdb ./main
