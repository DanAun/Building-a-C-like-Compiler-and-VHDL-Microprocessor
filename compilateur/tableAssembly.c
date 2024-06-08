#include "tableAssembly.h"
#include <stdio.h>
#include <string.h>

int ptrA = 0;

void insertInstruction(struct Instruction element, struct Instruction * table) {
    table[ptrA++] = element;
}

void upDateJMFInstruction(struct Instruction * table) {
  for (int i = ptrA; i >= 0; i--) {
    if (strcmp(table[i].command, "JMF") == 0 && table[i].val2 == -1) {
      table[i].val2 = ptrA;
      break;
    }
  }
}

void upDateJMPInstruction(struct Instruction * table) {
  for (int i = ptrA; i >= 0; i--) {
    if (strcmp(table[i].command, "JMP") == 0) {
      table[i].val1 = ptrA;
    }
  }
}

void toInstructionAddress(struct Instruction * table) {
  printf("Table of Instruction Address: \n");
  for (int i = 0;i<ptrA; i++) {
    char * command = "00";
    if (strcmp(table[i].command, "AFC") == 0) {
      command = "06";
    }
    else if (strcmp(table[i].command, "COP") == 0) {
      command = "05";
    }
    else if (strcmp(table[i].command, "JMF") == 0) {
      command = "08";
    }
    else if (strcmp(table[i].command, "JMP") == 0) {
      command = "07";
    }
    else if (strcmp(table[i].command, "ADD") == 0) {
      command = "01";
    }
    else if (strcmp(table[i].command, "MUL") == 0) {
      command = "02";
    }
    else if (strcmp(table[i].command, "SOU") == 0) {
      command = "03";
    }
    else if (strcmp(table[i].command, "DIV") == 0) {
      command = "04";
    }
    printf("%s%02x%02x%02x\n", command, table[i].val1, table[i].val2, table[i].val3);
  }
  printf("\n");
}

void print_instructions(struct Instruction * table) {
  printf("Table of Assembly: \n");
  for (int i = 0;i<ptrA; i++) {
    printf("%s %d %d %d\n", table[i].command, table[i].val1, table[i].val2, table[i].val3);
  }
  printf("\n");
}