require_relative '../config/environment'

Category.destroy_all
Question.destroy_all
Choice.destroy_all

create_categories
create_questions
create_correct_choices
create_incorrect_choices

puts "Welcome! Please enter your name."
user_name = gets.chomp
user1 = User.create(name: user_name)

puts "Hi #{user_name}, choose a category:"
Category.output_categories
selected_category = gets.chomp

q1 = Question.give_user_question(selected_category)

user_answer = gets.chomp
uq1 = UserQuestion.create(user: user1, question: q1)

uq1.tells_user_if_correct(user_answer)
uq1.keep_score(user_answer)

puts "Your score is #{user1.score}"
