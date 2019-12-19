set ns [new Simulator]

set traceFile [open 2.tr w]
$ns trace-all $traceFile
set namFile [open 2.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns traceFile namFile
	$ns flush-trace
	close $namFile
	close $traceFile
		exec awk -f 2.awk 2.tr &
		exec nam 2.nam &
	exit 0
}

$ns color 1 Blue
$ns color 2 Red

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]

$ns duplex-link $n0 $n2 2Mb 10ms DropTail
$ns duplex-link $n1 $n2 2Mb 10ms DropTail
$ns duplex-link $n2 $n3 900kb 10ms DropTail

$ns queue-limit $n0 $n2 10

set tcp0 [new Agent/TCP]
$ns attach-agent $n0 $tcp0

set sink0 [new Agent/TCPSink]
$ns attach-agent $n3 $sink0
$ns connect $tcp0 $sink0
$tcp0 set fid_ 1

set ftp [new Application/FTP]
$ftp attach-agent $tcp0
$ftp set type_ FTP

set tcp1 [new Agent/TCP]
$ns attach-agent $n1 $tcp1

set sink1 [new Agent/TCPSink]
$ns attach-agent $n3 $sink1
$ns connect $tcp1 $sink1
$tcp1 set fid_ 2

set telnet [new Application/Telnet]
$telnet attach-agent $tcp1
$telnet set type_ Telnet
$telnet set interval_ 0

$ns at 0.5 "$telnet start"
$ns at 0.6 "$ftp start"
$ns at 24.5 "$telnet stop"
$ns at 24.5 "$ftp stop"
$ns at 25.0 "finish"

$ns run
