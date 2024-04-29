#ifndef TABLE_ASSEMBLY_H
#define TABLE_ASSEMBLY_H
#define COMMAND_NAME_LENGTH 3
#define ASSEMBLY_TABLE_SIZE 255

struct Instruction {
  char command[COMMAND_NAME_LENGTH]; // Name of the command
  int val1;
  int val2;
  int val3;
};

void insertInstruction(struct Instruction element, struct Instruction * table);
void print_instructions(struct Instruction * table);

#endif