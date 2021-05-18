class TriviaPlayer

    attr_reader :name
    def initialize(name)        
        @name = name
        @score = 0
    end

    def welcome_msg
        welcome =  "Welcome, #{@name}"
        welcome
    end


end