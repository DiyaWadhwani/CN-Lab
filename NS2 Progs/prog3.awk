BEGIN{
	 TCPSent = 0;
	 TCPRecieved = 0;
	 TCPLost = 0;
	 UDPSent = 0;
	 UDPRecieved = 0;
	 UDPLost = 0;
	 totalSent = 0;
	 totalRecieved = 0;
	 totalLost = 0;
	}
	{
	 packetType = $5
	 event = $1
	 if(packetType == "tcp")
	 	{
	 	 if(event == "+")
	 	 	TCPSent++;
	 	 else if(event == "r")
	 	 	TCPRecieved++;
	 	 else if(event == "d")
	 	 	TCPLost++;
	 	}
	 else if(packetType == "cbr")
	 	{
	 	 if(event == "+")
	 	 	UDPSent++;
	 	 else if(event == "r")
	 	 	UDPRecieved++;
	 	 else if(event == "d")
	 	 	UDPLost++;
	 	}
	}
END{
	 totalSent = TCPSent+UDPSent;
	 totalLost = TCPLost+UDPLost;
	 printf("TCP Packets Sent : %d\n",TCPSent);
	 printf("TCP Packets Recieved : %d\n",TCPRecieved);
	 printf("TCP Packets Dropped : %d\n",TCPLost);
	 printf("UDP Packets Sent : %d\n",UDPSent);
	 printf("UDP Packets Recieved : %d\n",UDPRecieved);
	 printf("UDP Packets Dropped : %d\n",UDPLost);
	 printf("Total Sent : %d\n",totalSent);
	 printf("Total Lost : %d\n",totalLost);
	}
