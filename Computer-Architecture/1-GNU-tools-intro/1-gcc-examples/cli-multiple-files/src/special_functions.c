#include <stdio.h>

#include "types.h"

static void helper_function();

/* Extra function definitions */
void special_function(struct struct_type my_struct, union union_type my_union) {
  helper_function();
}


static void helper_function() {
  printf("helper function: I'm called by special_function!\n");
}