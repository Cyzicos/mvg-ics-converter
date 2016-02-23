#!/usr/bin/perl
open CSVINPUT,"/Users/hannesvietz/Documents/PerlLernen/Projekttest/kalenderRED.csv";
@zeilenListe=<CSVINPUT>;
close CSVINPUT;
open ICSINPUT, "/Users/hannesvietz/Documents/PerlLernen/Projekttest/Test3.ics";
@icsFile=<ICSINPUT>;
close ICSINPUT;

open(my $write, '>', '/Users/hannesvietz/Documents/PerlLernen/Projekttest/output.txt ');
for (my $i=0; $i<25;$i++){
print $write $icsFile[$i];
}


foreach $zeilenListe(@zeilenListe){

print $write "\nBEGIN:VEVENT\nDTEND;TZID=Europe/Berlin:";
@s=split /;/, $zeilenListe;
$timecode=&timeConverter($s[0]);
print $write $timecode;
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
print $write "END:VCALENDER\n";
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