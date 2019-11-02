%option noyywrap
%option yylineno

%{
#include <stdio.h>
#include<stdbool.h>
#include "symTable.h"
int symTableIndex;
bool error_occured = false;
int line_number = 1 ;

%}


DIGIT	[0-9]
LETTER  [a-zA-Z_]
SIGN    [+-]
%%

" " /* Ignore. */  ;
[ \t\r]+  ;
\n			      line_number++ ;
";"													 printf("'%s' => Semicolon\n", yytext);
","             									 printf("'%s' => Comma\n", yytext);
"("                           					     printf("'%s' => left parenthesis\n", yytext);
")"                           					     printf("'%s' => right parenthesis\n", yytext);
"{"													 printf("'%s' => left Brace\n", yytext);
"}"													 printf("'%s' => right Brace\n", yytext);
"="													 printf("'%s' => assignment\n", yytext);
"++"											     printf("'%s' => INCREMENT\n", yytext);
"--"											     printf("'%s' => DECREMENT\n", yytext);
"X"													 printf("'%s' => X\n", yytext);
"Y"													 printf("'%s' => Y\n", yytext);
({LETTER})+({LETTER}{DIGIT})*                         {
													  addToSymTable(yytext,idToken);
													  printf("'%s' => Identifier\n",  yytext );
													 }
{SIGN}?{DIGIT}+         	       					 {
													  symTableIndex=addToSymTable(yytext,numToken); 
													  setValueType(symTableIndex,intType);
													  setIntVal(symTableIndex,atoi(yytext));
													  printf("'%s' => num(int)\n", yytext);
													 } 
  {SIGN}?({DIGIT}*[.])?{DIGIT}+                       {
													  symTableIndex=addToSymTable(yytext,numToken);
													  setValueType(symTableIndex,realType);
													  setRealVal(symTableIndex,atof(yytext));
													  printf("'%s' =>num(float)\n", yytext);
													 }
													 
													 
													 

 {SIGN}?({DIGIT})+({LETTER})+                                   {error_occured = true; return 0;}
 {SIGN}?({DIGIT}+"."{DIGIT}+("E"{SIGN}?{DIGIT}+)?)+({LETTER})+  {error_occured = true; return 0;}
 
 
 
 
.                								   {error_occured = true; return 0;}
%%
int main( int argc, char **argv ){
			 char fname[50];
			 printf("Enter input file name: ");
			 scanf("%s",&fname);
			 FILE *infile = fopen(fname, "r");
	         if (!infile) {
			 printf("error loading file");
			 return -1;
	                     }
                     yyin =infile;
             yylex();
			 if(error_occured)
printf("Error in line %d : Bad Input Format!!\n", line_number);
			 printSymTable();
			 getch();
			 return 0;
             }