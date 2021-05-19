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


        # begin the loop through the available questions
        @json.each do |question|
            puts question["question"]
            question["answers"].each do | option, answer |
                puts "#{option}. #{answer}"
            end
            player_answer << gets.chomp
            # NEED TO PUT IN SOME ERROR HANDLING HERE!
        end
    end

    def test
        puts x
        
    end

end