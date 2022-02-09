class Mastermind 

    def initialize
        @creator = "none"
        @guesser = "none"
        @colors = ["yellow", "blue", "green", "red", "orange", "purple"]
        @secret_code = Array.new 
        @computer_guess = Array.new(4) 
        @count_turns = 1 
        @hint = Array.new

        set_roles 
    end 

    def set_roles 
        p "Please choose 'creator' or 'guesser'."
        player_choice = gets.chomp

        if player_choice == "creator"
            @creator = "player"
            @guesser = "computer"
            choose_colors
        elsif player_choice == "guesser"
            @creator = "computer"
            @guesser = "player"
            choose_colors
        else 
            p "invalid choice!"
            set_roles
        end 
    end 

    def choose_colors
        if @creator == "player"
            p "Choose four colors from the given list of colors. These can be repeated."
            p @colors

            i = 0 
            while i < 4 
                @secret_code.push(gets.chomp)
                i += 1 
            end 
            p "The computer will guess your colors."
            guess_colors
        elsif @creator == "computer"
            i = 0 
            while i < 4 
                @secret_code.push(@colors.sample)
                i += 1
            end 
            p "Computer chose the secret code."
            guess_colors
        end 
    end 

    def guess_colors 
        if @creator == "computer"
            while @count_turns <= 12
                    p "This is turn #{@count_turns} of 12"
                guess = Array.new 
                i = 0
                p "Guess four colors:"
                while i < 4 
                    guess.push(gets.chomp)
                    i += 1 
                end 
                @count_turns += 1

                if @count_turns == 13 
                    p "Out of turns, you lose."
                    p "The secret code was #{@secret_code}."
                    replay
                end 

                if guess == @secret_code
                    p "You guessed correctly, you are a mastermind!"
                    replay
                elsif 
                    hints(guess)
                end 
            end 
        elsif @creator == "player"

            while @count_turns <= 12
                i = 0 
                p "This is turn #{@count_turns} of 12"
                while i < (@secret_code.length)
                    if @computer_guess[i] == nil    
                    @computer_guess[i] = @colors.sample 
                    end 
                    i += 1 
                end 
                @count_turns += 1
                
                p "Computer's guess #{@computer_guess}"
                    
                    if @count_turns == 13 
                    p "The computer ran out of turns, you win!"
                    p "The secret code was #{@secret_code}."
                    replay
                end 

                if @computer_guess == @secret_code
                    p "The computer is a mastermind. You lose"
                    replay
                elsif 
                    hints(@computer_guess)
                end 
            end 
        end 
    end 

    def hints(guesses) 
        if @creator == "computer" 
            counter = 0 
            guesses.collect{ |e| e ? e.strip : e }
            guesses.each_with_index do |guess, indx|
                    if @secret_code[indx] == guess
                        @hint.push("#{guess} at position #{indx + 1} is correct.") 
                    elsif @secret_code.include?(guess) && !(@secret_code == guess)
                        counter += 1 
                    end
                end  
            @hint.uniq
            unless @hint.empty?
                p @hint
                @hint = Array.new 
            end 
            if counter > 0 
                p "#{counter} of the colors are in the code, but not the correct spot."
            elsif
                p "The other color(s) is/are incorrect"
            end 
        elsif @creator == "player"
            guesses.collect{ |e| e ? e.strip : e }
            guesses.each_with_index do |guess, indx|
                    if @secret_code[indx] == guess
                        @computer_guess[indx] = guess 
                    elsif @secret_code[indx] != guess
                        @computer_guess[indx] = nil 
                    end 
                end 
        end 
        @hint = Array.new 
        return 
    end 

    def replay
        p "Do you want to replay? Y/N"
        answer = gets.chomp
        
        if answer == "y" || answer == "Y"
            game = Mastermind.new
        elsif answer == "N" || answer == "n"
            return
        else 
            p "invalid answer."
            replay
        end 
    end 

end 

mastermind = Mastermind.new 