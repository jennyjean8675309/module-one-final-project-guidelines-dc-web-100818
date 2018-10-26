require 'colorize'

class TriviaGame
  def initialize
    @difficulty = "easy"
  end

  def start_game
    puts "Welcome! Please enter your name."
    puts "************************************************"
    user_name = gets.chomp
    @user = User.create(name: user_name)
    cls
    if user_name == "Dr. Seuss"
        puts "
              .;''-.
            .' |    `._
           /`  ;       `'.
         .'     \\         \\
        ,'\\|    `|         |
        | -'_     \\ `'.__,J
       ;'   `.     `'.__.'
       |      `'-.___ ,'
       '-,           /
       |.-`-.______-|
       }      __.--'L
       ;   _,-  _.-'`\\         ___
       `7-;'   '  _,,--._  ,-'`__ `.
        |/      ,'-     .7'.-'--.7 |        _.-'
        ;     ,'      .' .'  .-. \\/       .'
         ;   /       / .'.-     ` |__   .'
          \\ |      .' /  |    \\_)-   `'/   _.-'``
           _,.--../ .'     \\_) '`_      \\'`
         '`f-'``'.`\\;;'    ''`  '-`      |
            \\`.__. ;;;,   )              /
             `-._,|;;;,, /\\            ,'
              / /<_;;;;'   `-._    _,-'
             | '- /;;;;;,      `t'` \\. I like nonsence.
             `'-'`_.|,';;;,      '._/| It wakes up the brain cells!
             ,_.-'  \\ |;;;;;    `-._/
                   / `;\\ |;;;,  `'     - Theodor Seuss Geisel -
                 .'     `'`\\;;, /
                '           ;;;'|
                    .--.    ;.:`\\    _.--,
                   |    `'./;' _ '_.'     |
                    \\_     `'7f `)       /
                    |`   _.-'`t-'`'-.,__.'
                    `'-'`/;;  | |   \\ mx
                        ;;;  ,' |    `
                            /   '
      "
    end 

    puts "Hi #{user.name}! Welcome to TriviaGame!"
    puts "Directions:".colorize(:blue)
    puts "Choose a category before each round. Enter your answer as a letter: A, B, C, or D. If you'd like to quit during the game, you may enter 'quit' or 'exit'.".colorize(:blue)
    puts "If you answer enough questions correctly in the allotted question limit, you win! Good luck!".colorize(:blue)
  end

  # def get_category
  #   puts "Hi #{@user.name}! Please choose a category by name:"
  #   puts "************************************************"
  #   Category.output_categories
  # end

  # def validate_category
  #   get_category
  #   @selected_category = gets.chomp.downcase
  #   edged = Category.all.collect do |cat| cat.name.downcase end
  #   if edged.include?(@selected_category)
  #     begin_round
  #   else
  #     puts "Sorry, that's not a valid choice".colorize(:red)
  #     puts "Please enter a valid choice".colorize(:red)
  #     puts "************************************************"
  #     validate_category
  #   end
  # end

  def get_category
    prompt = TTY::Prompt.new
    cats = Category.all.collect do |cat| cat.name end
    @selected = prompt.select("Please choose a category:", cats)
    puts "************************************************"
  end

  def begin_round
      q = Question.give_user_question(@selected, @difficulty)
    if @user.questions.include?(q)
      begin_round
    else
      @uq = UserQuestion.create(user: @user, question: q)
      @user.user_questions << @uq
      puts "************************************************"
      puts q.question
      q.connect_letter_to_choice
      puts q.format_choices
    end
  end

  def user
    @user
  end

  def validate_answer
    font = TTY::Font.new(:standard)
    user_answer = gets.chomp.upcase
    if user_answer == "A" || user_answer == "B" || user_answer == "C" || user_answer == "D"
      @uq.tells_user_if_correct(user_answer)
      @uq.keep_score(user_answer)
      puts font.write("Your score is #{user.score}").colorize(:blue)
      puts "************************************************"
    elsif user_answer = "EXIT" || user_answer = "QUIT"
        exit
    else
      puts "Sorry, that choice is not valid.".colorize(:red)
      puts "Please enter a valid answer.".colorize(:red)
      puts "************************************************"
      validate_answer
    end
  end

  def advance_user
    if @user.score >= 2 && @user.score < 3
      @difficulty = "medium"
    elsif @user.score >=3 && @user.score < 4
      @difficulty = "hard"
    end
  end

  def won?
    @user.score == 5
  end

  def lost?
    @user.user_questions.length == 7
  end

  def over?
    won? || lost?
  end

  def round_loop
    font = TTY::Font.new(:standard)
    while over? != true
      advance_user
      # validate_category
      get_category #
      begin_round
      validate_answer
    end
    if won?
      puts font.write("Congrats! You Won!").colorize(:blue)
    elsif lost?
      puts "Sorry, try again".colorize(:red)
      puts "Game Over".colorize(:red)
    end
    leaderboard
  end


  def leaderboard
    font = TTY::Font.new(:standard)
    puts "***************************************************************************************************************************************************************".colorize(:blue)
    puts font.write("TRIVIA GAME LEADERBOARD:").colorize(:blue)
    puts "***************************************************************************************************************************************************************".colorize(:blue)
    leaders = User.all.max_by(3) { |user| user.score }
    leaders.each_with_index {|leader, index|
      puts "#{index + 1}. #{leader.name} - Score:#{leader.score}".colorize(:blue)
    }
  end

  def cls
    puts "\e[H\e[2J"
  end

  def play
    start_game
    round_loop
  end

end
