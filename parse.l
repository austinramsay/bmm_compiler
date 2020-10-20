%{
 
 /* constants are defined outside of the l file in y.tab.h
  * constants are defined from 257
  */

#include "y.tab.h"

char the_token[1000];
char full_line[1000];
int input_line_no = 1;

%}

whitespace	[ \t]
digit		[0-9]
letter		[A-Za-z]
alfanum		[A-Za-z0-9_]
asciichar	[\x20-\x7e]
int		{digit}+
id		{letter}{alfanum}*
binop		[-+*/]
anything	.

 /*
  * Start conditions are specified to identify comments,
  * literal strings, and literal chars.
  */

%Start comment_in comment_out string_in char_in char_out

%%


 /* ignore whitespace */
[ \t]	;

 /* line number is recorded */
[\n]	input_line_no++;


 /* identify comments */
<INITIAL>"/""*"         {
	BEGIN(comment_in);
}
<comment_in>"*"      BEGIN(comment_out);
<comment_in>[^*]     ;
<comment_out>"*"     ;
<comment_out>"/"     {
	BEGIN(INITIAL);
}
<comment_out>[^*/] BEGIN(comment_in);


 /* identify strings */
<INITIAL>\" {
	BEGIN(string_in);
}
<string_in>[^"]		;
<string_in>\" {
	BEGIN(INITIAL);
	return(STRING);
}


 /* identify chars */
<INITIAL>"'" {
	BEGIN(char_in);
}
<char_in>"\\" {
	// still taking in char newline or null char
	;
}
<char_in>{asciichar} {
	BEGIN(char_out);
}
<char_in>{anything} {
	BEGIN(INITIAL);
	return(OTHER);
}
<char_out>[^'] {
	BEGIN(INITIAL);
	return(OTHER);
}
<char_out>"'" {
	BEGIN(INITIAL);
	return(CHAR);
}


 /* identify integer values (0 to N) */
<INITIAL>{int} {
	return(INT);
}


 /* identify if-else tokens */
<INITIAL>"if" 	return(IF);
<INITIAL>"else" return(ELSE);


 /* identify loop tokens */
<INITIAL>"for"		return(FOR);
<INITIAL>"while"	return(WHILE);


 /* return token */
<INITIAL>"return"	return(RETURN);


 /* identify IDs */
<INITIAL>{id}	return(ID);


 /* assignment operator */
<INITIAL>"="	return(ASSIGN);


 /* identify binary operators */
<INITIAL>{binop} {
	if (strcmp(yytext, "+") == 0) {
		return(ADD);
	} else if (strcmp(yytext, "-") == 0) {
		return(MINUS);
	} else if (strcmp(yytext, "*") == 0) {
		return(MUL);
	} else if (strcmp(yytext, "/") == 0) {
		return(DIV);
	}
}


 /* identify relational operators */
<INITIAL>"=="	return(EQUALS);
<INITIAL>"!="	return(NTEQUAL);
<INITIAL>">="	return(GREQUAL);
<INITIAL>"<="	return(LSEQUAL);
<INITIAL>">"	return(GRTHAN);
<INITIAL>"<"	return(LSTHAN);


 /* identify logical operators */
<INITIAL>"&&"	return(AND);
<INITIAL>"||"	return(OR);


 /* semicolons, brackets, commas and paranethesis */
<INITIAL>";"	return(SEMIC);
<INITIAL>","	return(COMMA);
<INITIAL>"("	return(LPAR);
<INITIAL>")"	return(RPAR);
<INITIAL>"{"	return(LCURL);
<INITIAL>"}"	return(RCURL);
<INITIAL>"["	return(LBRAC);
<INITIAL>"]"	return(RBRAC);


 /* NOT operator */
<INITIAL>"!"	return(NOT);


 /*
  * For strings that can not be identified by any patterns specified previously
  * lex returns the value of the character
  */
<INITIAL>{anything} { 
	return(OTHER);
}


%%


 /* only used in testing lex */
 /* main() {
	int result;
        while ((result=yylex()) != 0) {
            printf("%d\t%s\n", result, yytext);
        }
        return 0;
}*/
