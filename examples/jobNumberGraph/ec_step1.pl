############################################################################
#
# Copyright 2014 Electric-Cloud Inc.
#
#############################################################################
$[/plugins/EC-Admin/project/scripts/perlHeaderJSON]

use DateTime;
use DateTime::Format::ISO8601;

$DEBUG=1;

my $dayLimit=10;

############################################################################
#
# Global variables
#
#############################################################################
# Extract the local timezone
my $myTZ=DateTime::TimeZone->new(name => 'local');

# Day of Week with Mon=1 -> Sun=7
my @week=qw(NONE Mon Tue Wed Thu Fri Sat Sun);
my @days=();

for (my $i=0;$i<$dayLimit;$i++) {
  my $dayMidnight=calculateDate($i);
  my $wday=getDayOfWeek($dayMidnight);
  my $yday=getDayOfYear($dayMidnight);
  push (@days, {'midnight'=> calculateEpoch($i), 'wday'=>$wday, 'yday'=>$yday});
}

my @filterList;

# only completed jobs
push (@filterList, 
    {"propertyName" => "status",
      "operator" => "equals",
      "operand1" => "completed"});
      
my $res=$ec->findObjects('job', {filter => \@filterList});

my %total=('success'=>0,'error'=>0,'warning'=>0);
my $nbJobs=0;                         # Total number of builds
my %dayTotal=();
  for (my $day=0; $day<=$dayLimit; $day++) {
    my $dayIndex=$days[$day]{yday};
    $dayTotal{$dayIndex}{'success'}=0;
    $dayTotal{$dayIndex}{'error'}=0;
    $dayTotal{$dayIndex}{'warning'}=0;

  }
  
foreach my $job ($res->findnodes('//job')) {
  my $outcome=$job->{'outcome'};
  my $start=$job->{'start'};
  $dayTotal{getDayOfYear($start)}{$outcome} ++;
  $total{$outcome} ++;
  $nbJobs++;
}

my $pointString='"points": [';
my $counter=0;
# Display days of week starting a while ago
for (my $day=$dayLimit-1 ; $day>= 0; $day --) {
  my $dayIndex=$days[$day]{yday};
  $pointString.=sprintf('%s{"x": "%s", "y":"%d"}', $counter ? ",\n" : "", 
                        $days[$day]{midnight}, $dayTotal{$dayIndex}{'success'});
  $counter=1;
}
$pointString .= "]";

print $pointString . "\n";
  
system("curl -d '{\"auth_token\": \"YOUR_AUTH_TOKEN\", $pointString}' http://192.168.56.25:3030/widgets/jobTrend;");



#############################################################################
#
# Calculate the UTC epoch in ms based on LOCAL now minus the number of days 
#
#############################################################################
sub calculateDate {
    my $nbDays=shift;
    #printf("Calculate offset: %s\n", $nbDays) if ($DEBUG);
    # Get Today Midnight Date
    my $dt=DateTime->now(time_zone=>'local')->subtract(days => $nbDays)->truncate(to => 'day');
    #printf("  local midnight time: %s", $dt);
    $dt->set_time_zone("UTC");
    return $dt->iso8601(). ".0Z";
}


#############################################################################
#
# Calculate the UTC Date based on LOCAL now minus the number of days 
#
#############################################################################
sub calculateEpoch {
    my $nbDays=shift;
    #printf("Calculate offset: %s\n", $nbDays) if ($DEBUG);
    # Get Today Midnight Date
    my $dt=DateTime->now(time_zone=>'local')->subtract(days => $nbDays)->truncate(to => 'day');
    #printf("  local midnight time: %s", $dt);
    $dt->set_time_zone("UTC");
    return $dt->epoch()*1000;
}

#############################################################################
#
# Calculate the LOCAL Day of the week from a start time in UTC
#
#############################################################################
sub getDayOfWeek {
    my $date=shift;
    my $dt = DateTime::Format::ISO8601->parse_datetime($date);
    $dt->set_time_zone($myTZ);

    my $wday=$dt->day_of_week();
    #printf("UTC Date: %s Local: %s - Local day: %s\n", $date, $dt, $week[$wday]) if ($DEBUG);
    return $wday;
}

#############################################################################
#
# Calculate the LOCAL Day of the week from a start time in UTC
#
#############################################################################
sub getDayOfYear {
    my $date=shift;
    my $dt = DateTime::Format::ISO8601->parse_datetime($date);
    $dt->set_time_zone($myTZ);

    my $yday=$dt->day_of_year();
    return $yday;
}

