#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "tab_sym.h"

ligne tab_sym[1000];

int indice = 0;

void recup_info (ligne *l){
	char id[10];
	char type[5];
	int init;
	int depth;

	if (scanf("%s",id) == 0) printf("failed id \n");
	if (scanf("%s",type) == 0) printf("failed type \n");
	if (scanf("%d",&init) == 0) printf("failed init \n");
	if (scanf("%d",&depth) == 0) printf("failed depth \n");

	strcpy(l->id , id);
	strcpy(l->type, type);
	l->init = init;
	l->depth= depth;
}

void ajout_tab (char *id, char *type, int  init, int depth){
	strcpy(tab_sym[indice].id , id);
	strcpy(tab_sym[indice].type , type);
	tab_sym[indice].init = init;
	tab_sym[indice].depth = depth;
	
	indice += 1;
}

int trouve_adresse(char * name, int adresse){
	int i ;
	for(i=0; i< indice;i++){
	   if(strcmp(tab_sym[i].id,name)==0){	
			return i;
		}	
	}      
	return adresse;
}


void affiche_tab () {
	int i;
	for (i = 0; i <indice; i++){
		printf("line %d  ",i);
		affiche_ligne(tab_sym[i]);
	}
}

void affiche_ligne(ligne l){
	printf ("id: %s, type: %s, init: %s, depth: %d \n",l.id, l.type, l.init? "true": "false", l.depth); 
}

void modifier(char * id, char* valeur, int type){
	//type 1    id  0   init 2 depth 3  adresse 4 

	int i;
	switch (type){
		case 0: break;
		case 1:
			for(i=0; i< indice;i++){
				if(strcmp(tab_sym[i].id,id)==0){	
					strcpy(tab_sym[i].type , valeur);
				}	
			}
			break;
		case 2: break;
		case 3: break;

		case 4: break;
		default: break;
	}
}




void ecrire(char * contenu, int clean){
		FILE *f;

 	if (clean == 1){
		f = fopen("assembleur.txt","w");
	}
	else{
		f = fopen("assembleur.txt","a+");
	}
	
	if (f == NULL)
	{		
		printf("Error opening file!\n");
		exit(1);
	}

	if (contenu != NULL){
		fprintf(f, "%s", contenu);
	}

	fclose(f);
}


