%{
#include <stdio.h>
#include <stdlib.h>

void yyerror(const char *s);
int yylex(void);
%}

%token BOOLEAN
%left OR
%left AND
%right NOT

%%

input:
    | input expr '\n' { printf("Expresión lógica válida\n"); }
    | input error '\n' { yyerror("Expresión inválida"); yyerrok; }
;

expr: expr AND expr
    | expr OR expr
    | NOT expr
    | '(' expr ')'
    | BOOLEAN
;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
}

int main() {
    printf("Introduce expresiones lógicas (1/0 para true/false, Ctrl+D para salir):\n");
    yyparse();
    return 0;
}