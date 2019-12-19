BEGIN {
	 ftppkts=0;
	 ftpsize=0;
	 cbrpkts=0;
	 cbrsize=0;
	}
	{
	 event=$1;
	 pkttype=$5;
	 pktsize=$6;
	 if(event=="r" && pkttype=="tcp")
	 	{
	 	 ftppkts++;
	 	 ftpsize=pktsize;
	 	}
	 if(event=="r" && pkttype=="cbr")
	 	{
	 	 cbrpkts++;
	 	 cbrsize=pktsize;
	 	}
	}
END {
	 ftptot=ftppkts*ftpsize;
	 cbrtot=cbrpkts*cbrsize;
	 printf("Throughput of FTP:%d\n",ftptot/123.0);
	 printf("Throughput of CBR:%d\n",cbrtot/124.4);	 
	}
