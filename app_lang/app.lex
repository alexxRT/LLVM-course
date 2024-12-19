%{
#define YYSTYPE void*
#include "app.tab.h"
extern "C" int yylex();
%}

%option yylineno
%option noyywrap

%%

[/][/].*\n      ; // comment
[0-9]*          {
                  printf("IntLiteral %s\n", yytext);
                  yylval = strdup(yytext);
                  return IntLiteral;
                }
"func"          { printf("FunctionBegin\n"); return FunctionBegin; }
"end"           { printf("FunctionEnd\n"); return FunctionEnd; }
"call"          { printf("CallFunction\n"); return CallFunction; }
"if"            { printf("IfToken\n"); return IfToken; }
"for"           { printf("ForToken\n"); return ForToken; }
"goto"          { printf("GotoToken\n"); return GotoToken; }
"paint_pixel"   { printf("PutToken\n"); return PutToken; }
"flush_window"  { printf("FlushToken\n"); return FlushToken; }
"abs"           { printf("AbsToken\n"); return AbsToken;}
[A-Za-z_]+      { // identifier
                  printf("Identifier %s\n", yytext);
                  yylval = strdup(yytext);
                  return NameToken;
                }
[ \t\r\n]      ; // whitespace
.              { return *yytext; }

%%