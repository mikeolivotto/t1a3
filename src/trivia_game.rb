class TriviaGame

    attr_reader :name, :score, :player_answer
    # initialise the game/player with the player's name, a score starting at zero, and an empty array for their answers
    def initialize(name, mode)        
        @name = name
        @score = 0
        @player_answer = []
        # access and parse the JSON question file
        @@question_file = File.read(mode)
        @@json = JSON.parse(@@question_file)
        # @set the ascii font for headings
        @@ascii = Artii::Base.new :font => 'doom'
        @@games_played = 0
        # initialize prompt
        @@prompt = TTY::Prompt.new
    end

    # display number of games played when called
    def self.games_played
        puts ""
        if @@games_played == 1
            puts "You have played #{@@games_played} game"
        else 
            puts "You have played #{@@games_played} games"    
        end
    end
    
    # create a welcome message
    def welcome_msg
        # asciify the header
        puts @@ascii.asciify('Trivia Time!').red
        # create a box around the welcome message
        print TTY::Box.frame "Welcome to Trivia Time, #{@name}!".colorize(:blue),
            "",
            "Please select the answer you believe to be correct",
            "by pressing #{"↑".black.on_white}/#{"↓".black.on_white} arrows to move and #{"ENTER".black.on_white} to select",
            "",
            "To start the game, press any key".black.on_yellow,
            "(where's the 'any' key??)",
            padding: 1, 
            align: :center

        @@prompt.keypress()
        system "clear"
    end

    # logic for displaying questions and getting the user's answers
    def play_game

        # Counter to be used to dynamically display question number (useful if questions are delivered randomly)
        @question_counter = 1
        # Add to @@games_played count
        @@games_played += 1

        
        @@json.each do |question|

            puts ""
            # puts "Q#{@question_counter}:".black.on_yellow
            player_answer << @@prompt.select("Q#{@question_counter}: #{question["question"]}".black.on_yellow) do |menu|
                question["answers"].each do | option, answer|
                    # menu.choice "#{option} #{answer}"
                    menu.choice "#{answer}", "#{option}"
                end
            end
            @question_counter += 1
            system "clear"
        end
    end

    def player_score
        puts @@ascii.asciify('Player score').red
        #loop through player_answer array, compare to actual answers
        index_of_answer = 0
        player_answer.each do |answer|
            # if answer is correct, increase score count
            if answer == @@json[index_of_answer]["correct_answer"]
                @score += 1
            end
            index_of_answer += 1
        end

        # puts the score
        puts ""
        puts "You answered #{@score} of #{@@json.length} questions correctly."
        puts ""
        # Need to create logic to ask player what to do next
        puts "What would you like to do next? (Play again, See correct answers, exit)"
        @@prompt.keypress()
        system "clear"
    end

    def corrections
        
        # display the correct answers to questions user got wrong (UNLESS they answeres all questions correctly)
        unless @score == @@json.length
            puts @@ascii.asciify('Corrections').red
            puts "These are the correct answers to the questions you got wrong"
            # loop through player_answer array, pull out the user's incorrect answers and display correct answers
            index_of_answer = 0
            player_answer.each do |answer|
                json_index = @@json[index_of_answer]
                if answer != json_index["correct_answer"]
                    puts ""
                    # show the question
                    puts json_index["question"]
                    # show the correct answer
                    puts json_index["answers"][json_index["correct_answer"]].green
                end
                index_of_answer += 1
            end
        end
    end
end