#!/usr/bin/perl

## monitor /var/log/krb5.log for afsbackup tickets from anywhere but roscoe

#Feb 12 10:11:16 brick kernel: Internal Connection: IN=eth0 OUT= MAC=00:aa:00:30:82:47:00:03:31:1f:0c:0a:08:00 SRC=141.142.97.11 DST=141.142.3.16 LEN=60 TOS=0x00 PREC=0x00 TTL=62 ID=40291 DF PROTO=TCP SPT=60963 DPT=23 WINDOW=5840 RES=0x00 SYN URGP=0

#Feb 17 10:47:20 dop  -- root[28930]: ROOT LOGIN ON tty2
#Feb 17 10:58:05 dop  -- dopheide: LOGIN ON tty2 BY dopheide

$notifyemail = "kerberos-admin\@ncsa.uiuc.edu";

open(LOG,"tail --follow=name /var/log/krb5.log|");

#Aug 24 12:39:39 brick krb5kdc[13848]: TGS_REQ (7 etypes {18 17 16 23 1 3 2}) 10.142.199.15: ISSUE: authtime 1156441179, etypes {rep=18 tkt=1 ses=1}, afsbackup@NCSA.EDU for afs/ncsa.uiuc.edu@NCSA.EDU

while(<LOG>){
    if($_ =~ /^(\w+\s+\d+\s[\d\:]+)\s(\w+).*\}\)\s([\d\.]+)\:.*afsbackup\@NCSA\.EDU/){
	$date = $1;
	$host = $2;
	$srcip = $3;
#	print "$date $host $srcip\n";
	if($srcip ne "10.142.199.15"){
	    $cmd = "/bin/mail -s \"$host AFS Backup Security Warning\" $notifyemail";
	    open(SENDMAIL,"|$cmd");
	    print SENDMAIL "\n$date\n\n";
	    print SENDMAIL "$srcip (not roscoe) requested tickets for afsbackup\n";
	    close(SENDMAIL);
	}
    }
}

close(LOG);
