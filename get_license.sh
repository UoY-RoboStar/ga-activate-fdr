#!/usr/bin/expect -f
set license_type [lindex $argv 0]
set email [lindex $argv 1]
set name [lindex $argv 2]

spawn refines empty.csp
expect {
	-re {^Welcome to FDR [^\]]*\] } {
		send "$license_type\r"; exp_continue
	}
	-re {To obtain a free FDR[^:]*: } {
		send "$email\r"; exp_continue
	}
	"Please enter your name: " {
		send "$name\r"; exp_continue
	}
	-re {Requesting license .*$} {
		puts "DONE"; exp_continue
	}
	eof
}
