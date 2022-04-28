%{
    #include<stdio.h>
    #include<string.h>
    typedef struct node {
        char ID[10], DataType[10];
        struct node * next;
    }node_t;
    node_t *head = NULL, *temp = NULL, *current = NULL;
%}

%%
int|float|char|double             {
                                            if(head==NULL) {
                                                head = (node_t*)malloc(sizeof(node_t));
                                                strcpy(head->DataType, yytext);
                                            }
                                            else {
                                                strcpy(temp->DataType, yytext);
                                            }
                                        }


[a-zA-Z]+[a-zA-Z0-9]*                   {
                                            if(head->next==NULL) {
                                                strcpy(head->ID, yytext);
                                                head->next = NULL;
                                            }
                                            else {
                                                strcpy(temp->ID, yytext);
                                                temp->next = NULL;
                                            }
                                        }

","                                     {
                                            if(temp==NULL) {
                                                temp=(struct node*)malloc(sizeof(struct node));
                                                head->next=temp;
                                                strcpy(temp->DataType, head->DataType);
                                            }
                                            else {
                                                char tempDT[10];
                                                strcpy(tempDT, temp->DataType);
                                                temp->next = (struct node*) malloc(sizeof(struct node));
                                                temp=(node_t*)temp->next;
                                                strcpy(temp->DataType, tempDT);
                                            }
                                        }

";"                                     {
                                            if(temp==NULL) {
                                                temp=(struct node*)malloc(sizeof(struct node));
                                                head->next=temp;
                                            }
                                            else {
                                                temp->next=(struct node*)malloc(sizeof(struct node));
                                                temp = (node_t*)temp->next;
                                            }
                                        }

"\n"                                    {
                                            node_t *current = head;
                                            while(current!=NULL) {
                                                printf("%s\t%s\n", current->ID, current->DataType);
                                                current = current->next;
                                            }
                                        }

%%

int main() {
    yylex();
}

int yywrap()
{
    printf("printing;");
    return 1;
}
