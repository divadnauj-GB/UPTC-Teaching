# single line command to compile multiple files
gcc main.c src/special_functions.c -I./inc -o main


# individual commands to compile multiple files
# gcc -c main.c -I./inc -o main.o
# gcc -c src/special_functions.c -I./inc -o special_functions.o
# gcc main.o special_functions.o -o main