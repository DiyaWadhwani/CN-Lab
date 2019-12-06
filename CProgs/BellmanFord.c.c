#include<stdio.h>
#include<stdlib.h>

int s;

int parent(int v, int p[20])
    {
        if(p[v]==s)
            return s;
        printf("%d <-- ",p[v]);
        return (parent(p[v],p));
    }
int BellFord(int g[20][20], int V, int e, int edge[20][2])
    {
        int i,k,u,v,dist[20],p[20],flag=1;
        printf("Enter source vertex number:\n");
        scanf("%d",&s);
        for(i=0;i<V;i++)
            {
                dist[i]=1000;
                p[i]=-1;
            }
        dist[s]=0;
        for(i=0;i<V-1;i++)
            for(k=0;k<e;k++)
            {
                u=edge[k][0];
                v=edge[k][1];
                if(dist[u]+g[u][v]<dist[v])
                    {
                        dist[v]=dist[u]+g[u][v];
                        p[v]=u;
                    }
            }
        for(k=0;k<e;k++)
            {
                u=edge[k][0];
                v=edge[k][1];
                if(dist[u]+g[u][v]<dist[v])
                    flag=0;
            }
        if(flag)
            {
                printf("From source %d to : \n",s);
                for(i=0;i<V;i++)
                    {
                        if(i!=s)
                            {
                                printf("vertex %d : cost = %d\n",i,dist[i]);
                                printf("Path : %d <-- ",i);
                                printf("%d\n",parent(i,p));
                            }
                    }
            }
        return flag;
    }

void main()
    {
        int i,j,k=0,v,g[20][20],edge[20][2];
        printf("Enter no. of vertices:\n");
        scanf("%d",&v);
        printf("Enter graph in matrix format:\n");
        for(i=0;i<v;i++)
            for(j=0;j<v;j++)
            {
                scanf("%d",&g[i][j]);
                if(g[i][j]!=0)
                    {
                        edge[k][0]=i;
                        edge[k++][1]=j;
                    }
            }
        if(BellFord(g,v,k,edge))
            printf("\nNo negative weighted cycle\n");
        else
            printf("\nWeighted cycle exists\n");
    }
