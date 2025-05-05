%{
#include "y.tab.h"
#include <stdlib.h>
%}

%%

[01]         { yylval = atoi(yytext); return BOOLEAN; }
"AND"        { return AND; }
"OR"         { return OR; }
"NOT"        { return NOT; }
[ \t]        ; /* Ignorar espacios */
\n           { return '\n'; }
"("          { return '('; }
")"          { return ')'; }
.            { yyerror("Carácter no válido"); }

%%

int yywrap() {
    return 1;
}