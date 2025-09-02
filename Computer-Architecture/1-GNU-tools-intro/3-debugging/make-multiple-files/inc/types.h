#ifndef TYPES_H
#define TYPES_H

/* Type definitions */
typedef int my_type;

struct struct_type {
  my_type val1;
  int val2;
};

union union_type {
  my_type n;
  char c;
};

#endif