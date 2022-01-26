#include<stdio.h>
#include<stdlib.h>
#include<conio.h>
#include<windows.h> 
typedef struct node{
	long value;
	node *next;
}node;
void lab02(){
	long a,b,r;
	long A,B;
	long cd;
	printf("please input two integers\n");
	printf("first number:");
	scanf("%ld",&A);
	printf("second number:");
	scanf("%ld",&B);
	
	a=A;b=B;
	if(a>=b){
		r=a-b*(a/b);
		while(r){
			a=b;b=r;
			r=a-b*(a/b);
		}
		cd=b;
	}
	else {
		r=b-a*(b/a);
		while(r){
			b=a;a=r;
			r=b-a*(b/a);
		}
		cd=a;
	}
	printf("The greatest common divisor of %ld and %d is %ld\n",A,B,cd);
}

void lab03(){
	node* head;
	node* p;
	int i;
	int n=0;
	long value;
	do{
	printf("input how many nodes you want to create the linklist\n");
	scanf("%d",&n);
	if(n<=0)
	printf("invalid input!\n");
    }while(n<=0);
	head=(node*)malloc(sizeof(node));
	if(!head) exit(-1);
	head->next=NULL;
	printf("input value\n");
	for(i=0;i<n;i++){
		p=(node*)malloc(sizeof(node));
		if(!p) exit(-1);
		scanf("%ld",&value);
		p->next=head->next;
		head->next=p;
		p->value=value;
	}
	/*printf("The linklist now is:\n");
	for(p=head->next;p;p=p->next)
	printf("%ld\n",p->value);*/
	node* New;
	node* pmax;
	node* q;
	New=(node*)malloc(sizeof(node));
	New->next=NULL;
	long max;
	for(i=0;i<n;i++){
		max=-65534;
		for(p=head->next;p;p=p->next){
			if(p->value>max){
				max=p->value;
				pmax=p;
			}
		}
		pmax->value=-65535;
		q=(node*)malloc(sizeof(node));
		q->value=max;
		q->next=New->next;
		New->next=q;
	}
	printf("The linklist after sorted is:\n");
	for(q=New->next;q;q=q->next)
	printf("%ld\n",q->value);
}

void Print(int a,int b, int c){
	int k;
	printf("ROWA:");
	for(k=0;k<a;k++)
	putchar('o');
	printf("\n");
	printf("ROWB:");
	for(k=0;k<b;k++)
	putchar('o');
	printf("\n");
	printf("ROWC:");
	for(k=0;k<c;k++)
	putchar('o');
	printf("\n");
}

void lab04(){
	int i=1;
    int k;
	int a,b,c;
	char in[100];
	char row;
	int num;
	a=3;b=5;c=8;
	do{
		if(a==0&&b==0&c==0){
			if(i>0)printf("Player1 Wins.\n");
			else printf("Player2 Wins.\n");
			//printf("Press Enter to Continue\n");
			break;
		}
	Print(a,b,c);
	if(i>0)
	printf("Player1,choose a row and number of rocks:");
    else
    printf("Player2,choose a row and number of rocks:");
	in[0]=getch();putchar(in[0]);
	in[1]=getch();putchar(in[1]);
	printf("\n");
	row=in[0];
	num=in[1]-'0';
	if(row=='A'){
		if(a<num||num<=0){
			printf("invalid move ,try again\n");
			continue;
		}
		
		else {
			a=a-num;
			i=-i;
			continue;
		}
	}
	else if(row=='B'){
		if(b<num||num<=0){
			printf("invalid move ,try again\n");
			continue;
		}
		else {
			b=b-num;
			i=-i;
			continue;
		}
	}
	else if(row=='C'){
		if(c<num||num<=0){
		printf("invalid move ,try again\n");
		continue;
	 }
	 else {
	 c=c-num;
	 i=-i;
	 continue;
    }
   }
    else {
	printf("invalid move ,try again\n");
	continue;
    }
 }while(1);
}

void lab05(){
	int i;
	int key;
	printf("\nPress ESC to Exit\n\n");
	while(1){
	printf(" ICS 2020 ");
    Sleep(200);
	if(kbhit()){
		printf("\n");
		key=getch();
		if(key==27) break; 
		putchar(key);
		key=key-'0';
		if(key>9||key<0)
		printf(" is not a demical digit\n");
		else printf(" is a demical digit\n");
	}
 }
}

int main(){
	char ch;
	printf("which function to run?\n");
	printf("2 for lab02\n3 for lab03\n4 for lab04\n5 for lab05\nPress ESC to Exit\n");
	while(1){
	//scanf("%c",&ch);
	ch=getch();
	switch(ch){
		case '2':
			lab02();
			break;
		case '3':
			lab03();
			break;
		case '4':
			lab04();
			break;
		case '5':
			lab05();
			break;
		case 27:
		    return 0;
		default:
			printf("invalid input!\n");
	}
	//getchar();
	printf("which function to run?\n");
  }
	return -1;
}
