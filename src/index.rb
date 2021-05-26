require_relative "trivia_game.rb"
require 'colorize'
require 'json'
require 'artii'
require "tty-prompt"
require "tty-box"

# Global variable to instantiate TTY-Prompt
$prompt = TTY::Prompt.new

# Global variable to instantiate Artii
$ascii = Artii::Base.new :font => 'doom'

# clear the screen for the user
system "clear"

# Set default name and mode to empty if not entered as command line arguments
name = ''
mode = ''

# Handle command line arguments: -h / --help, difficulty level, and player name
ARGV.each do |arg|
    if (arg == "-h") || (arg == "--help")
        puts $ascii.asciify('HELP!').red
        print TTY::Box.frame "LOADING THE GAME".black.on_yellow,
            "================",
            "When loading the app, you can enter up to 3 arguments:",
            "* '-h' or '--help' to view the help instructions",
            "* The player's first name",
            "* 'easy', 'regular' or 'hard' to nominate question difficulty mode",
            "",
            "You don't need to enter any arguments, the app will prompt you if you dont",
            "",
            "USAGE".black.on_yellow,
            "=====",
            "* Follow the on-screen prompts.",
            "* Select answers by pressing the ↑/↓ arrows to move and Enter to select.",
            "",
            ".",
            padding: 1, 
            align: :center,
            width: 60
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
        puts ''
        puts "Before you begin, please enter your name.".black.on_yellow
        name = STDIN.gets.strip.chomp
        validate_name(name)
    end

rescue InvalidNameError
    retry
end

def difficulty
    $prompt.select("Select question difficulty".black.on_yellow) do |menu|
        menu.choice name: "Regular",  value: './regular.json'
        menu.choice name: "Easy", value: './easy.json'
        menu.choice name: "Hard",  value: './hard.json'
    end  
end

# Request player's chosen mode if not entered as command line argument
if mode == ''
    puts ""
    mode = difficulty
    system "clear"
end

# Create an instance of the game
player = TriviaGame.new(name, mode)

# Display welcome message
player.welcome_msg

# Start delivering questions
player.play_game