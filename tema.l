/*** Dumitru Elena-Bianca 331CC ***/

/*** Variable declaration; keeps count of values obtained from parsing ***/
%{
	int vertexesNumber = 0;
	int facesNumber = 0;
	int isTexture = 0;
	int notFinished = 0;
	char foundTexture[100];
	int firstObject = 1;
%}

/*** 
State declaration;
If we have found the marker indicating that we should be looking for
the object name, vertexes, faces or texture we go to a specific state.
The states are marked x because they don't need to match on other rules,
only the ones within the function
***/

%x FINDOBJECT
%x FINDVERTEXES
%x FINDFACES
%x FINDTEXTURE

%%

<INITIAL>"Object"	{if (firstObject == 0 && notFinished > 0) {
						if (isTexture == 0)
							memcpy(foundTexture, "no texture", sizeof(foundTexture));
						printf(" vertexes: %d, faces: %d, %s\n", vertexesNumber, facesNumber, foundTexture);
					 }
					
					 firstObject = 0;

					 if (notFinished > 0) {
						 for (int i = 0; i < notFinished; i++)
						 	printf("\t");
					 }

					 printf("%s", yytext);
					 notFinished++;
					 vertexesNumber = 0;
					 facesNumber = 0;
					 isTexture = 0;
					 BEGIN(FINDOBJECT);}

<FINDOBJECT>[\n]  	{yyless(yyleng - 1); ECHO; printf(":"); BEGIN(INITIAL);}

<INITIAL>"vertexes"	{BEGIN(FINDVERTEXES);}

<FINDVERTEXES>"(" 	{vertexesNumber++;}

<FINDVERTEXES>. 	{;}

<FINDVERTEXES>[\n]  {BEGIN(INITIAL);}

<INITIAL>"faces"	{BEGIN(FINDFACES);}

<FINDFACES>";" 		{facesNumber++;}

<FINDFACES>. 		{;}

<FINDFACES>[\n]  	{BEGIN(INITIAL);}

<INITIAL>"texture"	{isTexture = 1;}

<INITIAL>"img"		{if (isTexture == 1)
						BEGIN(FINDTEXTURE);}
					
<INITIAL>"}"		{notFinished--;
					if (notFinished == 0) 
						printf(" vertexes: %d, faces: %d, %s\n", vertexesNumber, facesNumber, foundTexture);}					

<FINDTEXTURE>.		{yymore();}

<FINDTEXTURE>[\n]  	{yyless(yyleng - 1);
					 memcpy(foundTexture, "texture:", sizeof(foundTexture));
					 strcat(foundTexture, yytext);
					 BEGIN(INITIAL);}

.|\n	    {;}

%%

int yywrap(){}
int main(int argc, char *argv[]){

	/* yywrap() - Indicates end of file */
	/* yyin     - Takes file pointer containing input */
	/* yylex()  - Main flex function */
	/* yytext   - Represents the text in the buffer */

	// Read input file
	FILE *fp;
	char* filename = (char*) malloc(sizeof(char) * strlen(argv[1]));
	strcpy(filename, argv[1]);
	fp = fopen(filename, "r");
	yyin = fp;

	// Run flex function
	yylex();

	// Deallocate memory
	free(filename);

	return 0;
}
