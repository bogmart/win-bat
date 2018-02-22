@rem = 'PERL for Windows NT -- "ccperl" must be in search path
@echo off
ccperl C:\Windows\BAT\%0
goto endofperl
@rem ';

# Begin of Perl section


# This script mounts the CESVXW Vobs on the local Windows machine. It reads the
# VOBs from the @vob_list variable. It does not verify that the VOBs listed in
# this variable are part of the CESVXW project.
################################ VARIABLES ######################################
use strict;

my @vob_list = ('\malibu',
                '\server',
                '\client',
                '\pki',
                '\oshost',
                '\osshare',
                '\ostarget',
                '\floppy',
                '\tools',
                '\shared_tools',
                '\thirdparty',
                '\techpubs',
                '\release_eng_tools',
                '\javaclient',
                '\bldtools',
                '\client_tools',
                '\mstools');

################################### SUBS ######################################## 
sub MountVob {
   my ($vob) = @_;
   my ($tmp,$match);

   $tmp = `cleartool lsvob $vob`;
   $match = "\\$vob";

   return if $tmp =~ /\*\s+$match/;

   if ($tmp =~ /$match/) {
      system("cleartool","mount","-persistent","$vob")
         and die "Can not mount <$vob>.\n$!";
   }
   else {
      die "Vob <$vob> does not exist.";
   }
}

################################### MAIN ########################################

foreach $_ (@vob_list)
    {
	    &MountVob($_);
    }
    
__END__
:endofperl