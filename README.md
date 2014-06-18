This project contains a Dashing Dashboard to display data monitoring the status of your server.

It uses Vagrant and VirtualBox to spin a VM with all the required parts.

simply invoke  the following command to create the and provision the VM:  
	`vagrant up`

You can then ssh in the VM by using:  
	`vagrant ssh`

If you do not want to use Vagrant, create your own machine and follow the directions 
in the script part of the Vagrantfile.
/vagrant is a specific mount point on the guest OS to access the local host directory.

Once your machine is up and configured, you need to modify the following files:  
  /opt/dashing/lib/credentials to enter your information to connect to ElectricCommander, Jira and Twitter
  /opt/dashing/jobs/commander_sessions.rb to change the name of the project and procedure you want to monitor

The last build widget data is pushed from commander. The step looks like:

```sh
if [ "$[/myJob/latestBuildOutcome]" = "success" ]
then
    outcome="Green" 
    curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Latest Build - $[/myJob/latestBuild] ran for '$[/myJob/latestBuildElapsedTime]' hours, and was '$outcome' woo! ", "isGreen": 3}' \http://192.168.56.25:3030/widgets/welcome 
else
    outcome="Red" 
    curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "$[/myJob/latestBuild] ran for $[/myJob/latestBuildElapsedTime] hours, and was '$outcome'! ", "isRed": 3}' \http://192.168.56.25:3030/widgets/welcome
fi
```

The properties are set in a previous step where you can define a simple findObjects('job').
Replace the IP address by the one associated to your VM (if you have changed the VagrantFile)

I'll publish a full example in the EC-Dashing-Widget project later on

The goal is to add additional widgets specific to Commander over time.

Contact the authors:  
	Nikhil Vaze  
	Siddhartha Gupta  
	Laurent Rochette (lrochette@electric-cloud.com)  

Legal Jumbo
 
This module is free for use. Modify it however you see fit to better your 
experience using ElectricCommander. Share your enhancements and fixes.

This module is not officially supported by Electric Cloud. It has undergone no 
formal testing and you may run into issues that have not been uncovered in the 
limited manual testing done so far.

Electric Cloud should not be held liable for any repercusions of using this 
software.
