#include "tableSymbol.h"
#include <stdio.h>
#include <string.h>

int ptr = 0;

void insertSymbol(struct Symbol element, struct Symbol * table) {
  table[ptr++] = element;
}

/* Gets the address of the first symbol in table, returns -1 if symbol was not found in table*/
int getSymbolAddr(char * sym, struct Symbol * table) {
  for (int i = 0; i < ptr; i++) {
    // strcmp returns 0 if the str are equal
    if (!strcmp(sym, table[i].name)) {
      return i;
    }
  }
  return -1;
}

/* Returns the address of the last symbol added*/
int peek(struct Symbol * table){
  return ptr-1;
}

int pop(struct Symbol * table) {
  ptr--;
  return ptr;
}

void print_table(struct Symbol * table) {
  printf("Table of Symbol: \n");
  for (int i = 0;i<ptr; i++) {
    printf("%s, ", table[i].name);
  }
  printf("\n");
}