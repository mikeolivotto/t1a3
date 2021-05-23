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

# IDEAS
# True / false answers
# multiple choice answers
# free text answers


require_relative "trivia_player.rb"
require 'colorize'
require 'json'
require 'artii'
require "tty-prompt"
require "tty-box"




# clear the screen for the user
system "clear"

# set up how to handle command line arguments.
file = './questions.json'
ARGV.each do |arg|
	if (arg == "-h") || (arg == "--help")
		# call 'help' / 'usage' message method from the trivia game class
        # for now put in a dummy help message
        puts "It's a trivia app. Just answer the questions, mate."
		exit
    elsif arg == "easy"
        file = './easy.json'
    elsif arg == "hard"
        file = './hard.json'
	end
end


# Create an instance of the player
# Update this to a gets or ARGV input?
player = TriviaGame.new("Mike", file)

# Display welcome message
player.welcome_msg

# Start delivering questions
player.play_game

# Display the player's score
player.player_score

# Display the correct answers the questions the user got wrong
player.corrections

# Display the number of games played by the user
TriviaGame.games_played

