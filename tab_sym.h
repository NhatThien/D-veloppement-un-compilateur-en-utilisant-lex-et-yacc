typedef struct ligne{  	
	char id[10];
  	char type[5];
	int init;
	int depth;
} ligne;


void recup_info (ligne * l);
void ajout_tab (char *id, char *type, int init, int depth);
void modifier(char * id, char* valeur, int type);
void affiche_tab ();
void affiche_ligne (ligne l);
