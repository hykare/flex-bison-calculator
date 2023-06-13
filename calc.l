%option noyywrap

%{
#include <stdio.h>
#include "calc.tab.h"

#define YY_DECL int yylex()


%}

digit     [0-9]
whitespace  [ \t\r\f]+

%%

{digit}+\.{digit}+  { yylval.fval = atof(yytext); return FLOAT; }
{digit}+		        { yylval.ival = atoi(yytext); return INT; }
"+"		              { return PLUS; }
"-"		              { return MINUS; }
"*"		              { return MULTIPLY; }
"/"		              { return DIVIDE; }
"^"		              { return POWER; }
"("		              { return L_PAREN; }
")"		              { return R_PAREN; }
"exit"		          { return QUIT; }
"quit"		          { return QUIT; }
\n		              { return NEWLINE; }
{whitespace}

%%
