#!/usr/bin/perl -w
#
#	CHEN SEI-LIM
#	2018-10-19
#
my $goalhostname='tp02';
my $hit=0;
my $pool = {};
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
foreach my $line (@list) 
{	
	chop $line;
	my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev, $size,$atime,$mtime,$ctime,$blksize,$blocks) = stat ($line);
	my $hold = {
				'SIZE' => $size
			};
	$pool->{$line} = $hold;
}



while (my $fileline= <$fh>)
{
	chop $fileline;
	my @filedata =    split(' ', $fileline); 
	if( exists($pool->{$filedata[1]}) )
	{
		my $hold = $pool->{$filedata[1]};
		my $goalsize =  $hold->{SIZE};  
		my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev, $size,$atime,$mtime,$ctime,$blksize,$blocks) = stat ($filedata[1]);
		
		
		if($size eq $goalsize)
		{
			#print "size eq.\n";
		}
		else
		{
			&FileCopy($filedata[1]);
		}
	}
	else
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


