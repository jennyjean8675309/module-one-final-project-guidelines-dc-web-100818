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

  def check_score
    if @user.score >= 3 && @user.score < 6
      @difficulty = "medium"
    elsif @user.score >=6 && @user.score < 9
      @difficulty = "hard"
    elsif @user.score >=9
      return "You won!"
    end
  end

  def round_loop
    check_score
    get_category
    begin_round
    validate_answer
    round_loop
  end

  def play
    start_game
    round_loop
  end
end
