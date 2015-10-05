require 'jumpstart_auth'

class MicroBlogger
	attr_reader :client

	def initialize
		@client = JumpstartAuth.twitter	
	end

	def tweet message
		puts message.length
		if message.length.between?(0, 140)
			@client.update message
		else
			puts "Message should be 140 characters max."
		end
	end
end

blogger = MicroBlogger.new
blogger.tweet "aaaaMr MicroBloggerMicroBlogger MicroBlogger MicroBlogger MicroBlogger  MicroBlogger MicroBlogger M MicroBlogger MicroBlogger MicroBlogger!!"
