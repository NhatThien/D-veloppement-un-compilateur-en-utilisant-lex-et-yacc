%{
	#include <stdio.h>
	#include <stdlib.h>
	#include <string.h>
	#include "tab_sym.c"
	#include "interpreteur.c"
	int yylex (void);
	void yyerror(char*);
	char id[10];

	int  value;
	char type[5];
	int init;
	int depth;
	int adresse=0;
	char convert[50];

	int linenum=0;
	int ln=0;
int flag=0;
%}

%union {
	int nb;
	char * str;
}

%token tMAIN tCONST tVAR tADD tSTAR tMOINS tDIV tEGAL tSEP tINT tACCO tACCF tNUM tPRTO tPRTF tPV tLINE tWHILE tTRUE tFALSE tIF tELSE tFOR tSUP tINF tINEGAL tEGALEGAL tADR

%left tADD tMOINS
%left tSTAR tDIV

%type <str> tINT tVAR tNUM 

%%
    Start: 	tINT tMAIN tPRTO tPRTF Body {printf("Main Fonction \n");};

    Body: 	tACCO Instrucs tACCF			{printf("Body \n");};
    Instrucs: Instruc tPV  Instrucs   		rule_instrus              
				|						
				|Phase Instrucs			;	
 	 
	If: tIF tPRTO Condition tPRTF
		 	{
				ajout_ligne_inter("LOAD","1",inttochare(flag));
				ajout_ligne_inter("JMPC","-1",inttochare(1));
	        	ln = (getmyindex());
				printf("now line is %d\n",ln );       	
			}		

 			Body
			{			
				printf("flag %d\n" ,flag);
				printf("now after body line is %d\n" ,(ln));
		  		changejumpline(ln-1, inttochare(ln));
				affiche_inter();	
			}

 			tELSE
			{
				linenum = (getmyindex());
				printf("line %d\n", linenum);
			}

			Body
			{
				printf("flag %d\n" ,flag);
				printf("lineeeeeeeeeee %d\n", linenum);

         		printf("now after body line is %d\n" ,(linenum));
	  			changejumpline(ln-1, inttochare(linenum));
				affiche_inter();
        	}
;
				
 												   
    While: 	tWHILE  tPRTO Condition  tPRTF Body  rule_while; 
	Forhead2:  Condition| ;
	Forhead1:  Affectation| ;  
	Forhead3:  Affectation| ;
	For: tFOR tPRTO Forhead1 tPV Forhead2 tPV Forhead3 tPRTF Body rule_for;
	Phase: While|If|For;
    Instruc:    Declaration					rule_instru
				|Affectation				
				|							rule_instru;
                						
    Declaration:tCONST tINT Affectation		rule_decl
				|tINT tVAR 					{ajout_tab($2,$1,0,0);}
				|tINT Affectation			{modifier(id,$1,1);}
				|tINT tSTAR tVAR			rule_pointer;


	Affectation:tVAR tEGAL Arithmetisation   
				{
					ajout_tab($1,type,1,0);
					//printf ("AFC r0 %d  ",value);
					ajout_ligne_inter("AFC","r0",inttochare(value));
					ecrire ("AFC r0 ", 0);
					sprintf (convert, "%d", value);
					ecrire (convert, 0);
					//printf ("Store %d r0 \n",trouve_adresse($1,15));
					ajout_ligne_inter("Store","r0",inttochare(trouve_adresse($1,15)));
				    ecrire ("\nStore ", 0);
					sprintf (convert, "%d", trouve_adresse($1,15));
					ecrire (convert, 0);                	
				    ecrire(" r0 \n",0);
					adresse++;
					strcpy(id,$1);
				};

				|Shortcut rule_affec;     

	Condition: 	tTRUE   
				{
					printf("change flag %d\n" ,flag);
					flag= 1;
				}

				|tFALSE		
				{
					printf("change flag %d\n" ,flag);
					flag=0;
				}
				|Compare	;		
	Compare:	Var_num Operations1 Var_num	{  
};           				
	

	Shortcut: tVAR tADD tADD
			  |tVAR tMOINS tMOINS
			  |tMOINS tMOINS tVAR
		  	  |tADD tADD tVAR
			  |tVAR Operations2 tEGAL Var_num;
	Arithmetisation: Var_num Operations2 Arithmetisation | Var_num   rule_arthme;
 	Var_num:tVAR 
			|tNUM   {value= atoi($1);}
			|tADR tVAR 
			|tSTAR tVAR;
	Operations1: tSUP | tINF | tINEGAL | tEGALEGAL;
	Operations2: tADD | tMOINS | tSTAR | tDIV;		

		
rule_instrus: {printf("Instructions \n");};
rule_instru:  {printf("Intruction \n");};
rule_decl :   {printf("Declaration \n");};
rule_affec:   {printf("Affectation \n");};
rule_arthme:  {printf("Arithmetisation \n");};
rule_while:   {printf("while \n");};
//rule_if:      {printf("if \n");};
rule_for:      {printf("for \n");};
rule_pointer:      {printf("Declaration of pointer \n");};


%%
int main(){
	yyparse();
	// prend tableau -> file
}
