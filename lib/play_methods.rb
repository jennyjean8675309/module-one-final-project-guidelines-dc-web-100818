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

  def validate_category
    get_category
    @selected_category = gets.chomp.downcase
    edged = Category.all.collect do |cat| cat.name.downcase end
    if edged.include?(@selected_category)
      begin_round
    else
      puts "Sorry, that's not a valid choice"
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
      puts q.question
      q.connect_letter_to_choice
      puts q.format_choices
    end
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

  def won?
    @user.score == 3
  end

  def lost?
    @user.user_questions.length == 4
  end

  def over?
    won? || lost?
  end

  def round_loop
    while over? != true
      advance_user
      validate_category
      validate_answer
      round_loop
    end
    if won?
      puts "Congratulations! You won!"
    elsif lost?
      puts "Sorry, game over."
    end
    leaderboard
  end

  def leaderboard
    puts "TRIVIA GAME LEADERBOARD:"
    leaders = User.all.max_by(3) { |user| user.score }
    leaders.each do |user|
      puts "#{user.name}"
    end
  end

  def play
    start_game
    round_loop
  end
end
