require_relative '../config/environment'


game = TriviaGame.new
game.play



# #Begins Round 1 (easy)
# difficulty = "easy"
# puts "Hi #{user_name}, choose a category:"
# Category.output_categories
# selected_category = gets.chomp
#
# q1 = Question.give_user_question(selected_category, "easy")
#
# user_answer = gets.chomp
# uq1 = UserQuestion.create(user: user1, question: q1)
#
# uq1.tells_user_if_correct(user_answer)
# uq1.keep_score(user_answer)
#
# puts "Your score is #{user1.score}"
#
#
#
# #Begins Round 2
