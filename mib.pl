#!/usr/bin/perl -w

# Renames .mib files to the name before the first DEFINITIONS ::= BEGIN
# for ex.   HMPRIV-MGMT-SNMP-MIB   DEFINITIONS ::= BEGIN

# Hirschmann A&C, Michael Meschenmoser, October 2008
# Last testet with Windows XP SP2 !!

# Als Maskottchen von Perl dient ein Dromedar. Es zierte erstmals den Umschlag
# des auch als Kamelbuch bekannten Referenzwerkes Programming Perl. Sein
# Verleger (Tim O’Reilly) sagte in einem Interview scherzhaft als Begründung: Perl ist
# hässlich und kommt über lange Strecken ohne Wasser aus.
use Cwd;
my $akt_verz = cwd();

my $some_dir = $akt_verz . "/";

opendir(DIR, $some_dir) || die "can't opendir $some_dir: $!";
        @mibs = grep { /\.mib$/ && -f "$some_dir/$_" } readdir(DIR);
closedir DIR;

foreach (@mibs) {
        print "Found MIB: " . $some_dir . $_ . "\n";
        open (MIBFILE, $some_dir.$_) || die "Can not open file";
                @mibfile = <MIBFILE>;
        close MIBFILE;

        foreach $line(@mibfile) {
                if ($line =~ /([^\ ]+)\ +DEFINITIONS\ \:\:\=\ BEGIN/) {
                        print "-> ".$1."\n";
                        print "renaming from (".$_.") to (".$1.")\n";
                        rename($_ , $1) || die "EPIC FAIL - Cannot rename!!!";
                }
        }
}
