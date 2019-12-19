BEGIN {
	 rtcp=0;
	 dtcp=0;
	 rudp=0;
	 dudp=0;
	}
	{
	 event=$1;
	 pkttype=$5;
	 if(pkttype=="tcp")
	 	{
	 	 if(event=="r")
	 	 	rtcp++;
	 	 if(event=="d")
	 	 	dtcp++;
	 	}
	 if(pkttype=="cbr")
	 	{
	 	 if(event=="r")
	 	 	rudp++;
	 	if(event=="d")
	 		dudp++;
	 	}
	}
	
END {
	 printf("\nTCP\nDropped:%d\tRecieved:%d\n",dtcp,rtcp);
	 printf("UDP\nDropped:%d\tRecieved:%d\n",dudp,rudp);
	}

