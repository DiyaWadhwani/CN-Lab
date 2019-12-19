BEGIN {
	 stcp=0;
	 rtcp=0;
	 dtcp=0;
	 sudp=0;
	 rudp=0;
	 dudp=0;
	}
	{
	 event=$1;
	 pkttype=$5;
	 if (pkttype=="tcp")
	 	{
	 	 if (event=="r")
	 	 	rtcp++;
	 	 if (event=="+")
	 	 	stcp++;
	 	 if (event=="d")
	 	 	dtcp++;
	 	}
	 if(pkttype=="cbr")
	 	{
	 	 if (event=="r")
	 	 	rudp++;
	 	 if(event=="+")
	 	 	sudp++;
	 	 if (event=="d")
	 	 	dudp++;
	 	}
	}
END {
	 printf("TCP:\nRecieved:%d\tSent:%d\tDropped:%d\n",rtcp,stcp,dtcp);
	 printf("UDP:\nRecieved:%d\tSent:%d\tDropped:%d\n",rudp,sudp,dudp);
	}
	 
	 	 
