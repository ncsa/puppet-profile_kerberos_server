#!/usr/bin/perl

## copy propagation data to a backup so we can revert to an recent kerberos
#  database if we need to.  (for instance if a script goes horribly wrong and
#  changes everyones password or something)

$dir = "/var/kerberos/krb5kdc/";
$backupdir = "/var/kerberos/krb5kdc/backups/";
$data = "from_master";

(@time) = localtime(time());

$mon = $time[4] + 1;
$day = $time[3];
$year = $time[5] + 1900;
$suffix = sprintf("%.2d%.2d%4d\n",$mon,$day,$year);

$file = $dir.$data;
$tofile = $backupdir.$data.".".$suffix;
$dest = $backupdir;

if((-e $file) && (-e $dest)){
    system("cp $file $tofile");
}else{
    print "krb5_sm_backup failed\n";
}

system("bzip2 -9vs $tofile");
