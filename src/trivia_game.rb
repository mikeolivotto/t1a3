class TriviaGame

    attr_reader :name, :score,  :json, :corrected_answers
    attr_accessor :player_answer
    # Initialise game with the player name, a score starting at zero, and an empty array for their answers
    def initialize(name, mode)        
        @name = name
        @score = 0
        @player_answer = []
        @corrected_answers = []
        # access and parse the JSON question file
        @question_file = File.read(mode)
        @json = JSON.parse(@question_file)
        # @set the ascii font for headings
        @@games_played = 0
    end

    # Display number of games played when called
    def self.games_played
        puts ""
        if @@games_played == 1
            puts "You have played 1 game"
        else 
            puts "You have played #{@@games_played} games"    
        end

    end
    
    # Create a welcome message
    def welcome_msg
        # Asciify the header
        puts $ascii.asciify('Trivia Time!').red
        # Create a box around the welcome message
        print TTY::Box.frame " Welcome to Trivia Time, #{@name}! ".light_blue.on_white,
            "",
            "Please select the answer you believe to be correct",
            "by pressing #{"↑".black.on_white}/#{"↓".black.on_white} arrows to move and #{"ENTER".black.on_white} to select",
            "",
            "To start the game, press any key".black.on_yellow,
            "(where's the 'any' key??)",
            padding: 1, 
            align: :center
        # Code will not proceed until a key press is registered
        $prompt.keypress()
        system "clear"
    end

    # Logic for displaying questions and getting user answers
    def play_game
        # Counter to dynamically display question number (useful if questions are delivered randomly)
        @question_counter = 1
        # Add to @@games_played count
        @@games_played += 1
        # Cycle through each of the questions
        @json.each do |question|
            puts ""
            # Puts "Q#{@question_counter}:".black.on_yellow
            player_answer << $prompt.select("Q#{@question_counter}: #{question["question"]}".black.on_yellow) do |menu|
                question["answers"].each do | option, answer |
                    menu.choice "#{answer}", "#{option}"
                end
            end
            @question_counter += 1
            system "clear"
        end
        calculate_score
        corrected_array
        what_next
    end

    # Logic for displaying user score
    def calculate_score
        # Loop through player_answer array, compare to actual answers
        index_of_answer = 0
        player_answer.each do |answer|
            # If answer is correct, increase score count
            if answer == @json[index_of_answer]["correct_answer"]
                @score += 1
            end

            index_of_answer += 1
        end
        score
    end

    def player_score
        system "clear"
        puts $ascii.asciify('Player score').red
        # Puts the score
        puts ""
        puts "You answered #{@score} of #{@json.length} questions correctly."
        puts ""
        what_next
    end

    def corrected_array
        # Loop through player_answer array, pull out the user's incorrect answers and display correct answers
        index_of_answer = 0
        player_answer.each do |answer|
            json_index = @json[index_of_answer]
            if answer != json_index["correct_answer"]
                @corrected_answers << [json_index["question"], json_index["answers"][json_index["correct_answer"]]]
            end
            index_of_answer += 1
        end
        @corrected_answers
    end

    def corrections
        system "clear"
        # Display correct answers to Qs user got wrong
        puts $ascii.asciify('Corrections').red

        if @score == @json.length
            puts "You genius, you got everything right! No corrections needed!"
        else
            puts "These are the correct answers to the questions you got wrong"
        end

        @corrected_answers.each do | pair |
            puts ""
            puts pair[0].black.on_yellow
            puts pair[1].green
        end

        what_next
    end

    next_choice = nil
    # Method to ask for user's input for what to do next
    def what_next
        puts ""
        sleep(0.4)
        next_choice = $prompt.select("What would you like to do next??") do |menu|
            menu.choice name: "View score", value: "a"
            menu.choice name: "View corrections", value: "b"
            menu.choice name: "Play again", value: "c", disabled: "(Feature coming soon)"
            menu.choice name: "Exit", value: "d"
        end
        
        if next_choice == "a"
            player_score
        elsif next_choice == "b"
            corrections
        # elsif next_choice == "c"
        #     play_game
        elsif next_choice == "d"
            system "clear"
            puts $ascii.asciify('Goodbye!').red
            puts "Thanks for playing"
            sleep(1.8)
            system "clear"
            exit
        end
    end
end