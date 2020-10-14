/* A Bison parser, made by GNU Bison 3.7.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    STRINGCON = 258,               /* STRINGCON  */
    CHARCON = 259,                 /* CHARCON  */
    INTCON = 260,                  /* INTCON  */
    EQUALS = 261,                  /* EQUALS  */
    NOTEQU = 262,                  /* NOTEQU  */
    GREEQU = 263,                  /* GREEQU  */
    LESEQU = 264,                  /* LESEQU  */
    GREATE = 265,                  /* GREATE  */
    LESSTH = 266,                  /* LESSTH  */
    ANDCOM = 267,                  /* ANDCOM  */
    ORCOMP = 268,                  /* ORCOMP  */
    SEMIC = 269,                   /* SEMIC  */
    COMMA = 270,                   /* COMMA  */
    LPARN = 271,                   /* LPARN  */
    RPARN = 272,                   /* RPARN  */
    LBRAC = 273,                   /* LBRAC  */
    RBRAC = 274,                   /* RBRAC  */
    LCURL = 275,                   /* LCURL  */
    RCURL = 276,                   /* RCURL  */
    NOT = 277,                     /* NOT  */
    EQUAL = 278,                   /* EQUAL  */
    ADD = 279,                     /* ADD  */
    SUB = 280,                     /* SUB  */
    MUL = 281,                     /* MUL  */
    DIV = 282,                     /* DIV  */
    ID = 283,                      /* ID  */
    EXTERN = 284,                  /* EXTERN  */
    FOR = 285,                     /* FOR  */
    WHILE = 286,                   /* WHILE  */
    RETURN = 287,                  /* RETURN  */
    IF = 288,                      /* IF  */
    ELSE = 289,                    /* ELSE  */
    VOID = 290,                    /* VOID  */
    CHAR = 291,                    /* CHAR  */
    INT = 292,                     /* INT  */
    OTHER = 293,                   /* OTHER  */
    UMINUS = 294                   /* UMINUS  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif
/* Token kinds.  */
#define YYEOF 0
#define YYerror 256
#define YYUNDEF 257
#define STRINGCON 258
#define CHARCON 259
#define INTCON 260
#define EQUALS 261
#define NOTEQU 262
#define GREEQU 263
#define LESEQU 264
#define GREATE 265
#define LESSTH 266
#define ANDCOM 267
#define ORCOMP 268
#define SEMIC 269
#define COMMA 270
#define LPARN 271
#define RPARN 272
#define LBRAC 273
#define RBRAC 274
#define LCURL 275
#define RCURL 276
#define NOT 277
#define EQUAL 278
#define ADD 279
#define SUB 280
#define MUL 281
#define DIV 282
#define ID 283
#define EXTERN 284
#define FOR 285
#define WHILE 286
#define RETURN 287
#define IF 288
#define ELSE 289
#define VOID 290
#define CHAR 291
#define INT 292
#define OTHER 293
#define UMINUS 294

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
