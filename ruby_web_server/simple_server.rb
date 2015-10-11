# Get sockets from stdlib
require 'socket'

# Socket to listen on port 2000
server = TCPServer.open(2000)
loop {
	client = server.accept # Wait for a client to connect
	client.puts(Time.now.ctime) # Send time to the client
	client.puts "Closing the connection. Bye!"
	client.close # Disconnect from client
}