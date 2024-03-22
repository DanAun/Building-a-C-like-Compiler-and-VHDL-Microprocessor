/* Binome Emilie GREAKER, Daniel AUNAN*/

%{
/* Include necessary headers */
#include <stdio.h>
#include <stdlib.h>
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
  int_or_const tID 
  ;

multi_var_declaration:
  int_or_const tID more_declarations
  ;

more_declarations:
| tCOMMA tID more_declarations
  ;

fun_call_parametres:
  equation
| equation tCOMMA fun_call_parametres
  ;

exp:
  var_declaration tSEMI // Declares 1 variable
| var_declaration assignment tSEMI // Declares 1 variable and assigns it a value
| multi_var_declaration tSEMI // Declares multiple variables
| multi_var_declaration assignment tSEMI // Declares multiple variables and assigns a value to them
//TODO:
| tID assignment //CHECK NESTE GANG GJLØRE FERDIG EXP
| if_case
| ifelse_case
| while_case
| printf
| return_case
  ;

printf:
    tPRINTF tLPAR tID tRPAR tSEMI
    ;
int_or_const:
  tINT
| tCONST
  ;

multi_int_declaration:
  tID tCOMMA multi_int_declaration { struct Symbol sym; strcpy(sym.name, $1); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol);}
| tID { struct Symbol sym; strcpy(sym.name, $1); insertSymbol(sym, &tableSymbol); print_table(&tableSymbol);}
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
  tASSIGN equation tSEMI
| tASSIGN function_call tSEMI
  ;

return_case:
  tRETURN tID tSEMI
| tRETURN tNB tSEMI
  ;

function_call:
  tID tLPAR fun_call_parametres tRPAR

equation:
  tID
| tNB
| equation tADD equation {$$ = atoi($1) + atoi($3);}
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
