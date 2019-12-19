set ns [new Simulator]

set traceFile [open 4.tr w]
$ns trace-all $traceFile
set namFile [open 4.nam w]
$ns namtrace-all $namFile

proc finish {} {
	global ns namFile traceFile
	$ns flush-trace
	close $namFile
	close $traceFile
		exec awk -f 4.awk 4.tr &
		exec nam 4.nam &
	exit 0
}

for {set i 0} {$i<7} {incr i} {
	set n($i) [$ns node]
}

for {set i 1} {$i<4} {incr i} {
	$ns duplex-link $n($i) $n(0) 1Mb 10ms DropTail
}
$ns duplex-link $n(4) $n(0) 1Mb 100ms DropTail
$ns duplex-link $n(5) $n(0) 1Mb 100ms DropTail
$ns duplex-link $n(6) $n(0) 1Mb 100ms DropTail

Agent/Ping instproc recv {from rtt} {
	$self instvar node_
	puts "node [$node_ id] recieved ping answer from $from with round-trip-time $rtt ms"
}

for {set i 1} {$i<7} {incr i} {
	set p($i) [new Agent/Ping]
	$ns attach-agent $n($i) $p($i)
}

for {set i 1} {$i<6} {incr i} {
	$ns queue-limit $n(0) $n($i) 2
}
$ns queue-limit $n(0) $n(6) 1

$ns connect $p(1) $p(4)
$ns connect $p(2) $p(5)
$ns connect $p(3) $p(6)

$ns at 0.1 "$p(1) send"
$ns at 0.3 "$p(2) send"
$ns at 0.5 "$p(3) send"
$ns at 1.0 "$p(4) send"
$ns at 1.3 "$p(5) send"
$ns at 1.5 "$p(6) send"
#$ns at 1.1 "$p(1) send"
#$ns at 1.5 "$p(2) send"
#$ns at 1.5 "$p(3) send"
#$ns at 1.5 "$p(4) send"
#$ns at 2.0 "$p(5) send"
#$ns at 2.0 "$p(6) send"
$ns at 2.0 "finish"

$ns run
