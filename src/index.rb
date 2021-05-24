# user story

# user must be able to view the instructions
# user should be able to select an answers
# user should be given an overall score
# user should be able to view the correct answers for questions they got wrong

# pseudocode
# 1. display a welcome message with instructions
# 2. display multiple choice questions
#     1. If user gets answer correct, increase score by 1
#     2. If user gets answer wrong, add question to array of wrong answers
# 3. Display total score
# 4. Display correct answers


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

# set up how to handle command line arguments.
# 3 arguments: -h or --help for game info, the mode (hard or easy), and player name
ARGV.each do |arg|
    if (arg == "-h") || (arg == "--help")
		# call 'help' / 'usage' message method from the trivia game class
        # for now put in a dummy help message
        puts "It's a trivia app. Just answer the questions, mate."
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
        name = gets.chomp
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
end



# Create an instance of the game
# Update this to a gets or ARGV input?
player = TriviaGame.new(name, mode)

# Display welcome message
player.welcome_msg

# Start delivering questions
player.play_game


