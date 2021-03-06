#! perl

=head1 TITLE

gen_version.pl - script to generate Rakudo version information

=cut

use POSIX 'strftime';

print "# generated by build/gen_version.pl\n";

open(my $fh, "<", "VERSION") or die $!;
my $VERSION = <$fh>;
close $fh;

if (-d '.git' && open(my $GIT, '-|', "git describe")) {
    $VERSION = <$GIT>;
    close $GIT;
}

chomp $VERSION;
print ".macro_const RAKUDO_VERSION '$VERSION'\n";


my $date = strftime('%Y-%m-%dT%H:%M:%SZ', gmtime);
print ".macro_const RAKUDO_BUILD_DATE '$date'\n";
