%{
#include "y.tab.h"
#include <stdlib.h>


void yyerror(const char *s);
%}

%%

[0-9]+      { yylval = atoi(yytext); return NUMBER; }
[ \t]       ; /* Ignorar espacios en blanco */
\n          { return '\n'; }
"+"         { return '+'; }
"-"         { return '-'; }
"*"         { return '*'; }
"/"         { return '/'; }
"("         { return '('; }
")"         { return ')'; }
.           { yyerror("Carácter no válido"); }

%%

int yywrap() {
    return 1;
}