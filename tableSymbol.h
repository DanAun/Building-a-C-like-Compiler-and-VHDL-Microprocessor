#ifndef TABLE_SYMBOL_H
#define TABLE_SYMBOL_H
#define SYMBOL_NAME_LENGTH 20
#define SYMBOL_TABLE_SIZE 255

struct Symbol {
  char name[SYMBOL_NAME_LENGTH]; // Name of the symbol
};

void insertSymbol(struct Symbol element, struct Symbol * table);
void print_table(struct Symbol * table);
int getSymbolAddr(char * sym, struct Symbol * table);
int getTopAddr(struct Symbol * table);

#endif