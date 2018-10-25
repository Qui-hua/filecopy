#!/usr/bin/perl -w
#
#	CHEN SEI-LIM
#	2018-10-19
#

my $argc = @ARGV;
if ($argc < 1) {
	printf ("usage: perl %s <dirname>-\n", $0);
	exit;
}

my $fold = $ARGV[0];
if (!-d $fold) {
	exit;
}

chdir $fold;

my @list = `find $fold`;
foreach my $line (@list) {
	chop $line;
	if (-f $line) {
#               my $csum = `csum -h MD5 $line`;
#                print $line,"\n";
                my $csum = `ls -l  $line `;
				my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev, $size1,$atime,$mtime,$ctime,$blksize,$blocks) = stat ($line);
               # my $text = sprintf 'rcp zh03:%s .', $line;
#               print $text, "\n";
                chop $csum;
                my @size =  split / +/, $csum;
                my $outline = sprintf ("%12d  %s",$size[4],$line);
              #  print $outline , "\n";
                print $size1,"   ",$line , "\n";

	}

	if (-d $line) {
		my $text = sprintf 'mkdir %s', $line;
#		print $text, "\n";
	}
}

__END__


