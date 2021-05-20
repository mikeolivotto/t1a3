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

# Create an instance of the player
# Update this to a gets or ARGV input?
player = TriviaPlayer.new("Mike")

# Display welcome message
player.welcome_msg

# Start delivering questions
player.play_game

# display the answer array
p player.player_answer

player.player_score
player.corrections



