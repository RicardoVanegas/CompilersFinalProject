%{
#include <stdio.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE* yyin;

void yyerror(const char* s);
FILE *out_file;
%}


%union {
int ival;
char *sval;
}

%token <ival> DIGIT
%token <ival> DEGREE
%token <sval> WORD
%token <sval> ROBOT
%token <sval> PLEASE
%token <sval> MOVE
%token <sval> TURN

%%
sentence : ROBOT PLEASE indication
;
indication : moveindication word turnindication
		|moveindication
		;
word: 	WORD word
	|/*epsylon */
	;
turnindication :	turn word newmove
			;
newmove :	indication
		|/*epsilon*/
		;	
turn : 	TURN DEGREE	{ fprintf(out_file, "TURN %d\n", $2); } 
		;
moveindication :	MOVE DIGIT	{ fprintf(out_file, "MOV %i\n", $2); }
			;
%%

void yyerror(const char* s) {
    fprintf(stderr, "Parse error: %s\n", s);
    exit(1);
}

int main(int argc, char* argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Usage: %s input_file\n", argv[0]);
        return 1;
    }

    FILE* file = fopen(argv[1], "r");
    if (!file) {
        fprintf(stderr, "Error: Unable to open the input file.\n");
        return 1;
    }

    out_file = fopen("instructions.asm", "w");
    if (!out_file) {
        fprintf(stderr, "can't open instructions.asm\n");
        exit(1);
    }

    yyin = file; 
    yyparse();

    fclose(file);
    fclose(out_file);

    return 0;
}
