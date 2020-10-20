/* 
 * Austin Ramsay
 * austinramsay@gmail.com
 * 
 * University of Arizona
*/

%{

#include <stdio.h>

// #define YDEBUG
#ifndef YDEBUG
#define Y_DEBUG_PRINT(x)
#else
#define Y_DEBUG_PRINT(x) printf("Yout %s \n ",x)
#endif

int yydebug = 1;

// Buffer from lex to get token values 
extern char the_token[];

// Current line number accounted for by lex 
extern int input_line_no;

// Buffer from lex for the whole line 
extern char *full_line;

// Function prototypes
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
%right NOT
%nonassoc UMINUS 

%%

prog :	/* empty */ 
     	| prog statement		{ Y_DEBUG_PRINT("prog-1-statement"); } 
	;

statement : assign SEMIC		{ Y_DEBUG_PRINT("statement-1-assign-SEMIC"); }

assign : ID assign1 ASSIGN expr {Y_DEBUG_PRINT("assign-1-ID-assign1-ASSIGN-expr"); }

assign1 : 			{ Y_DEBUG_PRINT("assign1-1-Empty"); }
	| LBRAC expr RBRAC 	{ Y_DEBUG_PRINT("assign1-2-LBRAC-expr-RBRAC"); }
	| LBRAC expr error 	{ warn(": missing RBRAC"); }
	| error expr RBRAC 	{ warn(": missing LBRAC"); }
	| LBRAC error RBRAC 	{ warn(": Invalid array index"); }

expr : MINUS expr %prec UMINUS 	{ Y_DEBUG_PRINT("expr-1-UMINUS expr"); }
	| NOT expr 		{ Y_DEBUG_PRINT("expr-2-ABANG expr"); }
	| expr binaryop expr 	{ Y_DEBUG_PRINT("expr-3-expr-binaryop-expr"); }
	| expr relop expr 	{ Y_DEBUG_PRINT("expr-4-expr-binaryop-expr"); }
	| expr logicop expr 	{ Y_DEBUG_PRINT("expr-5-expr-logicop-expr"); }
	| ID 			{ Y_DEBUG_PRINT("expr-6-ID"); }
	| LPAR expr RPAR 	{ Y_DEBUG_PRINT("expr-7-LPAR-expr-RPAR");}
	| INT 			{ Y_DEBUG_PRINT("expr-8-INT"); }
	| CHAR 			{ Y_DEBUG_PRINT("expr-9-CHAR"); }
	| STRING 		{ Y_DEBUG_PRINT("expr-10-STRING"); }
	| array 		{ Y_DEBUG_PRINT("expr-11-array"); }
	| error 		{ warn(":invalid expression "); }

array :	ID LBRAC expr RBRAC 	{ Y_DEBUG_PRINT("array-1-ID-LBRAC-expr-RBRAC"); }
	| ID error RBRAC 	{ warn( ": invalid array expression"); }

binaryop : ADD 			{ Y_DEBUG_PRINT("binaryop-1-ADD"); }
	| MINUS 			{ Y_DEBUG_PRINT("binaryop-2-MINUS"); }
	| MUL 			{ Y_DEBUG_PRINT("binaryop-3-MUL"); }
	| DIV 			{ Y_DEBUG_PRINT("binaryop-4-DIV"); }

logicop : AND 			{ Y_DEBUG_PRINT("logicop-1-AND"); }
	| OR 		{ Y_DEBUG_PRINT("logicop-2-OR"); }

relop : EQUALS 			{ Y_DEBUG_PRINT("relop-1-EQUALS"); }
	| NTEQUAL 		{ Y_DEBUG_PRINT("relop-2-NTEQUAL"); }
	| LSEQUAL 		{ Y_DEBUG_PRINT("relop-3-LSEQUAL"); }
	| GREQUAL 		{ Y_DEBUG_PRINT("relop-4-GREQUAL"); }
	| GRTHAN 		{ Y_DEBUG_PRINT("relop-5-GRTHAN"); }
	| LSTHAN 		{ Y_DEBUG_PRINT("relop-6-LSTHAN"); }

%%

int main() {

	int result = yyparse();

	/*if (lex_state == 1) {
		yyerror("End of file within a comment");
	}

	if (lex_state == 2) {
		yyerror("End of file within a string");
	}*/

	return result;
}

int yywrap() {
	return 1;
}

void yyerror(char *s) {
	fprintf(stderr, "%s on line %d\n", s, input_line_no);
}

void warn(char *s) {
	fprintf(stderr, "%s\n", s);
}
 
