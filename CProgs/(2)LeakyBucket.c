#include<stdio.h>
#include<stdlib.h>

#define MIN(x,y)(x>y)?y:x

void main()
    {
        int rate=10,drop=0,cap=100,inp[50]={0},x,count=0,nsec,i=0;
        printf("Bucket size : %d\n",cap);
        printf("Output rate : %d\n",rate);
        srand(time(0));
        do
            {
                inp[i]=rand()%200;
                printf("Number of packets coming at %d second : %d\n",i+1,inp[i]);
                i++;
            } while(i<5);
        nsec=i;
        printf("Summary :\n");
        printf("Second\tRecieved\tSent\tDropped\tRemaining\n");
        for(i=0; count||i<nsec; i++)
            {
                printf("%d \t%d \t%d \t",i+1,inp[i],(MIN(inp[i]+count,rate)));
                x=inp[i]+count-rate;
                if(x>0)
                    {
                        if(x>cap)
                            {
                                count=cap;
                                drop=x-cap;
                            }
                        else
                            {
                                count=x;
                                drop=0;
                            }
                    }
                else
                    {
                        drop=0;
                        count=0;
                    }
                printf("%d \t%d\n",drop,count);
            }
        return 0;
    }
