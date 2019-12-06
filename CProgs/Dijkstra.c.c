#include<stdio.h>
#include<stdlib.h>

int cost[20][20];

void dijkstra(int n, int source)
    {
        int count=0, min=0, nextnode=0, dist[20], pred[20], visited[20], i, j;
        for(i=0;i<n;i++)
            {
                dist[i]=cost[source][i];
                visited[i]=0;
                pred[i]=source;
            }
        dist[source]=0;
        visited[source]=1;
        count=1;

        while(count<n)
            {
                min=999;

                for(i=0;i<n;i++)
                    {
                        if(dist[i]<min && !visited[i])
                            {
                                min=dist[i];
                                nextnode=i;
                            }
                    }
                visited[nextnode]=1;
                for(i=0;i<n;i++)
                    {
                        if(!visited[i])
                            {
                                if(min+cost[nextnode][i]<dist[i])
                                    {
                                        dist[i]=min+cost[nextnode][i];
                                        pred[i]=nextnode;
                                    }
                            }
                    }
                count++;
            }
        for(i=0;i<n;i++)
            {
                if(i!=source)
                    {
                        printf("\nDistance of node %d from %d = %d\n",i,source,dist[i]);
                        printf("Path :\n%d",i);
                        j=i;
                        do
                            {
                                j=pred[j];
                                printf(" <-- %d",j);
                            }while(j!=source);
                    }
            }
    }

void main()
    {
        int n, source, i, j;
        printf("Enter no. of vertices:\n");
        scanf("%d",&n);
        printf("Enter cost matrix:\n");
        for(i=0;i<n;i++)
            for(j=0;j<n;j++)
                {
                    scanf("%d",&cost[i][j]);
                    if(cost[i][j]==0 && i!=j)
                        cost[i][j]=999;
                }
        printf("Enter starting node:\n");
        scanf("%d",&source);
        dijkstra(n,source);
    }
