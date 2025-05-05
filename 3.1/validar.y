%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token NUMBER
%left '+' '-'
%left '*' '/'
%right UMINUS

%%

input: 
    | input expr '\n' { printf("Expresión válida\n"); }
    | input error '\n' { yyerror("Expresión inválida"); yyerrok; }
;

expr: expr '+' expr
    | expr '-' expr
    | expr '*' expr
    | expr '/' expr
    | '-' expr %prec UMINUS
    | '(' expr ')'
    | NUMBER
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Introduce expresiones aritméticas (Ctrl+D para salir):\n");
    yyparse();
    return 0;
}