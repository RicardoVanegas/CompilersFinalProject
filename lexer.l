%{
#include "y.tab.h"
#include <stdio.h>

%}
%%
Robot	{yylval.sval = strdup(yytext); return ROBOT;}
please	{yylval.sval = strdup(yytext); return PLEASE;}
move	{yylval.sval = strdup(yytext); return MOVE;}
[0-9]	{yylval.ival = atoi(yytext); return DIGIT;}
turn	{yylval.sval = strdup(yytext); return TURN;}
90	{yylval.ival = atoi(yytext); return DEGREE;}
180	{yylval.ival = atoi(yytext); return DEGREE;}
270	{yylval.ival = atoi(yytext); return DEGREE;}
360	{yylval.ival = atoi(yytext); return DEGREE;}
[a-z]+	{yylval.sval = strdup(yytext); return WORD;}
[\t] ; /*ignore whitespaces*/
\n	return 0; /*logical end of file*/



%%
int yywrap(void) {
    return 1;
}
