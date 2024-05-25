/* Binome Emilie GREAKER, Daniel AUNAN*/

%{
/* Include necessary headers */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tableSymbol.h"
#include "tableAssembly.h"

/* Declare any necessary global variables or functions */

struct Symbol tableSymbol[SYMBOL_TABLE_SIZE];
struct Instruction tableAssembly[ASSEMBLY_TABLE_SIZE];

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
| function_declaration input
| main_declaration { print_instructions(&tableAssembly); print_table(&tableSymbol); toInstructionAddress(&tableAssembly); printf("\nParsed whole program\n");}
  ;
  
return_type:
| tINT
| tVOID
  ;

main_declaration:
  return_type tMAIN {
    upDateJMPInstruction(&tableAssembly);
    //print_instructions(&tableAssembly);
  } 
  tLPAR tRPAR tLBRACE body tRBRACE
| return_type tMAIN {
    upDateJMPInstruction(&tableAssembly);
    //print_instructions(&tableAssembly);
  }
  tLPAR tVOID tRPAR tLBRACE body tRBRACE
| return_type tMAIN {
    upDateJMPInstruction(&tableAssembly);
    //print_instructions(&tableAssembly);
  } tLPAR parametres_declaration tRPAR tLBRACE body tRBRACE
  ;

function_declaration:
  return_type tID tLPAR tRPAR tLBRACE 
  {
    struct Instruction inst = {"JMP", -1, 0, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
  body tRBRACE
| return_type tID tLPAR tVOID tRPAR tLBRACE {
    struct Instruction inst = {"JMP", -1, 0, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
  body tRBRACE
| return_type tID tLPAR {
    struct Instruction inst = {"JMP", -1, 0, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  } 
  parametres_declaration tRPAR tLBRACE body tRBRACE
  ;

body:
| exp body
  ;

parametres_declaration:
  var_declaration
| var_declaration tCOMMA parametres_declaration
 ;

var_declaration:
  int_or_const tID { 
    struct Symbol sym; strcpy(sym.name, $2); 
    insertSymbol(sym, &tableSymbol); 
    $$ = getSymbolAddr(sym.name, &tableSymbol); 
    //print_table(&tableSymbol);
    }
  ;

multi_var_declaration:
  var_declaration more_declarations { if($2 == -1) {$$ = $1;} else {$$ = $2;}}
  ;

more_declarations: { $$ = -1;}
| tCOMMA tID more_declarations {
  struct Symbol sym; strcpy(sym.name, $2); 
  insertSymbol(sym, &tableSymbol); 
  //print_table(&tableSymbol);
  if($3 == -1) {
      $$ = getSymbolAddr($2, &tableSymbol);
      } else {$$ = $3;}
      }
  ;

fun_call_parametres:
  equation
| equation tCOMMA fun_call_parametres
  ;

exp:
  multi_var_declaration tSEMI // Declares multiple variables
| multi_var_declaration assignment tSEMI /* Declares multiple variables and assigns a value to them*/ {
    struct Instruction inst = {"COP", $1, peek(&tableSymbol), 0}; 
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly); 
    pop(&tableSymbol);}// Assigns a value to a variable
| tID assignment tSEMI {
    struct Instruction inst = {"COP", getSymbolAddr($1, &tableSymbol), peek(&tableSymbol), 0}; 
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
    pop(&tableSymbol);}// Assigns a value to a variable
| if_case
| ifelse_case
| while_case
| printf tSEMI
| return_case tSEMI // returns a value
  ;

printf:
  tPRINTF tLPAR tID tRPAR { 
    struct Instruction inst = {"PRI", getSymbolAddr($3, &tableSymbol), 0, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
  ;

int_or_const:
  tINT
| tCONST
  ;

if_case:
  tIF tLPAR boolean_eq tRPAR {
    struct Instruction inst = {"JMF", peek(&tableSymbol), -1, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
    pop(&tableSymbol);}
  tLBRACE body tRBRACE {
    upDateJMFInstruction(&tableAssembly);
    //print_instructions(&tableAssembly);
  }
  ;

ifelse_case:
  if_case tELSE tLBRACE body tRBRACE
  ;

while_case:
  tWHILE tLPAR boolean_eq tRPAR {
    struct Instruction inst = {"JMF", peek(&tableSymbol), -1, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
    pop(&tableSymbol);}
  tLBRACE body tRBRACE {
    upDateJMFInstruction(&tableAssembly);
    //print_instructions(&tableAssembly);
  }
  ;

assignment:
  tASSIGN equation { $$ = $2;}
| tASSIGN function_call
  ;

return_case:
  tRETURN equation
  ;

function_call:
  tID tLPAR fun_call_parametres tRPAR
  ;
  
equation:
  tID { 
    struct Symbol sym; strcpy(sym.name, "@"); 
    insertSymbol(sym, &tableSymbol); 
    //print_table(&tableSymbol); 
    struct Instruction inst = {"COP", peek(&tableSymbol), getSymbolAddr($1, &tableSymbol), 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly); // We chose '@' because its a char not often used
  }
| tNB { 
    struct Symbol sym; strcpy(sym.name, "@"); 
    insertSymbol(sym, &tableSymbol); 
    //print_table(&tableSymbol); 
    struct Instruction inst = {"AFC", peek(&tableSymbol), $1, 0}; 
    insertInstruction(inst, &tableAssembly); 
    //print_instructions(&tableAssembly); // We chose '@' because its a char not often used
  }
| equation tADD equation { 
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"ADD", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| equation tSUB equation { 
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"SOU", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| equation tMUL equation { 
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"MUL", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| equation tDIV equation { 
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"DIV", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| tLPAR equation tRPAR
  ;

boolean_operator:
  tLT {
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"INF", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| tGT {
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"SUP", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| tNE
| tEQ {
    int tmp = pop(&tableSymbol); 
    struct Instruction inst = {"EQU", peek(&tableSymbol), peek(&tableSymbol), tmp};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly);
  }
| tGE
| tLE
| tAND
| tOR
  ;

boolean_eq:
  tID { 
    struct Symbol sym; strcpy(sym.name, "@"); 
    insertSymbol(sym, &tableSymbol); 
    //print_table(&tableSymbol); 
    struct Instruction inst = {"COP", peek(&tableSymbol), getSymbolAddr($1, &tableSymbol), 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly); // We chose '@' because its a char not often used
  }
| tNB { 
    struct Symbol sym; strcpy(sym.name, "@"); 
    insertSymbol(sym, &tableSymbol); 
    //print_table(&tableSymbol); 
    struct Instruction inst = {"AFC", peek(&tableSymbol), $1, 0};
    insertInstruction(inst, &tableAssembly);
    //print_instructions(&tableAssembly); // We chose '@' because its a char not often used
  }
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
