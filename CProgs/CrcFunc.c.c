#include<stdio.h>
#include<string.h>
#include<conio.h>

void main()
    {
        int dsize, gsize, i, j, k, len;
        char dataword[100], generator[50], crc[100];

        printf("Enter size of generator :\n");
        scanf("%d",&gsize);
    start :
        printf("Enter size of dataword :\n");
        scanf("%d",&dsize);

        if(dsize<gsize)
            {
                printf("Enter CORRECT size of dataword :\n");
                goto start;
            }

        printf("Enter dataword :\n");
        scanf("%s",dataword);

        //copy dataword to crrc for checking for syndrome later
        strcpy(crc,dataword);

        printf("Enter generator :\n");
        scanf("%s",generator);

        for(i=0;i<gsize-1;i++)
            {
                dataword[dsize+i]='0';
            }
        dataword[dsize+gsize-1]='\0';

        printf("\nDataword : %s",dataword);
        printf("\nGenerator : %s",generator);

        do
            {
                for(i=0;i<gsize;i++)
                    {
                        if(dataword[i]==generator[i])
                            dataword[i]='0';
                        else
                            dataword[i]='1';
                    }

                k=0;
                for(i=0;i<dsize+gsize-1;i++)
                    {
                        if(dataword[i]=='0')
                            k++;
                    }
                if(k==(dsize+gsize-1))
                    break;

                while(dataword[0]!='1')
                    {
                        for(i=0;i<dsize+gsize-1;i++)
                            dataword[i]=dataword[i+1];
                        dsize--;
                    }
                len=dsize+gsize-1;

            }while(len>gsize-1);

        dataword[len]='\0';

        printf("\nRemainder is : ");
        for(i=0;i<=len;i++)
            {
                printf("%c",dataword[i]);
            }

        //to check for errors, new dataword ?
            //if dataword changes, syndrome will not be=0
        printf("\n\nDo you want to change dataword? [y-->0/n-->1] : ");
        scanf("%d",&j);
        if(j==0)
            {
                crc[0]='\0';
                printf("Enter new dataword:\n");
                scanf("%s",crc);
            }

        //set length
        len=strlen(dataword);
        dsize=strlen(crc);

        //add 0's to the remainder to make dsize of crc =gsize-1
        if(len!=gsize-1)
            {
                for(i=0;i<gsize-1-len;i++)
                    crc[dsize+i]='0';
            }
        crc[dsize+i]='\0';

        //adding remainder to end of crc to calculate syndrome
        len=strlen(dataword);
        dsize=strlen(crc);

        for(i=0;i<len;i++)
            crc[dsize+i]=dataword[i];
        crc[dsize+i]='\0';

        //code to calculate syndrome is same as to find remainder (do while loop)
            //copy crc to dataword
        dataword[0]='\0';
        strcpy(dataword,crc);

        do
            {
                for(i=0;i<gsize;i++)
                    {
                        if(dataword[i]==generator[i])
                            dataword[i]='0';
                        else
                            dataword[i]='1';
                    }

                k=0;
                for(i=0;i<gsize+dsize-1;i++)
                    {
                        if(dataword[i]=='0')
                            k++;
                    }
                if(k==(dsize+gsize-1))
                    break;

                while(dataword[0]!='1')
                    {
                        for(i=0;i<dsize+gsize-1;i++)
                            dataword[i]=dataword[i+1];
                        dsize--;
                    }
                len=dsize+gsize-1;

            }while(len>gsize-1);

        dataword[len]='\0';

        printf("\nSyndrome is : %s",dataword);
    }
