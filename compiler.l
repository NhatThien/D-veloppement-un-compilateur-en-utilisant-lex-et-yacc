%{
	#include "rule.tab.h"
%}

VAR [a-zA-Z][0-9a-zA-Z_]*
SEP [,]
NUM [0-9]*

%%
"main" 						return tMAIN;
"while"						return tWHILE;
"if"						return tIF;
"else"						return tELSE;
"for"						return tFOR;
"true"					    return tTRUE;
"false"						return tFALSE;
\{							return tACCO;
\}							return tACCF;
"int" {
		yylval.str= strdup(yytext);
		return tINT;
} 
"const"			  		 	return tCONST;
{VAR} {
		yylval.str= strdup(yytext);
		return tVAR;
} 			            

{NUM}						 {
		yylval.str= strdup(yytext);
		return tNUM;
} 		
\+ 							return tADD;
\* 							return tSTAR;
\- 							return tMOINS;
\/ 							return tDIV;
\= 							return tEGAL;
\<							return tSUP;
\>							return tINF;
"!="						return tINEGAL;
"=="						return tEGALEGAL;
{SEP} 						return tSEP;
\(							return tPRTO;
\)							return tPRTF;
\;						   	return tPV;
\&							return tADR;
\\n							return tLINE;
[ \t\n]						;


