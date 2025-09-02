#include <stdio.h>

/* Extra files headers */
#include "types.h"
#include "special_functions.h"


void helper_function();

/* Main program */
int main() {
  struct struct_type my_struct = { .val1 = 1 , .val2 = 1};
  union union_type my_union = { .n = 1 };

  special_function(my_struct, my_union);
  helper_function();
  printf("Success!\n");
  return 0;
}


void helper_function() {
  printf("helper function: I'm called from main!\n");
}