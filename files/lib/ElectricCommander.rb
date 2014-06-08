require 'uri'
require 'net/http'
require 'net/https'
require 'json'

class ElectricCommander  

  $sessionId = ""
  def initialize(server, port,format,debug)  
    # Instance variables  
    @server = server  
    @port = port
    @format = format
    @debug = debug	
	@uri = URI("https://#{@server}:#{@port}/")
  end  
  
  def login (user,password)  
    
	http = Net::HTTP.new(@uri.host,@uri.port)

	# Create the request for the login
	req = Net::HTTP::Post.new(@uri.path, initheader = {'Content-Type' =>'application/json'})
	req.body = <<EOF
	{"version":"2.2","timeout":180,"sessionId":"123","requests":[{"parameters":{"password":"#{password}","userName":"#{user}"},"requestId":1,"operation":"login"}]}
EOF

	# Send the request
	res = http.request(req)

	# Response is in the form of
	# {
	#   "requestId" : "1",
	#   "sessionId" : "SESSION_ID",
	#   "userName" : "admin"
	#}

	if !res.code == "200"
	   puts "ERROR: Could not login"
	end

	# Parse response from the commander server
	resultJSON = JSON.parse(res.body)

	# Get the sessionId from the response and store it in a global variable
	$sessionId = resultJSON["responses"][0]["sessionId"]
	
  end  

  def logout  
    
	http = Net::HTTP.new(@uri.host,@uri.port)

	# Create the request for the login
	req = Net::HTTP::Post.new(@uri.path, initheader = {'Content-Type' =>'application/json'})
	req.body = <<EOF
	{"version":"2.2","timeout":180,"sessionId":"#{$sessionId}","requests":[{"requestId":1,"operation":"logout"}]}
EOF

	# Send the request
	res = http.request(req)

	if !res.code == "200"
	   puts "ERROR: Could not login"
	end
	
  end
  
  def countObjects(objectType, createdAfterDate)  

  http = Net::HTTP.new(@uri.host,@uri.port)

  # Create the request for the login
  req = Net::HTTP::Post.new(@uri.path, initheader = {'Content-Type' =>'application/json'})
  req.body = <<EOF
  {"version":"2.2","timeout":180,"sessionId":"#{$sessionId}","requests":[{"parameters":{"filter":[{"operator":"and","filter":[{"operator":"equals","operand1":"1","propertyName":"preflight"},{"operator":"greaterThan","operand1":"#{createdAfterDate}","propertyName":"createTime"}]}],"objectType":"#{objectType}"},"requestId":1,"operation":"countObjects"}]}
EOF

  # Send the request
  res = http.request(req)

  if !res.code == "200"
    puts "ERROR: Could not login"
  end

  resultJSON = JSON.parse(res.body)
  return resultJSON["responses"][0]["count"]
  
  end
  
  def countObjectsTotalNumberOfJobs(objectType, createdAfterDate, projectName, procedureName)  

  http = Net::HTTP.new(@uri.host,@uri.port)

  # Create the request for the login
  req = Net::HTTP::Post.new(@uri.path, initheader = {'Content-Type' =>'application/json'})
  req.body = <<EOF
  {"version":"2.2","timeout":180,"sessionId":"#{$sessionId}","requests":[{"parameters":{"filter":[{"operator":"and","filter":[{"operator":"greaterThan","operand1":"#{createdAfterDate}","propertyName":"createTime"},{"operator":"equals","operand1":"#{projectName}","propertyName":"projectName"},{"operator":"equals","operand1":"#{procedureName}","propertyName":"procedureName"}]}],"objectType":"job"},"requestId":1,"operation":"countObjects"}]}
EOF

  # Send the request
  res = http.request(req)

  if !res.code == "200"
    puts "ERROR: Could not login"
  end

  resultJSON = JSON.parse(res.body)
  return resultJSON["responses"][0]["count"]
  
  end

  def countObjectsTotalNumberOfSuccessJobs(objectType, createdAfterDate, projectName, procedureName)  

  http = Net::HTTP.new(@uri.host,@uri.port)

  # Create the request for the login
  req = Net::HTTP::Post.new(@uri.path, initheader = {'Content-Type' =>'application/json'})
  req.body = <<EOF
  {"version":"2.2","timeout":180,"sessionId":"#{$sessionId}","requests":[{"parameters":{"filter":[{"operator":"and","filter":[{"operator":"greaterThan","operand1":"#{createdAfterDate}","propertyName":"createTime"},{"operator":"equals","operand1":"#{projectName}","propertyName":"projectName"},{"operator":"equals","operand1":"#{procedureName}","propertyName":"procedureName"}, {"operator":"equals","operand1":"success","propertyName":"outcome"}]}],"objectType":"job"},"requestId":1,"operation":"countObjects"}]}
EOF

  # Send the request
  res = http.request(req)

  if !res.code == "200"
    puts "ERROR: Could not login"
  end

  resultJSON = JSON.parse(res.body)
  return resultJSON["responses"][0]["count"]
  
  end    
  
  # DEBUG purposes only
  def getSessionId  
    return "#{$sessionId}"  
  end  
end  