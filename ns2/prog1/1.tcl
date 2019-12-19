set ns [new Simulator]

set traceFile [open 1.tr w]
$ns trace-all $traceFile
set namFile [open 1.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace
	close $namFile
	close $traceFile
		exec awk -f prog1.awk 1.tr &
		exec nam 1.nam &
	exit 0
}

set n0 [$ns node]
set n1 [$ns node]
set n2 [$ns node]

$ns duplex-link $n0 $n1 0.5Mb 20ms DropTail
$ns duplex-link $n1 $n2 0.5Mb 20ms DropTail
$ns queue-limit $n0 $n1 10
$ns queue-limit $n1 $n2 10

$ns color 1 orange

$n0 color red
$n0 shape hexagon
$n1 color green
$n2 color blue
$n2 shape box 

set udp [new Agent/UDP]
$ns attach-agent $n0 $udp
$udp set fid_ 1

set null [new Agent/Null]
$ns attach-agent $n2 $null
$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set packetSize_ 512
$cbr set interval_ 0.005

$ns at 0.5 "$cbr start"
$ns at 2.0 "$cbr stop"
$ns at 2.0 "finish"

$ns run

