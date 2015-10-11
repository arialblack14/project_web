require 'socket'

hostname = 'localhost'
port = 2000

socket = TCPSocket.open(hostname, port)
# Read lines from the socket
while line = socket.gets
	puts line.chop
end
# Close the socket when done
socket.close