#!/usr/bin/perl -w
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
#		用find指令來取得全部的檔案結構
my @list = `find $fold `;
foreach my $line (@list) {
	chop $line;
	#		這是文字檔
	if (-f $line) {
	#		讀取檔案資料
				my ($dev,$ino,$mode,$nlink,$uid,$gid,$rdev, $size1,$atime,$mtime,$ctime,$blksize,$blocks) = stat ($line);
                my $outline = sprintf ("%12d  %s",$size1,$line);
                print $outline , "\n";
	}

	if (-d $line) {
#		這是資料夾
	}
	
}

__END__


