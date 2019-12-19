BEGIN{
	 rec=0;
	 drop=0;
	}
	{
	 event=$1;
	 if(event=="r")
	 	rec++;
	 else if(event=="d")
	 	drop++;
	}
END{
	 printf("Packets dropped : %d\n",drop);
	 printf("Packets received : %d\n",rec);
	}
	 	
