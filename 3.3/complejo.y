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
    printf("Introduce expresiones (Ctrl+D para salir):\n");


    yyparse();
    
    return 0;
}