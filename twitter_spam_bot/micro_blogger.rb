require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

	def initialize
		@client = JumpstartAuth.twitter	
	end

	def tweet message
		puts "Message length is : " + message.length.to_s
		if message.length.between?(0, 140)
			@client.update message
		else
			puts "Message should be 140 characters max."
		end
	end

	def run
		command = ""
		puts "This program may spam your twitter account, so be careful when using it."
		while command != "q"
			printf "Enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when "q" then puts "Goodbye!"
				when "t" then tweet(parts[1..-1].join(" ")) unless parts[1..-1].nil?
				else
					puts "Sorry, i don't know how to #{command}."				
			end
		end
	end
end

blogger = MicroBlogger.new
blogger.run
