#!/usr/bin/perl
use warnings;


=pod
  Information logger
  Purpose: allows user to log activities, etc in a log file with
  date and time stamp. If log file already exists, new text is appended
  to it, else new file is created. Name of log file is taken as the 
  first command line argument.
=cut

$sentinel = "endlog";
$logfile = $ARGV[0];
$num_args = scalar @ARGV;	# number of command line args
unless($num_args > 0){		# ensure that user gave file name
	die "ERROR: Need file name as argument!\n";
}
if($num_args > 1){	# if more than 1 arg given, warn user that only first is used
	print "WARNING: All arguments after the first will be ignored\n";
}

# if there is already a log file in the current dir, open and append
if(-e $logfile){
	open (FILE, '>>'.$logfile);
	print FILE "\n";

# else open pre-existing file
} else {
	print " Log file does not exist.\n Creating a new log file.\n";
	unless(open FILE, '>'.$logfile){	# ensure no errors upon opening
	# note: '>>' means append whereas '>' overwrites the file
		die "\nERROR: Unable to create file.\n\n"
	}
}

# get and print date and time
$date = localtime();
print FILE "--------------------------\n",
     " $date\n--------------------------\n";
print "\n********************************\n",
      " $date \n Begin Log\n Enter \"endlog\" to finish entry\n",
      "********************************\n\n";

# prepare to loop thru and write each line that user enters
# until they enter a line with just $sentinel
$done = "false";
do{
	print ">> ";
	$input = <STDIN>;
	chomp($input);
	if($input eq $sentinel){ # if delimeter, ignore line and exit
		$done = "true";
		print FILE "\n";
	} else {
		print FILE "$input\n";
	}
# while no delimeter
} while($done eq "false");

# close the file and exit
close FILE;
die "Log written\n\n";
