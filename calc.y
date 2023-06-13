%{

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
%}

%union {
	int ival;
	float fval;
}

%token<ival> INT
%token<fval> FLOAT
%token PLUS MINUS MULTIPLY DIVIDE POWER L_PAREN R_PAREN
%token NEWLINE QUIT
%left PLUS MINUS
%left MULTIPLY DIVIDE
%right POWER

%type<ival> expression
%type<fval> mixed_expression

%start calculation

%%

calculation:
	   | calculation line
;

line: NEWLINE
    | mixed_expression NEWLINE	{ printf("\t= %f\n", $1); }
    | expression NEWLINE 				{ printf("\t= %i\n", $1); }
    | QUIT NEWLINE							{ printf("bye!\n"); exit(0); }
;

mixed_expression: FLOAT                 		 			{ $$ = $1; }
	  | mixed_expression PLUS mixed_expression			{ $$ = $1 + $3; }
	  | mixed_expression MINUS mixed_expression			{ $$ = $1 - $3; }
	  | mixed_expression MULTIPLY mixed_expression	{ $$ = $1 * $3; }
	  | mixed_expression DIVIDE mixed_expression		{ $$ = $1 / $3; }
	  | L_PAREN mixed_expression R_PAREN		 				{ $$ = $2; }
	  | expression PLUS mixed_expression	 	 				{ $$ = $1 + $3; }
	  | expression MINUS mixed_expression	 	 				{ $$ = $1 - $3; }
	  | expression MULTIPLY mixed_expression				{ $$ = $1 * $3; }
	  | expression DIVIDE mixed_expression	 				{ $$ = $1 / $3; }
	  | mixed_expression PLUS expression	 	 				{ $$ = $1 + $3; }
	  | mixed_expression MINUS expression	 	 				{ $$ = $1 - $3; }
	  | mixed_expression MULTIPLY expression 	 			{ $$ = $1 * $3; }
	  | mixed_expression DIVIDE expression	 				{ $$ = $1 / $3; }
	  | expression DIVIDE expression		 						{ $$ = $1 / (float)$3; }

		| expression POWER mixed_expression						{ $$ = pow($1, $3); }
		| mixed_expression POWER expression						{ $$ = pow($1, $3); }
		| mixed_expression POWER mixed_expression			{ $$ = pow($1, $3); }
;

expression: INT																		{ $$ = $1; }
	  | expression PLUS expression									{ $$ = $1 + $3; }
	  | expression MINUS expression									{ $$ = $1 - $3; }
	  | expression MULTIPLY expression							{ $$ = $1 * $3; }
	  | expression POWER expression									{ $$ = pow($1, $3); }
	  | L_PAREN expression R_PAREN									{ $$ = $2; }
;

%%

int main() {
	yyin = stdin;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}

void yyerror(const char* s) {
	fprintf(stderr, "error: %s\n", s);
	exit(1);
}
