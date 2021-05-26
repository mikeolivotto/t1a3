require_relative "../trivia_game.rb"
require 'json'

describe TriviaGame do

    before(:each) do
        # this piece of code runs before each test case defined in it block
        @player = TriviaGame.new("Mike", "./easy.json")
    end

    it "instance must have a name" do
        expect(@player.name).to eq("Mike")
    end

    # it "should display a welcome message" do
    #     msg = "Welcome, Mike"
    #     expect(@player.welcome_msg).to eq(msg)
    # end


    # Test for difficulty mode
    it "instance must have a difficulty mode" do
        expect(@@question_file).to eq(File.read(easy))
        ./easy.json
    end

    # Test for questions and answers displaying
    # it "instance must have a readable name" do
    #     expect(@player.name).to eq("Mike")
    # end

    # Test for user score
    # it "instance must have a readable name" do
    #     expect(@player.name).to eq("Mike")
    # end

    # Test for correct answers
    # it "instance must have a readable name" do
    #     expect(@player.name).to eq("Mike")
    # end

end
