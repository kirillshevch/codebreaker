module Codebreaker
  class Game
    def initialize
      @secret_code = ""
      @turns = 5
      @hint = 1
    end

    def start
      4.times do
        @secret_code += rand(1..6).to_s
      end
    end

    def load
      loop do
        if @turns > 0
          if @turns == 5
            puts "You have 5 attempts to guess the secret code"
          end
          puts "Enter you code(4 numbers from 1 to 6): "
          input_code = gets.to_s.strip
          if valid?(input_code)
            if user_code(input_code) == "++++"
              save_result("log.txt")
              puts "You won!"
              break
            else
              puts user_code(input_code)
            end
          elsif input_code == "hint" && @hint > 0
            puts hint
            @hint = 0
          else
            puts "Insert valid code plz!"
          end
          @turns = @turns-1
        else
          puts "You lost"
          break
        end
      end
    end

    def user_code(param)
      res = ""

      param.chars.each_with_index do |value, index|
        if value == @secret_code[index]
          res += '+'
        elsif @secret_code.include? value
          res += '-'
        end
      end

      return res
    end

    def hint
      res = ""
      random_hint = rand(0..3)
      @secret_code.chars.each_with_index do |value, index|
        if index == random_hint
          res += value
        else
          res += '*'
        end
      end

      return res
    end

    def save_result(file)
      time = Time.now
      File.open(file, 'a') { |f| f.puts("Аноним угадал число: #{@secret_code} \n #{time} ") }
    end

    def valid?(code)
      code =~ /^[1-6]{4}$/
    end
  end
end