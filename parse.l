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
number		[0-9]
letter		[A-Za-z]
alfanum		[A-Za-z0-9_]
intcon		{number}+
id		{letter}{alfanum}*
anything	.

 /*
  * Start conditions are specified to identify comments,
  * literal strings, and literal chars.
  */

%Start comment_in comment_out string_in char_in char_out

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


<INITIAL>\" {
	BEGIN(string_in);
}

<INITIAL>{intcon} {
	return(INTCON);
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
 /*main() {
        int result;
        while ((result=yylex()) != 0) {
            printf("%d\t%s\n", result, yytext);
        }
        return 0;
 }*/