# Class to deal with questions related to the game
class Game

    # Random method that provide the random computer option
    def self.get_computer_option
        integer_computer_option = rand(1..3)
    
        if integer_computer_option == 1
          return "paper"
        elsif integer_computer_option == 2
          return "rock"
        end
    
        return "scissors"
    end

    # Compares the user option with the random computer option and
    # returns a string related to the result
    def self.evaluate user_option
        computer_option = Game.get_computer_option

        if ((user_option == "paper" && computer_option == "rock") || (user_option == "rock" && computer_option == "scissors") || (user_option == "scissors" && computer_option == "paper"))
            winner = "user (you)"
        elsif user_option == computer_option   
            winner = "draw"
        else
            winner = "computer"        
        end
      
        return "{\"message\": \"winner: #{winner}, computer option: #{computer_option}\"}"
    end
end

