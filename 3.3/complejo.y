%{
#include <stdio.h>
#include <stdlib.h>

int yylex();
void yyerror(const char *s);
%}

%token NUMBER BOOLEAN
%left OR
%left AND
%left '+' '-'
%left '*' '/'
%right NOT
%right UMINUS

%%

input: combined_expr '\n' { printf("Expresión válida\n"); }
     | error '\n' { yyerror("Expresión inválida"); yyerrok; }
     ;

combined_expr: combined_expr '+' combined_expr
             | combined_expr '-' combined_expr
             | combined_expr '*' combined_expr
             | combined_expr '/' combined_expr
             | '-' combined_expr %prec UMINUS
             | '(' combined_expr ')'
             | combined_expr AND combined_expr
             | combined_expr OR combined_expr
             | NOT combined_expr
             | NUMBER
             | BOOLEAN
             ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "%s\n", s);
}

int main() {
    printf("Analizador de expresiones combinadas (v2.0)\n");
    printf("Prueba con:\n");
    printf("  (4 + 5) * (2 AND 1)\n");
    printf("  (4 + 5) * 2\n\n");
    
    while(1) {
        printf("> ");
        yyparse();
    }
    return 0;
}