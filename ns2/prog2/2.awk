BEGIN {
	 telpkts=0;
	 telsize=0;
	 teltot=0;
	 ftppkts=0;
	 ftpsize=0;
	 ftptot=0;
	}
	{
	 event=$1;
	 pkttype=$5;
	 pktsize=$6;
	 fromnode=$9;
	 tonode=$10;
	 if(event=="r" && pkttype=="tcp" && fromnode="0.0" && tonode=="3.0")
	 	{
	 	 ftppkts++;
	 	 ftpsize=pktsize;
	 	}
	 if(event=="r" && pkttype=="tcp" && fromnode="1.0" && tonode=="3.1")
	 	{
	 	 telpkts++;
	 	 telsize=pktsize;
	 	}
	 }
END {
	 teltot=telpkts*telsize*8;
	 ftptot=ftppkts*ftpsize*8;
	 printf("Throughput:\n FTP : %d\t TELNET : %d\n",ftptot/24,teltot/24);
	}
	
