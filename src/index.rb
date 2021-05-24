require_relative "trivia_game.rb"
require 'colorize'
require 'json'
require 'artii'
require "tty-prompt"
require "tty-box"

# clear the screen for the user
system "clear"

# Set default name and mode to empty if not entered as command line arguments
name = ''
mode = ''

# handle command line arguments: -h / --help, difficulty level, and player name
ARGV.each do |arg|
    if (arg == "-h") || (arg == "--help")
		# call 'help' / 'usage' message method from the trivia game class
        # for now put in a dummy help message
        puts "It's a trivia app. Just answer the questions, mate."
        puts ""
		# exit
    elsif arg == "easy"
        mode = './easy.json'
    elsif arg == "regular"
        mode = './regular.json'
    elsif arg == "hard"
        mode = './hard.json'
    else name = arg
	end
end


# Create custom error for when name is empty
class InvalidNameError < StandardError
end

# method to check if name is empty and raises error if so
def validate_name(name)
    name = name.strip
    raise InvalidNameError, "Name must not be empty" if name.empty?
    name
end

# Request player name if not entered as command line argument
begin
    if name == ''
        puts "Please enter your name."
        name = STDIN.gets.strip.chomp
        validate_name(name)
    end
rescue InvalidNameError
    retry
end

prompt = TTY::Prompt.new
def difficulty
    TTY::Prompt.new.select("Select question difficulty") do |menu|
        menu.choice name: "Regular",  value: './regular.json'
        menu.choice name: "Easy", value: './easy.json'
        menu.choice name: "Hard",  value: './hard.json'
    end  
end

# Request player's chosen mode if not entered as command line argument
if mode == ''
    mode = difficulty
    system "clear"
end

# Create an instance of the game
player = TriviaGame.new(name, mode)

# Display welcome message
player.welcome_msg

# Start delivering questions
player.play_game