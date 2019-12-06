#include<stdio.h>
#include<stdlib.h>
#define hmax 2
#define lmax 3
int hprior[100]={0},lprior[100]={0},h=-1,l=-1;
void insert(int val, int prior){
    if(prior==1){
        if(h<hmax){
            hprior[++h]=val;
            printf("Packet added to higher priority queue\n");
        }
        else
            printf("Higher priority queue full, packet dropped\n");
    }
    else if(prior==2){
        if(l<lmax){
            lprior[++l]=val;
            printf("Packet added to lower priority queue\n");
        }
        else
            printf("Lower priority queue full, packet dropped\n");
    }
    else
        printf("Invalid priority number\n");
}

void process()
    {
        printf("Processing higher priority queue\n");
        int i=0;
        if(h==-1)
        printf("Queue empty\n");
        else
            {
                while(i<=h)
                    {
                        printf("%d ",hprior[i]);
                        hprior[i++]=0;
                    }
                printf("\n");
                h=-1;
            }
        i=0;
        printf("Processing lower priority queue\n");
        if(l==-1)
            printf("Queue empty\n");
        else
            {
                while(i<=l)
                    {
                        printf("%d ",lprior[i]);
                        lprior[i++]=0;
                    }
                printf("\n");
                l=-1;
            }
    }

void main()
    {
        printf("1.Add to queue, 2.Process queues, 3.Exit\n");
        int ch,val,prior;
        while(1)
            {
                printf("Enter choice: ");
                scanf("%d",&ch);
                switch(ch)
                    {
                        case 1: printf("Enter packet no.: ");
                                scanf("%d",&val);
                                printf("Enter priority no: ");
                                scanf("%d",&prior);
                                insert(val,prior);
                                break;

                        case 2:process();
                                break;

                        case 3:exit(0);

                        default:printf("Invalid choice\n");
                    }
            }
    }
