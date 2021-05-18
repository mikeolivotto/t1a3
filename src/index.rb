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
puts player.welcome_msg.colorize(:blue)
puts ''

# Instructions
puts "You will be given a series of multiple choice questions."
puts "Use your arrow keys to select the correct answer."

# access / read the question file
question_file = File.read('./questions.json')

# parse JSON from the file into a ruby hash
json = JSON.parse(question_file)
p json

finished = false

# loop through questions until no more questions left
until finished

    # take the first yet-to-be-asked question, ask it

    # display the answers

    # user selects their answer
    
    # user answer added to answer array

end
