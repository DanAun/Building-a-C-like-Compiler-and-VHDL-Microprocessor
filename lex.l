/* Definitions */
%{
    #include "parser.tab.h"
%}

%option noyywrap
%option noinput
%option nounput

/* Rules */

/* States for handling multi-line and single-line comments */
%x MULTI_LINE_COMMENT
%x SINGLE_LINE_COMMENT

%%


"/*" { BEGIN(MULTI_LINE_COMMENT); } // Matches the beginning of a MULTI_LINE_COMMENT and switches to the MULTI_LINE_COMMENT state
<MULTI_LINE_COMMENT>"*/" { BEGIN(INITIAL); } // Matches the end of a MULTI_LINE_COMMENT and switches back to the INITIAL state
<MULTI_LINE_COMMENT>\n { /* Matches a newline and ignores it*/ }
<MULTI_LINE_COMMENT>. { /* Matches any character in a MULTI_LINE_COMMENT and ignores it */ }

"//" { BEGIN(SINGLE_LINE_COMMENT); } // Matches the beginning of a SINGLE_LINE_COMMENT and switches to the SINGLE_LINE_COMMENT state
<SINGLE_LINE_COMMENT>\n { BEGIN(INITIAL); } // Matches the end of a SINGLE_LINE_COMMENT and switches back to the INITIAL state
<SINGLE_LINE_COMMENT>. { /* Matches any character in a SINGLE_LINE_COMMENT and ignores it */ } /*

 Matches keywords */
void { return tVOID; }
const { return tCONST; }
int { return tINT; }
main { return tMAIN; }
if { return tIF; }
else { return tELSE; }
while { return tWHILE; }
return { return tRETURN; }
printf { return tPRINTF; } /*

 Matches identifiers and integers */
[a-zA-Z][a-zA-Z0-9]* { yylval.str = strdup(yytext); return tID; } // Matches an identifier and prints it
[0-9]+ { yylval.num = atoi(yytext); return tNB; }
[0-9]+e[-+]?[0-9]+ { yylval.num = atof(yytext); /*printf("tNB-SN: '%.0f[0x%x]'\n", atof(yytext), (int)atof(yytext));*/ return tNB;/* Matches a number in scientific notation and prints it in decimal format and converts it to hexadecimal format*/ }
0x[0-9A-Fa-f]+ {yylval.num = strtol(yytext, NULL, 16); return tNB; /* Matches a hexadecimal number and prints it and converts it to decimal format*/ } /*

 Matches symbols */
"+" { return tADD; }
"-" { return tSUB; }
"*" { return tMUL; }
"/" { return tDIV; }
"<" { return tLT; }
">" { return tGT; }
"!=" { return tNE; }
"==" { return tEQ; }
">=" { return tGE; }
"<=" { return tLE; }
"=" { return tASSIGN; }
"&&" { return tAND; }
"||" { return tOR; }
"!" { return tNOT; }
"{" { return tLBRACE; }
"}" { return tRBRACE; }
"(" { return tLPAR; }
")" { return tRPAR; }
";" { return tSEMI; }
"," { return tCOMMA; }
[ \t\n\r]+   { /* Ignores white, tab and newline */ }
. { return tERROR; /* Compilation error, when unknown expression encountered */}

%%