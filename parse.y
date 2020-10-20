%{

#include <stdio.h>
#define YDEBUG
#ifndef YDEBUG

#define Y_DEBUG_PRINT(x)

#else

#define Y_DEBUG_PRINT(x) printf("Yout %s \n ",x)

#endif

int yydebug = 1;
extern char the_token[];
/* This is how I read tokens from lex... :) */

extern int input_line_no;
/* This is the current line number */

extern char *full_line;
/* This is the full line */

void yyerror();
void warn(char *);

%}

%token STRING CHAR INT EQUALS NTEQUAL GREQUAL LSEQUAL GRTHAN LSTHAN
%token AND OR SEMIC COMMA LPAR RPAR LBRAC RBRAC LCURL RCURL NOT
%token ASSIGN ADD MINUS MUL DIV ID EXTERN FOR WHILE RETURN IF ELSE
%token VOID OTHER

%left OR
%left AND
%left EQUALS NTEQUAL
%left LSTHAN GRTHAN LSEQUAL GREQUAL
%left ADD MINUS
%left MUL DIV
%right UMINUS NOT

%%

Assign : ID Assign1 ASSIGN Expr {Y_DEBUG_PRINT("Assign-1-ID-Assign1-ASSIGN-Expr"); }

Assign1 : 			{ Y_DEBUG_PRINT("Assign1-1-Empty"); }
	| LBRAC Expr RBRAC 	{ Y_DEBUG_PRINT("Assign1-2-LBRAC-Expr-RBRAC"); }
	| LBRAC Expr error 	{ warn(": missing RBRAC"); }
	| error Expr RBRAC 	{ warn(": missing LBRAC"); }
	| LBRAC error RBRAC 	{ warn(": Invalid array index"); }

Expr : MINUS Expr %prec UMINUS 	{ Y_DEBUG_PRINT("Expr-1-UMINUS Expr"); }
	| NOT Expr 		{ Y_DEBUG_PRINT("Expr-2-ANABG Expr"); }
	| Expr Binop Expr 	{ Y_DEBUG_PRINT("Expr-3-Expr-Binop-Expr"); }
	| Expr Relop Expr 	{ Y_DEBUG_PRINT("Expr-4-Expr-Binop-Expr"); }
	| Expr Logop Expr 	{ Y_DEBUG_PRINT("Expr-5-Expr-Logop-Expr"); }
	| ID 			{ Y_DEBUG_PRINT("Expr-6-ID"); }
	| LPAR Expr RPAR 	{ Y_DEBUG_PRINT("Expr-7-LPAR-Expr-RPAR");}
	| INT 			{ Y_DEBUG_PRINT("Expr-8-INT"); }
	| CHAR 			{ Y_DEBUG_PRINT("Expr-9-CHAR"); }
	| STRING 		{ Y_DEBUG_PRINT("Expr-10-STRING"); }
	| Array 		{ Y_DEBUG_PRINT("Expr-11-Array"); }
	| error 		{ warn(":invalid expression "); }

Array :	ID LBRAC Expr RBRAC 	{ Y_DEBUG_PRINT("Array-1-ID-LBRAC-Expr-RBRAC"); }
	| ID error RBRAC 	{ warn( ": invalid array expression"); }

Binop : ADD 			{ Y_DEBUG_PRINT("Binop-1-ADD"); }
	| MINUS 			{ Y_DEBUG_PRINT("Binop-2-MINUS"); }
	| MUL 			{ Y_DEBUG_PRINT("Binop-3-MUL"); }
	| DIV 			{ Y_DEBUG_PRINT("Binop-4-DIV"); }

Logop : AND 			{ Y_DEBUG_PRINT("Logop-1-AND"); }
	| OR 		{ Y_DEBUG_PRINT("Logop-2-OR"); }

Relop : EQUALS 			{ Y_DEBUG_PRINT("Relop-1-EQUALS"); }
	| NTEQUAL 		{ Y_DEBUG_PRINT("Relop-2-NTEQUAL"); }
	| LSEQUAL 		{ Y_DEBUG_PRINT("Relop-3-LSEQUAL"); }
	| GREQUAL 		{ Y_DEBUG_PRINT("Relop-4-GREQUAL"); }
	| GRTHAN 		{ Y_DEBUG_PRINT("Relop-5-GRTHAN"); }
	| LSTHAN 		{ Y_DEBUG_PRINT("Relop-6-LSTHAN"); }

%%

/*
int main()
{
	int result = yyparse();

	if (lex_state == 1) {
		yyerror("End of file within a comment");
	}

	if (lex_state == 2) {
		yyerror("End of file within a string");
	}
	

	return result;
}*/

int yywrap() {
	return 1;
}

void yyerror(char *s) {
	fprintf(stderr, "%s on line %d",s,input_line_no);
}

void warn(char *s) {
	fprintf(stderr, "%s\n", s);
}
 
