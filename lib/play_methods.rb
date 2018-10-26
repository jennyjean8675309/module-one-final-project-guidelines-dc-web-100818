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
  end

  def get_category
    puts "Hi #{@user.name}! Please choose a category by name:"
    puts "************************************************"
    Category.output_categories
  end

  def validate_category
    get_category
    @selected_category = gets.chomp.downcase
    edged = Category.all.collect do |cat| cat.name.downcase end
    if edged.include?(@selected_category)
      begin_round
    else
      puts "Sorry, that's not a valid choice".colorize(:red)
      puts "Please enter a valid choice".colorize(:red)
      puts "************************************************"
      validate_category
    end
  end

  def begin_round
      q = Question.give_user_question(@selected_category, @difficulty)
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
    elsif @user.score >=3&& @user.score < 4
      @difficulty = "hard"
    end
  end

  def won?
    @user.score == 5
  end

  def lost?
    @user.user_questions.length == 2
  end

  def over?
    won? || lost?
  end

  def round_loop
    font = TTY::Font.new(:standard)
    while over? != true
      advance_user
      validate_category
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

  def play
    start_game
    round_loop
  end
end
