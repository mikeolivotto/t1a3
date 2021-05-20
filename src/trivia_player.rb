class TriviaPlayer

    attr_reader :name, :score, :player_answer
    def initialize(name)        
        @name = name
        @score = 0
        @player_answer = []
    end

    def welcome_msg
        puts "Welcome, #{@name}".colorize(:blue)
        puts ""
        puts "These are the instructions"
    end

    def play_game

        # access and parse the JSON file
        @question_file = File.read('./questions.json')
        @json = JSON.parse(@question_file)
        @question_counter = 1


        # begin the loop through the available questions
        @json.each do |question|
            puts "Question #{@question_counter}: #{question["question"]}"
            question["answers"].each do | option, answer |
                puts "#{option}. #{answer}"
            end
            @question_counter += 1
            player_answer << gets.chomp
            # NEED TO PUT IN SOME ERROR HANDLING HERE!
        end
    end

    def player_score
        #loop through player_answer array, compare to actual answers
        
        index_of_answer = 0

        player_answer.each do |answer|
            if answer == @json[index_of_answer]["correct_answer"]
                @score += 1
            end
            index_of_answer += 1
        end

        # puts the score
        puts "You answered #{@score} of #{@json.length} questions correctly."
    end

    def corrections
        
    end

end