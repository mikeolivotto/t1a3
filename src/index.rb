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

# Set default name and mode if not entered as command line arguments
name = nil
mode = './regular.json'

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

if name == nil
    puts "Please enter your name."
    name = STDIN.gets.chomp
end



# Create an instance of the game
# Update this to a gets or ARGV input?
player = TriviaGame.new(name, mode)

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

