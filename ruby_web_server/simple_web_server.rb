require 'socket'
require 'uri'

# def requested_file request_line
# 	request_uri = request_line.split(" ")[1]	
# end


server = TCPServer.new('localhost', 2000)
# request = "GET #{path} HTTP/1.0/\r\n\r\n"

# def send_request request
# 	if request =~ /GET/
# 		requested_file(request)
# 	end

# 	if request =~/\/index\.html/
# 		response = 'HTTP/1.1 200 OK'
# 	else
# 		response = 'HTTP/1.1 404 Not Found'
# 	end
# end


loop {
	# Wait until client connects
	client = server.accept
	# Read the first line of the request
	request = client.gets
	# Log the request to the console
	STDERR.puts request

	response = File.open("ruby_web_server/index.html")

	# Always end lines with CRLF (i.e. \r\n)
	client.print "HTTP/1.1 200 OK\r\n" +
								"Content-Type: text/html\r\n" +
								"Content-Length: #{response.size}\r\n"
								"Connection: close\r\n"
	# Print a line to separate header from response body
	client.print "\r\n"

	client.print response

	message = "File not found\n"

	client.print "HTTP/1.1 404 Not Found\r\n"
							 "Content-Type: text/html\r\n"
							 "Content-Length: #{message.size}\r\n"
							 "Connection: close\r\n"
	client.print "\r\n"
	client.print message
	
	client.puts "Closing the connection. Bye!"
	client.close
}