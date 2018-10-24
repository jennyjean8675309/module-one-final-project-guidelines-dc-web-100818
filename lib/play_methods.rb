class TriviaGame
  def initialize
    @difficulty = "easy"
  end

  def start_game
    puts "Welcome! Please enter your name."
    user_name = gets.chomp
    @user = User.create(name: user_name)
  end

  def get_category
    puts "Hi #{@user.name}! Please choose a category:"
    Category.output_categories
  end

  def begin_round
    get_category
    selected_category = gets.chomp
    q = Question.give_user_question(selected_category, @difficulty)
    @uq = UserQuestion.create(user: @user, question: q)
    @user.user_questions << @uq
  end

  def user
    @user
  end

  def validate_answer
    user_answer = gets.chomp.upcase
    if user_answer == "A" || user_answer == "B" || user_answer == "C" || user_answer == "D"
      @uq.tells_user_if_correct(user_answer)
      @uq.keep_score(user_answer)
      puts "Your score is #{user.score}"
    else
      puts "Sorry, that choice is not valid."
      validate_answer
    end
  end

  def advance_user
    if @user.score >= 1 && @user.score < 2
      @difficulty = "medium"
    elsif @user.score >=2 && @user.score < 3
      @difficulty = "hard"
    end
  end

  def over?
    if @user.score == 3
      puts "Congratulations! You won!"
      true
      binding.pry
    elsif @user.user_questions.length == 4
      puts "Sorry, game over."
      true
    else
      false
    end
  end

  def round_loop
    while over? != true
      advance_user
      begin_round
      validate_answer
      round_loop
    end
  end

  def play
    start_game
    round_loop
  end
end
