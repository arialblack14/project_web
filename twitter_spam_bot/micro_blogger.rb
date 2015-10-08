require 'jumpstart_auth'
require 'bitly'

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
		puts "MicroBlogger Initialized."
		sleep(1)
		puts
		puts "***This program may spam your twitter friends/followers, so be careful when using it."
		puts
		while command != "q"
			printf "Enter command: "
			input = gets.chomp
			parts = input.split(" ")
			command = parts[0]
			case command
				when "q" then puts "Goodbye!"
				when "t" then tweet(parts[1..-1].join(" ")) unless parts[1..-1].nil?
				when "dm" then dm(parts[1], parts[2..-1].join(" "))
				when "spam" then spam_my_followers parts[1..-1]
				when "elt" then everyones_last_tweet
				when "s" then shorten(parts[1..-1].join)

				else
					puts "Sorry, i don't know how to #{command}."				
			end
		end
	end

	def dm target, message
		puts "Trying to send #{target} this direct message:"
		puts message
		screen_names = @client.followers.collect { |follower| @client.user(follower).screen_name }
		if followers_list.include? target
			message = "dm @#{target} #{message}"
			tweet message
		else
			puts "You are trying to message someone who is a non-follower."
		end
	end

	def followers_list
		screen_names = []
		@client.followers.each do |follower|
			screen_names << @client.user(follower).screen_name
		end
		screen_names
	end

	def spam_my_followers message
		followers_list.each do |screen_name|
			dm(screen_name, message.join(" "))
		end
	end

	def everyones_last_tweet
		friends = @client.friends.sort_by { |friend| @client.user(friend).screen_name.downcase }
		friends.each do |friend|
			timestamp = @client.user(friend).status.created_at

			puts "#{@client.user(friend).screen_name} said this on on #{timestamp.strftime("%A, %b, %d")}"
			puts @client.user(friend).status.text
			puts
		end
	end

	def shorten(original_url)
		puts "Shortening this URL: #{original_url}"

		Bitly.use_api_version_3
		bitly = Bitly.new('hungryacademy', 'R_430e9f62250186d2612cca76eee2dbc6')
		return bitly.shorten(original_url).short_url
	end
end

blogger = MicroBlogger.new
blogger.run
