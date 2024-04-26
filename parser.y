/* Binome Emilie GREAKER, Daniel AUNAN*/

%{
/* Include necessary headers */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tableSymbol.h"

/* Declare any necessary global variables or functions */

struct Symbol tableSymbol[SYMBOL_TABLE_SIZE];

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
%type <num> equation
%type <num> assignment // Address of variable being assigned, no num is passed if assignement is a value
%type <num> var_declaration // Address in symbol of tables of the variable being declared
%type <num> multi_var_declaration // Address in symbol of tables of the variable being declared
%type <num> more_declarations // Address in symbol of tables of the variable being declared

/* Define your grammar rules here */
%%

input:
|  function_declaration input 
|  main_declaration {printf("Parsed whole program without errors\n");}
  ;

return_type:
| tINT
| tVOID
  ;

main_declaration:
  return_type tMAIN tLPAR tRPAR tLBRACE body tRBRACE
| return_type tMAIN tLPAR tVOID tRPAR tLBRACE body tRBRACE
| return_type tMAIN tLPAR parametres_declaration tRPAR tLBRACE body tRBRACE
  ;

function_declaration:
  return_type tID tLPAR tRPAR tLBRACE body tRBRACE
| return_type tID tLPAR tVOID tRPAR tLBRACE body tRBRACE
| return_type tID tLPAR parametres_declaration tRPAR tLBRACE body tRBRACE
  ;

body:
| exp body
  ;

parametres_declaration:
  var_declaration
| var_declaration tCOMMA parametres_declaration
 ;

var_declaration:
  int_or_const tID { $$ = getSymbolAddr($2, &tableSymbol); struct Symbol sym; strcpy(sym.name, $2); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol);}
  ;

multi_var_declaration:
  var_declaration more_declarations { if($2 == -1) {$$ = $1;} else {$$ = $2;}}
  ;

/*HJEEEEEEEEEEEEEEEEEEEEEEEEEELPPPPPPPPPPP!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

  LESE DETTE"!!!!:

  EMILIE TAKE THE WORD:

  i mean... segmentation fault?
  vet ikke hvorfor det skjer

  OK takk for ignenting emilie

  Noe galt som skjer når vi gjør $$ = -1; i more_declarations
  */

*/
more_declarations: { $$ = -1;}
| tCOMMA tID more_declarations { if($3 == -1) {$$ = getSymbolAddr($2, &tableSymbol);} else {$$ = $3;} struct Symbol sym; strcpy(sym.name, $2); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol);}
  ;

fun_call_parametres:
  equation
| equation tCOMMA fun_call_parametres
  ;

exp:
  multi_var_declaration tSEMI // Declares multiple variables
| multi_var_declaration assignment tSEMI /* Declares multiple variables and assigns a value to them*/ { printf("COP %d %d \n", getSymbolAddr($1, &tableSymbol), peek(&tableSymbol)) ; pop(&tableSymbol);}// Assigns a value to a variable
| tID assignment tSEMI { printf("COP %d %d \n", getSymbolAddr($1, &tableSymbol), peek(&tableSymbol)) ; pop(&tableSymbol);}// Assigns a value to a variable
| if_case
| ifelse_case
| while_case
| printf tSEMI
| return_case tSEMI // returns a value
  ;

printf:
    tPRINTF tLPAR tID tRPAR { printf("PRI %d \n", getSymbolAddr($3, &tableSymbol));}
    ;
int_or_const:
  tINT
| tCONST
  ;

if_case:
  tIF tLPAR boolean_eq tRPAR tLBRACE body tRBRACE {printf("JMF %d %s \n", peek(&tableSymbol), "???");}
  ;

ifelse_case:
  if_case tELSE tLBRACE body tRBRACE
  ;

while_case:
  tWHILE tLPAR boolean_eq tRPAR tLBRACE body tRBRACE
  ;

assignment:
  tASSIGN equation { $$ = $2;}
| tASSIGN function_call
  ;

return_case:
  tRETURN tID
| tRETURN tNB
  ;

function_call:
  tID tLPAR fun_call_parametres tRPAR
  ;
  
equation:
  tID { struct Symbol sym; strcpy(sym.name, "@"); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol); printf("COP %d %d \n", peek(&tableSymbol), getSymbolAddr($1, &tableSymbol));} // We chose '@' because its a char not often used}
| tNB { struct Symbol sym; strcpy(sym.name, "@"); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol); printf("AFC %d %d \n", peek(&tableSymbol), $1);} // We chose '@' because its a char not often used
| equation tADD equation { int tmp = pop(&tableSymbol); printf("ADD %d %d %d \n", peek(&tableSymbol), peek(&tableSymbol), tmp);}
| equation tSUB equation { int tmp = pop(&tableSymbol); printf("SOU %d %d %d \n", peek(&tableSymbol), peek(&tableSymbol), tmp);}
| equation tMUL equation { int tmp = pop(&tableSymbol); printf("MUL %d %d %d \n", peek(&tableSymbol), peek(&tableSymbol), tmp);}
| equation tDIV equation { int tmp = pop(&tableSymbol); printf("DIV %d %d %d \n", peek(&tableSymbol), peek(&tableSymbol), tmp);}
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
  tID { struct Symbol sym; strcpy(sym.name, "@"); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol); printf("COP %d %d \n", peek(&tableSymbol), getSymbolAddr($1, &tableSymbol));} // We chose '@' because its a char not often used
| tNB { struct Symbol sym; strcpy(sym.name, "@"); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol); printf("AFC %d %d \n", peek(&tableSymbol), $1);} // We chose '@' because its a char not often used
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
