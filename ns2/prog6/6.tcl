set ns [new Simulator]

set error_rate 0.00

set traceFile [open 6.tr w]
$ns trace-all $traceFile
set namFile [open 6.nam w]
$ns namtrace-all $namFile

proc finish {} {
	 global ns namFile traceFile
	 $ns flush-trace
	 close $namFile
	 close $traceFile
	 	exec awk -f 6.awk 6.tr &
	 	exec nam 6.nam &
	 exit 0
	}

for {set i 0} {$i<6} {incr i} {
	 set n($i) [$ns node]
	}

$ns color 1 purple
$ns color 2 orange

$ns duplex-link $n(0) $n(2) 2Mb 10ms DropTail
$ns duplex-link $n(1) $n(2) 2Mb 10ms DropTail
$ns simplex-link $n(2) $n(3) 0.3Mb 100ms DropTail
$ns simplex-link $n(3) $n(2) 0.3Mb 100ms DropTail

set lan [$ns newLan "$n(3) $n(4) $n(5)" 0.5Mb 40ms LL Queue/DropTail MAC/802_3 Channel]

$ns duplex-link-op $n(0) $n(2) orient right-down
$ns duplex-link-op $n(1) $n(2) orient right-up
$ns simplex-link-op $n(2) $n(3) orient right

$ns queue-limit $n(0) $n(2) 20
#$ns simplex-link-op $n(3) $n(2) queuePos 0.5

set lm [new ErrorModel]
$lm ranvar [new RandomVariable/Uniform]
$lm drop-target [new Agent/Null]
$lm set rate_ $error_rate
$ns lossmodel $lm $n(2) $n(3)

set tcp [new Agent/TCP/Newreno]
$ns attach-agent $n(0) $tcp
$tcp set fid_ 1
$tcp set window_ 8000
$tcp set packetSize_ 552

set sink [new Agent/TCPSink/DelAck]
$ns attach-agent $n(4) $sink
$ns connect $tcp $sink

set ftp [new Application/FTP]
$ftp attach-agent $tcp
$ftp set type_ FTP

set udp [new Agent/UDP]
$ns attach-agent $n(1) $udp
$udp set fid_ 2

set null [new Agent/Null]
$ns attach-agent $n(5) $null
$ns connect $udp $null

set cbr [new Application/Traffic/CBR]
$cbr attach-agent $udp
$cbr set type_ CBR
$cbr set packetSize_ 1000
$cbr set rate_ 0.2Mb
$cbr set random false

$ns at 0.1 "$cbr start"
$ns at 1.0 "$ftp start"
$ns at 124.0 "$ftp stop"
$ns at 124.5 "$cbr stop"
$ns at 125.0 "finish"

$ns run
