#!/usr/bin/perl -w
#
#	CHEN SEI-LIM
#	2018-10-19
#
my $goalhostname='tp02';
my $hit=0;
my $argc = @ARGV;
if ($argc < 2) {
	printf ("usage: perl %s <dirname> <goaldata>-\n", $0);
	exit;
}

my $fold = $ARGV[0];
my $filename = $ARGV[1];
my $fh;
if (!-d $fold) {
	exit;
}

open($fh, '<', $filename)
or die "Could not open file '$filename' $!"; 
chdir $fold;
#		用find指令來取得全部的檔案結構
my @list = `find $fold`;
while (my $fileline= <$fh>)
{
	my @filedata =    split(' ', $fileline);  
	foreach my $line (@list) 
	{
		chop $line;
		if($line eq $filedata[1])
		{
			my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev, $size,$atime,$mtime,$ctime,$blksize,$blocks) = stat ($line);
			if($size eq $filedata[0])
			{
				#print "size eq.\n";
			}
			else
			{
				&FileCopy($filedata[1]);
			}
		}
	}
	if($hit==0)
	{
			&FileCopy($filedata[1]);
	}
}

sub FileCopy
{
	my($filename) = @_;
	my @localfold =    split('/', $filename);
	pop @localfold;
	my $newlocalfold="";
	foreach my $line1 (@localfold) 
	{
		$newlocalfold=$newlocalfold.'/'.$line1;
	}
	`mkdir  -p $newlocalfold `;
	my $text = sprintf 'rcp %s:%s %s',$goalhostname ,$filename,$filename;
	my $csum = `$text `;
	print $text,"\n";
}

__END__


