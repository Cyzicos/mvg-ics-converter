#!/usr/bin/perl
open CSVINPUT,"/Users/hannesvietz/Documents/PerlLernen/Projekttest/kalenderREDzeitraum.csv";
@zeilenListe=<CSVINPUT>;
close CSVINPUT;

$headerString="BEGIN:VCALENDAR\nMETHOD:PUBLISH\nVERSION:2.0\nX-WR-CALNAME:MVG-Termine\nPRODID:-//Hannes\nX-APPLE-CALENDAR-COLOR:#63DA38\nX-WR-TIMEZONE:Europe/Berlin\nCALSCALE:GREGORIAN\n";

open(my $write, '>', '/Users/hannesvietz/Documents/PerlLernen/Projekttest/output.ics');

print $write $headerString;



foreach $zeilenListe(@zeilenListe){

print $write "\nBEGIN:VEVENT\nDTEND;TZID=Europe/Berlin:";
@s=split /;/, $zeilenListe;
$_=$s[0];
if (/-/) {
 $endtimecode=&endtimeConverter($s[0]);

	}
else{
 $endtimecode=&timeConverter($s[0]);
	}
print $write $endtimecode;
print $write "010000\n";

print $write "SUMMARY:";
$summary=$s[1];
print $write $summary;
print $write "\n";

print $write "DTSTART;TZID=Europe/Berlin:";
print $write $timecode;
print $write "000000\n";

print $write "LOCATION:";
$location=&locationMaker($s[3],$s[4]);
print $write $location;
print $write "\nEND:VEVENT\n";


#print $write "@s";
}
print $write "\nEND:VCALENDAR";
close $write;


sub locationMaker{
my $location="$_[0] $_[1]";
chomp($location);
$location;
}

sub timeConverter{

my $day=substr($_[0],0,2);
my $month=substr($_[0],3,2);
my $year=substr($_[0],6,4);
#print "Day: $day Month: $month Year $year\n";
$timecode=$year.$month.$day."T";
}
sub endtimeConverter{

my $endday=substr($_[0],4,2);
my $day=substr($_[0],0,2);
my $month=substr($_[0],7,2);
my $year=substr($_[0],10,4);

#print "Day: $day Month: $month Year $year\n";
$timecode=$year.$month.$day."T";
$endtimecode=$year.$month.$endday."T";

}
