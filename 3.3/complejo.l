%{
#include "y.tab.h"
%}

%option noyywrap

%%

[0-9]+          { yylval = atoi(yytext); return NUMBER; }
"true"|"false"  { yylval = (yytext[0] == 't'); return BOOLEAN; }
"AND"           { return AND; }
"OR"            { return OR; }
"NOT"           { return NOT; }
[ \t]           ;  /* ignorar espacios */
[\n]            { return '\n'; }
[+\-*/()]       { return yytext[0]; }
.               { return yytext[0]; }

%%