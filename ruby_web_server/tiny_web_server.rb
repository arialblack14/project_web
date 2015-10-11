require 'socket'

host = 'www.google.com'
port = 80
path = '/index.html'
request = "GET #{path} HTTP/1.0\r\n\r\n"
if request =~ /GET\s+\/index\.html/
	path
end

socket = TCPSocket.open(host, port)
socket.print(request) # Send request
response = socket.read # Read complete response
# Split response at first blank like into headers and body
headers, body = response.split("\r\n\r\n", 2)
print body