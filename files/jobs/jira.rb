require './lib/credentials'

require 'net/http'

require 'json'
require 'uri'
require 'pp'

points = []

# TODO: Use these in the req variable
board_id = '504' # The ID number of the Rapid Board you wish to monitor
wip_status = 'In Progress'

SCHEDULER.every '5s', :first_in => 0 do |job|
  uri = URI.parse($jira_url)
  http = Net::HTTP.new(uri.host, uri.port)
  req = Net::HTTP::Get.new("/rest/api/2/search?jql=sprint%20%3D%20914%20AND%20status%20%3D%20%27In%20Progress%27")
  req.basic_auth $jira_username, $jira_password
  response = http.request(req)
  issuesinP = JSON.parse(response.body)["total"]  
  send_event('buzzwords', value: issuesinP)

end
