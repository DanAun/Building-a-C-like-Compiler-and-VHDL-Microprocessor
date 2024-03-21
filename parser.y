/* Binome Emilie GREAKER, Daniel AUNAN*/

%{
/* Include necessary headers */
#include <stdio.h>
#include <stdlib.h>
#define SYMBOL_NAME_LENGTH 20
#define SYMBOL_TABLE_SIZE 255

/* Declare any necessary global variables or functions */

struct Symbol {
  char name[SYMBOL_NAME_LENGTH]; // Name of the symbol
};

struct Symbol tableSymbol[SYMBOL_TABLE_SIZE];

/* Initilisaes tableSymbol with empty string names */
void init_tableSymbol(){
  for (int i; i < sizeof(&tableSymbol); i++) {
  strcpy(tableSymbol[i].name, "");
  }
}

void insertSymbol(struct Symbol element) {
  int i=0;
  while(tableSymbol[i].name != ""){
    i++;
  }
  tableSymbol[i] = element;
}

void print_table(struct Symbol * table) {
  printf("Table:\n");
  int i;
  while(table[i].name != "") {
    printf(",%s", table[i].name);
    i++;
  }
}

init_tableSymbol();
%}



%union {
    int num;
    char * str;
}
/* Bison declarations section */
%token <num> tNB
%token <str> tID
%token tINT tVOID tMAIN tIF tELSE tWHILE tRETURN tPRINTF tADD tSUB tMUL tDIV tLT tGT tNE tEQ tGE tLE tASSIGN tAND tOR tNOT tLBRACE tRBRACE tLPAR tRPAR tSEMI tCOMMA tERROR
%token tCONST 

/* Define your grammar rules here */
%%

input:
|  function_declaration input 
|  main_declaration {printf("Parsed whole program without errors\n");}
  ;

declaration_type:
  tINT
| tVOID
  ;

main_declaration:
  declaration_type tMAIN tLPAR parametres_func_declaration tRPAR tLBRACE body tRBRACE
| declaration_type tMAIN tLPAR tRPAR tLBRACE body tRBRACE
| tMAIN tLPAR parametres_func_declaration tRPAR tLBRACE body tRBRACE
| tMAIN tLPAR tRPAR tLBRACE body tRBRACE
  ;

function_declaration:
  declaration_type tID tLPAR parametres_func_declaration tRPAR tLBRACE body tRBRACE
| declaration_type tID tLPAR tRPAR tLBRACE body tRBRACE
  ;

body:
| exp body
  ;

parametres_func_declaration:
  tVOID
| declaration_type tID {struct Symbol sym = {$2}; insertSymbol(sym); print_table(&tableSymbol);}
| declaration_type tID tCOMMA parametres_func_declaration
 ;

parametres:
  equation tCOMMA parametres
| equation
  ;

exp:
  int_declaration
| assignment
| if_case
| ifelse_case
| while_case
| printf
| return_case
  ;

printf:
    tPRINTF tLPAR tID tRPAR tSEMI
    ;
int_const:
  tINT
| tCONST
  ;

int_declaration:
  int_const tID tSEMI
| int_const multi_int_declaration tSEMI
| int_const tID tASSIGN equation tSEMI
| int_const multi_int_declaration tASSIGN equation tSEMI
| int_const tID tASSIGN function_call tSEMI
| int_const multi_int_declaration tASSIGN function_call tSEMI
  ;

multi_int_declaration:
  tID tCOMMA multi_int_declaration
| tID
  ;

if_case:
  tIF tLPAR boolean_eq tRPAR tLBRACE body tRBRACE
  ;

ifelse_case:
  if_case tELSE tLBRACE body tRBRACE
  ;

while_case:
  tWHILE tLPAR boolean_eq tRPAR tLBRACE body tRBRACE
  ;

assignment:
  tID tASSIGN equation tSEMI
| tID tASSIGN function_call tSEMI
  ;

return_case:
  tRETURN tID tSEMI
| tRETURN tNB tSEMI
  ;

function_call:
  tID tLPAR parametres tRPAR

equation:
  tID
| tNB
| equation tADD equation
| equation tSUB equation
| equation tMUL equation
| equation tDIV equation
| tLPAR equation tRPAR
  ;

boolean_operator:
  tLT
| tGT
| tNE
| tEQ
| tGE
| tLE
| tAND
| tOR
  ;

boolean_eq:
  tID
| tNB
| tNOT boolean_eq
| boolean_eq boolean_operator boolean_eq
  ;

%%

/* Bison parser function */
int yyparse();

/* Error handling function */
void yyerror(const char *s) {
    fprintf(stderr, "Parser error: %s\n", s);
    exit(1);
}

/* Main function */
int main() {
  /* Call the parser*/
  yyparse();
  return 0;
}
