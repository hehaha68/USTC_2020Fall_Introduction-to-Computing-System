/*************************************************************
** School:  School Of Data Science, USTC
** auth:    PB19010450 ∫Õ”æ“„
** date:    2021/1/8 16:37:16
** desc:    ICS Lab06--Implement lab02 to lab05 in C language 
**************************************************************/

#include<stdio.h>
#include<stdlib.h>
#include<conio.h>

/*Structure of LinkList*/
typedef	struct LinkList{
	int				data; 
	struct LinkList	*next;
}LinkList; 

/*********	Function declaration	*********/
LinkList* CreateList();//Create a list for lab03
void PrintList(LinkList *L);//Print the list we created
void PrintRocks(int a,int b,int c);//Print the status of game for lab04
void Calculate(int *n,int ROCKS,int *flag);//Calculate the changes of rocks for lab04
void Interrupt(char *c);//Interrupt the loop for lab05
int lab02(int a,int b);//Greatest Common Divisor
void lab03(LinkList *L);//The Linked-List Sort
void lab04();//The Game of Nim
void lab05();//Interrupt a Running Program
/********************************************/

LinkList* CreateList(){
	int n = 1,a;
	LinkList *L = (LinkList*)malloc(sizeof(LinkList));;
	LinkList *p,*rear = L;
	printf("\nPlease enter the data,end by pressing 2020.\n");
	printf("\nPlease enter the data of the node %d: ",n++);
	scanf("%d",&a);
	while(a != 2020){
		p = (LinkList*)malloc(sizeof(LinkList));
		p->data = a;
		p->next = NULL;
		rear->next = p;
		rear = rear->next;
		printf("\nPlease enter the data of the node %d: ",n++);
		scanf("%d",&a);
	}
	if(rear != NULL)	rear->next = NULL;
	return L;
}

void PrintList(LinkList *L){
	LinkList *p = L->next;
	while(p){
		printf(" %d ",p->data);
		p = p->next;
	}
}

void PrintRocks(int a,int b,int c){
	printf("\nROW A:");
	for(;a > 0;a--)	printf("o");
	printf("\nROW B:");
	for(;b > 0;b--)	printf("o");
	printf("\nROW C:");
	for(;c > 0;c--)	printf("o");	
}

void Calculate(int *n,int ROCKS,int *flag){
	if(*n < ROCKS || ROCKS < 0){
		*flag = 1;
		printf("\nInvalid move. Try again.");
		return;
	}
	*n -= ROCKS;
}

void Interrupt(char *c){
	if(kbhit()){
		c = getchar();
		if(c >= '0' && c <= '9')
		printf("\n%c is a decimal digit.\n",c);
		else printf("\n%c is not a decimal digit.\n",c);
	}
}

int lab02(int a,int b){
 	if(a%b == 0)	return b;
    else	return lab02(b,a%b);
}
 
void lab03(LinkList *L){
    int i = 0,j = 0,num = 0,temp;
    LinkList *p,*q1,*q2;
    if (!L->next)	return;
    for(p = L->next;p;p = p->next)	num++;
    for (i = 0; i < num - 1; i++) {
        p = L->next;
        for (j = 0; j < num - i - 1; j++) {
            q1 = p;
            q2 = p->next;
            if (q1->data > q2->data) {
                temp = p->data;
                q1->data = q2->data;
                q2->data = temp;
            }
            p = p->next;
        }
    }
}
 
void lab04(){
	int i = 1,flag = 0;
	int a = 3,b = 5,c = 8,ROCKS;
	char ROW;
	printf("\n-------The NIM Game-------\n");
	while(1){
		if(!a && !b && !c)	break; 
		PrintRocks(a,b,c); 
		if(i%2)
			printf("\nPlayer 1, choose a row and number of rocks: ");
		else
			printf("\nPlayer 2, choose a row and number of rocks: ");
			getchar();
		scanf("%c",&ROW);
		scanf("%d",&ROCKS);
		if(ROW != 'A' && ROW != 'B' && ROW != 'C'){
			printf("\nInvalid move. Try again."); 
			continue;
		}
		if(ROW == 'A')	Calculate(&a,ROCKS,&flag);
		if(ROW == 'B')	Calculate(&b,ROCKS,&flag);
		if(ROW == 'C')	Calculate(&c,ROCKS,&flag);
		if(flag)	continue;
		flag = 0;
		i++;
	}
	if(i%2)	printf("\n\nPlayer 2 Wins.\n");
	else	printf("\n\nPlayer 1 Wins.\n");
	printf("\n-------Game Over-------\n"); 
}
 
void lab05(){
	char c;
	int a;
	printf("\nPlease stop the loop by pressing P\n");
	while(1){
		printf("ICS2020	");
		for(a = 5E8;a > 0;a--);
		if(kbhit()){
			getchar();
			c = getchar();
			if(c >= '0' && c <= '9') printf("%c is a decimal digit.\n",c);
			else if(c == 'p'){
				printf("\n °æEnd°ø\n");
				return;
			}
			else printf("%c is not a decimal digit.\n",c);
	    }
	}
}
 
int main(){
 	int flag = 1,menu = 0,a,b;
 	LinkList *L;
 	while(flag == 1){
 		printf("\n----------ICS LAB----------\n");
 		printf("\n°æ2°ølab02	°æ3°ølab03");
 		printf("\n°æ4°ølab04	°æ5°ølab05");
 		printf("\n\nPlease choose the number of lab:");
 		scanf("%d",&menu);
 		switch(menu){
 			case 2:{
 				printf("Please enter two integers, separated by a space:");
 				scanf("%d %d",&a,&b);
 				printf("The GCD of %d and %d is %d.\n",a,b,lab02(a,b));				
				break;
			 }
 			case 3:{
 				L = CreateList();
 				printf("\nThe initial linklist£∫\n");
 				PrintList(L);
 				lab03(L);
 				printf("\nAfter sorting£∫\n");
 				PrintList(L);
				break;
			 }
			case 4:{
				lab04();
				break;
			}
			case 5:{
				lab05(); 
				break;
			}
			default:{
				printf("\n°æWrong input! Please check your input and try again!°ø\n");
				break;
			} 
		 }
		printf("\nPlease continue by pressing 1:");
 		scanf("%d",&flag);		
	 }
	printf("\nProgram termination!\n");
	return 0; 	  
 }
