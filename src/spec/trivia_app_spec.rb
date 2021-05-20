# Test cases
# 1. Test is the user instance is created
# 2. should display a welcome message and instructions
# 3. should add answers to an array
# 4. should count the number of correct answers
# 5. should display correct answers to the questions the user got wrong

require_relative "../trivia_player.rb"

describe TriviaPlayer do

    before(:each) do
        # this piece of code runs before each test case defined in it block
        @player = TriviaPlayer.new("Mike")
    end

    it "instance must have a readable name" do
        expect(@player.name).to eq("Mike")
    end

    # it "should display a welcome message" do
    #     msg = "Welcome, Mike"
    #     expect(@player.welcome_msg).to eq(msg)
    # end

    

end
