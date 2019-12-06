#include<stdio.h>
#include<stdlib.h>
#include<string.h>

int checksum(int ch)
    {
        int sum=0, n, i;
        char data[100];
        printf("Enter data:\n");
        fflush(stdin);
        gets(data);
        if(strlen(data)%2==0)
            n=strlen(data)/2;
        else
            n=(strlen(data)+1)/2;
        for(i=0;i<n;i++)
            sum += (data[i*2]*256) + data[(i*2)+1];
        if(ch==1)
            {
                printf("Enter value of checksum recieved : ");
                scanf("%d",&n);
                sum+=n;
            }
        if(sum>=65536)
            sum=(sum/65536)+(sum%65536);
        sum=65535-sum;
        return (sum);
    }

void main()
    {
        int ch, cs;
        printf("\tCHECKSUM\t");
        while(1)
            {
                printf("\n\n1.Encode\t2.Decode\t3.Exit\nEnter option: ");
                scanf("%d",&ch);
                switch(ch)
                    {
                        case 1: cs=checksum(0);
                                printf("Checksum to be sent is : %d",cs);
                                break;
                        case 2: cs=checksum(1);
                                if(cs!=0)
                                    printf("Checksum : %d\nError detected !!",cs);
                                else
                                    printf("Checksum : %d\nNo Error detected !!",cs);
                                break;
                        case 3: exit (0);
                                break;
                        default: printf("Invalid choice !!");
                                break;
                    }
            }
    }
