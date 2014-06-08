require 'twitter'
## ElectricCommander Settings
$commander_user = "admin"
$commander_password = "changeme"
$commander_server = "ec50"

## JIRA Settings

# Set your JIRA location here. Leave out the trailing slash on the end of the URL.
$jira_url = 'http://jira'
$jira_board_id = '504' # The ID number of the Rapid Board you wish to monitor
$jira_wip_status = 'In Progress'
$jira_username = 'JIRA_USER'
$jira_password = 'JIRA_PASSWORD'

#### Get your twitter keys & secrets:
#### https://dev.twitter.com/docs/auth/tokens-devtwittercom
$twitter = Twitter::REST::Client.new do |config|
        config.consumer_key = 'CONSUMER_KEY'
        config.consumer_secret = 'CONSUMER_SECRET'
        config.access_token = 'ACCESS_TOKEN'
        config.access_token_secret = 'ACCESS_TOKEN_SECRET'
end
