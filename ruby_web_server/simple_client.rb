require 'socket'

hostname = 'localhost'
port = 2000

s = TCPSocket.open(hostname, port)
# Read lines from the socket
while line = s.gets
	puts line.chop
end
# Close the socket when done
s.close