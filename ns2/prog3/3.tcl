set ns [new Simulator]

set traceFile [open 3.tr w]
$ns trace-all $traceFile
set namFile [open 3.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace
	close $namFile
	close $traceFile
		exec awk -f 3.awk 3.tr &
		exec nam 3.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$n0 color red
$n1 color blue
$n2 color green
$n3 color orange

$ns color 1 blue

#$n0 label TCP
#$n1 label UDP
#$n3 label NULL-TCPSINK

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 900kb 10ms DropTail

$ns queue-limit $n0 $n2 10
 
set tcp [new Agent/TCP]
$ns attach-agent $n0 $tcp

set sink [new Agent/TCPSink]
$ns attach-agent $n3 $sink
$ns connect $tcp $sink
$tcp set fid_ 1

set udp [new Agent/UDP]
$ns attach-agent $n1 $udp

set null [new Agent/Null]
$ns attach-agent $n3 $null
$ns connect $udp $null

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSzie_ 500
$cbr set interval_ 0.005

$ns at 0.5 "$ftp start"
$ns at 1.0 "$cbr start"
$ns at 9.5 "$ftp stop"
$ns at 9.0 "$cbr stop"
$ns at 10.0 "finish"

$ns run
