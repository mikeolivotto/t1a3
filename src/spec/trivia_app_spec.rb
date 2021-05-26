require_relative "../trivia_game.rb"
require 'json'
require 'colorize'
require 'artii'
require "tty-prompt"
require "tty-box"

# # Global variable to instantiate TTY-Prompt
$prompt = TTY::Prompt.new

# # Global variable to instantiate Artii
$ascii = Artii::Base.new

describe TriviaGame do

    before(:each) do
        # this piece of code runs before each test case defined in it block
        @player = TriviaGame.new("Mike", "./easy.json")
        @player.player_answer = ["c", "b", "c", "b"]
    end

    # Test that name argument gets passed through to name variable
    it "instance must have a name" do
        expect(@player.name).to eq("Mike")
    end

    # Test for difficulty mode
    it "instance must have a difficulty mode" do
        # Since the 'easy' mode is defined for @player, the answer to the first question should be "c"
        expect(@player.json[0]["correct_answer"]).to eq("c")
    end

    # Test that user score is calculated correctly
    it "Calculate the score" do
        # The answers to the easy questions in order are c,a,c,b
        # Score should equal 3 as TriviaGame is instantiated with 1 wrong answer
        expect(@player.calculate_score).to eq(3)
    end

    # Test that answer corrections are displayed correctly
    it "instance should display the correct answers" do
        expect(@player.corrected_array).to eq([["Where would you find the Eiffel Tower?", "Paris"]])
    end

end
