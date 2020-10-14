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
anything	.

 /*
  * Start conditions are specified to identify comments,
  * literal strings, and literal chars.
  */

%Start comment_in comment_out string_in char_in char_out
%option noyywrap 

%%

 /* line number is recorded */
[\n]                        input_line_no++;


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
<char_in>asciichar {
	BEGIN(char_out);
}
<char_out>"'" {
	BEGIN(INITIAL);
	return(CHAR);
}


 /* identify integer values (0 to N) */
<INITIAL>{int} {
	return(INT);
}


 /*
  * For strings that can not be identified by any patterns specified previously
  * lex returns the value of the character
  */
<INITIAL>anything { 
	return(OTHER);
}


%%

 /* only used in testing lex */
 main() {
        int result;
        while ((result=yylex()) != 0) {
            printf("%d\t%s\n", result, yytext);
        }
        return 0;
 }
