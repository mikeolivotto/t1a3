class TriviaPlayer

    attr_reader :name, :score, :player_answer
    # initialise the game/player with the player's name, a score starting at zero, and an empty array for their answers
    def initialize(name)        
        @name = name
        @score = 0
        @player_answer = []
        # access and parse the JSON question file
        @@question_file = File.read('./questions.json')
        @@json = JSON.parse(@@question_file)
    end

    # create a welcome message
    def welcome_msg
        puts "Welcome, #{@name}".colorize(:blue)
        puts ""
        puts "You will be given a series of questions. Please select the answer you believe to be correct."
    end

    # logic for displaying questions and getting the user's answers
    def play_game
        # Counter to be used to dynamically display question number (useful if questions are delivered randomly)
        @question_counter = 1
        # begin the loop through the available questions
        @@json.each do |question|
            puts ""
            puts "Question #{@question_counter}: #{question["question"]}"
            question["answers"].each do | option, answer |
                puts "#{option}. #{answer}"
            end
            @question_counter += 1
            # get the player's answer
            player_answer << gets.chomp
            # NEED TO PUT IN SOME ERROR HANDLING HERE!
        end
    end

    def player_score
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
    end

    def corrections
        # display the correct answers to questions user got wrong (UNLESS they answeres all questions correctly)
        unless @score == @@json.length
            puts ""
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
                    puts json_index["answers"][json_index["correct_answer"]]
                end
                index_of_answer += 1
            end
        end


    end

end