#include<string.h>
#include<stdlib.h>
#define idToken 1
#define numToken 2
#define intType 1
#define realType 2
#define TOKENMAX 100

typedef struct entryRec{
char *name;
int type;
int valueType;
float realVal;
int intVal;}symTableEntry;

symTableEntry symTable[TOKENMAX];

int numOfTokens=0;
int searchSymTable(char *n)
{
int found=0;
int i;
for (i=0;i<numOfTokens && !found;i++)
if (strcmp(n,symTable[i].name)==0)
	found=1;

if (found)
	return i-1;
else
	return -1;
}

void setIntVal(int i,int iv)
{symTable[i].intVal=iv;
return;
}

void setRealVal(int i,float rv)
{symTable[i].realVal=rv;
return;
}

int addToSymTable(char *n,int t)
{
int i=searchSymTable(n);

if(i==-1){
i=numOfTokens;
symTable[i].name=malloc(strlen(n)+1);
strcpy(symTable[i].name,n);
symTable[i].type=t;
numOfTokens++;}
return i;
}

void setValueType(int i,int vt)
{
symTable[i].valueType=vt;
return;
}
void printSymTable()
{
int i;
printf("\n\t____________________Symbol Table____________________\n");
printf("\tToken Name\tToken type\tValue Type\tValue\t\t\n");
for(i=0;i<numOfTokens;i++)
{printf("\t%s\t",symTable[i].name);
if(symTable[i].type ==idToken)
printf("\tidentifier\t");

else {
printf("\tnum\t");
if(symTable[i].valueType==intType)
printf("\tinteger\t\t%d\t",symTable[i].intVal);
 else if(symTable[i].valueType==realType)
printf("\treal\t\t%f\t",symTable[i].realVal);}
printf("\n");}
return;
}
