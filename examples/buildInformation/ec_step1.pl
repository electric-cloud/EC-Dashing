use strict;
use ElectricCommander;

# Turn off buffering 
$| = 1;

my $ec = new ElectricCommander();

# define the filter to extract the exact job you are looking for
#
my $xpath = $ec->findObjects("job",
        {maxIds => "1",
          filter => [{propertyName => "status",
                        operator => "equals",
                        operand1 => "completed"}],
  
        sort => [{propertyName => "finish",
                  order => "descending"}]
        });

#
# save Data as job properties
#
my $lastBuild = $xpath->findvalue('//jobName')->value();
$ec->setProperty('/myJob/latestBuild', $lastBuild);

my $lastBuildStatus = $xpath->findvalue('//outcome')->value();
$ec->setProperty('/myJob/latestBuildOutcome', $lastBuildStatus);


my $lastBuildTime = $xpath->findvalue('//elapsedTime')->value();

my $temp= $lastBuildTime / 3600000;
my $time=substr($temp,0,index($temp,'.') + 1 + 2);

$ec->setProperty('/myJob/latestBuildElapsedTime', $time);