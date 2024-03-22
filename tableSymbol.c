#include "tableSymbol.h"

int ptr = 0;

void insertSymbol(struct Symbol element, struct Symbol * table) {
  table[ptr++] = element;
}

void print_table(struct Symbol * table) {
  printf("Table of Symbol: ");
  for (int i = 0;i<ptr; i++) {
    printf("%s, ", table[i].name);
  }
  printf("\n");
}