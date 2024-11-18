#!/usr/bin/perl

## monitor /var/log/messages for Internal Connections and console logins
#  We could keep watching the logs to see who logged in during that internal
#  connection, but in reality, if there's a problem, it might not show up
#  in the logs like we expect and then our script would just be sitting there
#  instead of sending out the email to warn us.

#Feb 12 10:11:16 brick kernel: Internal Connection: IN=eth0 OUT= MAC=00:aa:00:30:82:47:00:03:31:1f:0c:0a:08:00 SRC=141.142.97.11 DST=141.142.3.16 LEN=60 TOS=0x00 PREC=0x00 TTL=62 ID=40291 DF PROTO=TCP SPT=60963 DPT=23 WINDOW=5840 RES=0x00 SYN URGP=0

#Feb 17 10:47:20 dop  -- root[28930]: ROOT LOGIN ON tty2
#Feb 17 10:58:05 dop  -- dopheide: LOGIN ON tty2 BY dopheide

$notifyemail = "kerberos-admin\@lists.ncsa.illinois.edu";

open(LOG,"tail --follow=name /var/log/messages|");

while(<LOG>){
    if($_ =~ /^(\w+\s+\d+\s[\d\:]+)\s(\w+).*Internal\sConnection.*SRC\=(\d+\.\d+\.\d+\.\d+).*DPT\=(\d+)/){
	$date = $1;
	$host = $2;
	$srcip = $3;
	$dport = $4;

	$cmd = "/bin/mail -s \"$host Internal Connection\" $notifyemail";
	open(SENDMAIL,"|$cmd");
	if($dport == "22"){
	    print SENDMAIL "\nInternal SSH connection to \'$host\'\n";
	}elsif($dport == "23"){
	    print SENDMAIL "\nInternal Telnet connection to \'$host\'\n";
	}else{
	    print SENDMAIL "\nInternal Port $dport connection to \'$host\'\n";
	}
	print SENDMAIL "Date:    $date\n";
	print SENDMAIL "SRC IP:  $srcip\n";

	close(SENDMAIL);
    }elsif($_ =~ /^(\w+\s+\d+\s[\d\:]+)\s(\w+)\s+\-\-\s([\w\-]+).*\sLOGIN\sON/){
	$date = $1;
	$host = $2;
	$user = $3;
	$cmd = "/bin/mail -s \"$host Internal Connection\" $notifyemail";
	open(SENDMAIL,"|$cmd");
	print SENDMAIL "\nConsole login by \'$user\' on \'$host\'\n";
	print SENDMAIL "Date:    $date\n";
	close(SENDMAIL);
    }


}

close(LOG);
