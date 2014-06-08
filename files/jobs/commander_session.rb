require 'uri'
require 'net/http'
require 'net/https'
require 'json'
require 'time'
require './lib/ElectricCommander'
require './lib/credentials'

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '1m', :first_in => 0 do |job|

  # Create ElectricCommander object
  ec = ElectricCommander.new("#{$commander_server}", "8000","json","0");

  # Login
  ec.login("#{$commander_user}","#{$commander_password}")
  
  # This is the time commander expects
  # 86400 seconds in a day
  yesterday = (Time.now - 86400).utc.iso8601(3)
  
  # Get the number of preflights run in the last 24 hours
  result = ec.countObjects("job",yesterday)
    
  # Get number of total jobs  
  # change Project and procedure below to reflect what you want to monitor
  allJobs = ec.countObjectsTotalNumberOfJobs("job",yesterday, "ProjectToCheck", "ProcedureToCheck")

  # Get the number of successful (green) jobs
  # change Project and procedure below to reflect what you want to monitor
 greenJobs = ec.countObjectsTotalNumberOfSuccessJobs("job",yesterday, "ProjectToCheck", "ProcedureToCheck")

  percentageOfGreenBuilds = ((greenJobs.to_f / allJobs.to_f) * 100 ).to_i
  
  ec.logout
  
  # Update the number of preflights run
  send_event('preflightsRun', { text: result })
  
  # Update the % of green builds counter
  send_event('percentageOfGreenBuilds', { value: percentageOfGreenBuilds })
end