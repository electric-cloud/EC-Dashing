#
# Sending job properties to the dashboard by using curl
# Change the IP address as required
# Color is part of the widget CSS

if [ "$[/myJob/latestBuildOutcome]" = "success" ]
then
    outcome="Green" 
    curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "Latest Build - $[/myJob/latestBuild] ran for '$[/myJob/latestBuildElapsedTime]' hours, and was '$outcome' woo! ", "isGreen": 3}' \http://192.168.56.25:3030/widgets/lastBuild 
else
    outcome="Red" 
    curl -d '{ "auth_token": "YOUR_AUTH_TOKEN", "text": "$[/myJob/latestBuild] ran for $[/myJob/latestBuildElapsedTime] hours, and was '$outcome'! ", "isRed": 3}' \http://192.168.56.25:3030/widgets/lastBuild
fi